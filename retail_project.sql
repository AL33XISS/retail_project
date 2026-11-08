CREATE DATABASE retail_project;

-- DDL: tablas principales
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    edad INTEGER NOT NULL,
    CONSTRAINT chk_clientes_edad CHECK (edad >= 18)
);

CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    categoria VARCHAR(60) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INTEGER NOT NULL,
    CONSTRAINT chk_productos_precio CHECK (precio > 0),
    CONSTRAINT chk_productos_stock CHECK (stock >= 0)
);

-- Crear ventas
CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    fecha_venta DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_ventas_clientes
        FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
        ON DELETE RESTRICT,
    CONSTRAINT fk_ventas_productos
        FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
        ON DELETE RESTRICT,
    CONSTRAINT chk_ventas_cantidad CHECK (cantidad > 0),
    CONSTRAINT chk_ventas_precio_unitario CHECK (precio_unitario > 0)
);

-- DML:
BEGIN;

-- 5 clientes
INSERT INTO clientes (nombre, email, edad) VALUES
('Ana Pérez', 'ana.perez@example.com', 28),
('Bruno Silva', 'bruno.silva@example.com', 35),
('Carla Gómez', 'carla.gomez@example.com', 22),
('Diego Rodríguez', 'diego.rodriguez@example.com', 41),
('Elena Fernández', 'elena.fernandez@example.com', 31);

-- 5 productos
INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Auriculares Bluetooth', 'Electrónica', 2490.00, 20),
('Mouse inalámbrico', 'Electrónica', 890.00, 35),
('Botella térmica', 'Accesorios', 650.00, 40),
('Mochila urbana', 'Accesorios', 1890.00, 15),
('Cuaderno A5', 'Papelería', 220.00, 60);

-- 6 ventas: se elimina la de prueba quedando 5 al final.
INSERT INTO ventas (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES
(1, 1, 1, 2490.00, '2026-10-01'),
(2, 2, 2, 890.00, '2026-10-02'),
(3, 3, 1, 650.00, '2026-10-03'),
(4, 4, 1, 1890.00, '2026-10-04'),
(5, 5, 3, 220.00, '2026-10-05'),
(1, 5, 1, 220.00, '2026-10-06');

COMMIT;

-- UPDATE
SELECT id_producto, nombre, categoria, precio
FROM productos
WHERE categoria = 'Accesorios';

-- Aumentar un 10% el precio de los productos de Accesorios.
UPDATE productos
SET precio = ROUND(precio * 1.10, 2)
WHERE categoria = 'Accesorios';

-- DELETE
SELECT id_venta, id_cliente, id_producto, fecha_venta
FROM ventas
WHERE id_venta = 6;

-- Eliminar la venta de prueba
DELETE FROM ventas
WHERE id_venta = 6;

-- Verificar cantidades finales:
SELECT 'clientes' AS tabla, COUNT(*) AS cantidad FROM clientes
UNION ALL
SELECT 'productos', COUNT(*) FROM productos
UNION ALL
SELECT 'ventas', COUNT(*) FROM ventas;