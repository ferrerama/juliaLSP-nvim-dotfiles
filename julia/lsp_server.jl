import Pkg
using LanguageServer
using SymbolServer

# 🚦 Force depot portable BEFORE activate
ENV["JULIA_DEPOT_PATH"] = "C:/Users/USUARIO/ws/julia/share/julia;C:/Users/USUARIO/.julia"
println(Base.stderr, "DEPOT_PATH activo: ", ENV["JULIA_DEPOT_PATH"])

# 🚦 Activate the portable environment
# project_path = "C:/Users/USUARIO/ws/julia/env"
project_path = length(ARGS) > 0 ? ARGS[1] : "C:/Users/USUARIO/ws/julia/env"
Pkg.activate(project_path)

# 🚦 Pass depot_path as String (not vector)
server = LanguageServerInstance(
    stdin,
    stdout,
    project_path,
    ENV["JULIA_DEPOT_PATH"],  # here string complete
)

run(server)