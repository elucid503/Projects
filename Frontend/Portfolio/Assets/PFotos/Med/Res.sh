#!/bin/bash

# Usage: ./scale_webp.sh half | third | <scale_factor>

# Determine scale factor
case "$1" in
  half)
    SCALE=0.5
    ;;
  third)
    SCALE=0.333
    ;;
  ''|*)
    SCALE=$1
    ;;
esac

# Validate scale factor
if ! [[ $SCALE =~ ^0\.[0-9]+$ ]]; then
  echo "Invalid scale factor. Use 'half', 'third', or a float like '0.25'"
  exit 1
fi

# Process each .webp file
for file in *.webp; do
  [ -f "$file" ] || continue
  base="${file%.*}"
  ffmpeg -i "$file" -vf "scale=iw*$SCALE:ih*$SCALE" "${base}_scaled.webp"
done

echo "Done scaling images with factor $SCALE."
