#!/usr/bin/env bash
file=$1
w=$(($2 - 2))
h=$(($3 - 2))
x=$4
y=$5

if [[ "$( file -Lb --mime-type "$file")" =~ ^image ]]; then
    kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$file" < /dev/null > /dev/tty
    exit 1
fi

num_lines=$(tr '\r' '\n' < "$file" | wc -l)
end_start=$(($num_lines - 1))

case "${file}" in
  # *) echo $h ;;
  *.log) tr '\r' '\n' < "${file}" | bat -f -n -l log --terminal-width "${w}" --wrap=never -r :$h -r $end_start:;;
  *) bat -f -n --terminal-width "${w}" "${file}";;
esac
