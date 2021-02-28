#!/usr/bin/ruby
# coding: utf-8

# These are the last digit in U+030x unicode, from:
# Combining Diacritical Marks (0300–036F), since version 1.0
#
# { 'chinese tone': unicode, }
$utf = {'1'=>0x4,'2'=>0x1,'3'=>0xC,'4'=>0x0}
         .transform_values{ |v| 0x300+v }

def combine vowel, tone
  [vowel.ord, $utf[tone]].pack('U*')
end

# (a1) => ā
def utfPinyin pinyin
  tonal = pinyin =~ /[A-Z]/
  tone = pinyin[/\d/]
  pinyin.downcase!.chop!
  pinyin[tonal] = combine pinyin[tonal], tone
  pinyin
end

# (a) => [a, ā, á, ǎ, à]
def syllabes syllabe
  [*1..4].map{|t| utfPinyin syllabe+t.to_s}.unshift syllabe.downcase
end

$tags = {
  hard: /^(j|q|s|zh|ch|sh|z|c|s|x)/,
  'medium-u': /iu|un|yu/,
  medium: /^(b|p|d|t|g|k)/
}

def tags basePinyin
  $tags.filter{|k, v| basePinyin.downcase.match v}.keys.join ' '
end

def row basePinyin
  pinyins = syllabes basePinyin
  ankiPinyins = pinyins.map{|p| p+';'}
  ankiSounds = [*1..4].map{ |tone|
    "[sound:#{basePinyin.downcase+tone.to_s}.mp3];" }
  ( ankiPinyins+ankiSounds ).join+(tags basePinyin)
end

# basePinyin is a pinyin syllabe with a capital letter
# the capital letter will receive the 4 accents
for basePinyin in ARGV
  puts row basePinyin
end
