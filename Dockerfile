##################################################
# Section 1: Build the application
FROM ubuntu:22.04 as builder

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y

# Get timezone data before installing tzdata
RUN ln -snf /usr/share/zoneinfo/$(curl https://ipapi.co/timezone) /etc/localtime
# Install CMake, essential libraries, line coverage tool
RUN apt-get install -y --no-install-recommends \
        cmake \
        build-essential \
        lcov \
        gcovr

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
    gcovr -r .. --html-details -o coverage_report/gcov_details.html && \
    gcovr -r .. --xml-pretty --print-summary -x -o coverage_report/coverage.xml

##################################################
# Section 2: Bundle the application.
FROM ubuntu:22.04

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y

WORKDIR /opt
COPY --from=builder /tmp/helloworld .
COPY --from=builder /opt/sources/build/coverage_report /opt/coverage_report

ENTRYPOINT ["/opt/helloworld"]
