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
        wkhtmltopdf \
        pandoc

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
    echo '#!/bin/bash' > merge_html.sh && \
    echo 'echo "<!DOCTYPE html><html><head><title>Coverage Report</title></head><body>" > merged.html' >> merge_html.sh && \
    echo 'cat coverage_report/index.html >> merged.html' >> merge_html.sh && \
    echo 'for file in coverage_report/*/source.html; do' >> merge_html.sh && \
    echo '  echo "<hr><h2>$(basename "$(dirname "$file")")</h2>" >> merged.html' >> merge_html.sh && \
    echo '  pandoc -f html -t html --no-highlight --wrap=none --atx-headers --extract-media . --strip-comments --standalone "$file" | grep -v -e "^<!DOCTYPE" -e "^<html>" -e "^<head>" -e "^<meta" -e "^<title>" -e "^</head>" -e "^<body>" -e "^</body>" -e "^</html>" >> merged.html' >> merge_html.sh && \
    echo 'done' >> merge_html.sh && \
    echo 'echo "</body></html>" >> merged.html' >> merge_html.sh && \
    chmod +x merge_html.sh && \
    ./merge_html.sh && \
    wkhtmltopdf --enable-local-file-access merged.html coverage_report.pdf && \
    cp coverage_report.pdf /tmp/code_coverage.pdf

##################################################
# Section 2: Bundle the application.
FROM ubuntu:22.04

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y

WORKDIR /opt
COPY --from=builder /tmp/helloworld .
COPY --from=builder /tmp/code_coverage.pdf .
ENTRYPOINT ["/opt/helloworld"]
