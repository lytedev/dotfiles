{ pkgs, ... }: {
  # TODO: email access?
  # accounts.email.accounts = {
  #   google = {
  #     address = "wraithx2@gmail.com";
  #   };
  # };

  home.username = "daniel";
  home.homeDirectory = "/home/daniel/.home";
  home.stateVersion = "23.05";

  home.packages = [

  ];

  programs.broot = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  # programs.nix-direnv.enable = true;

  programs.fish = {
    enable = true;
    shellInit = ''
      # paths
      if not set --query NICE_HOME
        set --export --universal NICE_HOME $HOME

        # if HOME ends with a dir called .home, assume that NICE_HOME is HOME's parent dir
        test (basename $HOME) = .home \
          && set --export --universal NICE_HOME (realpath $HOME/..)
      end

      set --export --universal XDG_CONFIG_HOME $HOME/.config
      set --export --universal XDG_CACHE_HOME $HOME/.cache
      set --export --universal XDG_DATA_HOME $HOME/.local/share
      set --export --universal XDG_STATE_HOME $HOME/.local/state
      set --export --universal XDG_DESKTOP_DIR $HOME/desktop
      set --export --universal XDG_PUBLICSHARE_DIR $HOME/public
      set --export --universal XDG_TEMPLATES_DIR $HOME/templates
      set --export --universal XDG_DOCUMENTS_DIR $NICE_HOME/doc
      set --export --universal XDG_DOWNLOAD_DIR $NICE_HOME/dl
      set --export --universal XDG_MUSIC_DIR $NICE_HOME/music
      set --export --universal XDG_PICTURES_DIR $NICE_HOME/img
      set --export --universal XDG_VIDEOS_DIR $NICE_HOME/video
      set --export --universal XDG_GAMES_DIR $NICE_HOME/games

      set --export --universal DOTFILES_PATH $XDG_CONFIG_HOME/lytedev-dotfiles
      set --export --universal ENV_PATH $XDG_CONFIG_HOME/lytedev-env
      set --export --universal FISH_PATH $XDG_CONFIG_HOME/fish

      set --export --universal NOTES_PATH $NICE_HOME/doc/notes
      set --export --universal SCROTS_PATH $NICE_HOME/img/scrots
      set --export --universal USER_LOGS_PATH $NICE_HOME/doc/logs

      for s in $ENV_PATH/*/config.d.fish
        source $s (dirname $s)
      end

      # vars
      set --export --universal LS_COLORS 'ow=01;36;40'
      set --export --universal EXA_COLORS '*=0'

      set --export --universal ERL_AFLAGS "-kernel shell_history enabled -kernel shell_history_file_bytes 1024000"

      set --export --universal BROWSER firefox

      set --export --universal EDITOR hx
      set --export --universal VISUAL hx

      # TODO: helix ($EDITOR) as man/pager
      set --export --universal PAGER "less"
      set --export --universal MANPAGER "less"

      set --export --universal SOPS_AGE_KEY_FILE "$XDG_CONFIG_HOME/sops/age/keys.txt"

      set --export --universal SKIM_ALT_C_COMMAND "fd --hidden --type directory"
      set --export --universal SKIM_CTRL_T_COMMAND "fd --hidden"

      # colors
      set -U fish_color_normal normal # default color
      set -U fish_color_command white # base command being run (>ls< -la)
      set -U fish_color_param white # command's parameters
      set -U fish_color_end green # command delimiter/separators (; and &)
      set -U fish_color_error red # color of errors
      set -U fish_color_escape yellow # color of escape codes (\n, \x2d, etc.)
      set -U fish_color_operator blue # expansion operators (~, *)
      set -U fish_color_quote yellow
      set -U fish_color_redirection blue # redirection operators (|, >, etc.)
      set -U fish_color_cancel 333 brblack # sigint at prompt (^C)
      set -U fish_color_autosuggestion 666 brblack # as-you-type suggestions
      set -U fish_color_match blue # matching parens and the like
      set -U fish_color_search_match white\x1e\x2d\x2dbackground\x3d333 # selected pager item
      set -U fish_color_selection blue # vi mode visual selection (only fg)
      set -U fish_color_valid_path yellow # if an argument is a valid path (only -u?)
      set -U fish_color_comment 666 brblack # comments like this one!

      set -U fish_pager_color_completion white # main color for pager
      set -U fish_pager_color_description magenta # color for meta description
      set -U fish_pager_color_prefix blue # the string being completed
      set -U fish_pager_color_progress white\x1e\x2d\x2dbackground\x3d333 # status indicator at the bottom
      # set -U fish_pager_color_secondary \x2d\x2dbackground\x3d181818 # alternating rows

      function has_command --wraps=command --description "Exits non-zero if the given command cannot be found"
        command --quiet --search $argv[1]
      end
    '';
    # TODO: rtx?
    # TODO: homebrew?
    # TODO: asdf?
    # TODO: direnv?
    # TODO: pass and pass-otp
    # TODO: kitty integration
    # TODO: zellij and/or tmux?
    functions = {
      d = ''
        # --wraps=cd --description "Quickly jump to NICE_HOME (or given relative or absolute path) and list files."
        if count $argv > /dev/null
          cd $argv
        else
          cd $NICE_HOME
        end
        la
      '';

      c = ''
        if count $argv > /dev/null
          cd $NICE_HOME && d $argv
        else
          d $NICE_HOME
        end
      '';

      g = ''
        if count $argv > /dev/null
          git $argv
        else
          git status
        end
      '';

      ltl = ''
        set d $argv[1] .
        set -l l ""
        for f in $d[1]/*
          if test -z $l; set l $f; continue; end
          if command test $f -nt $l; and test ! -d $f
            set l $f
          end
        end
        echo $l
      '';
    };
    interactiveShellInit = ''
      # prompt
      function get_hostname
        if test (uname) = Linux || test (uname) = Darwin
          has_command hostname && hostname | cut -d. -f1 || cat /etc/hostname
        else
          # assume bsd
          hostname | head -n 1 | cut -d. -f1
        end
      end

      function fish_greeting
        _prompt_prefix
        printf "%s\n" (date)
      end

      function preprocess_pwd
        test (pwd) = / && echo "/" && return 1
        test (pwd) = $NICE_HOME && echo "~" && return 0
        pwd \
          | cut -c2- \
          | gawk '{n=split($0,p,"/");for(i=1;i<=n;i++){if(i==n){printf "/%s",p[i]}else{printf "/%.3s",p[i]}}}'
      end

      function _maybe_sudo_prefix
        if set -q SUDO_USER
          set_color -b yellow black
          printf " SUDO "
          set_color -b normal normal
          printf " "
        end
      end

      function _maybe_aws_profile
        if set -q AWS_PROFILE && test $AWS_PROFILE = prd
          printf " "
          set_color -b yellow black
          printf " AWS_PROFILE=prd "
          set_color -b normal normal
        end
      end

      function _user_and_host
        if test $argv[1] -eq 0
          set_color -b normal blue
        else
          set_color -b normal red
        end
        printf "%s@%s" $USER (get_hostname)
      end

      function _cur_work_dir
        set_color -b normal magenta
        printf " %s" (preprocess_pwd)
      end

      function _last_cmd_duration
        set_color -b normal green
        set -q CMD_DURATION && printf " %dms" $CMD_DURATION
      end

      function _maybe_jobs_summary
        if jobs -q
          set_color -b normal cyan
          printf " &%d" (jobs -p | wc -l)
        end
      end

      function _user_prompt
        printf "\n"
        set_color brblack
        if test (id -u) -eq 0
          printf '# '
        else
          printf '$ '
        end
        set_color -b normal normal
      end

      function _maybe_git_summary
        set_color -b normal yellow
        set cur_sha (git rev-parse --short HEAD 2>/dev/null)
        if test $status = 0
          set num_changes (git status --porcelain | wc -l | string trim)
          if test $num_changes = 0
            set num_changes "✔"
          else
            set num_changes "+$num_changes"
          end
          printf " %s %s %s" (git branch --show-current) $cur_sha $num_changes
        end
      end

      function _prompt_marker
        printf "%b133;A%b" "\x1b\x5d" "\x1b\x5c"
      end

      function _prompt_continuation_marker
        printf "%b133;A;k=s%b" "\x1b\x5d" "\x1b\x5c"
      end

      function cmd_marker --on-variable _
        printf "%b133;C%b" "\x1b\x5d" "\x1b\x5c"
      end

      function _prompt_prefix
        set_color -b normal brblack
        printf "# "
      end

      function fish_prompt
        set last_cmd_status $status
        _prompt_marker
        _prompt_prefix
        _maybe_sudo_prefix
        _user_and_host $last_cmd_status
        _cur_work_dir
        _maybe_git_summary
        _maybe_aws_profile
        _last_cmd_duration
        _maybe_jobs_summary
        _user_prompt
      end

      function fish_mode_prompt; end
      function fish_right_prompt; end

      # key bindings
      set normal_mode "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"

      bind -M insert \cg skim-cd-widget
      bind -M insert jk $normal_mode
      bind -M insert jK $normal_mode
      bind -M insert Jk $normal_mode
      bind -M insert JK $normal_mode
      bind -M insert jj $normal_mode
      bind -M insert jJ $normal_mode
      bind -M insert Jj $normal_mode
      bind -M insert JJ $normal_mode

      bind -M insert \cp up-or-search
      bind -M insert \cn down-or-search
      bind -M insert \ce end-of-line
      bind -M insert \ca beginning-of-line

      bind -M insert \cv edit_command_buffer
      bind -M default \cv edit_command_buffer
    '';
    loginShellInit = ''
        '';
    shellAbbrs = { };
    shellAliases = {
      l = "br";
      ls = "exa --group-directories-first --classify";
      la = "exa -la --group-directories-first --classify";
      lA = "exa -la --all --group-directories-first --classify";
      tree = "exa --tree --level=3";
      lt = "exa -l --sort=modified";
      lat = "exa -la --sort=modified";
      lc = "lt --sort=accessed";
      lT = "lt --reverse";
      lC = "lc --reverse";
      lD = "la --only-dirs";
      "cd.." = "d ..";
      "cdd" = "d $DOTFILES_PATH";
      "cde" = "d $XDG_CONFIG_HOME/lytedev-env";
      "cdc" = "d $XDG_CONFIG_HOME";
      "cdn" = "d $NOTES_PATH";
      "cdl" = "d $XDG_DOWNLOAD_DIR";
      "cdg" = "d $XDG_GAMES_DIR";
      ".." = "d ..";
      "..." = "d ../..";
      "...." = "d ../../..";
      "....." = "d ../../../..";
      "......" = "d ../../../../..";
      "......." = "d ../../../../../..";
      "........" = "d ../../../../../../..";
      "........." = "d ../../../../../../../..";
      cat = "bat";
      dc = "docker compose";
      k = "kubectl";
      kg = "kubectl get";
      v = "$EDITOR";
      sv = "sudo $EDITOR";
      kssh = "kitty +kitten ssh";
    };
  };

  programs.exa.enable = true;

  # TODO: move all fish config into here so that this will work?
  programs.skim = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.pointerCursor = {
    name = "Catppuccin-Mocha-Sapphire-Cursors";
    package = pkgs.catppuccin-cursors.mochaSapphire;
    size = 64; # TODO: this doesn't seem to work -- at least in Sway
  };

  programs.firefox = {
    enable = true;

    package = (pkgs.firefox.override { extraNativeMessagingHosts = [ pkgs.passff-host ]; });

    # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #   ublock-origin
    # ]; # TODO: would be nice to have _all_ my firefox stuff managed here instead of Firefox Sync maybe?

    profiles = {
      daniel = {
        id = 0;
        settings = {
          "general.smoothScroll" = true;
        };

        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          // user_pref("full-screen-api.ignore-widgets", true);
          user_pref("media.ffmpeg.vaapi.enabled", true);
          user_pref("media.rdd-vpx.enabled", true);
        '';

        userChrome = ''
          /* Remove close button */
          .titlebar-buttonbox-container{ display:none }

          #webrtcIndicator {
            display: none;
          }

          #main-window[tabsintitlebar="true"]:not([extradragspace="true"]) #TabsToolbar>.toolbar-items {
            opacity: 0;
            pointer-events: none;
          }

          #main-window:not([tabsintitlebar="true"]) #TabsToolbar {
            visibility: collapse !important;
          }
        '';

        # userContent = ''
        # '';
      };

    };
  };

  # wayland.windowManager.sway = {
  #   enable = true;
  # }; # TODO: would be nice to have my sway config declared here instead of symlinked in by dotfiles scripts?
  # maybe we can share somehow so things for nix-y systems and non-nix-y systems alike
}
