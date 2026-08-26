--==================================================================================================--
-------------------------- PROYECTO COLEGIO(notas,asistencia y anotaciones) --------------------------
--==================================================================================================--



-------------------------- 1. ALUMNOS --------------------------

CREATE TABLE colegios (
    id_colegio NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rbd        VARCHAR2(20) NOT NULL UNIQUE, -- Registro Base de Datos escolar
    nombre     VARCHAR2(150) NOT NULL,
    direccion  VARCHAR2(200)
);

-------------------------- 2. NIVELES (1° medio, 2° medio,3° medio,4° medio) --------------------------

CREATE TABLE niveles (
    id_nivel NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre   VARCHAR2(50) NOT NULL UNIQUE
);

-------------------------- 3. DOCENTES --------------------------

CREATE TABLE docente (
    id_docente NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rut        VARCHAR2(12) NOT NULL UNIQUE,
    nombres    VARCHAR2(100) NOT NULL,
    apellidos  VARCHAR2(100) NOT NULL,
    email      VARCHAR2(100),
    telefono   VARCHAR2(20)
);

-------------------------- 4. ALUMNOS --------------------------

CREATE TABLE alumnos (
    id_alumno NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rut       VARCHAR2(12) NOT NULL UNIQUE,
    nombres   VARCHAR2(100) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    fecha_nac DATE,
    email     VARCHAR2(100)
);

-------------------------- 5. ASIGNATURAS --------------------------

CREATE TABLE asignaturas (
    id_asignatura NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre        VARCHAR2(100) NOT NULL UNIQUE
);

-------------------------- 6. CURSOS --------------------------

CREATE TABLE cursos (
    id_curso     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_colegio   NUMBER NOT NULL,
    id_nivel     NUMBER NOT NULL,
    letra        CHAR(1) NOT NULL,    -- Ej: 'A'
    anio_lectivo NUMBER(4) NOT NULL,  -- Ej: 2026
    CONSTRAINT fk_curso_colegio FOREIGN KEY (id_colegio) REFERENCES colegios(id_colegio),
    CONSTRAINT fk_curso_nivel FOREIGN KEY (id_nivel) REFERENCES niveles(id_nivel),
    CONSTRAINT uq_curso UNIQUE (id_colegio, id_nivel, letra, anio_lectivo)
);

-------------------------- 7. MATRICULAS  --------------------------

CREATE TABLE matriculas (
    id_matricula NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_alumno    NUMBER NOT NULL,
    id_curso     NUMBER NOT NULL,
    fecha_matr   DATE DEFAULT SYSDATE,
    CONSTRAINT fk_matr_alumno FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
    CONSTRAINT fk_matr_curso FOREIGN KEY (id_curso) REFERENCES cursos(id_curso),
    CONSTRAINT uq_alumno_curso UNIQUE (id_alumno, id_curso)
);

-------------------------- 8. CARGA DOCENTE --------------------------

CREATE TABLE carga_docente (
    id_carga      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_curso      NUMBER NOT NULL,
    id_asignatura NUMBER NOT NULL,
    id_docente    NUMBER NOT NULL,
    CONSTRAINT fk_carga_curso FOREIGN KEY (id_curso) REFERENCES cursos(id_curso),
    CONSTRAINT fk_carga_asig FOREIGN KEY (id_asignatura) REFERENCES asignaturas(id_asignatura),
    CONSTRAINT fk_carga_docente FOREIGN KEY (id_docente) REFERENCES docente(id_docente),
    CONSTRAINT uq_carga UNIQUE (id_curso, id_asignatura)
);

-------------------------- 9. ASISTENCIA  --------------------------

CREATE TABLE asistencia (
    id_asistencia NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_matricula  NUMBER NOT NULL,
    fecha         DATE NOT NULL,
    estado        VARCHAR2(15) NOT NULL CHECK (estado IN ('PRESENTE', 'AUSENTE', 'JUSTIFICADO', 'ATRASADO')),
    observacion   VARCHAR2(255),
    CONSTRAINT fk_asist_matricula FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula),
    CONSTRAINT uq_asistencia_dia UNIQUE (id_matricula, fecha)
);

-------------------------- 10. CALIFICACIONES --------------------------

CREATE TABLE calificaciones (
    id_calificacion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_matricula    NUMBER NOT NULL,
    id_carga        NUMBER NOT NULL, -- Asocia directamente al profesor y asignatura del curso
    nota            NUMBER(3,1) NOT NULL CHECK (nota BETWEEN 1.0 AND 7.0),
    ponderacion     NUMBER(3,2) CHECK (ponderacion BETWEEN 0.01 AND 1.00),
    fecha           DATE DEFAULT SYSDATE NOT NULL,
    descripcion     VARCHAR2(100), -- Ej: 'Prueba Parcial 1'
    CONSTRAINT fk_not_matricula FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula),
    CONSTRAINT fk_not_carga FOREIGN KEY (id_carga) REFERENCES carga_docente(id_carga)
);

-------------------------- 11. ANOTACIONES --------------------------

CREATE TABLE anotaciones (
    id_anotacion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_matricula NUMBER NOT NULL,
    id_docente   NUMBER NOT NULL, -- Registra qué profesor puso la anotación
    id_carga     NUMBER,          -- Opcional: si ocurrió durante una clase específica
    tipo         VARCHAR2(10) NOT NULL CHECK (tipo IN ('POSITIVA', 'NEGATIVA')),
    categoria    VARCHAR2(50),    -- Ej: 'Convivencia', 'Responsabilidad'
    detalle      CLOB NOT NULL,
    fecha        DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_anot_matricula FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula),
    CONSTRAINT fk_anot_docente FOREIGN KEY (id_docente) REFERENCES docente(id_docente),
    CONSTRAINT fk_anot_carga FOREIGN KEY (id_carga) REFERENCES carga_docente(id_carga)
);





COMMIT;

--==================================================================================================--
------------------------------------- FIN CREACION BDD -----------------------------------------------
--==================================================================================================--

-------------------------- INSERTACION DE DATOS --------------------------

INSERT INTO ALUMNOS(
    id_colegio, 
    rbd, 
    nombre, 
    direccion)
VALUES
    (
        
    )

