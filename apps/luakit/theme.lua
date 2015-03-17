--------------------------
-- Default luakit theme --
--------------------------

local theme = {}

-- Default settings
theme.font = "Open Sans normal 10"
theme.fg   = "#fff"
theme.bg   = "#111"

-- Genaral colours
theme.success_fg = "#a6e22e"
theme.loaded_fg  = "#66d9ef"
theme.error_fg = "#f8f8f8"
theme.error_bg = "#f92672"

-- Warning colours
theme.warning_fg = "#f92672"
theme.warning_bg = "#111111"

-- Notification colours
theme.notif_fg = "#f8f8f8"
theme.notif_bg = "#111111"

-- Menu colours
theme.menu_fg                   = "#f8f8f8"
theme.menu_bg                   = "#111111"
theme.menu_selected_fg          = "#111111"
theme.menu_selected_bg          = "#f4bf75"
theme.menu_title_bg             = "#111111"
theme.menu_primary_title_fg     = "#f92672"
theme.menu_secondary_title_fg   = "#666666"

-- Proxy manager
theme.proxy_active_menu_fg      = '#f8f8f8'
theme.proxy_active_menu_bg      = '#111111'
theme.proxy_inactive_menu_fg    = '#888888'
theme.proxy_inactive_menu_bg    = '#111111'

-- Statusbar specific
theme.sbar_fg         = "#f8f8f8"
theme.sbar_bg         = "#111111"

-- Downloadbar specific
theme.dbar_fg         = "#f8f8f8"
theme.dbar_bg         = "#111111"
theme.dbar_error_fg   = "#f92672"

-- Input bar specific
theme.ibar_fg           = "#f8f8f8"
theme.ibar_bg           = "#111111"

-- Tab label
theme.tab_fg            = "#888888"
theme.tab_bg            = "#222222"
theme.tab_ntheme        = "#dddddd"
theme.selected_fg       = "#f8f8f8"
theme.selected_bg       = "#111111"
theme.selected_ntheme   = "#dddddd"
theme.loading_fg        = "#66d9ef"
theme.loading_bg        = "#111111"

-- Trusted/untrusted ssl colours
theme.trust_fg          = "#a6e22e"
theme.notrust_fg        = "#f92672"

return theme
-- vim: et:sw=4:ts=8:sts=4:tw=80
