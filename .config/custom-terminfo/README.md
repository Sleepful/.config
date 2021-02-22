Custom terminfo for terminal emacs
to have full 24bit color support

compile with:

tic -x -o ~/.terminfo terminfo-custom.src

for some reason on OSX it didn't work like that, I had to do:

/usr/bin/tic -x -o ~/.terminfo terminfo-custom.src
