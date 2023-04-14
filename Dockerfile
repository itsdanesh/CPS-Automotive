##################################################
# Section 1: Build the application
FROM ubuntu:22.04 as builder

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y

# Install CMake, essential libraries, line coverage tool, and HTML-to-PDF converter
RUN apt-get install -y --no-install-recommends \
        cmake \
        build-essential \
        lcov \
        wkhtmltopdf

ADD . /opt/sources
WORKDIR /opt/sources

RUN cd /opt/sources && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=Release .. && \
    make && make test && cp helloworld /tmp && \
    lcov --capture --directory . --output-file coverage.info && \
    lcov --remove coverage.info '/usr/*' --output-file coverage_filtered.info && \
    genhtml coverage_filtered.info --output-directory coverage_report && \
    wkhtmltopdf --enable-local-file-access coverage_report/index.html coverage_report.pdf

##################################################
# Section 2: Bundle the application.
FROM ubuntu:22.04

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y

WORKDIR /opt
COPY --from=builder /tmp/helloworld .
ENTRYPOINT ["/opt/helloworld"]
