//
//  TemarioViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 27/05/20.
//  Copyright © 2020 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class TemarioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tablaTemario: UITableView!
    
    
    @IBOutlet weak var nombreMateria: UINavigationItem!
    
    
    var datoRecibido:String?
     
     var tipoHerramienta: [String] = []
     var videoHerramienta: [String] = []
     
     var imagenesHerramienta: [String] = []
     var nombreHerramienta:String = ""
     
     var arrayDatos:[[String:AnyObject]] = []
     
     var asignatura:String?
     var preguntasRealizadas:String?
     var resultadoFinal:String?
     var fecha:String?
     
     var arrayEscuelas:[[String:String]] = []
     
     var arrayPreguntas:[[String:String]] = []
     var arrayDatosPreguntas:[[String:String]] = []
     
     var temasEspanol: [String] = []
     var videosEspanol: [String] = []
     
     var parametroCuestionario:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("parametroCuestionario \(parametroCuestionario)")
        
        nombreMateria.title = "Clases de \(parametroCuestionario)"
        
        
         
             UINavigationBar.appearance().barTintColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
             UINavigationBar.appearance().tintColor = UIColor.white
             UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]
        
        
        if(parametroCuestionario=="Estructura de la lengua"){
            temarioEspanol()
        }
        
        if(parametroCuestionario=="Comprensión lectora"){
            temarioRazVerbal()
        }
        
        
        if(parametroCuestionario=="Comprensión del entorno de México"){
            temarioHisMex()
        }

        
        if(parametroCuestionario=="Pensamiento analítico"){
            temarioRazMate()
        }
        
        if(parametroCuestionario=="Pensamiento matemático"){
            temarioMatematicas()
        }
        
        if(parametroCuestionario=="Fenómenos físico-químicos"){
            temarioFisica()
        }

        
        if(parametroCuestionario=="Fenómenos biológicos y de la salud"){
            temarioBiologia()
        }
        

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipoHerramienta.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaTemario", for: indexPath) as! TemarioTableViewCell
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        let width = CGFloat(2.0)
        cell.layer.borderWidth = 1
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.frame = CGRect(x: 0, y: cell.frame.size.height - width, width:  cell.frame.size.width, height: cell.frame.size.height)
        let borderColor: UIColor = UIColor(red:0.70, green:0.45, blue:0.27, alpha:1.0)
        cell.layer.borderColor = borderColor.cgColor
        
        //color a los datos
        cell.temaClase.textColor = borderColor
        
        // Configure the cell...
        let nombreCategoria = tipoHerramienta[indexPath.row]
       // let imagen = imagenesHerramienta[indexPath.row]

        cell.temaClase.text = nombreCategoria
        
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nombreHerramienta = videoHerramienta[indexPath.row]
        
        if let _ = tableView.cellForRow(at: indexPath) {
          //  if nombreHerramienta == "Español" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "verVideo",
                             sender: self)
          //  }
            
        }
       /* if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Razonamiento verbal" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "cuestionario",
                             sender: self)
            }
            
        }
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Historia universal" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "cuestionario",
                             sender: self)
            }
            
        }
        
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Historia de Mexico" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "cuestionario",
                             sender: self)
            }
            
        }
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Geografía universal" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "cuestionario",
                             sender: self)
            }
            
        }
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Geografía de Mexico" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "cuestionario",
                             sender: self)
            }
            
        }
       /* if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Civismo" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "cuestionario",
                             sender: self)
            }
            
        }*/
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Razonamiento matemático" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "cuestionario",
                             sender: self)
            }
            
        }
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Matemáticas" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "cuestionario",
                             sender: self)
            }
            
        }
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Física" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "cuestionario",
                             sender: self)
            }
            
        }
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Química" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "cuestionario",
                             sender: self)
            }
            
        }
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Biología" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "cuestionario",
                             sender: self)
            }
            
        }*/
        /*  if let _ = tableView.cellForRow(at: indexPath) {
         if nombreHerramienta == "Calculadora" {
         performSegue(withIdentifier: "",
         sender: self)
         }
         
         }*/
    }
    
    func refresh(){
          
        if(parametroCuestionario=="Estructura de la lengua"){
            temarioEspanol()
        }
        
        if(parametroCuestionario=="Comprensión lectora"){
            temarioRazVerbal()
        }
        
        
        if(parametroCuestionario=="Comprensión del entorno de México"){
            temarioHisMex()
        }

        
        if(parametroCuestionario=="Pensamiento analítico"){
            temarioRazMate()
        }
        
        if(parametroCuestionario=="Pensamiento matemático"){
            temarioMatematicas()
        }
        
        if(parametroCuestionario=="Fenómenos físico-químicos"){
            temarioFisica()
        }

        
        if(parametroCuestionario=="Fenómenos biológicos y de la salud"){
            temarioBiologia()
        }
        
        self.tablaTemario.reloadData()
        //self.refreshControl.endRefreshing()
        
        let objDaoIngresos = DataBase()
        
        arrayEscuelas = objDaoIngresos.ejecutarSelect("SELECT * FROM opcionesescuelas") as! [[String : String]]
        
    }
    
    func temarioEspanol(){
        
        tipoHerramienta = [
            "Copretérito",
            "Nexo",
            "Orden de ideas",
            "Texto informativo",
            "Ilustraciones",
            "Adverbio",
            "Puntos suspensivos",
            "Los conectores",
            "Tipos de puntos",
            "Ficha bibliográfica",
            "Índice",
            "Título",
            "Tipo de letra",
            "Gráficas",
            "Explicación",
            "Orden cronológico",
            "Tema",
            "Cita textual y paráfrasis",
            "Modificadores",
            "Enunciados Unimembres",
            "Enunciado bimembre"
        ]
        
        videoHerramienta = [
            "copreterito_espanol_comipems.mp4",
            "nexo_espanol_comipems.mp4",
            "orden_de_ideas_espanol_comipems.mp4",
            "texto_informativo_espanol_comipems.mp4",
            "ilustraciones_espanol_comipems.mp4",
            "adverbio_espanol_comipems.mp4",
            "puntos_suspensivos_espanol_comipems.mp4",
            "los_conectores_espanol_comipems.mp4",
            "tipos_de_puntos_espanol_comipems.mp4",
            "ficha_bibliográfica_comipems_espanol.mp4",
            "indice_comipems_espanol.mp4",
            "titulo_comipems_espanol.mp4",
            "tipo_de_letra_comipems_espanol.mp4",
            "graficas_comipems_espanol.mp4",
            "explicacion_comipems_espanol.mp4",
            "orden_cronologico_comipems_espanol.mp4",
            "tema_comipems_espanol.mp4",
            "cita_textual_comipems_espanol.mp4",
            "modificadores_comipems_espanol.mp4",
            "enunciados_unimembres_cimipems_espanol.mp4",
            "enunciado_bimembre.mp4"
        ]
        
        
    }
    
    func temarioHisMex(){
        
        tipoHerramienta = [
            "Asentamiento Tres Zapotes",
            "Las Audiencias",
            "La civilización maya.",
            "Caída de la gran ciudad de Tenochtitlán.",
            "Juan de Grijalva.",
            "Reformas Borbónicas.",
            "Organización de la Independencia.",
            "Virreinato de Nueva España.",
            "Dominicos.",
            "Primera República Federal.",
            "Batalla de la Angostura.",
            "Ley Lerdo.",
            "Benito Juarez.",
            "El Plan de Tuxtepec.",
            "Luis Echeverría.",
            "Neoliberalismo.",
            "El TLCAN.",
            "Carlos Salinas de Gortari.",
            "Puerto de Veracruz.",
                  "Usumacinta, Suchiate.",
                  "Sonda de Campeche.",
                  "Popocatépetl.",
                  "Producción maderable.",
                  "Rio Usumacinta y Mayo.",
                  "Mixtecas, Zapotecos.",
                  "Golfo de México.",
                  "Zona del Bajío.",
                  "Eje Neo volcánico."

        ]
        
        videoHerramienta = [
            "asentamiento_tres_zapotes.mp4",
            "las_audiencias.mp4",
            "la_civilizacion_maya.mp4",
            "juan_de_grijalva.mp4",
            "caida_de_tenochtitlan.mp4",
            "reformas_borbonicas.mp4",
            "organizacion_de_la_independencia.mp4",
            "virreinato_de_nueva_espana.mp4",
            "dominicos.mp4",
            "primera_república_federal.mp4",
            "batalla_de_la_angostura.mp4",
            "ley_lerdo.mp4",
            "benito_juarez.mp4",
            "el_plan_de_tuxtepec.mp4",
            "luis_echeverria.mp4",
            "neoliberalismo.mp4",
            "el_tlcan.mp4",
            "carlos_salinas_de_gortari.mp4",
            "puerto_de_veracruz.mp4",
                     "usumacinta_suchiate.mp4",
                     "sonda_de_campeche.mp4",
                     "popocatepetl.mp4",
                     "produccion_maderable.mp4",
                     "rio_usumacinta_y_mayo.mp4",
                     "mixtecas_zapotecos.mp4",
                     "golfo_de_mexico.mp4",
                     "zona_del_bajio.mp4",
                     "eje_neo_volcanico.mp4"
        ]
        
        
    }
    
    func temarioHisUniv(){
        
        tipoHerramienta = [
            "Edad moderna",
            "Renacimiento y el Humanismo",
            "Tratado de Tordesilla",
            "Ilustración o Iluminismo",
            "El derecho divino",
            "Feudalismo",
            "Colonialismo",
            "Fernando de Magallanes",
            "Renacimiento",
            "Martín Lutero",
            "Las trece colonias.",
            "Toma de la Bastilla.",
            "Independencia Hispanoamérica.",
            "Revolución Industrial.",
            "Las guerras napoleónicas.",
            "Imperialismo.",
            "Primera Guerra Mundial.",
            "Tratado de Versalles.",
            "Revolución francesa.",
            "El Nacionalismo.",
            "Revolución rusa.",
            "Nacional Socialista.",
            "El capitalismo.",
            "Segunda Revolución Industrial.",
            "Los aliados.",
            "Conflicto del Golfo Pérsico.",
            "Neoliberalismo.",
            "El muro de Berlín.",
            "Sistema socialista.",
            "Elementos Segunda Revolución Industrial."
        ]
        
        videoHerramienta = [
            "edad_moderna.mp4",
                     "renacimiento_y_humanismo.mp4",
                     "tratado_de_tordesilla.mp4",
                     "ilustracion_o_iluminismo.mp4",
                     "el_derecho_divino.mp4",
                     "feudalismo.mp4",
                     "colonialismo.mp4",
                     "fernando_de_magallanes.mp4",
                     "renacimiento.mp4",
                     "martin_lutero.mp4",
                     "las_trece_colonias.mp4",
                     "toma_de_la_bastilla.mp4",
                     "independencia_hispanoamerica.mp4",
                     "revolucion_industrial.mp4",
                     "las_guerras_napoleonicas.mp4",
                     "imperialismo.mp4",
                     "primera_guerra_mundial.mp4",
                     "tratado_de_versalles.mp4",
                     "revolucion_francesa.mp4",
                     "el_nacionalismo.mp4",
                     "revolucion_rusa.mp4",
                     "nacional_socialista.mp4",
                     "el_capitalismo.mp4",
                     "segunda_revolucion_industrial.mp4",
                     "los_aliados.mp4",
                     "conflicto_del_golfo_persico.mp4",
                     "neoliberalismo.mp4",
                     "el_muro_de_berlin.mp4",
                     "sistema_socialista.mp4",
                     "elementos_segunda_revolucion_industrial.mp4"

        ]
        
        
    }
    
    func temarioGeoUniv(){
        
        tipoHerramienta = [
            "Migrante.",
            "Globo terráqueo.",
            "Paralelos y meridianos.",
            "Organización Mundial del Comercio.",
            "Mareas.",
            "Subducción.",
            "Los Alpes.",
            "Pirineos.",
            "Amazonas.",
            "Monte Atlas.",
            "Espacio terrestre.",
            "Exosfera.",
            "Mapa.",
            "Internet.",
            "País multicultural.",
            "Escala.",
            "Patrimonio cultural.",
            "Etnia.",
            "Espacios de soberanía nacional.",
            "Conflicto entre palestinos e israelíes."
        ]
        
        videoHerramienta = [
            "migrante.mp4",
                    "globo_terraqueo.mp4",
                    "paralelos_y_meridianos.mp4",
                    "organizacion_mundial_del_comercio.mp4",
                    "mareas.mp4",
                    "subduccion.mp4",
                    "los_alpes.mp4",
                    "pirineos.mp4",
                    "amazonas.mp4",
                    "monte_atlas.mp4",
                    "espacio_terrestre.mp4",
                    "exosfera.mp4",
                    "mapa.mp4",
                    "internet.mp4",
                    "pais_multicultural.mp4",
                    "escala.mp4",
                    "patrimonio_cultural.mp4",
                    "etnia.mp4",
                    "espacios_de_soberania_nacional.mp4",
                    "conflicto_entre_palestinos_e_israelies.mp4"

        ]
        
        
    }
    
    func temarioRazMate(){
        
        tipoHerramienta = [
            "Imaginación espacial.",
               "Series numéricas agrupadas.",
               "Series numéricas descendentes.",
               "Series numéricas ascendentes.",
               "Regla de tres.",
               "Estrategias de razonamiento.",
               "Series formadas por una ley."

        ]
        
        videoHerramienta = [
            "imaginacion_espacial.mp4",
                  "series_numericas_agrupadas.mp4",
                  "series_numericas_descendentes.mp4",
                  "series_numericas_ascendentes.mp4",
                  "regla_de_tres.mp4",
                  "estrategias_de_razonamiento.mp4",
                  "series_formadas_por_una_ley.mp4"

        ]
        
        
    }
    
    func temarioGeoMex(){
        
        tipoHerramienta = [
            "Puerto de Veracruz.",
                  "Usumacinta, Suchiate.",
                  "Sonda de Campeche.",
                  "Popocatépetl.",
                  "Producción maderable.",
                  "Rio Usumacinta y Mayo.",
                  "Mixtecas, Zapotecos.",
                  "Golfo de México.",
                  "Zona del Bajío.",
                  "Eje Neo volcánico."

        ]
        
        videoHerramienta = [
            "puerto_de_veracruz.mp4",
               "usumacinta_suchiate.mp4",
               "sonda_de_campeche.mp4",
               "popocatepetl.mp4",
               "produccion_maderable.mp4",
               "rio_usumacinta_y_mayo.mp4",
               "mixtecas_zapotecos.mp4",
               "golfo_de_mexico.mp4",
               "zona_del_bajio.mp4",
               "eje_neo_volcanico.mp4"

        ]
        
        
    }
    
    func temarioFisica(){
        
        tipoHerramienta = [
            "Relación de magnitudes.",
                "Tiro parabólico.",
                "Movimiento rectilíneo uniforme.",
                "Movimiento Uniformemente Acelerado.",
                "Uniformemente acelerado.",
                "Magnitud escalar.",
                "Movimiento Pendular.",
                "Magnitud vectorial.",
                "Velocidad.",
                "Galileo Galilei.",
                "Aceleración.",
                "Leyes de Newton.",
                "Química.",
                "Propiedades cualitativas.",
                "Método científico.",
                "Propiedades químicas.",
                "Ley de la Conservación de la Materia.",
                "Mezcla.",
                "Una mezcla heterogénea.",
                "Coloide.",
                "Disolución.",
                "Decantación.",
                "Cristalización.",
                "Neutrones.",
                "Peso atómica.",
                "Átomo.",
                "Ion.",
                "Protón.",
                "Electrón.",
                "Estructuras de Lewis.",
                "Tabla periódica.",
                "Electrostático.",
                "La electronegatividad.",
                "Reacción.",
                "Coeficiente.",
                "Reacción química.",
                "Subíndice.",
                "Ecuación química.",
                "Escala PH."
        ]
        
        videoHerramienta = [
            "relacion_de_magnitudes.mp4",
            "tiro_parabolico.mp4",
            "movimiento_rectilineo_uniforme.mp4",
            "movimiento_uniformemente_acelerado.mp4",
            "uniformemente_acelerado.mp4",
            "magnitud_escalar.mp4",
            "movimiento_pendular.mp4",
            "magnitud_vectorial.mp4",
            "velocidad.mp4",
            "galileo_galilei.mp4",
            "formula_de_la_aceleracion.mp4",
            "leyes_de_newton.mp4",
            "quImica.mp4",
              "propiedades_cualitativas.mp4",
              "metodo_cientifico.mp4",
              "propiedades_quimicas.mp4",
              "ley_de_la_conservacion_de_la_materia.mp4",
              "mezcla.mp4",
              "una_mezcla_heterogenea.mp4",
              "coloide.mp4",
              "disolucion.mp4",
              "decantacion.mp4",
              "cristalizacion.mp4",
              "neutrones.mp4",
              "peso_atomica.mp4",
              "atomo.mp4",
              "ion.mp4",
              "proton.mp4",
              "electron.mp4",
              "estructuras_de_lewis.mp4",
              "tabla_periodica.mp4",
              "electrostatico.mp4",
              "la_electronegatividad.mp4",
              "reaccion.mp4",
              "coeficiente.mp4",
              "reaccion_quimica.mp4",
              "subindice.mp4",
              "ecuacion_quimica.mp4",
              "escala_ph.mp4"

        ]
        
        
    }
    
    func temarioRazVerbal(){
        
        tipoHerramienta = [
            "Analogía.",
            "Antónimos.",
            "Sinónimo.",
            "Análisis critico",
            "Conclusión.",
            "Idea secundaria.",
            "Idea principal.",
            "Contenido del texto.",
            "Hechos."

        ]
        
        videoHerramienta = [
            "analogIa.mp4",
            "antonimos.mp4",
            "sinonimo.mp4",
            "analisis_critico.mp4",
            "conclusion.mp4",
            "idea_secundaria.mp4",
            "idea_principal.mp4",
            "contenido_del_texto.mp4",
            "hechos.mp4"

        ]
        
        
    }
    
    func temarioQuimica(){
        
        tipoHerramienta = [
            "Química.",
            "Propiedades cualitativas.",
            "Método científico.",
            "Propiedades químicas.",
            "Ley de la Conservación de la Materia.",
            "Mezcla.",
            "Una mezcla heterogénea.",
            "Coloide.",
            "Disolución.",
            "Decantación.",
            "Cristalización.",
            "Neutrones.",
            "Peso atómica.",
            "Átomo.",
            "Ion.",
            "Protón.",
            "Electrón.",
            "Estructuras de Lewis.",
            "Tabla periódica.",
            "Electrostático.",
            "La electronegatividad.",
            "Reacción.",
            "Coeficiente.",
            "Reacción química.",
            "Subíndice.",
            "Ecuación química.",
            "Escala PH."

        ]
        
        videoHerramienta = [
            "quImica.mp4",
             "propiedades_cualitativas.mp4",
             "metodo_cientifico.mp4",
             "propiedades_quimicas.mp4",
             "ley_de_la_conservacion_de_la_materia.mp4",
             "mezcla.mp4",
             "una_mezcla_heterogenea.mp4",
             "coloide.mp4",
             "disolucion.mp4",
             "decantacion.mp4",
             "cristalizacion.mp4",
             "neutrones.mp4",
             "peso_atomica.mp4",
             "atomo.mp4",
             "ion.mp4",
             "proton.mp4",
             "electron.mp4",
             "estructuras_de_lewis.mp4",
             "tabla_periodica.mp4",
             "electrostatico.mp4",
             "la_electronegatividad.mp4",
             "reaccion.mp4",
             "coeficiente.mp4",
             "reaccion_quimica.mp4",
             "subindice.mp4",
             "ecuacion_quimica.mp4",
             "escala_ph.mp4"

        ]
        
        
    }
    
    func temarioMatematicas(){
        
        tipoHerramienta = [
            "Raíz cuadrada.",
               "Números primos.",
               "Ecuaciones algebraicas.",
               "Factorización.",
               "Regla de tres.",
               "Más ejemplos de la regla de tres.",
               "Notación científica.",
               "Multiplicación con decimales.",
               "Número decimal por número entero.",
               "Números enteros.",
               "Solución de operaciones.",
               "Proporción.",
               "Operaciones de fracciones.",
               "Porcentaje.",
               "Multiplicación de potencias",
               "División de potencias de igual base.",
               "Multiplicación de potencias de igual exponente.",
               "Calculo de ángulos.",
               "Binomios."

        ]
        
        videoHerramienta = [
            "raiz_cuadrada.mp4",
            "numeros_primos.mp4",
            "ecuaciones_algebraicas.mp4",
            "factorizacion.mp4",
            "regla_de_tres.mp4",
            "mas_ejemplos_de_la_regla_de_tres.mp4",
            "notacion_cientifica.mp4",
            "multiplicacion_con_decimales.mp4",
            "numero_decimal_por_numero_entero.mp4",
            "numeros_enteros.mp4",
            "solucion_de_operaciones.mp4",
            "proporcion.mp4",
            "operaciones_de_fracciones.mp4",
            "porcentaje.mp4",
            "multiplicacion_de_potencias.mp4",
            "division_de_potencias_de_igual_base.mp4",
            "multiplicacion_de_potencias_de_igual_exponente.mp4",
            "calculo_de_angulos.mp4",
            "binomios.mp4"

        ]
        
        
    }
    
    func temarioBiologia(){
        
        tipoHerramienta = [
            "Citología.",
               "Carbono.",
               "Evolución.",
               "Creacionismo.",
               "J. Lamarck",
               "Biodiversidad.",
               "Ecología.",
               "Fotosíntesis.",
               "Tallo.",
               "Oxígeno - ATP.",
               "Respiración aerobia.",
               "La fermentación.",
               "Ciclo biogeoquímico.",
               "Organismos fotosintéticos.",
               "Nutrición.",
               "Cadena trófica.",
               "Quimiosintética.",
               "Efecto invernadero.",
               "Organismos pluricelulares.",
               "Teoria de Darwin.",
               "Capacidad Homeostática.",
               "Reproducción.",
               "Ciclo celular.",
               "Mitosis.",
               "Gemación."

        ]
        
        videoHerramienta = [
            "citologia.mp4",
                   "carbono.mp4",
                   "evolucion.mp4",
                   "creacionismo.mp4",
                   "j_lamarck.mp4",
                   "biodiversidad.mp4",
                   "ecologia.mp4",
                   "fotosintesis.mp4",
                   "tallo.mp4",
                   "oxigeno_atp.mp4",
                   "respiracion_aerobia.mp4",
                   "la_fermentacion.mp4",
                   "ciclo_biogeoquimico.mp4",
                   "organismos_fotosinteticos.mp4",
                   "nutricion.mp4",
                   "cadena_trofica.mp4",
                   "quimiosintetica.mp4",
                   "efecto_invernadero.mp4",
                   "organismos_pluricelulares.mp4",
                   "teoria_de_darwin.mp4",
                   "capacidad_homeostatica.mp4",
                   "reproduccion.mp4",
                   "ciclo_celular.mp4",
                   "mitosis.mp4",
                   "gemacion.mp4"

        ]
        
        
    }
    
    

    /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     
     
     if nombreHerramienta ==   "Ahorrar para Objetivos"{
     
     performSegue(withIdentifier: "muestraAhorros",
     sender: self)
     
     /*     if var indexPath = opcionesHerramientas.indexPathForSelectedRow{
     let objIngreso = self.tipoHerramienta[indexPath.row]
     
     let objDestinoDetalle = segue.destination as! ActIngresosViewController
     
     }*/
     }
     
     
     
     /*     if segue.identifier ==   "actGastos"{
     
     performSegue(withIdentifier: "actGastos",
     sender: self)
     
     /*     if var indexPath = opcionesHerramientas.indexPathForSelectedRow{
     let objIngreso = self.tipoHerramienta[indexPath.row]
     
     let objDestinoDetalle = segue.destination as! GastosActualizaViewController
     
     }*/
     }
     
     
     
     if segue.identifier ==   "actGastos"{
     
     performSegue(withIdentifier: "actGastos",
     sender: self)
     
     /*  if var indexPath = opcionesHerramientas.indexPathForSelectedRow{
     let objIngreso = self.tipoHerramienta[indexPath.row]
     
     let objDestinoDetalle = segue.destination as! GastosActualizaViewController
     
     }*/
     }*/
     
     
     
     
     
     
     /*     if segue.identifier ==   "gastodetallle"{
     
     if var indexPath = movTable.indexPathForSelectedRow{
     let objIngreso = self.arrayMov[indexPath.row]
     
     let objDestinoDetalle = segue.destination as! GastosActualizaViewController
     objDestinoDetalle.paramtro2 = objIngreso
     }
     }*/
     }*/
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("arrayEscuelas \(arrayEscuelas)")
        
     //   if(arrayEscuelas.count>0){
            

            
            if segue.identifier ==   "verVideo"{
                
                if var indexPath = tablaTemario.indexPathForSelectedRow{
                    
              
                        
                        let objMateria = self.videoHerramienta[indexPath.row]
                                         print("objMateria: \(objMateria)")
                                         
                                         let objDestinoDetalle = segue.destination as! VideoViewController
                                         objDestinoDetalle.parametroCuestionario = objMateria
                        

                    
                 
                }
            }
            
            
       /* }else{
            
            // create the alert
            let alert = UIAlertController(title: "Atención", message: "¡Antes de comenzar debes seleecionar tus escuelas!", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            //     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }*/



    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //unwind
    @IBAction func volverVistaTemarioViewController(unwindSegue: UIStoryboardSegue){
        refresh()
        print("Pintando vista escuelas")
    }


}
