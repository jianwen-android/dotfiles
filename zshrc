# --- Powerlevel10k instant prompt (must stay near the top) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Path to oh-my-zsh installation ---
export ZSH="$HOME/.oh-my-zsh"

# --- Theme ---
ZSH_THEME="powerlevel10k/powerlevel10k"

# Confirmed by: setopt dump shows `correctall` active, and alias dump is
# full of `nocorrect <cmd>` aliases — both only appear when this is "true".
ENABLE_CORRECTION="true"

# --- Plugins ---
plugins=(
  git
  nvm
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# --- Powerlevel10k config ---
# If ~/.p10k.zsh also got deleted, run `p10k configure` to regenerate it.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- pyenv (confirmed via PYENV_ROOT / pyenv-virtualenv shims in PATH;
# not an oh-my-zsh plugin, so it must be initialized manually) ---
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# --- NVM ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# --- Android SDK (confirmed var name: ANDROID_SDK, not ANDROID_HOME) ---
export ANDROID_SDK="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_SDK/platform-tools"

# --- Misc confirmed exports ---
export EDITOR=vim
export PAGER=less
export LESS=-R
export LSCOLORS=Gxfxcxdxbxegedabagacad
export YDIFF_OPTIONS='-s -c auto -w 0 --wrap'

# --- ANTHROPIC ---
export ANTHROPIC_AUTH_TOKEN=sk-af6c2dd87a1ed122-38f3e0-f87fb229
export ANTHROPIC_BASE_URL=http://pi-pwa:20128
export ANTHROPIC_MODEL=free-stack

# VERIFY: LDFLAGS pointed at the Xcode SDK — likely needed for building
# native extensions (pyenv/pip packages that compile C code). Uncomment
# if `pip install` or `pyenv install` starts failing on missing headers.
# export LDFLAGS="-L/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib"

# VERIFY: pip user-installed scripts — common, but not proven to be from
# your old .zshrc specifically.
export PATH="$HOME/.local/bin:$PATH"

# TEST --- POLAR FLOW ---
export POLAR_CLIENT_ID="40c52e6f-d07c-43ca-abca-c8066bc31363"
export POLAR_CLIENT_SECRET="7ad38e36-1d10-4307-ae37-63070649e32a"


# VERIFY: Obsidian CLI on PATH — unusual enough to flag. Only needed if
# you were running Obsidian from the command line.
# export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

# --- Custom aliases ---
alias emulator='~/Library/Android/sdk/tools/emulator'
alias adbremove='adb shell pm uninstall --user 0'
alias pngtowebp='/usr/local/bin/dwebp -o'
alias scrcpys='scrcpy -Sw -m 1480'
alias pi-pwa='ssh jianw@100.80.216.41'
alias zshconfig='vim ~/.zshrc && source ~/.zshrc && cp ~/.zshrc ~/.zshrc.bak'

# --- nocorrect ---
alias bclm='nocorrect bclm'
alias claude='nocorrect claude'
alias code='nocorrect code'
alias ebuild='nocorrect ebuild'
alias gist='nocorrect gist'
alias heroku='nocorrect heroku'
alias hpodder='nocorrect hpodder'
alias link='nocorrect link'
alias mysql='nocorrect mysql'
alias ncu='nocorrect ncu'
alias ydiff='nocorrect ydiff'
