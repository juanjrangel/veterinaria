-- Base de datos Veterinaria
-- Integrantes:
--   Isabella Plata - 2243568
--   Mateo Leiva - 2230339
--   Juan Morera - 2243581
--   Diego Quintero - 2243593
--   Juan José Rangel - 2243554


USE Veterinaria;

-- Consulta 1: Historial clínico detallado de atenciones
SELECT
    A.ID_atencion,
    A.Fecha,
    A.Hora,
    M.Nombre AS Mascota,
    M.Especie,
    CONCAT(P_Prop.Nombres, ' ', P_Prop.Apellidos) AS Propietario,
    CONCAT(P_Vet.Nombres, ' ', P_Vet.Apellidos) AS Veterinario,
    S.Nombre AS Sede
FROM Atencion A
JOIN Mascota M ON A.ID_Mascota = M.ID
JOIN Propietario Pr ON M.ID_Propietario = Pr.ID_Persona
JOIN Persona P_Prop ON Pr.ID_Persona = P_Prop.ID
JOIN Veterinario V ON A.ID_Veterinario = V.ID_Persona
JOIN Persona P_Vet ON V.ID_Persona = P_Vet.ID
JOIN Sede S ON A.ID_Sede = S.ID;

-- Consulta 2: Diagnóstico y tratamiento asignado a cada mascota.
SELECT
    M.Nombre AS Mascota,
    M.Especie,
    A.Fecha AS Fecha_Consulta,
    D.Hallazgos,
    D.Tratamiento
FROM Diagnostico D
JOIN Atencion A ON D.ID_Atencion = A.ID_atencion
JOIN Mascota M ON A.ID_Mascota = M.ID;

-- Consulta 3: Total facturado generado por cada atención médica.
SELECT
    A.ID_atencion,
    A.Fecha,
    M.Nombre AS Mascota,
    SUM(Ser.Costo) AS Total_Atencion
FROM Atencion A
JOIN Mascota M ON A.ID_Mascota = M.ID
JOIN Atencion_Servicio AServ ON A.ID_atencion = AServ.ID_Atencion
JOIN Servicio Ser ON AServ.Codigo_Servicio = Ser.Codigo
GROUP BY A.ID_atencion, A.Fecha, M.Nombre;

-- Consulta 4: Distribución de mascotas registradas por especie.
SELECT
    Especie,
    COUNT(*) AS Cantidad_Mascotas
FROM Mascota
GROUP BY Especie;

-- Consulta 5: Mascotas atendidas en una sede específica con los datos de contacto de su dueño.
SELECT
    M.Nombre AS Mascota,
    M.Especie,
    CONCAT(P.Nombres, ' ', P.Apellidos) AS Propietario,
    Pr.Email,
    PT.Telefono
FROM Atencion A
JOIN Mascota M ON A.ID_Mascota = M.ID
JOIN Propietario Pr ON M.ID_Propietario = Pr.ID_Persona
JOIN Persona P ON Pr.ID_Persona = P.ID
LEFT JOIN Persona_Telefono PT ON P.ID = PT.ID_Persona
WHERE A.ID_Sede = 1;

-- Consulta 6: Servicios prestados en el sistema ordenados por frecuencia de uso.
SELECT
    S.Tipo,
    S.Descripcion,
    S.Costo,
    COUNT(AServ.ID_Atencion) AS Cantidad_Uso
FROM Servicio S
LEFT JOIN Atencion_Servicio AServ ON S.Codigo = AServ.Codigo_Servicio
GROUP BY S.Codigo, S.Tipo, S.Descripcion, S.Costo
ORDER BY Cantidad_Uso DESC;

-- Consulta 7: Promedio del costo facturado por atención según la sede.
SELECT
    S.Nombre AS Sede,
    AVG(SubConsulta.Total_Atencion) AS Promedio_Costo_Atencion
FROM Sede S
JOIN Atencion A ON S.ID = A.ID_Sede
JOIN (
    SELECT
        ID_Atencion,
        SUM(Ser.Costo) AS Total_Atencion
    FROM Atencion_Servicio AServ
    JOIN Servicio Ser ON AServ.Codigo_Servicio = Ser.Codigo
    GROUP BY ID_Atencion
) AS SubConsulta ON A.ID_atencion = SubConsulta.ID_Atencion
GROUP BY S.ID, S.Nombre;

-- Consulta 8: Cantidad de atenciones realizadas por cada veterinario.
SELECT
    CONCAT(P.Nombres, ' ', P.Apellidos) AS Veterinario,
    V.Registro_profesional,
    COUNT(A.ID_atencion) AS Total_Atenciones
FROM Veterinario V
JOIN Persona P ON V.ID_Persona = P.ID
LEFT JOIN Atencion A ON V.ID_Persona = A.ID_Veterinario
GROUP BY V.ID_Persona, P.Nombres, P.Apellidos, V.Registro_profesional;

-- Consulta 9: Propietarios que poseen más de una mascota registrada.
SELECT
    CONCAT(P.Nombres, ' ', P.Apellidos) AS Propietario,
    Pr.Email,
    COUNT(M.ID) AS Total_Mascotas
FROM Propietario Pr
JOIN Persona P ON Pr.ID_Persona = P.ID
JOIN Mascota M ON Pr.ID_Persona = M.ID_Propietario
GROUP BY Pr.ID_Persona, P.Nombres, P.Apellidos, Pr.Email
HAVING COUNT(M.ID) > 1;

-- Consulta 10: Listado de mascotas mayores a 5 años atendidas por especialidad.
SELECT
    M.Nombre AS Mascota,
    M.Especie,
    M.Fecha_Nacimiento,
    CONCAT(P.Nombres, ' ', P.Apellidos) AS Veterinario,
    VE.Especialidad,
    A.Fecha AS Fecha_Atencion
FROM Mascota M
JOIN Atencion A ON M.ID = A.ID_Mascota
JOIN Veterinario V ON A.ID_Veterinario = V.ID_Persona
JOIN Persona P ON V.ID_Persona = P.ID
JOIN Veterinario_Especialidad VE ON V.ID_Persona = VE.ID_Persona
WHERE M.Fecha_Nacimiento <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
ORDER BY VE.Especialidad, M.Nombre;
