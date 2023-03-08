
# Storing these color codes for later use
txtblk='\033[0;30m' # Black - Regular
txtred='\033[0;31m' # Red
txtgrn='\033[0;32m' # Green
txtylw='\033[0;33m' # Yellow
txtblu='\033[0;34m' # Blue
txtpur='\033[0;35m' # Purple
txtcyn='\033[0;36m' # Cyan
bldblk='\033[1;30m' # Black - Bold
bldred='\033[1;31m' # Red
bldgrn='\033[1;32m' # Green
bldylw='\033[1;33m' # Yellow
bldblu='\033[1;34m' # Blue
bldpur='\033[1;35m' # Purple
bldcyn='\033[1;36m' # Cyan

# Set color for the directory listing in the prompt
dir_listing_color=$bldgrn

# Set colors for different repository states
unmerged_color=$bldred
unstaged_color=$bldpur
staged_color=$bldcyn
clean_color=$bldblu

function git_color {
    git_status=`git status 2> /dev/null`

    if [ -n "`echo $git_status | grep "# Unmerged paths:"`" ]; then
        echo -e $unmerged_color
    elif [ -n "`echo $git_status | grep "# Changes not staged for commit:"`" ]; then
        echo -e $unstaged_color
    elif [ -n "`echo $git_status | grep "# Changes to be committed:"`" ]; then
        echo -e $staged_color
    else
        echo -e $clean_color
    fi
}

function git_branch {
    git_branch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ -n  "`git status 2> /dev/null | grep "# Untracked files:"`" ]; then
        untracked="*"
    fi
    echo $git_branch$untracked
}

PS1='\[`echo -e $dir_listing_color`\]\w \[`git_color`\](`git_branch`) \[\e[0m\]👾 $ '
