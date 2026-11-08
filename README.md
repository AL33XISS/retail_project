## Cómo ejecutar el script en DBeaver

El archivo `retail_project.sql` crea la base, las tablas, carga los datos y ejecuta operaciones de mantenimiento.

1. Abrir en DBeaver una conexión a una base existente, por ejemplo `postgres`.
2. Abrir `retail_project.sql` y ejecutar la sentencia `CREATE DATABASE retail_project;` del comienzo.
3. En DBeaver, abrir una conexión a la nueva base `retail_project` (o cambiar la base de datos de la conexión).
4. Volver al archivo y ejecutar el resto del script, desde la primera sentencia `CREATE TABLE clientes`.
5. Revisar el resultado del `SELECT` final: tienen que quedar cinco registros en cada tabla.