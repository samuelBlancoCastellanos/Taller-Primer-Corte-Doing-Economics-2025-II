//**********************************************
// Universidad del Rosario - Facultad de Economía
// Clase Haciendo Economía
// Primer Taller de clase
// Autores: Samuel Blanco Castellanos - Juan Jose Rusinque - Alejandro Herrera
// Título: ¿Cómo se conectan los micronegocios con el sector financiero?
//**********************************************

clear all

// Establecer la ruta
cd "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\Code"

// Cargar la base de datos
use "Base_datos_encuesta.dta", clear

// Tabular la variable de solicitud de crédito
tab Solic_Credito, missing

gen Solic_Credito_val = Solic_Credito if inlist(Solic_Credito, 1, 2, 3)
label values Solic_Credito_val solic_label
tab Solic_Credito_val, missing

//Aquí graficamos el pie chart de la presentación 
graph pie if !missing(Solic_Credito_val), over(Solic_Credito_val) ///
    plabel(_all percent, size(small) gap(0)) ///
    title("Proporción de micronegocios que han solicitado crédito en los últimos 12 meses", size(medsmall)) ///
    legend(label(1 "Sí") label(2 "No sabe") label(3 "No")) ///
    p(1, color(forest_green)) ///
    p(2, color(maroon)) ///
    p(3, color(gs12)) ///
    sort

preserve

// Colapsar las variables
collapse (sum) Razon_No_Cred__1-Razon_No_Cred__10

// Crear ID ficticio
gen id = 1

// Reestructurar a formato largo
reshape long Razon_No_Cred__, i(id) j(opcion)

// Crear etiquetas descriptivas directamente
label define razones_credito ///
    1 "No lo necesita" ///
    2 "No sabe dónde acudir" ///
    3 "Desconoce procedimiento" ///
    4 "No le gusta pedir crédito" ///
    5 "Intereses muy altos" ///
    6 "No se lo otorgarían" ///
    7 "No confía en instituciones" ///
    8 "No entiende condiciones" ///
    9 "Reportado en centrales" ///
    10 "Otra", replace

label values opcion razones_credito

// Gráfico horizontal con nombres completos
graph bar Razon_No_Cred__, over(opcion, sort(1) descending label(angle(0))) ///
    bar(1, color(maroon)) ///
    blabel(bar, size(small) color(black)) ///
    ytitle("") ///
    title("Principales razones para no solicitar crédito entre micronegocios", size(medsmall)) ///
    legend(off) ///
    horizontal

restore



preserve

gen id_persona = _n
rename (Pres_Bancario Amigos_Prestamo Pres_Partic_Cred) ///
       (cred_Bancos cred_Amigos cred_Particular)

reshape long cred_, i(id_persona) j(tipo) string
encode tipo, gen(tipo_n)

label define respuestas_credito ///
    1 "Sí, lo acepté" ///
    2 "Sí, me lo negaron" ///
    3 "Sí, pero no lo usé" ///
    4 "No", replace
label values cred_ respuestas_credito

label define tipo_credito 1 "Banco" 2 "Amigos" 3 "Particular", replace
label values tipo_n tipo_credito

graph bar (count), over(cred_, label(angle(15))) by(tipo_n, title("Solicitudes de crédito según fuente", size(small)) note("")) ///
    bar(1, color(forest_green)) bar(2, color(cranberry)) bar(3, color(teal)) bar(4, color(gs12)) ///
    blabel(bar, size(small) color(black)) ///
    ytitle("Número de personas", size(small)) ///
    legend(order(1 "Sí, lo aceptó" 2 "Sí, le fue negado" 3 "Sí, pero no lo usó" 4 "No lo solicitó") ///
           size(small) row(1) position(6)) // Leyenda horizontal debajo

restore





