#!/usr/bin/env bash

set -e

OUTPUT="README.md"

echo "# Wallpapers Collection" > "$OUTPUT"
echo "<p align=\"center\">" >> "$OUTPUT"

count=1
grid=0

find . -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort | while read -r img; do
    ext="${img##*.}"
    new_name=$(printf "%03d.%s" "$count" "$ext")

    # avoid overwriting
    if [ -e "$new_name" ]; then
        echo "Skipping $img → $new_name exists"
        continue
    fi

    mv "$img" "$new_name"

    echo "<img src=\"$new_name\" width=\"300\" loading=\"lazy\" />" >> "$OUTPUT"

    grid=$((grid+1))
    if ((grid % 3 == 0)); then
        echo "<br/>" >> "$OUTPUT"
    fi

    count=$((count+1))
done

echo "</p>" >> "$OUTPUT"

echo "✅ Files renamed in-place + README updated"
