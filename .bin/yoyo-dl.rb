#!/usr/bin/ruby

for pinyin in ARGV
  dPinyin = pinyin.downcase
  for tone in 1..4
    `curl https://www.yoyochinese.com/audio/pychart/#{dPinyin}#{tone}.mp3 --output #{dPinyin}#{tone}.mp3`
  end
end

