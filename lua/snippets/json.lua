-- New function to get filename without extension
local function filename_no_ext_function(args, snip, old_state)
    local filename_no_ext = vim.fn.expand('%:t:r') -- Get filename without extension
    return sn(nil, t(filename_no_ext)) -- Return snippet node with filename text
end

return { -- Define snippets for 'json' filetype
  s("luaaddIo",
    fmt(
      '"{}" : {{\n' ..
      '  "description": "{}",\n' ..
      '  "unit": "{}",\n' ..
      '  "type": "{}",\n' ..
      '  "kind": "{}",\n' ..
      '  "indexType": "Tag",\n' ..
      '  "mandatory": true\n' ..
      '}}',
      {
        i(1, "Name"),
        i(2, "Description"),
        i(3, "unit"),
        i(4, "type"),
        i(5, "indexed"),
      }
    )
  ),
  s( -- Add new command with filename
    "addCommand",
    fmt(
      '"{}.{}": {{\n' ..
      '  "description": "{}",\n' ..
      '  "arguments": {{\n'..
      '    \n'..
      '  }}\n' ..
      '}}\n',
      {
        d(1, filename_no_ext_function, {}),
        i(2, "commandName"), -- Insert node for command name
        i(3, "description"),
      }
    ),
    { description = "Add a ui command to service json with filename" }
  ),
  s("addArgument", fmt(
    '"{}": {{\n' ..
    '  "description": "{}",\n' ..
    '  "type": "{}",\n' ..
    '  }}\n',
    { 
      i(1, "argumentName"),
      i(2, "description"),
      i(3, "type"),
    }
  )),
  s("filename", { -- New snippet to insert filename without extension
        t("Current Filename (no extension): "),
        d(1, filename_no_ext_function, {}), -- Using the new function
    }),
}

--return { -- Define snippets for 'json' filetype
--  s("luaaddIo", {
--      t("\""), i(1, "Name"), t("\": {"),
--      t("\n  \"description\": \""), i(2, "Description"), t("\","),
--      t("\n  \"unit\": \""), i(3, "unit"), t("\","),
--      t("\n  \"type\": \""), i(4, "type"), t("\","),
--      t("\n  \"kind\": \""), i(5, "indexed"), t("\","),
--      t("\n  \"indexType\": \"Tag\","),
--      t("\n  \"mandatory\": true"),
--      t("\n}"), i(0)
--  }),

--  s( -- Add new command
--    "luaaddCommand",
--    {
--      i(0) -- Just a placeholder for now, you can add body if needed
--    },
--    { description = "Add a ui command to service json" }
--  ),
  -- Your dynamic command snippet from before (add it here in json.lua):
  --
--  }
