using PackageCompiler
create_sysimage([:CSV, :DataFrames, :IJulia, :Pluto, :PlutoUI, 
                :MeshArrays, :ClimateModels, :MITgcmTools, :IndividualDisplacements, 
                :UnicodePlots, :CairoMakie, :Plots],
                sysimage_path="ExampleSysimage.so",
                cpu_target = PackageCompiler.default_app_cpu_target())
