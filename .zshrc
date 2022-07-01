# Limit number of shell processes
ulimit -n 1024

# Keybindings set to vim
bindkey -v

# History settings
setopt histignorealldups sharehistory

# Keep 5000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# Autocompletion
autoload -Uz compinit && compinit

     RED='%F{red}'
   GREEN='%F{green}'
  YELLOW='%F{yellow}'
    BLUE='%F{blue}'
 MAGENTA='%F{magenta}'
    CYAN='%F{cyan}'
   RESET='%f'

NEWLINE=$'\n'

function parse_git_branch {
  git rev-parse --git-dir > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    git_status="$(git status 2> /dev/null)"
    branch_pattern="^On branch ([^${NEWLINE}]*)"
    detached_branch_pattern="detached"
    remote_pattern="Your branch is (.*) of"
    diverge_pattern="Your branch and (.*) have diverged"
    untracked_pattern="Untracked files:"
    staged_pattern="(new file|modified):"
    not_staged_pattern="Changes not staged for commit"

    #staged files
    if [[ ${git_status} =~ ${staged_pattern} ]]; then
      staged=" 💡"
    #files not staged for commit
    elif [[ ${git_status} =~ ${not_staged_pattern} ]]; then
      staged=" 👻"
    fi
    #untracked files
    if [[ ${git_status} =~ ${untracked_pattern} ]]; then
      untracked=" 👽"
    fi
    # add an else if or two here if you want to get more specific
    # show if we're ahead or behind HEAD
    if [[ ${git_status} =~ ${remote_pattern} ]]; then
      if [[ ${match[1]} == "ahead" ]]; then
        remote=" 😺"
      else
        remote=" 😿"
      fi
    fi
    #diverged branch
    if [[ ${git_status} =~ ${diverge_pattern} ]]; then
      remote=" 🙀"
    fi
    #branch name
    if [[ ${git_status} =~ ${branch_pattern} ]]; then
      branch="(${match[1]})"
    #detached branch
    elif [[ ${git_status} =~ ${detached_branch_pattern} ]]; then
      branch="☠️"
    fi

    echo " ${branch}${untracked}${staged}${remote}"
  fi
  return
}

function prompt_func() {
  prompt="${NEWLINE}[ %D{%Y-%m-%d} %T | $USER@%m : %~${GREEN}$(parse_git_branch)${RESET} ]${NEWLINE}> "
}

PROMPT_COMMAND=prompt_func
precmd() { eval "$PROMPT_COMMAND" }

# zplug - manage plugins
[ -s "/opt/homebrew/opt/zplug/init.zsh" ] && \. "/opt/homebrew/opt/zplug/init.zsh"
[ -s "/usr/local/opt/zplug/init.zsh" ] && \. "/usr/local/opt/zplug/init.zsh"
[ -s "/usr/share/zplug/init.zsh" ] && \. "/usr/share/zplug/init.zsh"
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"

# zplug - install/load new plugins when zsh is started or reloaded
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
zplug load

# Aliases
alias grep="grep --color=auto"

# Aliases for GitHub
alias gitclean="git checkout develop && git branch --merged | egrep -v \"(^\*|main|develop)\" | xargs git branch -d"

# Aliases for Docker
alias dcleanc="docker rm -v \$(docker ps -a -f status=exited -q)"
alias dcleani="docker rmi \$(docker images -a -f dangling=true -q)"
alias dcleanv="docker volume rm \$(docker volume ls -f dangling=true -f name=\"[0-9a-f]{64}\" -q)"
alias dclean="dcleanc; dcleani; dcleanv"

# Aliases for docker-compose
alias dc="docker-compose"
alias dcup="docker-compose up -d"
alias dcub="docker-compose up --build -d"
alias dcd="docker-compose down --remove-orphans"
alias dcr="docker-compose run --rm"
alias dcl="docker-compose logs"
alias dcps="docker-compose ps"
