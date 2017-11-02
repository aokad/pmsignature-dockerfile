FROM r-base:3.4.2
MAINTAINER aokad <aokad@hgc.jp>

# RUN: build
RUN apt-get -y update && \
    \
    apt-get install -y libcurl4-openssl-dev && \
    apt-get install -y libdbd-mysql libmysqlclient-dev && \
    apt-get install -y libgeos-dev && \
    apt-get install -y libxml2-dev && \
    apt-get install -y libssl-dev && \
    apt-get install -y python && \
    apt-get install -y python-pip && \
    \
    Rscript -e "install.packages('devtools')" && \
    Rscript -e "install.packages('ggplot2')" && \
    Rscript -e "install.packages('Rcpp')" && \
    Rscript -e "install.packages('rjson')" && \
    Rscript -e "source('http://bioconductor.org/biocLite.R');biocLite(c('GenomicRanges', 'BSgenome.Hsapiens.UCSC.hg19'), ask=FALSE)" && \
    Rscript -e "library(devtools);devtools::install_github('friend1ws/pmsignature')" && \
    \
    mkdir /tools && \
    wget https://github.com/Genomon-Project/paplot/archive/v0.5.5.zip && \
    unzip v0.5.5.zip -d /tools && \
    cd /tools/paplot-0.5.5; python setup.py build install && \
    \
    wget https://github.com/Genomon-Project/genomon_Rscripts/archive/v0.1.3.zip && \
    unzip v0.1.3.zip -d /tools && \
    \
    git clone https://github.com/aokad/pmsignature-dockerfile.git /tools/pmsignature-dockerfile && \
    \
    cp /tools/pmsignature-dockerfile/run.sh /run.sh

# CMD: run
CMD ["/bin/bash", "/run.sh"]
