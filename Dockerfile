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
RUN apt-get install -y --fix-missing less emacs r-base r-base-core r-base-dev r-recommended libzmq3-dev libcurl4-gnutls-dev

# install bioinformatics tools from conda
RUN conda install -c bioconda fastqc samtools vcftools bowtie2 biopython

# Set default CRAN repo
RUN echo 'options("repos"="http://cran.rstudio.com")' >> /usr/lib/R/etc/Rprofile.site

# Install IRkernel
RUN Rscript -e "install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'))" -e "devtools::install_github('IRkernel/IRkernel')" -e "IRkernel::installspec(user = FALSE)"

# Install other R packages
RUN Rscript -e "install.packages(c('vcfR','ggplot2'))"
