#!/usr/bin/env bash

brew install wget
brew install cpanminus
sudo cpanm Crypt::Rijndael
sudo cpanm Sort::Naturally
sudo cpanm Term::ShellUI
sudo cpanm File::KeePass
sudo cpanm Term::ReadLine::Gnu
sudo cpanm Term::ReadLine::Perl
sudo cpanm Clipboard --force
sudo cpanm Capture::Tiny
wget 'http://downloads.sourceforge.net/project/kpcli/kpcli-2.8.pl?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fkpcli%2F&ts=1426009460&use_mirror=iweb'
mv kpcli-*.pl* $HOME/Applications/kpcli.pl
sudo chmod +x $HOME/Applications/kpcli.pl

