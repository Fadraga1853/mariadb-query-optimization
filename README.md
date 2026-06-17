# ⚡ MariaDB Query Optimization & Index Management (DBA Role)

## 📌 1. Descripción del Proyecto
Este proyecto demuestra habilidades críticas de un **Administrador de Datos (DBA)** para diagnosticar y solucionar problemas de rendimiento en bases de datos relacionales de alto volumen. Se simuló un entorno con miles de registros de ventas para identificar cuellos de botella mediante planes de ejecución y optimizar los tiempos de respuesta utilizando estrategias de indexación.

---

## 🔍 2. Diagnóstico del Cuello de Botella (Full Table Scan)
Al ejecutar un análisis de la consulta analítica por país con el comando `EXPLAIN`, se identificaron las siguientes deficiencias en el motor de MariaDB:
* **type = ALL:** El servidor se veía obligado a realizar una lectura secuencial completa de la tabla en disco duro (Full Table Scan).
* **rows = 1536:** Para procesar una consulta simple, el motor inspeccionaba la totalidad de los registros del repositorio, lo que escalado a millones de filas degradaría por completo el rendimiento del servidor.

---

## 🛠️ 3. Estrategia de Optimización (Creación de Índices)
Para mitigar la carga del servidor, se diseñó e implementó un índice tradicional no agrupado (B-Tree) sobre la columna de filtrado geográfico:

```sql
CREATE INDEX idx_ventas_pais ON ventas_globales (pais_envio);
```

Para validar el comportamiento del optimizador en volúmenes controlados, se forzó el uso de la estructura mediante la sentencia `FORCE INDEX`.

---

## 📈 4. Resultados Obtenidos
Tras la aplicación del índice, se ejecutó una nueva auditoría del plan de ejecución, logrando los siguientes resultados de alta eficiencia:
1. **Optimización del tipo de acceso:** El campo `type` cambió de `ALL` a `ref`, indicando que el motor ahora realiza una búsqueda indexada directa en lugar de barrer la tabla entera.
2. **Reducción drástica de lectura de filas:** El indicador `rows` disminuyó de **1536 a solo 512 filas inspeccionadas**, reduciendo el esfuerzo del procesador a solo un 33% del estado original.

---

## 🚀 5. Habilidades Demostradas
* Análisis de Planes de Ejecución SQL (`EXPLAIN`).
* Diagnóstico de cuellos de botella en bases de datos relacionales.
* Diseño e implementación de Índices (`CREATE INDEX`).
* Estrategias de optimización de rendimiento y tuning para perfiles de administración de datos.
