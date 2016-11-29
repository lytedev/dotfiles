#!/usr/bin/env sh

XRES_FILE="$HOME/.Xresources"
if [ -a "$HOME/.Xresources.env" ]; then
  XRES_FILE="$HOME/.Xresources.env"
fi

PRIMARY_FONT_XRESOURCES=$(grep "^#define primaryfont xft:" "$XRES_FILE" | grep -v "/\*" | head -n 1)
export PRIMARY_FONT_FAMILY_WITH_SIZE=${PRIMARY_FONT_XRESOURCES:24}
export PRIMARY_FONT_FAMILY=$(echo $PRIMARY_FONT_FAMILY_WITH_SIZE | sed 's/\-.*//')
export PRIMARY_FONT_SIZE=$(echo $PRIMARY_FONT_FAMILY_WITH_SIZE | sed 's/.*\-//')

SECONDARY_FONT_XRESOURCES=$(grep "^#define secondaryfont xft:" "$XRES_FILE" | grep -v "/\*" | head -n 1)
export SECONDARY_FONT_FAMILY_WITH_SIZE=${SECONDARY_FONT_XRESOURCES:26}
export SECONDARY_FONT_FAMILY=$(echo $SECONDARY_FONT_FAMILY_WITH_SIZE | sed 's/\-.*//')
export SECONDARY_FONT_SIZE=$(echo $SECONDARY_FONT_FAMILY_WITH_SIZE | sed 's/.*\-//')

ICON_FONT_XRESOURCES=$(grep "^#define iconfont xft:" "$XRES_FILE" | grep -v "/\*" | head -n 1)
export ICON_FONT_FAMILY_WITH_SIZE=${ICON_FONT_XRESOURCES:21}
export ICON_FONT_FAMILY=$(echo $ICON_FONT_FAMILY_WITH_SIZE | sed 's/\-.*//')
export ICON_FONT_SIZE=$(echo $ICON_FONT_FAMILY_WITH_SIZE | sed 's/.*\-//')

