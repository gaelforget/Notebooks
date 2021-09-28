
using ClimateModels
#import PlutoSliderServer
#import Downloads

function fig1to5(x::ModelConfig)
    pth0=pwd()
    pth01=joinpath(pth0,"page","__site")
    pth=joinpath(x.folder,string(x.ID))
    cd(pth)

    #1.download

    #url="https://dap.ceda.ac.uk/badc/ar6_wg1/data/spm/"
    url="https://dap.ceda.ac.uk/badc/ar6_wg1/data/spm/spm_01/v20210809/"
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
        let
            include(fil_in)
        end
        println("success 1")
        #PlutoSliderServer.export_notebook(fil_in)
        fil_out="notebook_0$(ii).html"
        isdir(pth01) ? cp(fil_out,joinpath(pth01,fil_out))  : nothing
        println("success 2")
    end

    cd(pth0)

    println.(readdir(pth0))
    println.(readdir(pth))

    return x
end 

MC=ModelConfig(model="IPCC-AR6-WG1",configuration=fig1to5,inputs=Dict(:notebookIDs => [1:2]))
setup(MC)
build(MC)
launch(MC)

