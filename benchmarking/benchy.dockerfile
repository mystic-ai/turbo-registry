FROM ubuntu:latest

WORKDIR /app
# Look for a build argument called IMAGE_SIZE which will be used to set the
#  size of the image. Generate a size of 1GB by default.
ARG IMAGE_SIZE=1GB

# Populate file with random data
RUN dd if=/dev/urandom of=/app/file bs=1M count=$(echo $IMAGE_SIZE | tr '[:lower:]' '[:upper:]')

# Single layer ensures the best case scenario for processing the image on the host
# as there will be no intermediate layers to process/unwrap.
FROM scratch
COPY --from=0 /app/file /app/file

CMD ["date"]