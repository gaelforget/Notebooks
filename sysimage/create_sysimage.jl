using PackageCompiler
create_sysimage([:CSV, :DataFrames, :IJulia, :Pluto, :PlutoUI, 
                :MeshArrays, :ClimateModels, :MITgcmTools];
                precompile_execution_file = "/usr/local/etc/gf/sysimage/warmup.jl",
                sysimage_path="/usr/local/etc/gf/ExampleSysimage.so",
                cpu_target = PackageCompiler.default_app_cpu_target())
