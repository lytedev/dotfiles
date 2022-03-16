#!/usr/bin/env fish
complete -c pass -f -n '__fish_pass_needs_command' -a otp -d 'Command: show TOTP code'
complete -c pass -f -n '__fish_pass_uses_command otp' -s c -l clip -d 'Put TOTP code in clipboard'
complete -c pass -f -n '__fish_pass_uses_command otp' -a "(__fish_pass_print_entries)"
