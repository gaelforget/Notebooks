using PackageCompiler
create_sysimage([:Pluto, :Plots, :Printf, :UnicodePlots, :WGLMakie];
                replace_default = true)
