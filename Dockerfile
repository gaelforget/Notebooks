FROM mas.ops.maap-project.org/root/jupyter-image/vanilla:develop

USER root
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.2-linux-x86_64.tar.gz && \
    tar -xvzf julia-1.7.2-linux-x86_64.tar.gz && \
    mv julia-1.7.2 /opt/ && \
    ln -s /opt/julia-1.7.2/bin/julia /usr/local/bin/julia && \
    rm julia-1.7.2-linux-x86_64.tar.gz

ENV mainpath /usr/local/etc/gf
RUN mkdir -p ${mainpath}

COPY ./plutoserver ${mainpath}/plutoserver
COPY ./sysimage ${mainpath}/sysimage
COPY ./tutorials ${mainpath}/tutorials

RUN cp ${mainpath}/sysimage/environment.yml ${mainpath}/environment.yml
RUN cp ${mainpath}/sysimage/setup.py ${mainpath}/setup.py
RUN cp ${mainpath}/sysimage/runpluto.sh ${mainpath}/runpluto.sh
 
COPY ./Project.toml ${mainpath}/Project.toml

ENV JULIA_PROJECT ${gfpath}
ENV JULIA_DEPOT_PATH ${gfpath}/.julia

RUN julia -e "import Pkg; Pkg.Registry.update(); Pkg.instantiate();"

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential && \
    apt-get install -y --no-install-recommends vim && \
    apt-get install -y --no-install-recommends gfortran && \
    apt-get install -y --no-install-recommends openmpi-bin && \
    apt-get install -y --no-install-recommends openmpi-doc && \
    apt-get install -y --no-install-recommends libopenmpi-dev && \
    apt-get install -y --no-install-recommends mpich && \
    apt-get install -y --no-install-recommends libnetcdf-dev && \
    apt-get install -y --no-install-recommends libnetcdff-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN jupyter labextension install @jupyterlab/server-proxy && \
    jupyter lab build && \
    jupyter lab clean && \
    pip install ${mainpath} --no-cache-dir && \
    rm -rf ~/.cache

RUN julia --project=${mainpath} -e "import Pkg; Pkg.instantiate();"
RUN julia ${mainpath}/sysimage/download_stuff.jl
RUN julia ${mainpath}/sysimage/create_sysimage.jl

