#!/bin/bash
val=$(spt playback -s -f '%s %t')
if [ -z "$val" ]; then
    echo ""
else
    echo "#[fg=#fab387,bg=#1e1e2e,nobold,nounderscore,noitalics]#[fg=#1e1e2e,bg=#fab387,nobold,nounderscore,noitalics]♪ #[fg=#cdd6f4,bg=#313244] $val #[fg=#313244,bg=#1e1e2e,nobold,nounderscore,noitalics]"
fi
