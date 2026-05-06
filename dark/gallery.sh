#!/usr/bin/env fish

set OUTPUT "README.md"

echo "# Wallpapers Collection" > $OUTPUT
echo "<p align=\"center\">" >> $OUTPUT

set count 1
set grid 0

for img in (find . -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort)

    set img (string replace -r '^\\./' '' $img)
    set ext (string lower (string split -r -m1 '.' $img)[-1])

    set new_name (printf "%03d.%s" $count $ext)

    while test -e $new_name; and test "$new_name" != "$img"
        set count (math $count + 1)
        set new_name (printf "%03d.%s" $count $ext)
    end

    if test "$img" != "$new_name"
        mv -- $img $new_name
    end

    echo "<img src=\"$new_name\" width=\"300\" loading=\"lazy\" />" >> $OUTPUT

    set grid (math $grid + 1)
    set count (math $count + 1)

    if test (math $grid % 3) -eq 0
        echo "<br/>" >> $OUTPUT
    end

end

echo "</p>" >> $OUTPUT

echo "✅ Files renamed sequentially + README updated"
