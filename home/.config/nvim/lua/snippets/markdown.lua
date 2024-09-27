require("luasnip.session.snippet_collection").clear_snippets("markdown")

local ls = require("luasnip")

local fmta = require("luasnip.extras.fmt").fmta
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.snippet
local i = ls.insert_node
local snippet_name = "markdown"

local function createDateString()
	local current_time = os.time()
	local local_time = os.date("*t", current_time)
	local date_str = string.format("%04d-%02d-%02d", local_time.year, local_time.month, local_time.day)
	return date_str
end

local right = ">"

ls.add_snippets(snippet_name, {
	s(
		"nm",
		fmta(
			[[
---
tags:
- "#<val>"
meta: <metadata>
status: <status>
---
      ]],
			{
				val = i(1),
				metadata = i(2),
				status = "researching",
			}
		)
	),

	s(
		"meta",
		fmta(
			[[
---
title: "<title>"
description: "<desc>"
date: <date>
tags: ["<tag>"]
showTags: true
readTime: true
---
]],
			{
				title = i(1, "post title"),
				desc = i(2, "post description"),
				date = createDateString(),
				tag = i(3, ""),
			}
		)
	),

	s(
		"note",
		fmta(
			[[
      <right_angle> [!NOTE]
      <right_angle_1>
      <right_angle_2> <note>
      ]],
			{
				note = i(0),
				right_angle = right,
				right_angle_1 = right,
				right_angle_2 = right,
			}
		)
	),

	s("fn", fmt("[^{}]", { i(0) })),
	s("fnr", fmt("[^{}]: {}", { i(0), i(1) })),
})
