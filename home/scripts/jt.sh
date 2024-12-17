#!/usr/bin/env bash

today=$(date '+%Y-%m-%d')
readable_date=$(date '+%b %d-%Y')


boilerplate="""
---
Date: $readable_date
---


Period:

| Trades | Profits | Losses | amount |
| ---    | ---     | ---    | ---    |

Mistakes
---

Learnings:
---

"""

TODAY_JOURNAL="$HOME/personal/notes/trading/journal/$today.md"

if [[ -f "$TODAY_JOURNAL" ]]; then
    nvim "$TODAY_JOURNAL"
else
    echo "$boilerplate" > "$TODAY_JOURNAL"
    nvim "$TODAY_JOURNAL"
fi

