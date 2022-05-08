# vImDE
Neovim + IPython and some plugins to work with a REPL workflow.

This repo is mainly a backup of my working configurations, but feel free to use them if you want to.
If you aren't interested in running IPython along side neovim in TMUX, you can just grab the `.config/nvim/init.vim` and still have a fancy setup.

## What this setup provides
With this setup I can use my regular `nvim` when editing files or doing some brief work, but I can also use the `vimde` command if I'm working within a well defined Python project with dependencies managed by Poetry.

This allows me to follow some REPL driven development and debugging and allows me to detach the session and come back to it later.

### Bonus Key mappings
- `,<space>` will bring the NERDTree file view
- `,ff` will open the fuzzy file search
- `,fg` fuzzy grep
- `,fb` fuzzy buffer
- `,ec` will edit this configuration file
- `,sc` will reload this configuration
- `<Tab>` and `<Shift><Tab>` will cycle splits
- `<Ctrl-c>` will send selection to IPython if running with TMUX

## Dependencies

This configuration depends on a few Linux tools being available in the environment.

For Tmux + IPython:
- tmux
- tmuxp
- neovim
- some fonts with emojis

Neovim Plugins:
- pyenv (not required but you probably want this if your writing any amount of Python)
- poetry
- nodejs
- ripgrep
- fd

## Setup
Setting this up takes a bit of effort as you need to know how to install / manage the plugins required to make this work.
When first loading your `nvim` you may get some Errors since the plug-in manager needs to be installed.

Follow along here: https://github.com/junegunn/vim-plug to install `Plug`

Once `Plug` is installed, you can install / fetch all the plugins defined in the configuration with `:PlugInstall`

Note: I did have to manually clone the vim-slime repo into my `~/.config/nvim/plugged` folder since `Plug` didn't seem to want to download it, however it picked it up after I had cloned it manually. Note (this isn't really required unless you plan to use IPython in a separate TMUX pane).

## Language Servers
You can issue a `:LspInfo`, `:LspInstall pyright bashls terraformls tflint` to get the language servers once the plugins have been loaded.

## Copilot
Once the plugins are installed you should be able to activate GitHub Copilot with the following command: `:Copilot` this only has to be done once.

## Extras

Any extra directions or configurations you can follow along by reading the `init.vim` file.
To open this in nvim use the `,ec` command, and once you save any modifications you can hot-reload the configuration with `,sc`

## Usage
Use `nvim` as usual for editing.

When editing a Python project with poetry managed dependencies you can use the `vimde` command assuming you've added it to your path which will just call the tmuxp with the vimde.yaml configuration.
