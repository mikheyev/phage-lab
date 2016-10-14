FROM andrewosh/binder-base

MAINTAINER Sasha Mikheyev <mikheyev@homologo.us>

USER root

# Add dependency
RUN echo "deb http://cloud.r-project.org/bin/linux/debian jessie-cran3/" >> /etc/apt/sources.list

RUN apt-get install -y locales

## Configure default locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
      && locale-gen en_US.utf8 \
      && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 381BA480
RUN apt-get update
RUN apt-get install -y --fix-missing less tree emacs r-base r-base-core r-base-dev r-recommended libzmq3-dev libcurl4-gnutls-dev

RUN conda config --add channels bioconda
RUN conda install bowtie2 freebayes platypus-variant
RUN  conda update --all

# Set default CRAN repo
RUN echo 'options("repos"="http://cran.rstudio.com")' > .Rprofile

# Install IRkernel
RUN Rscript -e "install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'))" -e "devtools::install_github('IRkernel/IRkernel')" -e "IRkernel::installspec(user = FALSE)"

# Install other R packages
RUN Rscript -e "install.packages(c('vcfR'))"

# Install Bioconductor packages
RUN Rscript -e "source('https://bioconductor.org/biocLite.R')" -e 'biocLite(c("IRanges", "GenomicRanges", "ggbio", "biovizBase", "Rsamtools", "ShortRead"))'

# Install Calico notebook extensions
RUN git clone https://github.com/Calysto/notebook-extensions.git && cd notebook-extensions && jupyter nbextension install calysto
RUN jupyter nbextension enable calysto/document-tools/main && jupyter nbextension enable calysto/cell-tools/main