#!/bin/bash
# Script to analyze SVG files in the 'icons' directory
# It counts different SVG elements and reports files with non-path elements.
# only used to check if the assumptions are correct.

# execute as ./scripts/analyze_icons.sh

# Navigate to svg directory
cd ../raw-icons/

echo "Analyzing SVG elements..."
echo ""

# Temporary file to store results
temp_file=$(mktemp)

max_paths=0
max_path_file=""

# Analyze each SVG file
for file in *.svg; do
    # Count different element types
    path_count=$(grep -o '<path' "$file" | wc -l)
    circle_count=$(grep -o '<circle' "$file" | wc -l)
    rect_count=$(grep -o '<rect' "$file" | wc -l)
    line_count=$(grep -o '<line' "$file" | wc -l)
    polygon_count=$(grep -o '<polygon' "$file" | wc -l)
    polyline_count=$(grep -o '<polyline' "$file" | wc -l)
    ellipse_count=$(grep -o '<ellipse' "$file" | wc -l)
    text_count=$(grep -o '<text' "$file" | wc -l)
    g_count=$(grep -o '<g' "$file" | wc -l)
    
    # Track max paths
    if [ $path_count -gt $max_paths ]; then
        max_paths=$path_count
        max_path_file=$file
    fi
    
    # Check if file has non-path elements
    total_non_path=$((circle_count + rect_count + line_count + polygon_count + polyline_count + ellipse_count + text_count))
    
    if [ $total_non_path -gt 0 ]; then
        echo "$file: paths=$path_count, circles=$circle_count, rects=$rect_count, lines=$line_count, polygons=$polygon_count, polylines=$polyline_count, ellipses=$ellipse_count, text=$text_count, groups=$g_count" >> "$temp_file"
    fi
done

echo "=== File with most <path> elements ==="
echo "$max_path_file: $max_paths paths"
echo ""

echo "=== Files with non-path elements ==="
if [ -s "$temp_file" ]; then
    cat "$temp_file"
else
    echo "All files contain only <path> elements!"
fi

# Cleanup
rm "$temp_file"

echo ""
echo "=== Summary of all element types found ==="
echo "Total files with circles: $(grep -l '<circle' *.svg | wc -l)"
echo "Total files with rects: $(grep -l '<rect' *.svg | wc -l)"
echo "Total files with lines: $(grep -l '<line' *.svg | wc -l)"
echo "Total files with polygons: $(grep -l '<polygon' *.svg | wc -l)"
echo "Total files with polylines: $(grep -l '<polyline' *.svg | wc -l)"
echo "Total files with ellipses: $(grep -l '<ellipse' *.svg | wc -l)"
echo "Total files with text: $(grep -l '<text' *.svg | wc -l)"
