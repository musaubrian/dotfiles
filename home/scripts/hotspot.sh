#!/usr/bin/env bash
#

nmcli connection down Hotspot
nmcli connection modify Hotspot 802-11-wireless-security.psk 0123456788
nmcli connection up Hotspot
