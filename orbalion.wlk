class Equipos{
    var nombre
    var nivelDeEnergiaBase
    var entrenador
    const tecnologiasEspeciales = []

    method nombre() = nombre
    method nivelDeEnergiaBase() = nivelDeEnergiaBase
    method entrenador() = entrenador
    method tecnologiasComplementarias() = tecnologiasEspeciales
    method añadirTecnologia(unaTecnologia){
        tecnologiasEspeciales.add(unaTecnologia)
    }
    method cambiarNombre(unNombre){
        nombre = unNombre
    }
    method cambiarNivelDeEnergiaBase(unNumero){
        nivelDeEnergiaBase = unNumero
    }
    method cambiarEntrenador(unEntrenador){
        entrenador = unEntrenador
    }

    method energiaTotal() {
        const energiaTecnologias = tecnologiasEspeciales.filter({ t => t.activa() }).sum({ t => t.valorEnergetico() })
        return nivelDeEnergiaBase + energiaTecnologias
    }

    method esDePrestigioUniversal()
}

class Luminicos inherits Equipos{
    var radiacionCapturada
    const cristalesSolares = []
    method radiacionCapturada() = radiacionCapturada
    method cambiarRadiacionCapturada(unNumero){
        radiacionCapturada = unNumero
    }
    method cristalesSolares() = cristalesSolares

    override method energiaTotal() {
        const base = super()
        if (radiacionCapturada < 5000) {
            return base + (base * 0.1)
        }
        return base
    }
    override method esDePrestigioUniversal(){
        return (cristalesSolares.size() >= 3) && (self.entrenador().esDeEliteGalactica())
                && (self.tecnologiasComplementarias().all({ t => t.activa() }))
    }
}
class Sinteticos inherits Equipos{
    var nivelDeProcesamientoCentral
    var cantidadModulosActivos
    var estaCertificado

    method nivelDeProcesamientoCentral() = nivelDeProcesamientoCentral
    method cantidadModulosActivos() = cantidadModulosActivos
    method estaCertificado() = estaCertificado
    method cambiarNivelDeProcesamiento(unNumero){
        nivelDeProcesamientoCentral = unNumero
    }
    method cambiarCantidadDeModulos(unNumero){
        cantidadModulosActivos = unNumero
    }
    method siEstaCertificado(){
        estaCertificado = true
    }
    method noEstaCertificado(){
        estaCertificado = false
    }

    override method energiaTotal() {
        const base = super()
        if (cantidadModulosActivos > 5) {
            return base - (base * 0.2)
        }
        return base
    }
    override method esDePrestigioUniversal(){
        return  (estaCertificado) && (cantidadModulosActivos > 3) 
                && (self.tecnologiasComplementarias().all({ t => t.activa() }))
    }
}

class Etericos inherits Equipos{
    var nivelDeFluctuacionDimensional
    var cantidadDePortalesAbiertos
    method nivelDeFluctuacionDimensional() = nivelDeFluctuacionDimensional
    method cantidadDePortalesAbiertos() = cantidadDePortalesAbiertos
    method cambiarNivelDeFluctuacion(unNumero){
        nivelDeFluctuacionDimensional = unNumero
    }
    method cambiarCantidadDePortalesAbiertos(unNumero){
        cantidadDePortalesAbiertos = unNumero
    }
    override method esDePrestigioUniversal(){
        return  (nivelDeFluctuacionDimensional > 75) && (cantidadDePortalesAbiertos >= 2) 
                && (self.tecnologiasComplementarias().count({t => t.activa()}) >= 2)
    }

    override method energiaTotal(){
        const base = super()
        if (self.esDePrestigioUniversal()) {
            return base + (base * 0.15)
        }
        return base
    }

    
}

class Entrenadores{
    var cantidadDeCiclosSolares
    var estaEnSintonia
    var nivelDePrecisionEstrategica
    var rol
    const rolesDisponibles= ["Estratega Cuantico", "Arquitecto de Energía","Guía Mental"]
    method cantidadDeCiclosSolares() = cantidadDeCiclosSolares
    method estaEnSintonia() = estaEnSintonia
    method nivelDePrecisionEstrategica() = nivelDePrecisionEstrategica
    method rol() = rol
    method rolesDisponibles() = rolesDisponibles
    method cambiarCantidadDeCiclosSolares(unNumero){
        cantidadDeCiclosSolares = unNumero
    }
    method siEstaEnSintonia(){
        estaEnSintonia = true
    }
    method noEstaEnSintonia(){
        estaEnSintonia = false
    }
    method cambiarNivelDePrecisionEstrategica(unNumero){
        nivelDePrecisionEstrategica = unNumero.between(0, 100)
    }
    method cambiarRol(unRol){
        if (not rolesDisponibles.contains(unRol)){
            self.error("Rol no homologado por la FOZ")
        }
        rol = unRol
    }

    method esDeEliteGalactica(){
        return cantidadDeCiclosSolares > 10 && (
            (rol == "Estratega Cuantico" && nivelDePrecisionEstrategica > 80 ) ||
            (rol == "Arquitecto de Energía" && estaEnSintonia) ||
            (rol == "Guia Mental")
        )
    }
}

class TecnologiasEspeciales{
    var nombre
    var valorEnergetico
    var activa

    method nombre() = nombre
    method valorEnergetico() = valorEnergetico
    method activa() = activa
    method cambiarNombre(unNombre){
        nombre = unNombre
    }
    method camibarValorEnergetico(unNumero){
        valorEnergetico = unNumero
    }
    method estaActivada(){
        activa = true
    }
    method noEstaActivada(){
        activa = false
    }
}