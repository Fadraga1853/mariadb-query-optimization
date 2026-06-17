-- ====================================================================
-- PROYECTO 2: OPTIMIZACIÓN DE CONSULTAS Y GESTIÓN DE ÍNDICES (DBA)
-- MOTOR: MariaDB / MySQL | ENTORNO: DBeaver
-- ====================================================================

-- 1. CREACIÓN DE LA TABLA DE VENTAS MASIVAS
CREATE TABLE IF NOT EXISTS ventas_globales (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    monto DECIMAL(10,2),
    pais_envio VARCHAR(50),
    fecha_venta DATE
);

-- 2. DIAGNÓSTICO INICIAL (Full Table Scan detectado con type = ALL)
EXPLAIN SELECT * FROM ventas_globales WHERE pais_envio = 'España';

-- 3. SOLUCIÓN: CREACIÓN DEL ÍNDICE DE BÚSQUEDA RÁPIDA
CREATE INDEX idx_ventas_pais ON ventas_globales (pais_envio);

-- 4. COMPROBACIÓN DE OPTIMIZACIÓN (Cambio de type ALL a ref y reducción de rows)
EXPLAIN SELECT * FROM ventas_globales FORCE INDEX (idx_ventas_pais) WHERE pais_envio = 'España';
