export PATH=/usr/local/bin:$PATH

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### BELOW THIS LINE ARE EXPERIMENTS MADE ON JULY 11
### Look at http://alias.sh/ for more

# For rubby development
which -s bundle && alias be="bundle exec"

# Open GitHub webpage of current git repo
function github() {
  local github_url

  if ! git remote -v >/dev/null; then
    return 1
  fi

  # get remotes for fetch
  github_url="`git remote -v | grep github\.com | grep \(fetch\)$`"

  if [ -z "$github_url" ]; then
    echo "A GitHub remote was not found for this repository."
    return 1
  fi

  # look for origin in remotes, use that if found, otherwise use first result
  if [ "echo $github_url | grep '^origin' >/dev/null 2>&1" ]; then
    github_url="`echo $github_url | grep '^origin'`"
  else
    github_url="`echo $github_url | head -n1`"
  fi

  github_url="`echo $github_url | awk '{ print $2 }' | sed 's/git@github\.com:/http:\/\/github\.com\//g'`"
  open $github_url
}
# Make and cd into a directory
function mcd() {
  mkdir -p "$1" && cd "$1";
}

# Find a string in the entire git history
alias gitsearch='git rev-list --all | xargs git grep -F'

# Some tests with git common commands
alias gc='git commit -vm'
alias ga='git add'
alias gr='git rm'
alias gs='git status'
alias gco='git checkout'
alias gcom='git checkout master'
alias gpo='git push origin'
alias gp='git push'
alias gph='git push heroku master'
alias gb='git branch'

# Some tests with database commands in development
alias boom='be rake db:drop; be rake db:create && be rake db:migrate'
alias seed='be rake db:drop; be rake db:create && be rake db:migrate && rake db:seed'
alias booms='be rake db:drop; be rake db:create && be rake db:migrate && rails s'
alias seeds='be rake db:drop; be rake db:create && be rake db:migrate && rake db:seed && rails s'

# Opens bash profile
alias bp='subl ~/.bash_profile'

# Creates regenerating Jekyll server
alias js='jekyll serve --watch'

# Shows name (in cyan), current working directory (in green), current branch (in pink)
PS1='\[\e[1;96m\]\u: \[\e[0;32m\]\W \[\033[00m\]$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "\[\e[0;35m\][$(git branch | grep ^*|sed s/\*\ //)] \[\033[00m\]"; fi)>> '

# grab git branch & branch autocomplete
parse_git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'; }

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
# Some aliases for great purpose!
alias desk='cd ~/Desktop'
alias ls='ls -GFh'
alias code='cd ~/Documents/Projects'
alias reload='source ~/.bash_profile'