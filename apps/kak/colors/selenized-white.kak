###################
# SELENIZED WHITE #
###################
# theme by Jan Warchoł
# ported by Delapouite

evaluate-commands %sh{

bg='rgb:ffffff'
black='rgb:ebebeb'
br_black='rgb:cdcdcd'
white='rgb:878787'
fg='rgb:474747'
br_white='rgb:282828'

red='rgb:d6000c'
green='rgb:1d9700'
yellow='rgb:c49700'
blue='rgb:0064e4'
magenta='rgb:dd0f9d'
cyan='rgb:00ad9c'
orange='rgb:d04a00'
violet='rgb:7f51d6'

br_red='rgb:bf0000'
br_green='rgb:008400'
br_yellow='rgb:af8500'
br_blue='rgb:0054cf'
br_magenta='rgb:c7008b'
br_cyan='rgb:009a8a'
br_orange='rgb:ba3700'
br_violet='rgb:6b40c3'

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
