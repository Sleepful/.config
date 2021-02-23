#!/usr/bin/env ruby

def kitty(mods, key, code)
  "map #{mods}+#{key} send_text all \\x#{code}"
end

def elisp(modes, key, code)
  "(define-key map #{code}  (kbd #{mods + key}))"
end

for i in 0..31
  hex = "%02X" % i
  key = (i+64).chr.downcase
  puts kitty "cmd", key, hex
end
# puts kitty "cmd", "?", "7F"
