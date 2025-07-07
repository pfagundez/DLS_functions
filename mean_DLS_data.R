# ============================================================================
# FUNCIONES PARA ANÁLISIS DLS
# Archivo: funciones_dls.R
# Autor: [Tu nombre]
# Fecha: [Fecha]
# ============================================================================

# Cargar librerías necesarias
if (!require(readxl)) install.packages("readxl")
if (!require(dplyr)) install.packages("dplyr")
if (!require(ggplot2)) install.packages("ggplot2")

library(readxl)
library(dplyr)
library(ggplot2)

# Función para leer y combinar datos DLS de múltiples archivos Excel
promediar_dls_excel <- function(archivos, hoja = 1, col_size = 1, col_intensity = 2) {

  # Lista para almacenar los datos de cada corrida
  datos_lista <- list()

  # Leer cada archivo
  for(i in 1:length(archivos)) {
    cat("Leyendo archivo:", archivos[i], "\n")

    # Leer el archivo Excel
    datos_temp <- read_excel(archivos[i], sheet = hoja)

    # Renombrar columnas para estandarizar
    colnames(datos_temp)[col_size] <- "size"
    colnames(datos_temp)[col_intensity] <- "intensity"

    # Agregar identificador de corrida
    datos_temp$run <- paste("Corrida", i)

    # Seleccionar solo las columnas necesarias
    datos_temp <- datos_temp %>%
      select(size, intensity, run) %>%
      filter(!is.na(size) & !is.na(intensity))

    datos_lista[[i]] <- datos_temp
  }

  # Combinar todos los datos
  datos_combinados <- do.call(rbind, datos_lista)

  return(datos_combinados)
}

# Función para calcular estadísticas y crear gráfico
crear_grafico_promedio_dls <- function(datos_combinados,
                                       titulo = "Distribución de Tamaño Promedio por DLS",
                                       xlabel = "Tamaño de partícula (nm)",
                                       ylabel = "Intensidad (%)",
                                       mostrar_bandas_error = TRUE,
                                       mostrar_corridas_individuales = FALSE) {

  # Calcular estadísticas por tamaño
  datos_promedio <- datos_combinados %>%
    group_by(size) %>%
    summarise(
      intensity_mean = mean(intensity, na.rm = TRUE),
      intensity_sd = sd(intensity, na.rm = TRUE),
      intensity_se = intensity_sd / sqrt(n()),
      n_corridas = n(),
      .groups = 'drop'
    )

  # Crear el gráfico base
  p <- ggplot(datos_promedio, aes(x = size, y = intensity_mean))

  # Agregar corridas individuales si se solicita
  if(mostrar_corridas_individuales) {
    p <- p + geom_line(data = datos_combinados,
                       aes(x = size, y = intensity, color = run, group = run),
                       alpha = 0.3, linewidth = 0.5)
  }

  # Agregar bandas de error si se solicita
  if(mostrar_bandas_error) {
    p <- p + geom_ribbon(aes(ymin = intensity_mean - intensity_sd,
                             ymax = intensity_mean + intensity_sd),
                         alpha = 0.2, fill = "blue")
  }

  # Agregar línea promedio
  p <- p + geom_line(color = "red", size = 1.2) +
    geom_point(color = "red", size = 0.8) +
    labs(
      title = titulo,
      subtitle = paste("Promedio de", max(datos_promedio$n_corridas), "corridas"),
      x = xlabel,
      y = ylabel
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
      plot.subtitle = element_text(hjust = 0.5, size = 12),
      axis.title = element_text(size = 12),
      axis.text = element_text(size = 10),
      legend.position = "bottom"
    )

  return(list(grafico = p, datos_promedio = datos_promedio))
}

# Función de análisis completo (todo en uno)
analisis_dls_completo <- function(archivos,
                                  hoja = 1,
                                  col_size = 1,
                                  col_intensity = 2,
                                  guardar_grafico = TRUE,
                                  guardar_datos = TRUE,
                                  nombre_archivo = "dls_resultado") {

  # Leer y combinar datos
  cat("=== ANÁLISIS DLS COMPLETO ===\n")
  datos <- promediar_dls_excel(archivos, hoja, col_size, col_intensity)

  # Crear gráfico
  resultado <- crear_grafico_promedio_dls(datos)

  # Guardar resultados si se solicita
  if(guardar_grafico) {
    archivo_grafico <- paste0(nombre_archivo, "_grafico.png")
    ggsave(archivo_grafico, plot = resultado$grafico,
           width = 10, height = 6, dpi = 300)
    cat("Gráfico guardado como:", archivo_grafico, "\n")
  }

  if(guardar_datos) {
    archivo_datos <- paste0(nombre_archivo, "_datos.csv")
    write.csv(resultado$datos_promedio, archivo_datos, row.names = FALSE)
    cat("Datos guardados como:", archivo_datos, "\n")
  }

  # Mostrar resumen
  cat("\n=== RESUMEN ===\n")
  cat("Archivos procesados:", length(archivos), "\n")
  cat("Puntos de datos promedio:", nrow(resultado$datos_promedio), "\n")
  cat("Rango de tamaños:",
      round(min(resultado$datos_promedio$size), 2), "-",
      round(max(resultado$datos_promedio$size), 2), "nm\n")

  return(resultado)
}

# Mensaje de confirmación
cat("✓ Funciones DLS cargadas correctamente\n")
cat("Funciones disponibles:\n")
cat("  - promediar_dls_excel()\n")
cat("  - crear_grafico_promedio_dls()\n")
cat("  - analisis_dls_completo()\n")
