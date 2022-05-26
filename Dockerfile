FROM mas.ops.maap-project.org/root/jupyter-image/vanilla:develop

USER root
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.2-linux-x86_64.tar.gz && \
    tar -xvzf julia-1.7.2-linux-x86_64.tar.gz && \
    mv julia-1.7.2 /opt/ && \
    ln -s /opt/julia-1.7.2/bin/julia /usr/local/bin/julia && \
    rm julia-1.7.2-linux-x86_64.tar.gz

ENV gfpath /usr/local/etc/gf
RUN mkdir -p ${gfpath}

COPY ./plutoserver ${gfpath}/plutoserver
COPY ./sysimage ${gfpath}/sysimage
COPY ./tutorials ${gfpath}/tutorials

RUN cp ${gfpath}/sysimage/environment.yml ${gfpath}/environment.yml
RUN cp ${gfpath}/sysimage/setup.py ${gfpath}/setup.py
RUN cp ${gfpath}/sysimage/runpluto.sh ${gfpath}/runpluto.sh
 
COPY ./Project.toml ${gfpath}/Project.toml

ENV JULIA_PROJECT ${gfpath}
ENV JULIA_DEPOT_PATH ${gfpath}/.julia

RUN julia -e "import Pkg; Pkg.Registry.update(); Pkg.instantiate();"

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential && \
    apt-get install -y --no-install-recommends gfortran && \
    apt-get install -y --no-install-recommends openmpi-bin &&
    apt-get install -y --no-install-recommends libnetcdf-dev && \
    apt-get install -y --no-install-recommends libnetcdff-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN jupyter labextension install @jupyterlab/server-proxy && \
    jupyter lab build && \
    jupyter lab clean && \
    pip install ${gfpath} --no-cache-dir && \
    rm -rf ~/.cache
RUN julia --project=${gfpath} -e "import Pkg; Pkg.instantiate();"
RUN julia ${gfpath}/sysimage/download_stuff.jl


