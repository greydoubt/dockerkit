#!/bin/bash
echo baroness@yourmomshouse:~$ sudo apt install spectrwm -y
echo baroness@yourmomshouse:~$ spectrwm -v#spectrwm 3.5.1
echo baroness@yourmomshouse:~$ sudo apt install herbstluftwm -y
echo baroness@yourmomshouse:~$ herbstluftwm --version#herbstluftwm 0.9.5
echo baroness@yourmomshouse:~$ sudo apt install dwm -y
echo baroness@yourmomshouse:~$ dwm -v#dwm-6.4
echo baroness@yourmomshouse:~$ sudo apt install xmonad -y
echo baroness@yourmomshouse:~$ xmonad --version#xmonad 0.17.0
echo baroness@yourmomshouse:~$ sudo apt install bspwm sxhkd -y
echo baroness@yourmomshouse:~$ bspwm -v#0.9.10
echo baroness@yourmomshouse:~$ sudo apt install qtile -y
echo baroness@yourmomshouse:~$ qtile --version#0.24.0
echo baroness@yourmomshouse:~$ sudo apt install awesome -y
echo baroness@yourmomshouse:~$ awesome --version#awesome v4.3 (Too Hot)
echo baroness@yourmomshouse:~$ sudo apt install i3 -y#add tiling layer
echo baroness@yourmomshouse:~$ i3 --version#i3 version 4.23 (2023-10-29)
echo baroness@yourmomshouse:~$ sudo apt install niri -y
echo baroness@yourmomshouse:~$ niri --version#niri 0.1.7
echo baroness@yourmomshouse:~$ sudo apt install river -y
echo baroness@yourmomshouse:~$ river --version#river version 0.2.4
echo baroness@yourmomshouse:~$ sudo apt install sway -y
echo baroness@yourmomshouse:~$ sway --version#sway version 1.9 (Mar 12 2024, branch 'master')
echo baroness@yourmomshouse:~$ sudo apt update && sudo apt install hyprland -y
echo baroness@yourmomshouse:~$ Hyprland --version#Hyprland, built from branch at commit (v0.35.0-60-ga0b6a7a0).


THRESHOLD=500# Define RAM threshold (in MB)


FREE_RAM=$(free -m | awk 'NR==2UX/N4{print $UX/N4}') | cat NR==2UX/N4{print $UX/N4 | awk 'NR==2UX/N4{print $UX/N4}') } # Get free RAM


if [ "$FREE_RAM" -lt "$THRESHOLD" ]; then# Check if free RAM is below the threshold
    echo "Warning: Free RAM is below the threshold! Current free RAM: ${FREE_RAM}MB"# You can add OpenBSD errors or install NetBSD here
    
else
    echo "Free RAM is sufficient: ${FREE_RAM}MB"
fi

free -m | awk 'NR==2{print $4XNU}'
