-- Base de datos Veterinaria
-- Integrantes:
--   Isabella Plata - 2243568
--   Mateo Leiva - 2230339
--   Juan Morera - 2243581
--   Diego Quintero - 2243593
--   Juan José Rangel - 2243554


SET NAMES utf8mb4;
USE Veterinaria;

-- 1. Insertar en Persona
INSERT INTO Persona (ID, Nombres, Apellidos) VALUES
(1, 'Carlos', 'Gómez'),
(2, 'María', 'Rodríguez'),
(3, 'Juan', 'Pérez'),
(4, 'Ana', 'Martínez'),
(5, 'Laura', 'Sánchez'),
(6, 'Diego', 'López'),
(7, 'Camila', 'Torres'),
(8, 'Andrés', 'Ramírez'),
(9, 'Sofía', 'Hernández'),
(10, 'Javier', 'Díaz');

-- 2. Insertar en Persona_Telefono
INSERT INTO Persona_Telefono (ID_Persona, Telefono) VALUES
(1, '3001234567'),
(1, '3009876543'),
(2, '3102345678'),
(3, '3203456789'),
(4, '3154567890'),
(5, '3185678901');

-- 3. Insertar en Propietario
INSERT INTO Propietario (ID_Persona, Direccion, Email) VALUES
(1, 'Calle 10 # 5-20, Bucaramanga', 'carlos.gomez@email.com'),
(2, 'Carrera 15 # 45-12, Floridablanca', 'maria.rodriguez@email.com'),
(3, 'Calle 34 # 22-05, Girón', 'juan.perez@email.com'),
(4, 'Carrera 27 # 10-30, Bucaramanga', 'ana.martinez@email.com'),
(5, 'Calle 50 # 18-40, Piedecuesta', 'laura.sanchez@email.com');

-- 4. Insertar en Veterinario
INSERT INTO Veterinario (ID_Persona, Registro_profesional) VALUES
(6, 'VET-1001'),
(7, 'VET-1002'),
(8, 'VET-1003'),
(9, 'VET-1004'),
(10, 'VET-1005');

-- 5. Insertar en Veterinario_Especialidad
INSERT INTO Veterinario_Especialidad (ID_Persona, Especialidad) VALUES
(6, 'Cirugía General'),
(6, 'Traumatología'),
(7, 'Dermatología'),
(8, 'Cardiología'),
(9, 'Oftalmología'),
(10, 'Odontología Veterinaria');

-- 6. Insertar en Sede
INSERT INTO Sede (ID, Nombre, Direccion) VALUES
(1, 'Sede Central', 'Av. Quebradaseca # 31-15, Bucaramanga'),
(2, 'Sede Cañaveral', 'Calle 30 # 25-10, Floridablanca'),
(3, 'Sede Cabecera', 'Carrera 33 # 48-20, Bucaramanga'),
(4, 'Sede Girón', 'Carrera 25 # 12-08, Girón'),
(5, 'Sede Piedecuesta', 'Calle 8 # 6-14, Piedecuesta');

-- 7. Insertar en Sede_Telefono
INSERT INTO Sede_Telefono (ID_Sede, Telefono) VALUES
(1, '6076301111'),
(1, '6076302222'),
(2, '6076783333'),
(3, '6076454444'),
(4, '6076565555'),
(5, '6076656666');

-- 8. Insertar en Mascota
INSERT INTO Mascota (ID, Nombre, Fecha_Nacimiento, Especie, Sexo, ID_Propietario) VALUES
(101, 'Lucas', '2020-03-15', 'Perro', 'Macho', 1),
(102, 'Mia', '2021-06-20', 'Gato', 'Hembra', 2),
(103, 'Rocky', '2019-11-05', 'Perro', 'Macho', 3),
(104, 'Toby', '2022-01-10', 'Perro', 'Macho', 4),
(105, 'Pelusa', '2020-08-25', 'Gato', 'Hembra', 5),
(106, 'Luna', '2023-04-12', 'Gato', 'Hembra', 1);   -- segunda mascota de Carlos Gómez (Consulta 9)

-- 9. Insertar en Atencion
INSERT INTO Atencion (ID_atencion, Motivo_Consulta, Fecha, Hora, Notas, ID_Mascota, ID_Veterinario, ID_Sede) VALUES
(501, 'Control de rutina y vacunación', '2026-10-01', '09:00:00', 'Mascota en buen estado general', 101, 6, 1),
(502, 'Problema en la piel y picazón', '2026-10-02', '10:30:00', 'Presenta eritema en el lomo', 102, 7, 2),
(503, 'Chequeo cardíaco preventivo', '2026-10-05', '11:00:00', 'Soplo leve detectado', 103, 8, 3),
(504, 'Revisión ocular por inflamación', '2026-10-10', '14:15:00', 'Conjuntivitis aguda', 104, 9, 1),
(505, 'Limpieza dental profunda', '2026-10-12', '16:00:00', 'Sarro moderado en molares', 105, 10, 4);

-- 10. Insertar en Servicio
INSERT INTO Servicio (Codigo, Tipo, Descripcion, Costo) VALUES
(1, 'Consulta', 'Consulta médica general o especializada', 50000.00),
(2, 'Vacunación', 'Aplicación de vacuna múltiple o antirrábica', 35000.00),
(3, 'Examen Laboratorio', 'Hemograma y perfil bioquímico', 80000.00),
(4, 'Profilaxis', 'Limpieza dental ultrasónica', 120000.00),
(5, 'Especialidad', 'Valoración por especialidad médica', 90000.00);

-- 11. Insertar en Atencion_Servicio
INSERT INTO Atencion_Servicio (ID_Atencion, Codigo_Servicio) VALUES
(501, 1),
(501, 2),
(502, 1),
(502, 3),
(503, 5),
(504, 1),
(505, 4);

-- 12. Insertar en Diagnostico
INSERT INTO Diagnostico (ID_Diagnostico, Hallazgos, Tratamiento, Fecha, ID_Atencion) VALUES
(901, 'Paciente totalmente sano', 'Refuerzo de vacuna anual en 12 meses', '2026-10-01', 501),
(902, 'Dermatitis alérgica a picadura de pulga', 'Shampoo medicado y antihistamínicos por 10 días', '2026-10-02', 502),
(903, 'Soplo sistólico Grado II/VI', 'Control ecocardiográfico en 6 meses y dieta baja en sodio', '2026-10-05', 503),
(904, 'Conjuntivitis bacteriana primaria', 'Gotas oftálmicas antibióticas cada 8 horas por 7 días', '2026-10-10', 504),
(905, 'Enfermedad periodontal Grado I', 'Enjuague bucal veterinario y cepillado diario', '2026-10-12', 505);
