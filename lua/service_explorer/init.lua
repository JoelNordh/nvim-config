local M = {}

local json_path = "/home/joel.nordh/work/seedhawk/SeedHawkGateway/SeedHawkGateway.json"

local function read_json()
  local f = io.open(json_path, "r")
  if not f then return nil, "Could not open JSON file: " .. json_path end
  local content = f:read("*a")
  f:close()
  local ok, data = pcall(vim.fn.json_decode, content)
  if not ok then return nil, "JSON decode error" end
  return data, nil
end

local function find_service(data, name)
  for _, svc in ipairs(data.services or {}) do
    if svc.serviceName == name then return svc end
  end
  return nil
end

function M.list_services()
  local data, err = read_json()
  if not data then
    print(err)
    return
  end
  print("Available services:")
  for _, svc in ipairs(data.services or {}) do
    print(" - " .. svc.serviceName)
  end
end

function M.show_service(serviceName)
  local data, err = read_json()
  if not data then print(err) return end
  local svc = find_service(data, serviceName)
  if not svc then
    print("Service not found: " .. serviceName)
    return
  end
  print("Service: " .. svc.serviceName)
  
  print("Inputs:")
  for key, val in pairs(svc.inputs or {}) do
    print(string.format("  %s: %s", key, val))
  end
  print("Outputs:")
  for key, val in pairs(svc.outputs or {}) do
    print(string.format("  %s: %s", key, val))
  end
end

function M.get_provider()
  local data, err = read_json()
  if not data then print(err) return end
  local line = vim.api.nvim_get_current_line()
  local input_name = line:match('"([^"]+)"')
  if not input_name then
    print("Cursor not on an input field")
    return
  end
  for _, svc in ipairs(data.services or {}) do
    for _, out in ipairs(svc.outputs or {}) do
      if out == input_name then
        print("Provider: " .. svc.serviceName)
        return
      end
    end
  end
  print("No provider found for input: " .. input_name)
end

local function open_image_in_nvim(png_path)
  local ok, image = pcall(require, "image")
  if not ok then
    print("image.nvim not installed. Install it for in-editor image preview.")
    return
  end
  image.open(png_path)
end

function M.draw_dependencies(serviceName)
local data, err = read_json()
  if not data then print(err) return end
  local svc = find_service(data, serviceName)
  if not svc then print("Service not found: " .. serviceName) return end

  local lines = {}
  table.insert(lines, "Dependency graph for: " .. svc.serviceName)
  table.insert(lines, "Inputs:")
  for key, val in pairs(svc.inputs or {}) do
    local provider = nil
    for _, s in ipairs(data.services or {}) do
      for _, out_val in pairs(s.outputs or {}) do
        if out_val == val then provider = s.serviceName end
      end
    end
    table.insert(lines, string.format("  %s (%s) <-- %s", key, val, provider or "external"))
  end
  table.insert(lines, "Outputs:")
  for key, val in pairs(svc.outputs or {}) do
    local consumers = {}
    for _, s in ipairs(data.services or {}) do
      for _, inp_val in pairs(s.inputs or {}) do
        if inp_val == val then table.insert(consumers, s.serviceName) end
      end
    end
    table.insert(lines, string.format("  %s (%s) --> %s", key, val, #consumers > 0 and table.concat(consumers, ", ") or "external"))
  end

  -- Open a new scratch buffer and write the lines
  local buf = vim.api.nvim_create_buf(false, true) -- unlisted, scratch
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_set_current_buf(buf)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
end

local function write_dot(serviceName)
  local data, err = read_json()
  if not data then print(err) return end
  local svc = find_service(data, serviceName)
  if not svc then print("Service not found: " .. serviceName) return end

  local lines = {
    'digraph dependencies {',
    '  rankdir=LR;',
    '  splines=ortho;', 
    '  nodesep=0.8;',
    '  ranksep=1.5;', 
    '  node [shape=record, style=filled, fillcolor="#e0e0e0", fontname="Sans", fontsize=10, height=0.4];',
    '  edge [penwidth=1.0, arrowsize=0.8];'
  }

  local providers, consumers = {}, {}
  local provider_ports, consumer_ports = {}, {}

  -- 1. IDENTIFY PROVIDERS
  for main_in_key, main_in_val in pairs(svc.inputs or {}) do
    for _, s in ipairs(data.services or {}) do
      for out_key, out_val in pairs(s.outputs or {}) do
        if out_val == main_in_val then
          providers[s.serviceName] = s
          provider_ports[s.serviceName] = provider_ports[s.serviceName] or {}
          provider_ports[s.serviceName][out_key] = true
        end
      end
    end
  end

  -- 2. IDENTIFY CONSUMERS
  for main_out_key, main_out_val in pairs(svc.outputs or {}) do
    for _, s in ipairs(data.services or {}) do
      for in_key, in_val in pairs(s.inputs or {}) do
        if in_val == main_out_val then
          consumers[s.serviceName] = s
          consumer_ports[s.serviceName] = consumer_ports[s.serviceName] or {}
          consumer_ports[s.serviceName][in_key] = true
        end
      end
    end
  end

  -- === LABEL GENERATORS ===

  -- Main Service (Center)
  local function main_service_label(svc)
    local input_ports = {}
    for key, _ in pairs(svc.inputs or {}) do
      -- Port ID: in_key
      table.insert(input_ports, string.format('<in_%s> %s', key, key))
    end
    
    local output_ports = {}
    for key, _ in pairs(svc.outputs or {}) do
      -- Port ID: out_key
      table.insert(output_ports, string.format('<out_%s> %s', key, key))
    end

    if #input_ports == 0 then table.insert(input_ports, ' ') end
    if #output_ports == 0 then table.insert(output_ports, ' ') end

    return string.format(
      '"%s" [label="{ { %s } | \\N | { %s } }", fillcolor="#d0e0ff", penwidth=2];',
      svc.serviceName,
      table.concat(input_ports, " | "),
      table.concat(output_ports, " | ")
    )
  end

  -- Provider Label (Left Side) - Output ports only
  local function provider_label(svc, used_outputs, id_suffix)
    local output_ports = {}
    for key, _ in pairs(svc.outputs or {}) do
      if used_outputs[key] then
        table.insert(output_ports, string.format('<out_%s> %s', key, key))
      end
    end
    if #output_ports == 0 then table.insert(output_ports, '<dummy> dummy') end

    return string.format(
      '"%s%s" [label="{ %s | { %s } }"];',
      svc.serviceName, id_suffix,
      svc.serviceName,
      table.concat(output_ports, " | ")
    )
  end

  -- Consumer Label (Right Side) - Input ports only
  local function consumer_label(svc, used_inputs, id_suffix)
    local input_ports = {}
    for key, _ in pairs(svc.inputs or {}) do
      if used_inputs[key] then
        table.insert(input_ports, string.format('<in_%s> %s', key, key))
      end
    end
    if #input_ports == 0 then table.insert(input_ports, '<dummy> dummy') end

    return string.format(
      '"%s%s" [label="{ { %s } | %s }"];',
      svc.serviceName, id_suffix,
      table.concat(input_ports, " | "),
      svc.serviceName
    )
  end

  -- === WRITE NODES ===

  for name, s in pairs(providers) do
    table.insert(lines, provider_label(s, provider_ports[name], "_P"))
  end

  for name, s in pairs(consumers) do
    table.insert(lines, consumer_label(s, consumer_ports[name], "_C"))
  end

  table.insert(lines, main_service_label(svc))

  -- === INVISIBLE EDGES ===
  -- These preserve the Left -> Right layout structure
  for name in pairs(providers) do
    table.insert(lines, string.format('"%s_P" -> "%s" [style=invis, weight=10];', name, svc.serviceName))
  end
  for name in pairs(consumers) do
    table.insert(lines, string.format('"%s" -> "%s_C" [style=invis, weight=10];', svc.serviceName, name))
  end

  -- === REAL EDGES (with Compass Points) ===

  -- Providers (Output:East) -> Main (Input:West)
  for main_in_key, main_in_val in pairs(svc.inputs or {}) do
    for name, s in pairs(providers) do
      for out_key, out_val in pairs(s.outputs or {}) do
        if out_val == main_in_val and provider_ports[name][out_key] then
          -- ADDED: :e (East) to source, :w (West) to destination
          table.insert(lines, string.format(
            '  "%s_P":"out_%s":e -> "%s":"in_%s":w;', 
            s.serviceName, out_key, svc.serviceName, main_in_key
          ))
        end
      end
    end
  end

  -- Main (Output:East) -> Consumers (Input:West)
  for main_out_key, main_out_val in pairs(svc.outputs or {}) do
    for name, s in pairs(consumers) do
      for in_key, in_val in pairs(s.inputs or {}) do
        if in_val == main_out_val and consumer_ports[name][in_key] then
          -- ADDED: :e (East) to source, :w (West) to destination
          table.insert(lines, string.format(
            '  "%s":"out_%s":e -> "%s_C":"in_%s":w;', 
            svc.serviceName, main_out_key, s.serviceName, in_key
          ))
        end
      end
    end
  end

  table.insert(lines, "}")
  
  -- Generate File
  local dot_path = "/tmp/" .. serviceName .. "_dependencies.dot"
  local png_path = "/tmp/" .. serviceName .. "_dependencies.png"
  local f = io.open(dot_path, "w")
  if not f then print("Could not write dot file: " .. dot_path) return end
  f:write(table.concat(lines, "\n"))
  f:close()
  
  os.execute(string.format("dot -Tpng %s -o %s", dot_path, png_path))
  print("PNG written to " .. png_path)
  open_image_in_nvim(png_path)
end

vim.api.nvim_create_user_command("ListServices", function() M.list_services() end, {})
vim.api.nvim_create_user_command("ShowService", function(opts) M.show_service(opts.args) end, { nargs = 1 })
vim.api.nvim_create_user_command("GetProvider", function() M.get_provider() end, {})
vim.api.nvim_create_user_command("DrawDependencies", function(opts) M.draw_dependencies(opts.args) end, {
  nargs = 1,
  complete = function(arglead)
    local data, err = read_json()
    if not data then return {} end
    local matches = {}
    for _, svc in ipairs(data.services or {}) do
      if svc.serviceName and svc.serviceName:match("^" .. arglead) then
        table.insert(matches, svc.serviceName)
      end
    end
    return matches
  end
})
vim.api.nvim_create_user_command("DrawDependenciesGraph", function(opts)
  write_dot(opts.args)
end, {
  nargs = 1,
  complete = function(arglead)
    local data, err = read_json()
    if not data then return {} end
    local matches = {}
    for _, svc in ipairs(data.services or {}) do
      if svc.serviceName and svc.serviceName:match("^" .. arglead) then
        table.insert(matches, svc.serviceName)
      end
    end
    return matches
  end
})

return M
