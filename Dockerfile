FROM swift:4.1

MAINTAINER Christoph Pageler

WORKDIR /package

COPY . ./

RUN swift package resolve
RUN swift build
CMD swift test