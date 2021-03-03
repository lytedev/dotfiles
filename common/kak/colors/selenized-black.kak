####################
# SELENIZED BLACK  #
####################
# theme by Jan Warchoł
# ported by TeddyDD

evaluate-commands %sh{

bg="rgb:181818"
black="rgb:252525"
br_black="rgb:3b3b3b"
white="rgb:777777"
fg="rgb:b9b9b9"
br_white="rgb:dedede"

red="rgb:ed4a46"
green="rgb:70b433"
yellow="rgb:dbb32d"
blue="rgb:368aeb"
magenta="rgb:eb6eb7"
cyan="rgb:3fc5b7"
orange="rgb:e67f43"
violet="rgb:a580e2"

br_red="rgb:ff5e56"
br_green="rgb:83c746"
br_yellow="rgb:efc541"
br_blue="rgb:4f9cfe"
br_magenta="rgb:ff81ca"
br_cyan="rgb:56d8c9"
br_orange="rgb:fa9153"
br_violet="rgb:b891f5"

## code
echo "
set-face global value ${orange}+b
set-face global type ${br_orange}
set-face global variable ${magenta}
set-face global module ${blue}
set-face global function ${br_cyan}
set-face global string ${br_green}
set-face global keyword ${violet}+b
set-face global operator ${br_cyan}
set-face global attribute ${orange}
set-face global comment ${white}
set-face global meta ${br_orange}
set-face global builtin ${fg}+b

set-face global title ${blue}+u
set-face global header ${br_cyan}+u
set-face global bold ${br_white}+b
set-face global italic ${br_white}+i
set-face global mono ${br_green}
set-face global block ${orange}
set-face global link $blue
set-face global bullet ${br_magenta}
set-face global list ${magenta}

set-face global Default ${fg},${bg}
set-face global PrimarySelection $black,$white
set-face global SecondarySelection ${fg},$br_black+i
set-face global PrimaryCursor $bg,$red+b
set-face global SecondaryCursor $black,$br_cyan+i
set-face global MatchingChar $black,$blue
set-face global Search $br_white,$green
set-face global CurrentWord $white,$blue

set-face global MenuForeground $cyan,$br_black+b
set-face global MenuBackground $fg,$black

set-face global Information $br_yellow,$black
set-face global Error $black,$br_red

set-face global BufferPadding $black,$black
set-face global Whitespace $white
set-face global StatusLine $fg,$black
set-face global StatusLineInfo $yellow,$black

set-face global LineNumbers default
set-face global LineNumberCursor default,default+r
"

}
