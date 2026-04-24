# vim:ft=zsh ts=2 sw=2 sts=2
#
# Zagnoster Theme - A rainbow Powerline-inspired theme for ZSH
# Based on agnoster's Theme with git-duet support
#
# Requires a Powerline-patched font.

### Segment drawing

CURRENT_BG='NONE'

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  SEGMENT_SEPARATOR=$'\ue0b0'
}

# Rainbow color palette
typeset -a RAINBOW_COLORS
RAINBOW_COLORS=(red yellow green cyan blue magenta)
RAINBOW_INDEX=1

# Get next rainbow color and advance
next_rainbow_color() {
  REPLY=$RAINBOW_COLORS[$RAINBOW_INDEX]
  RAINBOW_INDEX=$(( (RAINBOW_INDEX % ${#RAINBOW_COLORS[@]}) + 1 ))
}

prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# Rainbow segment — auto-picks the next color in the cycle
rainbow_segment() {
  next_rainbow_color
  local bg=$REPLY
  # Use black text for light backgrounds, white for dark
  local fg=black
  [[ $bg == "blue" || $bg == "magenta" || $bg == "red" ]] && fg=white
  prompt_segment $bg $fg "$1"
}

prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    rainbow_segment "%(!.%{%F{yellow}%}.)%m"
  fi
}

prompt_git_duet() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    local author=$(git config duet.env.git-author-initials)
    local committer=$(git config duet.env.git-committer-initials)
    if [[ -n $author ]]; then
      local duet_str="${author}"
      [[ -n $committer ]] && duet_str="${author} ${committer}"
      rainbow_segment "$duet_str"
    fi
  fi
}

prompt_git() {
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'
  }
  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"

    # Dirty repos get yellow (warning), clean repos get the next rainbow color
    if [[ -n $dirty ]]; then
      prompt_segment yellow black
    else
      next_rainbow_color
      prompt_segment $REPLY black
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info

    upstream_branch_name="$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)"
    if [ -n "$upstream_branch_name" ]; then
      branch_name="$(git rev-parse --abbrev-ref HEAD)"
      diff_up="$(git rev-list HEAD..$upstream_branch_name --count)"
      diff_down="$(git rev-list $upstream_branch_name..HEAD --count)"

      if [[ $diff_up != "0" ]]; then
        echo -n "$diff_up↓ "
      fi

      if [[ $diff_down != "0" ]]; then
        echo -n "$diff_down↑ "
      fi
    fi

    echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"
  fi
}

prompt_dir() {
  rainbow_segment '%~'
}

prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    rainbow_segment "(`basename $virtualenv_path`)"
  fi
}

prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  RAINBOW_INDEX=1
  prompt_status
  prompt_dir
  prompt_git_duet
  prompt_git
  prompt_virtualenv
  prompt_context
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '
