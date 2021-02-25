#!/usr/bin/env ruby

$basePinyins = []
$mediaDir = nil
$importFile = nil

def cli argv, i
  arg = argv[i]
  case arg
  when nil
    return
  when "-f"
    $importFile = argv[i+1]
    cli argv, i+2
  when "-d"
    $mediaDir = argv[i+1]
    cli argv, i+2
  else
    $basePinyins << arg
    cli argv, i+1
  end
end

cli ARGV, 0
puts $basePinyins.join(','), '-d '+$mediaDir, '-f '+$importFile, "\n"

def process
  p = $basePinyins.join(' ')
  puts "ruby yoyo-dl.rb #{p.downcase}"
  puts "ruby anki-generate-import.rb #{p}"
end

process
