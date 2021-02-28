#!/usr/bin/env ruby
# coding: utf-8

$basePinyins = ""
$mediaDir = nil
$importFile = nil
$dryRun = false
$text = true
$mp3 = true
$help = "
Use this tool to generate anki imports for pinyin sounds.

    command [Options] -d directory -f file sound1 sound2

-d          The directory to which mp3 files will be saved.
-f          The file to which text imports will be saved.
sound1..n   The pinyins that you want to use, these must come
            with an uppercase letter where their tone mark
            should go, and should include no number.
[ Options ]

-h|--help   Prints this message.
--dry|-D    Dry run, doens't do anything, shows parsed arguments.
--text      Generate the text file only.
--mp3       Download the mp3s only.

Example:

    command -d ~/ -f ./imports.txt yI nI hAo

    This command will create the anki data for these tones:

    nī  ní  nî  nì
    yī  yí  yî  yì
    hāo háo hâo hào

"
def cli argv, i
  arg = argv[i]
  case arg
  when "-h", "--help"
    puts $help
    exit
  when nil
    return
  when "-f"
    $importFile = argv[i+1]
    cli argv, i+2
  when "-d"
    $mediaDir = argv[i+1]
    cli argv, i+2
  when "--dry", "-D"
    $dryRun = true
    cli argv, i+1
  when "--text"
    $mp3 = false
    cli argv, i+1
  when "--mp3"
    $text = false
    cli argv, i+1
  else
    $basePinyins << arg << " "
    cli argv, i+1
  end
end

def anki pinyins
  "ruby ~/.bin/pinyin-syllabes-anki-txt.rb #{pinyins} > #{$importFile}";end
def yoyo pinyins
  "cd #{$mediaDir} && ruby ~/.bin/yoyo-dl.rb #{pinyins.downcase}"; end

cli ARGV, 0


if $dryRun
  puts 'args: '+ $basePinyins,
       '  -d: '+ $mediaDir,
       '  -f: '+ $importFile,
       "\nCommands to run:", "\n"
  puts anki $basePinyins if $text
  puts yoyo $basePinyins if $mp3
  exit
end

def doTheThing
  `#{anki $basePinyins}` if $text
  `#{yoyo $basePinyins}` if $mp3
end

doTheThing
