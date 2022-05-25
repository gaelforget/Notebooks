FROM mas.ops.maap-project.org/root/jupyter-image/vanilla:develop

USER root
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.2-linux-x86_64.tar.gz && \
    tar -xvzf julia-1.7.2-linux-x86_64.tar.gz && \
    mv julia-1.7.2 /opt/ && \
    ln -s /opt/julia-1.7.2/bin/julia /usr/local/bin/julia && \
    rm julia-1.7.2-linux-x86_64.tar.gz

ENV USER_HOME_DIR /projects

COPY ./plutoserver ${USER_HOME_DIR}/plutoserver
COPY ./sysimage ${USER_HOME_DIR}/sysimage
COPY ./tutorials ${USER_HOME_DIR}/tutorials

RUN cp ${USER_HOME_DIR}/sysimage/environment.yml ${USER_HOME_DIR}/environment.yml
RUN cp ${USER_HOME_DIR}/sysimage/setup.py ${USER_HOME_DIR}/setup.py
RUN cp ${USER_HOME_DIR}/sysimage/runpluto.sh ${USER_HOME_DIR}/runpluto.sh
 
COPY ./Project.toml ${USER_HOME_DIR}/Project.toml

