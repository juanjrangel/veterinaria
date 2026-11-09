-- Base de datos Veterinaria
-- Integrantes:
--   Isabella Plata - 2243568
--   Mateo Leiva - 2230339
--   Juan Morera - 2243581
--   Diego Quintero - 2243593
--   Juan José Rangel - 2243554


SET NAMES utf8mb4;

-- 0. Crear y seleccionar la base de datos
DROP DATABASE IF EXISTS Veterinaria;   -- permite volver a ejecutar el script sin errores
CREATE DATABASE IF NOT EXISTS Veterinaria;
USE Veterinaria;

-- 1. Tabla Persona
CREATE TABLE Persona (
    ID INT PRIMARY KEY,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL
);

-- 2. Tabla Persona_Telefono
CREATE TABLE Persona_Telefono (
    ID_Persona INT,
    Telefono VARCHAR(20),
    PRIMARY KEY (ID_Persona, Telefono),
    FOREIGN KEY (ID_Persona) REFERENCES Persona(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 3. Tabla Propietario
CREATE TABLE Propietario (
    ID_Persona INT PRIMARY KEY,
    Direccion VARCHAR(150),
    Email VARCHAR(100),
    FOREIGN KEY (ID_Persona) REFERENCES Persona(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 4. Tabla Veterinario
CREATE TABLE Veterinario (
    ID_Persona INT PRIMARY KEY,
    Registro_profesional VARCHAR(50) NOT NULL,
    FOREIGN KEY (ID_Persona) REFERENCES Persona(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 5. Tabla Veterinario_Especialidad
CREATE TABLE Veterinario_Especialidad (
    ID_Persona INT,
    Especialidad VARCHAR(100),
    PRIMARY KEY (ID_Persona, Especialidad),
    FOREIGN KEY (ID_Persona) REFERENCES Veterinario(ID_Persona) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 6. Tabla Sede
CREATE TABLE Sede (
    ID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(150) NOT NULL
);

-- 7. Tabla Sede_Telefono
CREATE TABLE Sede_Telefono (
    ID_Sede INT,
    Telefono VARCHAR(20),
    PRIMARY KEY (ID_Sede, Telefono),
    FOREIGN KEY (ID_Sede) REFERENCES Sede(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 8. Tabla Mascota
CREATE TABLE Mascota (
    ID INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Fecha_Nacimiento DATE,
    Especie VARCHAR(50) NOT NULL,
    Sexo VARCHAR(10) NOT NULL,
    ID_Propietario INT NOT NULL,
    FOREIGN KEY (ID_Propietario) REFERENCES Propietario(ID_Persona) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 9. Tabla Atencion
CREATE TABLE Atencion (
    ID_atencion INT PRIMARY KEY,
    Motivo_Consulta VARCHAR(255) NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    Notas TEXT,
    ID_Mascota INT NOT NULL,
    ID_Veterinario INT NOT NULL,
    ID_Sede INT NOT NULL,
    FOREIGN KEY (ID_Mascota) REFERENCES Mascota(ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ID_Veterinario) REFERENCES Veterinario(ID_Persona) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ID_Sede) REFERENCES Sede(ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 10. Tabla Servicio
CREATE TABLE Servicio (
    Codigo INT PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(255),
    Costo DECIMAL(10, 2) NOT NULL
);

-- 11. Tabla Atencion_Servicio
CREATE TABLE Atencion_Servicio (
    ID_Atencion INT,
    Codigo_Servicio INT,
    PRIMARY KEY (ID_Atencion, Codigo_Servicio),
    FOREIGN KEY (ID_Atencion) REFERENCES Atencion(ID_atencion) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Codigo_Servicio) REFERENCES Servicio(Codigo) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 12. Tabla Diagnostico
CREATE TABLE Diagnostico (
    ID_Diagnostico INT PRIMARY KEY,
    Hallazgos TEXT NOT NULL,
    Tratamiento TEXT NOT NULL,
    Fecha DATE NOT NULL,
    ID_Atencion INT NOT NULL,
    FOREIGN KEY (ID_Atencion) REFERENCES Atencion(ID_atencion) ON DELETE CASCADE ON UPDATE CASCADE
);
