#!/bin/sh
if grep -q "inactive-dim = 0.3" ~/.config/compton/config; then
    sed -i 's/inactive-dim = 0.3/inactive-dim = 0.0/g' ~/.config/compton/config;
elif grep -q "inactive-dim = 0.0" ~/.config/compton/config; then
    sed -i 's/inactive-dim = 0.0/inactive-dim = 0.3/g' ~/.config/compton/config;
else
    echo "inactive-dim = 0.3;" >> ~/.config/compton/config;
fi
pkill compton;
compton --config /home/mvelzel/.config/compton/config &
