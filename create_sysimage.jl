using PackageCompiler
create_sysimage([:Pluto, :Plots, :Printf, :UnicodePlots, :WGLMakie];
                precompile_execution_file = "warmup.jl",
                replace_default = true,
                cpu_target = PackageCompiler.default_app_cpu_target())
