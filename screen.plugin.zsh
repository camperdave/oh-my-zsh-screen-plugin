# camperdave's screen config'ing plugin 
# Defined as a plugin, so it works with every theme.
# Hopefully people like that?

autoload -U add-zsh-hook


### Magic Functions
camperdave-screen-set-title(){
    printf "\033k%s\033\\" "$1"
}

camperdave-screen-set-hard(){
    printf  "\033]0;%s\a" "$1"
}

camperdave-sceen-preexec(){
    ## Screen-Specific
    
    if [[ $TERM == *screen* ]]; then
        TITLE="${PWD/#$HOME/~}"
        s=$3;
        arg=("${(s/ /)s}")
        cmd=$arg[1]
        if [[ $cmd == "ssh" ]]; then
            TITLE=$arg[2]
        fi
        
        camperdave-screen-set-title $TITLE
        
        HARD="${$(echo $3 | sed -r 's/^command sudo ([^ ]*) .*/\1/;tx;s/^([^ ]*) +.*/\1/;s/^([^ ]*)$/\1/;:x;q')/#*\/}"
        camperdave-screen-set-hard $HARD
    fi
}

camperdave-sceen-precmd(){
    ## Screen-Specific
    if [[ $TERM == *screen* ]]; then
        TITLE="${PWD/#$HOME/~}"
        HARD="zsh"
        camperdave-screen-set-title $TITLE 
        camperdave-screen-set-hard $HARD
    fi
}

add-zsh-hook precmd camperdave-sceen-precmd

add-zsh-hook preexec camperdave-sceen-preexec
