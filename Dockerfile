# Use base image
FROM broadinstitute/gatk:4.0.1.2

# Define directories
ENV OUTPUT_DIR /data
ENV WORK_DIR /code
ENV OPT_DIR /opt

# Mount the output volume as persistant
VOLUME ${OUTPUT_DIR}

RUN \
    # Install Packages Dependencies
    apt-get update -yqq && \
    apt-get install -yqq \
        curl \
        git \
        locales \
        python-pip \
        wget && \
    apt-get clean && \
    \
    ## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_US.utf8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

COPY . ${WORK_DIR}
WORKDIR ${WORK_DIR}

# Install picard 2.9.0
RUN \
    cd /downloads && \
    wget -q "https://github.com/broadinstitute/picard/releases/download/2.9.0/picard.jar"
ENV PICARD /downloads/picard.jar

# Run command
ENTRYPOINT ["python"]
