source("https://raw.githubusercontent.com/pfagundez/DLS_functions/main/mean_DLS_data.R")


# Definir archivos
mis_archivos <- c("i1.xls",
                  "i2.xls", 
                  "i3.xls",
                  "i4.xls",
                  "i5.xls",
                  "i6.xls")

# Análisis completo (más fácil)
resultado <- analisis_dls_completo(
  archivos = mis_archivos,
  hoja = 1,
  col_size = 1,
  col_intensity = 2,
  nombre_archivo = "mi_analisis_intensidad_dls"
)

# Ver el gráfico
print(resultado$grafico)
