
using ClimateModels
path0="notebooks"
nbs=notebooks.list()
notebooks.download(path0,nbs)

using DataFrames
url0="https://raw.githubusercontent.com/JuliaClimate/IndividualDisplacements.jl/master/examples/worldwide/"
nbs2=DataFrame( "folder" => ["IndividualDisplacements.jl","IndividualDisplacements.jl"],
                "file" => ["ECCO_FlowFields.jl","OCCA_FlowFields.jl"],
                "url" => [url0*"ECCO_FlowFields.jl",url0*"OCCA_FlowFields.jl"])
notebooks.download(path0,nbs2)

