#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
source $DIR/variables.bash

pacaur -S \
	todotxt-git \
	--noconfirm --noedit

if [ ! -f "$HOME/.todo/config" ]; then
	cp /usr/share/todotxt/todo.cfg ~/.todo/config
	vim "$HOME/.todo/config"
fi

mkdir -p "$HOME/.todo.actions.d"

curl -L http://github.com/fnd/todo.txt-cli/raw/extensions/commit > "$HOME/.todo.actions.d/commit"
curl -L https://raw.github.com/crobinsonut/todo_distributed/master/push > "$HOME/.todo.actions.d/push"
curl -L https://raw.github.com/crobinsonut/todo_distributed/master/pull > "$HOME/.todo.actions.d/pull"
curl -L https://raw.github.com/crobinsonut/todo_distributed/master/sync > "$HOME/.todo.actions.d/sync"
curl -L http://github.com/mbrubeck/todo.txt-cli/raw/master/todo.actions.d/edit > "$HOME/.todo.actions.d/edit"

chmod +x "$HOME/.todo.actions.d/commit"
chmod +x "$HOME/.todo.actions.d/pull"
chmod +x "$HOME/.todo.actions.d/push"
chmod +x "$HOME/.todo.actions.d/sync"
chmod +x "$HOME/.todo.actions.d/edit"
