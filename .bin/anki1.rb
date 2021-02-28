#!/usr/bin/env ruby
ankimedia = "\"~/Library/Application Support/Anki2/User 1/collection.media\""
ankifile  = '~/Documents/Anki/run1.txt'
script = '~/.bin/anki-pinyin-sounds.rb'

vowels = %{
  A E yI O Wu

  Ai Ei  wEi
  Ao Ou  yOu
  yE yuE Er
  An En  In
  yUn wEn

  Ang Eng Ing yOng
  bE bAo bAi bEn biAn
  pAo pAi piAo pEng pEn piAn
  mE mAng mEn Meng miAn
  fAn fAng fEng fOu
  dAn dAng dEng dOu dOng diAn
  tAn tAng tEng tE tOng tiAn

  duI tuI guI kuI huI zuI cuI suI zhuI chuI shuI ruI
  dUn tUn lUn gUn kUn hUn zUn cUn sUn zhUn chUn shUn rUn
  miU diU niU liU jiU qiU xiU
  jUn qUn xUn
  jU  qU  xU

  gA kA hA gEn kEn hEn gAi kAi hAi

  jI qI xI
  jiA qiA xiA
  jiAn qiAn xiAn
  jiAng qiAng xiAng

  zhA zhAn zhAng zhE zhEn zhEng
  chA chAn chAng chE chEn chEng
  shA shAn shAng shE shEn shEng

  zA zAn zAng zE zEn zEng
  cA cAn cAng cE cEn cEng
  sA sAn sAng sE sEn sEng

  rAn rAng rEn rEng

}.gsub(/[[:space:]]/, " ")

exec "ruby #{script} -d #{ankimedia} -f #{ankifile} #{vowels} --text"

=begin

Vowels that I have already entered into anki:

manually (first ones):

A, E, yI, O, Wu

other runs:



=end
