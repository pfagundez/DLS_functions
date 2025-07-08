# Análisis de Datos DLS (Dynamic Light Scattering)

Este script realiza análisis estadísticos de datos DLS procesando múltiples archivos Excel para distribuciones por intensidad, número y volumen.

## Configuración inicial

### Cargar funciones de análisis
```r
source("https://raw.githubusercontent.com/pfagundez/DLS_functions/main/mean_DLS_data.R")
```

## Análisis por Intensidad

### 1. Definir archivos de entrada
```r
mis_archivos <- c("i1.xls", "i2.xls", "i3.xls", "i4.xls", "i5.xls", "i6.xls")
```

### 2. Ejecutar análisis completo
```r
resultado_intensidad <- analisis_dls_completo(
  archivos = mis_archivos,
  hoja = 1,
  col_size = 1,
  col_intensity = 2,
  nombre_archivo = "mi_analisis_intensidad_dls"
)
```

### 3. Visualizar resultados
```r
# Mostrar gráfico de distribución
print(resultado_intensidad$grafico)

# Exportar resultados a CSV (creado automáticamente)
# Archivo: "mi_analisis_intensidad_dls.csv"
```

---

## Análisis por Número

### 1. Definir archivos de entrada
```r
mis_archivos <- c("n1.xls", "n2.xls", "n3.xls", "n4.xls", "n5.xls", "n6.xls")
```

### 2. Ejecutar análisis completo
```r
resultado_numero <- analisis_dls_completo(
  archivos = mis_archivos,
  hoja = 1,
  col_size = 1,
  col_intensity = 2,
  nombre_archivo = "mi_analisis_numero_dls"
)
```

### 3. Visualizar resultados
```r
print(resultado_numero$grafico)
# Resultados en: "mi_analisis_numero_dls.csv"
```

---

## Análisis por Volumen

### 1. Definir archivos de entrada
```r
mis_archivos <- c("v1.xls", "v2.xls", "v3.xls", "v4.xls", "v5.xls", "v6.xls")
```

### 2. Ejecutar análisis completo
```r
resultado_volumen <- analisis_dls_completo(
  archivos = mis_archivos,
  hoja = 1,
  col_size = 1,
  col_intensity = 2,
  nombre_archivo = "mi_analisis_volumen_dls"
)
```

### 3. Visualizar resultados
```r
print(resultado_volumen$grafico)
# Resultados en: "mi_analisis_volumen_dls.csv"
```

---

## Estructura esperada de archivos Excel
Cada archivo (.xls) debe contener al menos:
- **Columna 1**: Tamaño de partícula (nm)
- **Columna 2**: Intensidad (%)

Ejemplo:
| Tamaño (nm) | Intensidad (%) |
|-------------|----------------|
| 10          | 0.5            |
| 15          | 1.2            |
| ...         | ...            |

---

## Parámetros de la función `analisis_dls_completo()`
| Parámetro         | Descripción                                                                 |
|-------------------|-----------------------------------------------------------------------------|
| `archivos`        | Vector con nombres de archivos (ej: `c("file1.xls", "file2.xls")`)          |
| `hoja`            | Número de hoja donde están los datos (por defecto: 1)                       |
| `col_size`        | Número de columna con tamaños de partícula (por defecto: 1)                 |
| `col_intensity`   | Número de columna con valores de intensidad (por defecto: 2)                |
| `nombre_archivo`  | Nombre base para archivo CSV de resultados (sin extensión)                  |

---

## Resultados obtenidos
La función devuelve una lista con:
1. `$datos`: Dataframe con estadísticas resumen
2. `$grafico`: Gráfico de distribución combinada
3. Archivo CSV con resultados completos

## Visualización de resultados
```r
# Acceder a datos resumen
head(resultado_intensidad$datos)

# Personalizar gráfico (ejemplo con ggplot2)
library(ggplot2)
resultado_intensidad$grafico +
  ggtitle("Distribución por Intensidad") +
  theme_minimal()
```

> **Nota:** Los archivos de entrada deben estar en el mismo directorio de trabajo o proporcionar rutas completas.
