#!/bin/bash
if [ $# -lt 1 ]; then
  echo 'Usage: ./file_processor.sh <file>'
  exit 1
fi
input_file="$1"
if [ ! -f "$input_file" ]; then
echo 'File not found!'
exit 1
fi
output_file="${input_file%.txt}_processed.txt"
touch "$output_file"
while IFS= read -r line; do
  modified_line=$(echo "$line" | tr 'a-z' 'A-Z')
echo "$modified_line" >> "$output_file"
done < "$input_file"
echo "Processing complete. Output saved to $output_file."
word_count=$(wc -w < "$input_file")
char_count=$(wc -c < "$input_file")
echo "Word count: $word_count"
echo "Character count: $char_count"
date >> "$output_file"
echo "Processed on: $(date)" >> "$output_file"
if [ -f "$output_file" ]; then
  mv "$output_file" "${output_file%.txt}_$(date +%Y%m%d).txt"
echo "Renamed output file to include date."
fi
exit 0
