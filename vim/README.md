# Install base vim configuration
After a long time to configure my own vim, finally I turned to [spf13-vim](https://github.com/spf13/spf13-vim), the best vim configuration I've found ever. On *nix environment, install it with:
```
curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh
```

The command will do the following things:

- Bakcup your current vim config
- Clone repo [spf13-vim](https://github.com/spf13/spf13-vim) to `$HOME/.spf13-vim`
- Link vim config files:
  - `link -sf $HOME/.spf13-vim-3/.vimrc $HOME/.vimrc`
  - `link -sf $HOME/.spf13-vim-3/.vimrc.before $HOME/.vimrc.before`
  - `link -sf $HOME/.spf13-vim-3/.vimrc.bundles $HOME/.vimrc.bundles`

For more details of installation or envronment requirements, please refer to http://vim.spf13.com/

# Link/Copy local customization configs
Copy or link local customization files in this directory(`.vimrc.before.local`, `.vimrc.bundles.local`, `.vimrc.local`) to `$HOME/`

# Install YCM vim bundle
spf13-vim will install bundles according to your config, which is defined by variable `g:spf13_bundle_groups`. By default it's defined in file `.vimrc.bundles`:
```
let g:spf13_bundle_groups=['general', 'writing', 'neocomplete', 'programming', 'php', 'ruby', 'python', 'javascript', 'html', 'misc',]
```
I prefer [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) to [neocomplete](https://github.com/Shougo/neocomplete.vim), besides, I don't need `ruby` and `php` environment. New bundle groups is defined in file `.vimrc.bundles.before` as:
```
let g:spf13_bundle_groups = ['general', 'writing', 'programming', 'python', 'go', 'javascript', 'html', 'misc', 'youcompleteme']
```
Start vim and run `:VundleInstall`, bundle `youcompleteme` and related ones will be installed.

# Build YCM
The [YouCompleteMe repo](https://github.com/Valloric/YouCompleteMe) contains all information to build YCM on different environment, it could be as easy as:
```
> cd $HOME/.vim/bundle/YouCompleteMe
> ./install.py --clang-completer
```

This is enough for most cases, but not on my Archlinux environment, I need to use the system installed clang lib instead of the downloaded one. The final workaround is:
```
> pacman -S clang
> cd $HOME/.vim/bundle/YouCompleteMe
> ./install.py --clang-completer --system-libclang
```
