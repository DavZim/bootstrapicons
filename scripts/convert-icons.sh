#!/bin/bash

# Script to convert SVG files in the 'raw-icons' directory into a single typst file
# execute as ./scripts/convert-icons.sh
cd ../raw-icons/
output_file="../bs-icons.typ"
echo "#let svg_map = (" > "$output_file"
count=0
for svg_file in *.svg; do
  name=$(echo "$svg_file" | sed 's/\.svg$//')
  svg_content=$(sed 's/<svg[^>]*>//g;s/<\/svg>//g;s/^[[:space:]]*//;s/[[:space:]]*$//;/^$/d' "$svg_file" | tr -d '\n' | sed 's/"/\\"/g')
  echo "  \"$name\": \"$svg_content\"," >> "$output_file"
  count=$(expr $count + 1)
  remainder=$(expr $count % 100)
  [ $remainder -eq 0 ] && echo "Processed $count files..."
done
echo ")" >> "$output_file"
echo "Done! Processed $count SVG files into $output_file"
