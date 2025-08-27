//********************************************************************************************************
// Universidad del Rosario - Facultad de Economía
// Clase Haciendo Economía
// Primer Taller de clase
// Autores: Samuel Blanco Castellanos - Juan Jose Rusinque - Alejandro Herrera - Joan Schick
// Título: ¿Cómo se conectan los micronegocios con el sector financiero? y TAREAS RELACIONADAS CON LA CLASE
//**********************************************************************************************************

clear all

// Establecer la ruta
cd "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\Taller_1\Rawdata"

// Cargar la base de datos
use "Base_datos_encuesta", clear

*********************************** PRIMERA, SEGUNDA Y TERCERA SESIÓN (GRAFICAS Y FIGURAS) ********************************************

///GRAFICA PIE PARA ANALISIS DE SOLICITUD DE CREDITO (PIE CHART 1)
tab Solic_Credito, missing
label values Solic_Credito_val solic_label

//Aquí graficamos el pie chart de la presentación 
graph pie if !missing(Solic_Credito_val), over(Solic_Credito_val) ///
    plabel(_all percent, size(small) gap(0)) ///
    title("Proporción de micronegocios que han solicitado crédito en los últimos 12 meses", size(medsmall)) ///
    legend(label(1 "Sí") label(2 "No sabe") label(3 "No")) ///
    p(1, color(forest_green)) ///
    p(2, color(maroon)) ///
    p(3, color(gs12)) ///
    sort
graph export "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\Taller_1\Figures\piechart.png", replace
	
	
// Calcular totales y porcentajes
collapse (sum) Razon_No_Cred__1-Razon_No_Cred__10
egen total = rowtotal(Razon_No_Cred__1-Razon_No_Cred__10)
foreach var of varlist Razon_No_Cred__1-Razon_No_Cred__10 {
    replace `var' = (`var'/total)*100
}

gen id = 1
reshape long Razon_No_Cred__, i(id) j(opcion)

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

// Gráfico horizontal con etiquetas en porcentaje
graph bar Razon_No_Cred__, over(opcion, sort(1) descending label(angle(0))) ///
    bar(1, color(maroon)) ///
    blabel(bar, size(small) color(black) format(%4.1f)) ///
    ytitle("") ///
    title("Principales razones para no solicitar crédito entre micronegocios", size(medsmall)) ///
    legend(off) ///
    horizontal
graph export "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\Taller_1\Figures\Barchart_Razones_NO.png", replace

	
//GRAFICO MULTIPLE DE PERSONAS QUE SI ACEPTAN PRESTAMOS	A QUIENES SE LO PIDEN (GRAFICO DE BARRAS 3)
clear	

***VOLVER A CARGAR LA BASE DE TENDEROS***
use "Base_datos_encuesta", clear

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

//Aqui se genera el grafico
graph bar (count), over(cred_, label(angle(15))) by(tipo_n, title("Solicitudes de crédito según fuente", size(small)) note("")) ///
    bar(1, color(forest_green)) bar(2, color(cranberry)) bar(3, color(teal)) bar(4, color(gs12)) ///
    blabel(bar, size(small) color(black)) ///
    ytitle("Número de personas", size(small)) ///
    legend(order(1 "Sí, lo aceptó" 2 "Sí, le fue negado" 3 "Sí, pero no lo usó" 4 "No lo solicitó") ///
           size(small) row(1) position(6)) // 

graph export "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\Taller_1\Figures\Barchart_Razones_SI.png", replace


************************************************** CUARTA SESIÓN TAREAS A ENTREGAR **************************************************************************


**** VOLVER A CARGAR LA BASE DE DATOS de tenderos ******

/* TAREA #1: Acá se mantienen  las variables listadas  y se eliminan todas las demás de la base de datos ,facilitando el colapso de la base
Se cambia el nombre de la variable Munic_Dept a divipola para estandarizar el nombre.
Se agrupa la base de datos por las variables divipola y Municipio y se calcula el promedio de la variable uso_internet.
Se crea una nueva variable internet que convierte uso_internet en un porcentaje. 
Se elimina la variable uso_internet, dado que se utilizara la variable internet en formato de porcentaje
*/

keep Munic_Dept Municipio uso_internet
rename Munic_Dept divipola
collapse (mean) uso_internet, by(divipola Municipio)
gen internet = uso_internet*100
drop uso_internet
save "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\internet_municipio_tarea1", replace


/* TAREA #2: 
//Se conservan  las variables actG1 , ... , actG11  y uso_internet. 
//Se crea una variable id con el número de observación y se crea el identificador único para cada registro.
//Se convierte la base de formato ancho a formato largo. 
//Se mantienen solo las observaciones donde actG es igual a 1. estos son los casos donde una tienda realiza esa actividad específica.
//Se agrupa los datos por actG_num y calcula el promedio de uso_internet para cada grupo.
//Convierte la proporción en porcentaje al multiplicar por 100.
//Se elimina la variable original uso_internet dado que  se usará la variable anteriormente creada (porcentaje).
//Se define una etiqueta llamada actlbl que asigna nombres descriptivos a los valores de actG_num.
//Asigna la etiqueta actlbl a la variable actG_num.Esto permite que en divha variable se vean los nombres descriptivos de las actividades en lugar de solo los números.

*/

use "Base_datos_encuesta", clear
keep actG1-actG11 uso_internet 
gen id = _n
reshape long actG, i(id) j(actG_num)
keep if actG == 1
collapse (mean) uso_internet, by(actG_num)
gen internet = uso_internet*100
drop uso_internet
label define actlbl 1 "Tienda" 2 "Comida preparada" 3 "Peluquería y belleza" 4 "Ropa" ///
                    5 "Otras variedades" 6 "Papelería y comunicaciones" 7 "Vida nocturna" ///
                    8 "Productos bajo inventario" 9 "Salud" 10 "Servicios" 11 "Ferretería y afines"
label values actG_num actlbl
save "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\Created data\internet_act_tarea2", replace

/*TAREA #3: 
//Se conservan  las variables actG1 , ... , actG11 , uso_internet, Munic_Dept y Municipio
//Se crea una variable id con el número de observación . Se crea el identificador único para cada registro 
//Se convierte la base de formato ancho  a formato largo. 
//Se mantienen solo las observaciones donde actG es igual a 1. estos son los casos donde una tienda realiza esa actividad específica.
//Se agrupa los datos por actG_num, Munic_Dept y Municipio. Se calcula el promedio de uso_internet para cada grupo.
//Convierte la proporción en porcentaje al multiplicar por 100.
//Se elimina la variable original uso_internet dado que  se usará la variable anteriormente creada (porcentaje).
//Se renombra Munic_Dept a divipola para estandarizar.
//Se define una etiqueta llamada actlbl que asigna nombres descriptivos a los valores de actG_num.
// Asigna la etiqueta actlbl a la variable actG_num.Esto permite que en dicha variable se vean los nombres descriptivos de las actividades y no los números.

*/
clear all 
use "Base_datos_encuesta", clear
keep actG1-actG11 uso_internet Munic_Dept Municipio 
gen id = _n
reshape long actG, i(id) j(actG_num)
keep if actG == 1
collapse (mean) uso_internet, by(actG_num Munic_Dept Municipio)
gen internet = uso_internet*100
drop uso_internet
rename Munic_Dept divipola
label define actlbl 1 "Tienda" 2 "Comida preparada" 3 "Peluquería y belleza" 4 "Ropa" ///
                    5 "Otras variedades" 6 "Papelería y comunicaciones" 7 "Vida nocturna" ///
                    8 "Productos bajo inventario" 9 "Salud" 10 "Servicios" 11 "Ferretería y afines"
label values actG_num actlbl
save "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\internet_act_municipio_tarea3", replace

//TAREA #4 y #5: LO VAMOS A HACER CON DATOS DE HOMBRES PUES EN CLASE SE MENCIONÓ QUE SERIA CON LOS DATOS DE DIM 2 SUB1 QUE CORRESPONDE A HOMBRES 
//Se elimina varias columnas no necesarias 
//se elimina la primera fila de datos 
//Se eliminan comas de los numeros 
//se convierte la variable a tipo numérico
//Se conserva solo filas donde la unidad de medida sean "Nombres"
//Sumamos datoumérico por combinación de "cdigoentidad" y "año"
//Filtramos solo datos del año 2025
//se renombran variables para estandarización
//Se convierte divipola 
//se guardan los datos limpios
//Se carga la base de datos de la tarea 3 
//Combinamos  con los datos limpios de Terridata usando variable divipola
//solo coincidencias perfectas (_merge == 3)
//se elimina la variable de control _merge
//seguarda la base en formato largo
//se transforma a formato ancho, creando columnas separadas


//Descargamos y limpiamos TerriDATA 
clear all
import excel using "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\Taller_1\Rawdata\TerriData_Dim2_Sub1.xlsx", firstrow case(lower)
drop códigodepartamento departamento entidad subcategoría fuente
drop datocualitativo mes
drop dimensión
drop in 1
replace datonumérico = subinstr(datonumérico, ".", "", .)
replace datonumérico = subinstr(datonumérico, ",", ".", .)
destring datonumérico, replace
keep if unidaddemedida == "Hombres"
collapse (sum) datonumérico, by(códigoentidad año)
keep if año == "2025"
rename códigoentidad divipola
rename datonumérico poblacion_H
drop año
destring divipola, replace force
save "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\Taller_1\Created Data\Terridata_limpia_tarea4", replace

****HAY QUE HACER EL MERGE CON LA BASE DE LA TAREA 3 PUES RESULTA SER LA BASE MAS COMPLETA QUE TIENE CODIGO DIVIPOLA MUNICIPIO Y ACTIVIDADES ECONOMICAS*****


clear all
use "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\internet_act_municipio_tarea3.dta", clear
merge m:1 divipola using "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\Taller_1\Created Data\Terridata_limpia_tarea4.dta"
keep if _merge == 3
drop _merge

****NOTA: el resultado de la tarea 4 es la base de datos en formato largo para la tarea 5*****

save "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\Taller_1\Created Data\Base_Final_Larga_TAREA5", replace


reshape wide internet, i(divipola Municipio poblacion_H) j(actG_num)
save "C:\Users\Lenovo\Documents\Universidad\Material Clases\Haciendo Economía\Taller_1\Created Data\Base_Final_ancha_TAREA5", replace




