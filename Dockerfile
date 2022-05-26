FROM mas.ops.maap-project.org/root/jupyter-image/vanilla:develop

USER root
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.2-linux-x86_64.tar.gz && \
    tar -xvzf julia-1.7.2-linux-x86_64.tar.gz && \
    mv julia-1.7.2 /opt/ && \
    ln -s /opt/julia-1.7.2/bin/julia /usr/local/bin/julia && \
    rm julia-1.7.2-linux-x86_64.tar.gz

mkdir /usr/local/gf

ENV gfpath /usr/local/gf

COPY ./plutoserver ${gfpath}/plutoserver
COPY ./sysimage ${gfpath}/sysimage
COPY ./tutorials ${gfpath}/tutorials

RUN cp ${gfpath}/sysimage/environment.yml ${gfpath}/environment.yml
RUN cp ${gfpath}/sysimage/setup.py ${gfpath}/setup.py
RUN cp ${gfpath}/sysimage/runpluto.sh ${gfpath}/runpluto.sh
 
COPY ./Project.toml ${gfpath}/Project.toml

