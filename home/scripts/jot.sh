#!/usr/bin/env bash

today=$(date '+%Y-%m-%d')
readable_date=$(date '+%b %d-%Y')


boilerplate="""---
Date: $readable_date
---

"""

TODAY_JOURNAL="$HOME/personal/notes/journal/$today.md"

if [[ -f "$TODAY_JOURNAL" ]]; then
    nvim "$TODAY_JOURNAL"
else
    echo "$boilerplate" > "$TODAY_JOURNAL"
    nvim "$TODAY_JOURNAL" +5
fi

