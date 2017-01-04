FROM asciidoctor/docker-asciidoctor
RUN dnf install -y hostname npm bzip2
RUN npm install -g phantomjs
RUN npm install -g mermaid
ADD . /book
WORKDIR /book
VOLUME output /book/output
RUN make
