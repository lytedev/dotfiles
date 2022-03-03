#!/usr/bin/env fish

set profile_dirs ~/.mozilla/firefox/*.dev-edition-default

for p in $profile_dirs
	mkdir -p $p/chrome
	set user_chrome_css_file $p/chrome/userChrome.css
	echo '/* Generated by '(status -f)' -- do not edit manually! */' > $user_chrome_css_file
	cat $DOTFILES_PATH/common/firefox/userChrome.d.css >> $user_chrome_css_file
	echo >> $user_chrome_css_file
	for file_part in $ENV_PATH/*/firefox/userChrome.d.css
		cat $file_part >> $user_chrome_css_file
		echo >> $user_chrome_css_file
	end
	echo Built $user_chrome_css_file
end

echo Make sure you set 'toolkit.legacyUserProfileCustomizations.stylesheets' to true in about:config
