# Análisis por Intensidad

source("https://raw.githubusercontent.com/pfagundez/DLS_functions/main/mean_DLS_data.R")


## Definir archivos
mis_archivos <- c("i1.xls",
                  "i2.xls", 
                  "i3.xls",
                  "i4.xls",
                  "i5.xls",
                  "i6.xls")

## Análisis completo (más fácil)
resultado <- analisis_dls_completo(
  archivos = mis_archivos,
  hoja = 1,
  col_size = 1,
  col_intensity = 2,
  nombre_archivo = "mi_analisis_intensidad_dls"
)

## Ver el gráfico
print(resultado$grafico)

# Análisis por número
source("https://raw.githubusercontent.com/pfagundez/DLS_functions/main/mean_DLS_data.R")


## Definir archivos
mis_archivos <- c("n1.xls",
                  "n2.xls", 
                  "n3.xls",
                  "n4.xls",
                  "n5.xls",
                  "n6.xls")

## Análisis completo (más fácil)
resultado <- analisis_dls_completo(
  archivos = mis_archivos,
  hoja = 1,
  col_size = 1,
  col_intensity = 2,
  nombre_archivo = "mi_analisis_numero_dls"
)

## Ver el gráfico
print(resultado$grafico)


# Analisis por volumen

source("https://raw.githubusercontent.com/pfagundez/DLS_functions/main/mean_DLS_data.R")


## Definir archivos
mis_archivos <- c("v1.xls",
                  "v2.xls", 
                  "v3.xls",
                  "v4.xls",
                  "v5.xls",
                  "v6.xls")

## Análisis completo (más fácil)
resultado <- analisis_dls_completo(
  archivos = mis_archivos,
  hoja = 1,
  col_size = 1,
  col_intensity = 2,
  nombre_archivo = "mi_analisis_volumen_dls"
)

## Ver el gráfico
print(resultado$grafico)
