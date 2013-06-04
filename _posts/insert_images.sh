#! /bin/bash

# Find image names in a post and copy the original images into the
# image directory and resize. Insert images into post with markdown.
#
# Usage: ./insert_images.sh <post> <city>

# Check for correct number of arguments
if [ $# -ne 2 ]; then
    echo "Usage $0 <post> <city>"
    exit 1
fi

SOURCE_DIR="$HOME/Desktop/flickr/$2"
DEST_DIR="$HOME/dev/japan-blog/images/$2"

# Check if the source directory exists
if [ ! -d $SOURCE_DIR ]; then
    echo "$SOURCE_DIR does not exist."
    exit 1
fi

# Create destination directory for images
mkdir -p $DEST_DIR

# Get image names from post, resize from source to destination and
# replace image names with markdown to display images
echo "Resizing and copying:"
for img in $(grep $2_.*\.jpg $1); do
    if [ -f $DEST_DIR/$img ]; then
	echo "$DEST_DIR/$img already exists. Skipping...";
    else
	echo "$img -> $DEST_DIR/$img";
	convert $SOURCE_DIR/$img -resize 600x400 $DEST_DIR/$img;
	sed -i '.bak' "s|$img|![]({{ BASE_PATH }}/images/$2/$img)|g" $1;
    fi
done