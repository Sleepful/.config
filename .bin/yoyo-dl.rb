#!/usr/bin/ruby

for pinyin in ARGV
  for tone in 1..4
    `curl https://www.yoyochinese.com/audio/pychart/#{pinyin}#{tone}.mp3 --output #{pinyin}#{tone}.mp3`
  end
end

