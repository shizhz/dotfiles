# Installation
Backup your current configuration, and copy the whole directory to `$HOME/.config/`. The following programs are used in this config, make sure they've been installed to make i3 work:

- [Conky](https://github.com/brndnmtthws/conky), used to generate i3bar info, please refer to directory [conky](https://github.com/shizhz/dotfiles/tree/master/conky) for configuration info.
- [Chromium](https://wiki.archlinux.org/index.php/chromium), browser I'm using, which will be auto-started by i3. Feel free to remove line `exec --no-startup-id chromium` fron `config` or change it to whatever you like.
- [Terminator](https://wiki.archlinux.org/index.php/Terminator), terminal emulator I'm using, which will be auto-started by i3. Change line `exec --no-startup-id terminator` to your terminal emulator in file `config`.
- [Fcitx](https://wiki.archlinux.org/index.php/fcitx), input framework I'm using to type Chinese. Remove line `exec --no-startup-id fcitx` if you don't need it
