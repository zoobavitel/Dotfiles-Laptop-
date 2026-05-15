if status is-interactive
    # Aliases
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias dot='git --git-dir=/home/z/git/Dotfiles-Laptop-/.git --work-tree=/home/z'
    # PATH
    fish_add_path ~/.local/bin
    # STARSHIP
    starship init fish | source
    # ANIFETCH
    anifetch example.mp4 -W 80 -H 22 -r 24 -ca "--symbols block --fg-only"
end


# Win95-ish colors
set fish_color_command brwhite       # commands
set fish_color_param white           # arguments
set fish_color_error brred           # errors
set fish_color_comment 555           # comments (dark gray)
set fish_color_quote yellow          # strings
set fish_color_autosuggestion 555    # ghost suggestions (dark gray)
set fish_color_operator cyan
set fish_color_valid_path --underline
set fish_greeting ""
