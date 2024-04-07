require("luasnip.session.snippet_collection").clear_snippets "markdown"

local ls = require("luasnip")

local fmta = require("luasnip.extras.fmt").fmta
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.snippet
local i = ls.insert_node
local snippet_name = "markdown"

local function createDateString()
  local current_time = os.time()
  local local_time = os.date("*t", current_time)
  local utc_time = os.date("!*t", current_time)
  local timezone_offset_seconds = os.difftime(os.time(local_time), os.time(utc_time))

  local timezone_offset_hours = timezone_offset_seconds / 3600
  local timezone_offset_minutes = (timezone_offset_seconds % 3600) / 60

  local timezone_sign = "+"
  if timezone_offset_hours < 0 then
    timezone_sign = "-"
    timezone_offset_hours = -timezone_offset_hours
  end

  local timezone_offset = string.format("%02d:%02d", timezone_offset_hours, timezone_offset_minutes)
  local date_str = string.format("%04d-%02d-%02dT%02d:%02d:%02d%s%s",
    local_time.year, local_time.month, local_time.day,
    local_time.hour, local_time.min, local_time.sec,
    timezone_sign, timezone_offset)

  return date_str
end


ls.add_snippets(snippet_name, {
  s("nm",
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
        status = "researching"
      }
    )
  )
})


ls.add_snippets(snippet_name, {
  s("meta",
    fmta(
      [[
        ---
        title: '<title>'
        description: '<desc>'
        date: <date>
        draft: <draft>
        type: "post"
        tags: ["<tag>"]
        ---
      ]],
      {
        title = i(1, "post title"),
        desc = i(2, "post description"),
        date = createDateString(),
        draft = "true",
        tag = i(3, "default"),
      }
    )
  )
})
local right = ">"

ls.add_snippets(snippet_name, {
  s("note",
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
        right_angle_2 = right
      })
  ),
})
