FROM ubuntu:latest

WORKDIR /app
# Look for a build argument called IMAGE_SIZE which will be used to set the
#  size of the image. Generate a size of 1GB by default.
ARG FILE_SIZE=10
ARG N_FILES=1

COPY ./create_files.sh /app/create_files.sh
RUN chmod +x /app/create_files.sh
RUN FILE_SIZE=$FILE_SIZE N_FILES=$N_FILES /app/create_files.sh

# Single layer ensures the best case scenario for processing the image on the host
# as there will be no intermediate layers to process/unwrap.
FROM scratch
COPY --from=0 /app/ /app/

CMD ["date"]