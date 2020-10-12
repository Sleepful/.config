#!/bin/bash
DIR=~/Code/Forks
git clone https://github.com/sourcegraph/javascript-typescript-langserver.git $DIR
npm install $DIR
npm run build $DIR
