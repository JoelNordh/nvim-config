local function copy(args)
	return args[1]
end
local date_input = function(args, snip, old_state, fmt)
	local fmt = fmt or "%Y-%m-%d"
	return sn(nil, i(1, os.date(fmt)))
end


return { -- Your snippets start herei
  s("fn", {
		-- Simple static text.
		t("//Parameters: "),
		-- function, first parameter is the function, second the Placeholders
		-- whose text it gets as input.
		f(copy, 2),
		t({ "", "function " }),
		-- Placeholder/Insert.
		i(1),
		t("("),
		-- Placeholder with initial text.
		i(2, "int foo"),
		-- Linebreak
		t({ ") {", "\t" }),
		-- Last Placeholder, exit Point of the snippet.
		i(0),
		t({ "", "}" }),
	}),
    -- ... your existing snippets ...
    s("dtest", { -- Minimal d-node test snippet
        t("This is before dynamic node: "),
        d(function(args)
          return {t("Dynamic Text Here")} -- Super simple d node
        end),
        t(" :This is after dynamic node")
    }),
    s("datetime", { -- Date and Time snippet
        t("Current Date and Time: "),
        d(function()
          local date = require("os").date
          return {t(date("%Y-%m-%d %H:%M:%S"))} -- IMPORTANT: Return a table with t()
        end)
    }),
    s("novel", {
		t("It was a dark and stormy night on "),
		d(1, date_input, {}, { user_args = { "%A, %B %d of %Y" } }),
		t(" and the clocks were striking thirteen."),
	}),
}
