FROM swift:5.2

MAINTAINER Christoph Pageler

WORKDIR /package

COPY . ./

RUN swift package resolve
RUN swift build
CMD swift test
