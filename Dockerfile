FROM r-base
MAINTAINER aokad <aokad@hgc.jp>

# RUN: build
# 必要ライブラリのインストール
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install libcurl4-openssl-dev
RUN apt-get install libdbd-mysql libmysqlclient-dev
RUN apt-get install libgeos-dev
RUN apt-get install libxml2-dev
RUN apt-get install libssl-dev
RUN apt-get install python
RUN apt-get install python-pip
RUN apt-get install git

# pmsignature, paplotのインストール
RUN cd /home/docker
RUN git pull https://github.com/aokad/pmsignature-dockerfile.git
RUN R --vanilla --slave < /home/docker/pmsignature-dockerfile/install.R
RUN wget https://github.com/Genomon-Project/paplot/archive/v0.5.5.zip
RUN unzip v0.5.5.zip
RUN rm v0.5.5.zip
RUN cd paplot-0.5.5
RUN python setup.py build install
RUN cd /home/docker
RUN wget https://github.com/Genomon-Project/genomon_Rscripts/archive/v0.1.3.zip
RUN unzip v0.1.3.zip
RUN rm v0.1.3.zip
RUN cp /home/docker/pmsignature-dockerfile/run.sh /run.sh

# CMD: run
CMD ["/binbash", "/run.sh"]
