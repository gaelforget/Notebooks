using PackageCompiler
create_sysimage([:IJulia, :Pluto, :PlutoUI, :PyCall, :Conda, 
                :CairoMakie];
                sysimage_path="ExampleSysimage.so",
                cpu_target = PackageCompiler.default_app_cpu_target())
