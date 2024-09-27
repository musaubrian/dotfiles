require("luasnip.session.snippet_collection").clear_snippets("go")

local ls = require("luasnip")

local fmta = require("luasnip.extras.fmt").fmta

local s = ls.snippet
local i = ls.insert_node

ls.add_snippets("go", {
	s(
		"gof",
		fmta(
			[[
go func() {
<body>
}()
	]],
			{
				body = i(1),
			}
		)
	),
	s(
		"ei",
		fmta(
			[[
	if err != nil {
		<handle>
	}
	]],
			{
				handle = i(1),
			}
		)
	),
})
