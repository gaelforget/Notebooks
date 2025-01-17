
import PlutoSliderServer

function run_one_notebook(filename::String)
    pth_in=joinpath(pwd(),"tutorials")
    pth_out=joinpath(pwd(),"page","__site")

    cp(joinpath(pth_in,filename),joinpath(pth_out,filename))
    PlutoSliderServer.export_notebook(joinpath(pth_out,filename))
end 

run_one_notebook("NetCDF_basics.jl")
run_one_notebook("NetCDF_advanced.jl")
run_one_notebook("NetCDF_packages.jl")
