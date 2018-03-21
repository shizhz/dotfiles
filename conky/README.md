# Configuration
This configuration of conky is used to generate information for i3bar. Script `conkyi3bar.sh` will generate header data according to [i3bar protocol](https://i3wm.org/docs/i3bar-protocol.html), then invoke `conky` with config `conky.lua` to generate infinite json stream.

`conkyi3bar.sh` is configured in i3 as `i3bar` input:
```
bar {
        status_command $HOME/.config/conky/conkyi3bar.sh
}
```
And then copy the whole directory to `$HOME/.config/`, the i3bar looks like:

[![i3bar](https://raw.githubusercontent.com/shizhz/dotfiles/master/conky/i3bar.png)](#i3bar)
