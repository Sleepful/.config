#!/usr/bin/ruby
# coding: utf-8

# These are the last digit in U+030x unicode, from:
# Combining Diacritical Marks (0300–036F), since version 1.0
#
# { 'chinese tone': unicode, }
$utf = {'1'=>4,'2'=>1,'3'=>2,'4'=>0}
         .transform_values{ |v| "30#{v}".to_i(16) }

def combine vowel, tone
  [vowel.ord, $utf[tone]].pack('U*')
end

def utfPinyin pinyin
  tonal = pinyin =~ /[A-Z]/
  tone = pinyin[/\d/]
  pinyin.downcase!.chop!
  pinyin[tonal] = combine pinyin[tonal], tone
  pinyin
end

def syllabes syllabe
  [*1..4].map{|t| utfPinyin syllabe+t.to_s}
end

def row basePinyin
  pinyins = syllabes basePinyin
  ankiPinyins = pinyins.map{|p| p+';'}
  ankiSounds = [*1..4].map{ |t| "[sound:#{basePinyin+t.to_s}.mp3];" }
  ( ankiPinyins+ankiSounds ).join
end

# basePinyin is a pinyin syllabe with a capital letter
# the capital letter will receive the 4 accents
for basePinyin in ARGV
  puts row basePinyin
end
