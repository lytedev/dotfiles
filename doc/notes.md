# Notes

Like most people, I needed a way to keep decent notes on my machines. The way
that I prefer to take notes was writing text files with the option of grouping
together hierarchical data into nested bullet-style lists.

## Tools

Vim (or specifically Neovim) and Markdown for reading and writing have fit the
bill very well for me. Git has worked amazingly for syncing/merging.  I setup
some bash aliases to allow me to do this without even thinking (or even
automatically!) and note-taking life has been good ever since.

On occasion, I do want actual spreadsheets. I tend to use [my fork of
`sc-im`][sc-im] and a handful of Lua scripts for it. Primarily these are finance
or D&D-related.

Full searchability of notes and spreadsheets is very important. Since my notes
manifest as files on a filesystem, grep (or specifically [ripgrep][rg]) is
incredible.  When I need to find files by their filename, I tend to use find (or
specifically [`fd`][fd]).

Navigating between notes is also very important. For the most part, vim's `gf`
binding does the job. Barring that, [`fzf`] and good vim buffer management have
worked brilliantly for me.

It's nice when editing your notes feels clean and comfortable and when they just
*look good*. I really like the [`goyo` vim plugin by junegunn][goyo] to provide
some space at times. Here's a [link to a screenshot][goyo-screenshot].

My notes repository is on a private `Gitea` instance which automatically gets
mirrored to both GitHub and GitLab because redundancy is good and hooray for
distributed software! If I wanted, I could easily setup auto-sync (even just add
`nsync &` to the end of all the alises/scripts below would probably suffice),
but I find that most notes are not so urgent to sync and that I am sure to do so
if I need them. I should also probably encrypt/decrypt them on syncing.

I rarely ever make non-ephemeral notes on my phone and use Google Keep for those
notes. If they are more static, I would just copy and paste later at a machine
or if there is an emergency, I can absolutely edit my notes the same way I do on
my laptop and desktop via [termux][termux] where my vim and bash configurations
*just work*.

## Aliases

I have a handful of aliases (defined in `scripts/bin`) that do the large bulk of
the work.

1. `nf`: Create a **n**ote **f**ile in the repo and open it in `$EDITOR`. This
	 script is rarely invoked directly and is primarily used in subsequent
	 scripts.
	+ Arguments:
		+ `$1` must be the note's filename.
		+ `$2` may specify an optional subdirectory in the repo to place the file.
				I use this to segregate notes by categories such as `work/postmates` or
				`personal/jesus` or `unsorted`
	+ Examples:
		+ `nf medical.md personal/finance`
		+ `nf 2019-10-21_devotional.md personal/jesus`
		+ `nf todo.md`
2. `N`: Invokes `nf` adding `.md` to the end of the filename.
3. `nd`: Invokes `nf` prefixing the filename with `YYYY-MM-DD_`.
4. `n`: Combines `N` and `nd` resulting in a filename like `$DATE$1.md`.
5. `nsync`: Runs `git add -A && git commit -m Updates && git pull && git push`
	 in the notes repository.
6. `scn`: Invokes `nf` overriding the `$EDITOR` variable with my spreadsheet
	 editor.
7. `s`: Invokes `nf _scratch.md` which serves as both a scratchpad for temporary
	 or very quick notes and as an index for `gf`-jumping (or `fzf`-ing) to other
	 common files.

## How Could This Improve?

+ Automatic syncing
	+ Cron jobs?
	+ Building the syncing commands asynchronously into the aliases above?
		+ Just add `nsync &> /dev/null &` to each script
			+ Possibly hidden behind a flag so it can be disabled
			+ Would probably need to add options to `nsync` so that any interactive
					stuff (which would fail) gracefully fails and notifies the user
+ Encryption
	+ I keep some personal information in these notes that I'd rather not have
			exposed on GitHub/GitLab in plaintext.
+ Mobile editing workflow is less than ideal
	+ While this isn't necessary, perhaps a way to take good notes on my phone
			might improve my workflow
+ Accessibility
	+ My notes are really only able to be interacted with from a machine that is
			provisioned and setup to do so (read: ssh keys). It might be nice to have
			them more available especially to my wife, church, etc. through some web
			portal.
		+	Currently, I just use a `pbin` command and share the link, which works
				well enough.


[sc-im]: https://github.com/lytedev/sc-im
[rg]: https://github.com/BurntSushi/ripgrep
[fd]: https://github.com/sharkdp/fd
[fzf]: https://github.com/junegunn/fzf
[goyo]: https://github.com/junegunn/goyo.vim
[goyo-screenshot]: https://i.imgur.com/pRrzXLz.png
[termux]: https://termux.com
