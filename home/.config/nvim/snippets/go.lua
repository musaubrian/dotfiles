-- end
-- This clears my go snippets, so when I source this file
-- I can try the snippets again, without restarting neovim.
--
-- This is pretty useful if you're trying to do something a bit
-- more complicated or just exploring random snippet ideas
require("luasnip.session.snippet_collection").clear_snippets "go"

local ls = require "luasnip"

local fmta = require("luasnip.extras.fmt").fmta

local s = ls.snippet
local i = ls.insert_node


ls.add_snippets("go", {
  s(
    "ei",
    fmta(
      [[
      if err != nil {
          <handle>
      }
      <finish>
        ]],
      {
        handle = i(1),
        finish = i(0),
      }
    )
  ),
})
ls.add_snippets("go", {
  s("fmain",
    fmta(
      [[
        func main() {
          <content>
        }
      ]],
      {
        content = i(0)
      })
  ),
})

ls.add_snippets("go", {
  s("ts",
    fmta(
      [[
      type <struct_name> struct {
        <vals>
      }
      ]],
      {
        struct_name = i(1),
        vals = i(0)
      })
  ),
})
