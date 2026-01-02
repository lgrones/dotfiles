autoload -Uz promptinit
promptinit

precmd() { print "" }

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# pacman aliases
[ -s "$HOME/.config/pacman/pacman-aliases.zsh" ] && source "$HOME/.config/pacman/pacman-aliases.zsh"

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh --cmd cd)"
fi

# thefuck
if command -v thefuck &>/dev/null; then
    eval $(thefuck --alias fuck)
fi

# bare config repo alias
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# customization
[ -s "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -s "$HOME/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh" ] && source "$HOME/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh"

if command -v oh-my-posh &>/dev/null; then
	eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/catppuccin.omp.json)"
fi
