FROM debian:bookworm-slim

VOLUME /input
VOLUME /output

WORKDIR /

COPY router-setup.sh ./

# give user execute permission
RUN chmod u+x ./router-setup.sh

# copy the setup script and the config files to a tar file
#CMD tar -czf /output/router-setup.tar.gz -C input . -C ../ router-setup.sh
CMD tar --transform 's,^./input,./config,' -czf /output/router-setup.tar.gz \
                                               ./router-setup.sh ./input
