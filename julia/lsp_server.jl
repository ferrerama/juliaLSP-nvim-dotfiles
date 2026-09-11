import Pkg
using LanguageServer
using SymbolServer

# 🚦 Forzar depot portable ANTES de activar
ENV["JULIA_DEPOT_PATH"] = "C:/Users/mferrera/ws/julia/share/julia;C:/Users/mferrera/.julia"
println(Base.stderr, "DEPOT_PATH activo: ", ENV["JULIA_DEPOT_PATH"])

# 🚦 Activar entorno portable
# project_path = "C:/Users/mferrera/ws/julia/env"
project_path = length(ARGS) > 0 ? ARGS[1] : "C:/Users/mferrera/ws/julia/env"
Pkg.activate(project_path)

# 🚦 Pasar depot_path como String (no vector)
server = LanguageServerInstance(
    stdin,
    stdout,
    project_path,
    ENV["JULIA_DEPOT_PATH"],  # aquí va la cadena completa
)

run(server)