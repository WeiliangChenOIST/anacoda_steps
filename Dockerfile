# start from ubuntu 16.04
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y build-essential bzip2 gcc g++ cmake wget git

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda2-4.3.1-Linux-x86_64.sh  -O Anaconda.sh -O ~/Anaconda.sh && \
    /bin/bash ~/Anaconda.sh -b -p /opt/conda && \
    rm ~/Anaconda.sh

ENV PATH /opt/conda/bin:/opt/conda/bin/conda:/opt/conda/bin/python:$PATH
RUN /opt/conda/bin/conda install -y scipy numpy matplotlib ipython ipython-notebook 
RUN conda install swig openblas

WORKDIR /srcs

RUN git clone https://github.com/CNS-OIST/STEPS.git


WORKDIR /srcs/STEPS/build

RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/conda .. && make -j4 && make install

WORKDIR /srcs/

RUN rm -rf STEPS

WORKDIR /