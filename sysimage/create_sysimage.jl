using PackageCompiler
create_sysimage([:CSV, :DataFrames],
                sysimage_path="ExampleSysimage.so",
                cpu_target = PackageCompiler.default_app_cpu_target())
