using PackageCompiler
create_sysimage([:CSV, :DataFrames, :IJulia, :Pluto, :PlutoUI, :PlutoSliderServer, 
                 :MeshArrays, :ClimateModels, :MITgcmTools],
                sysimage_path="/usr/local/etc/gf/ExampleSysimage.so",
                cpu_target = PackageCompiler.default_app_cpu_target())
