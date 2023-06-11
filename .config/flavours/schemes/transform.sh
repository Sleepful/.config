# use this to transform all of the base16 themes in
# https://github.com/RRethy/nvim-base16/blob/master/colors
# into YAML specs, to be used with https://github.com/Misterio77/flavours
# :)

files=$(fd -e vim .)

for file in $files; do
	name=$(echo $file | gsed "s/base16-\(.*\)\.vim/\1/")
	echo $name
	filename="$name.yaml"
	echo "scheme: \"$name\"" >>$filename
	echo "author: \"(https://github.com/RRethy/nvim-base16/blob/master/colors)\"" >>$filename
	echo "" >>$filename
	cat $file |
		gsed -e "1,3d" -e '$d' |
		gsed "s/[\\\\n]//g" |
		gsed -E 's/[[:blank:]]*base(..) = ..(.{6}).,?/base\1: "\2\";/g' |
		tr ';' '\n' >>"$name.yaml"

done
