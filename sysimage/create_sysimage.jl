using PackageCompiler
create_sysimage([:IJulia, 
                :ClimateModels,
                :PyCall, :Conda];
                sysimage_path="ExampleSysimage.so",
                cpu_target = PackageCompiler.default_app_cpu_target())
