##################
# SELENIZED DARK #
##################
# theme by Jan Warchoł
# ported by Delapouite

evaluate-commands %sh{

bg="rgb:103c48"
black="rgb:184956"
br_black="rgb:2d5b69"
white="rgb:72898f"
fg="rgb:adbcbc"
br_white="rgb:cad8d9"

red="rgb:fa5750"
green="rgb:75b938"
yellow="rgb:dbb32d"
blue="rgb:4695f7"
magenta="rgb:f275be"
cyan="rgb:41c7b9"
orange="rgb:ed8649"
violet="rgb:af88eb"

br_red="rgb:ff665c"
br_green="rgb:84c747"
br_yellow="rgb:ebc13d"
br_blue="rgb:58a3ff"
br_magenta="rgb:ff84cd"
br_cyan="rgb:53d6c7"
br_orange="rgb:fd9456"
br_violet="rgb:bd96fa"

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
