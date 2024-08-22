#!/bin/bash

# RUN for i in {1..10000}; do mkdir -p /app/$i && dd if=/dev/urandom of=/app/$i/file$i bs=$FILE_SIZE count=1 2>/dev/null; done

# Create 10,000 files with 1KB size
# FILE_SIZE=1024
echo $N_FILES
echo $FILE_SIZE

for i in $(seq 1 $N_FILES); do
    file_hash=$(echo $i | md5sum | awk '{print $1}')
    # Make dir using first two characters of hash
    mkdir -p /app/${file_hash:0:2}/${file_hash:2:4}
    # Create file with hash as name
    echo $file_hash
    dd if=/dev/urandom of=/app/${file_hash:0:2}/${file_hash:2:4}/$file_hash bs=$FILE_SIZE count=1 2>/dev/null
done