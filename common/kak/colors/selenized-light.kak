####################
# SELENIZED LIGHT  #
####################
# theme by Jan Warchoł
# ported by TeddyDD

evaluate-commands %sh{

bg='rgb:fbf3db'
black='rgb:ece3cc'
br_black='rgb:d5cdb6'
white='rgb:909995'
fg='rgb:53676d'
br_white='rgb:3a4d53'

red='rgb:d2212d'
green='rgb:489100'
yellow='rgb:ad8900'
blue='rgb:0072d4'
magenta='rgb:ca4898'
cyan='rgb:009c8f'
orange='rgb:c25d1e'
violet='rgb:8762c6'

br_red='rgb:cc1729'
br_green='rgb:428b00'
br_yellow='rgb:a78300'
br_blue='rgb:006dce'
br_magenta='rgb:c44392'
br_cyan='rgb:00978a'
br_orange='rgb:bc5819'
br_violet='rgb:825dc0'

## code
echo "
set-face global value ${orange}+b
set-face global type ${br_orange}
set-face global variable ${magenta}
set-face global module ${green}
set-face global function ${br_cyan}
set-face global string ${green}
set-face global keyword ${violet}+b
set-face global operator ${br_cyan}
set-face global attribute ${orange}
set-face global comment ${br_black}
set-face global meta ${br_orange}
set-face global builtin ${fg}+b
"

## markup
echo "
set-face global title ${blue}+u
set-face global header ${br_cyan}
set-face global bold ${br_orange}+b
set-face global italic ${orange}+i
set-face global mono ${green}
set-face global block ${orange}
set-face global link $blue
set-face global bullet ${br_magenta}
set-face global list ${magenta}
"

echo "
set-face global Default ${br_white},${bg}
set-face global PrimarySelection ${fg},$br_black+i
set-face global SecondarySelection $black,$white
set-face global PrimaryCursor $black,$red+b
set-face global SecondaryCursor $bg,$br_cyan+i
set-face global MatchingChar $black,$blue
set-face global Search $br_white,$green
set-face global CurrentWord $white,$blue

# when item focused in menu
set-face global MenuForeground $orange,$br_black+d
# default bottom menu and autocomplete
set-face global MenuBackground $fg,$black

set-face global Information $yellow,$black
set-face global Error $black,$red

set-face global BufferPadding $black,$black
set-face global Whitespace $br_black
set-face global StatusLine $fg,$br_black
set-face global StatusLineInfo $blue,$br_black

set-face global LineNumbers default
set-face global LineNumberCursor default,default+r
"

}
