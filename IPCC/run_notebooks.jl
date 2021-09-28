
using ClimateModels
import PlutoSliderServer
#import Downloads

function fig1to5(x::ModelConfig)
    pth0=pwd()
    pth01=joinpath(pth0,"page","__site")
    pth=joinpath(x.folder,string(x.ID))
    cd(pth)

    #1.download

    url="https://dap.ceda.ac.uk/badc/ar6_wg1/data/spm/"
    #url="https://dap.ceda.ac.uk/badc/ar6_wg1/data/spm/spm_01/v20210809/"
    pth=joinpath(x.folder,string(x.ID))
    run(`wget -q -e robots=off --mirror --no-parent -r $url`)

    #2. run loop over notebooks

    cp(joinpath(pth0,"IPCC","pth_ipcc.jl"),"pth_ipcc.jl")
    for ii in x.inputs[:notebookIDs]
        fil_in="notebook_0$(ii).jl"
        println("where are we now $ii?")
        println(pwd())
        println(readdir(pwd()))
        cp(joinpath(pth0,"IPCC",fil_in),fil_in)
        println("success 1/3 at $(ii)")
        PlutoSliderServer.export_notebook(fil_in)
        println("success 2/3 at $(ii)")
        fil_out="notebook_0$(ii).html"
        isdir(pth01) ? cp(fil_out,joinpath(pth01,fil_out))  : nothing
        println("success 3/3 at $(ii)")
    end

    cd(pth0)

    println("pth01 : $(pth01)")
    println.(readdir(pth01))

    return x
end 

#MC=ModelConfig(model="IPCC-AR6-WG1",configuration=fig1to5,inputs=Dict(:notebookIDs => 1:5))

url=PackageSpec(url="https://github.com/JuliaOcean/AirSeaFluxes.jl")
MC=ModelConfig(model=url)

#import Pkg; Pkg.add("Suppressor"); using Suppressor;

println("step 1")

#@suppress setup(MC)
mkdir(joinpath(MC.folder,string(MC.ID)))

println("step 2")

fig1to5(MC)

