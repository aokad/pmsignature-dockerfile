FROM r-base:3.4.2
MAINTAINER aokad <aokad@hgc.jp>

# RUN: build
# 必要ライブラリのインストール
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libdbd-mysql libmysqlclient-dev
RUN apt-get install -y libgeos-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y python
RUN apt-get install -y python-pip
RUN apt-get install -y git

# pmsignature, paplotのインストール
RUN mkdir /tools
RUN git clone https://github.com/aokad/pmsignature-dockerfile.git /tools/pmsignature-dockerfile
RUN R --vanilla --slave < /tools/pmsignature-dockerfile/install.R
RUN wget https://github.com/Genomon-Project/paplot/archive/v0.5.5.zip
RUN unzip v0.5.5.zip -d /tools
RUN python /tools/setup.py build install
RUN wget https://github.com/Genomon-Project/genomon_Rscripts/archive/v0.1.3.zip
RUN unzip v0.1.3.zip -d /tools
RUN cp /tools/pmsignature-dockerfile/run.sh /run.sh

# CMD: run
CMD ["/binbash", "/run.sh"]
