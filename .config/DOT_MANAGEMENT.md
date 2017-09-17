All credit for this method goes to [jaagr](https://github.com/jaagr/dots/blob/master/README.md).  
Same goes for following documentation.  
Modified by ecly.

#### Management
---------------------------------
Files are added to the repository by calling `dot add $HOME/.config/file` and when
issuing `git status` - only changes to files explicitly added will be shown.

To get a list of files not tracked by git, use `dot untracked` or `dot untracked-at $HOME/path/to/foo/bar`
to only show files in a specific subdirectory.

~~~ sh
alias dot='git --git-dir=$HOME/.dots.git/ --work-tree=$HOME'
~~~

#### Setup
~~~ sh
git init --bare $HOME/.dots.git
dot remote add origin https://github.com/ecly/dotfiles.git
~~~

#### Configuration
~~~ sh
dot config status.showUntrackedFiles no

# Useful aliases
dot config alias.untracked "status -u ."
dot config alias.untracked-at "status -u"
~~~

#### Usage
~~~ sh
# Use the dot alias like you would use the git command
dot status
dot add --update ...
dot commit -m "..."
dot push

# Listing files (not tracked by git)
dot untracked
dot status -u .config/

# Listing files (tracked by git)
dot ls-files
dot ls-files .config/polybar/
~~~

#### Replication
~~~ sh
git clone --recursive --separate-git-dir=$HOME/.dots.git https://github.com/ecly/dotfiles.git /tmp/dots
rsync -rvl --exclude ".git" /tmp/dots/ $HOME/
rm -r /tmp/dots
dot submodule update --init --recursive $HOME/
~~~

#### Extra
If you don't want eg. LICENSE.md and README.md to clutter your home dir.
~~~ sh
git update-index --assume-unchanged LICENSE.md
~~~
To later undo this do:

~~~ sh
git update-index --no-assume-unchanged LICENSE.md
~~~
