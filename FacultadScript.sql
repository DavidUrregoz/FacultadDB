CREATE SCHEMA `facultad2` ;
USE facultad2;

CREATE TABLE `facultad2`.`persona` (
  `cedula` VARCHAR(20) NOT NULL,
  `edad` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `calle` VARCHAR(45) NULL,
  `carrera` VARCHAR(45) NULL,
  `numero_casa` VARCHAR(45) NULL,
  `es_profesor` VARBINARY(2) NOT NULL,
  `es_estudiante` VARBINARY(2) NOT NULL,
  `salario` DECIMAL(8,2) NULL,
  `casillero` VARCHAR(10) NULL,
  `creditos_aprobados` INT NULL,
  `promedio` DECIMAL(3,3) NULL,
  PRIMARY KEY (`cedula`),
  UNIQUE INDEX `cedula_UNIQUE` (`cedula` ASC) VISIBLE);
  
  CREATE TABLE `facultad2`.`materia` (
  `codigo_materia` INT NOT NULL AUTO_INCREMENT,
  `numero_salon` INT NOT NULL,
  `numero_bloque` INT NOT NULL,
  `nombre_materia` VARCHAR(100) NOT NULL,
  `numero_creditos` INT NOT NULL,
  `dias_clase` VARCHAR(45) NOT NULL,
  `horas_clase` VARCHAR(45) NOT NULL,
  `es_presencial` VARBINARY(2) NOT NULL,
  `es_laboratorio` VARBINARY(2) NOT NULL,
  PRIMARY KEY (`codigo_materia`),
  UNIQUE INDEX `codigo_materia_UNIQUE` (`codigo_materia` ASC) VISIBLE);
  
  
  CREATE TABLE `facultad2`.`correos` (
  `correo` VARCHAR(100) NOT NULL,
  `cedula` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`correo`, `cedula`),
  INDEX `fk_correo_persona_idx` (`cedula` ASC) VISIBLE,
  CONSTRAINT `fk_correo_persona`
    FOREIGN KEY (`cedula`)
    REFERENCES `facultad2`.`persona` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);
    
 CREATE TABLE facultad2.telefonos (
  `telefono` VARCHAR(20) NOT NULL,
  `cedula` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`telefono`, `cedula`),
  INDEX `fk_telefono_persona_idx` (`cedula` ASC) VISIBLE,
  CONSTRAINT `fk_telefono_persona_idx`
    FOREIGN KEY (`cedula`)
    REFERENCES `facultad2`.`persona` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);
    
CREATE TABLE `facultad2`.`relacion_toma` (
  `cedula` VARCHAR(20) NOT NULL,
  `codigo_materia` INT NOT NULL,
  PRIMARY KEY (`cedula`, `codigo_materia`),
  INDEX `fk_materia_toma_idx` (`codigo_materia` ASC) VISIBLE,
  CONSTRAINT `fk_persona_toma`
    FOREIGN KEY (`cedula`)
    REFERENCES `facultad2`.`persona` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_materia_toma`
    FOREIGN KEY (`codigo_materia`)
    REFERENCES `facultad2`.`materia` (`codigo_materia`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

CREATE TABLE `facultad2`.`relacion_dicta` (
  `cedula` VARCHAR(20) NOT NULL,
  `codigo_materia` INT NOT NULL,
  PRIMARY KEY (`cedula`, `codigo_materia`),
  INDEX `fk_materia_dicta_idx` (`codigo_materia` ASC) VISIBLE,
  CONSTRAINT `fk_persona_dicta`
    FOREIGN KEY (`cedula`)
    REFERENCES `facultad2`.`persona` (`cedula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_materia_dicta`
    FOREIGN KEY (`codigo_materia`)
    REFERENCES `facultad2`.`materia` (`codigo_materia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
CREATE TABLE `facultad2`.`departamento` (
  `nombre_departamento` VARCHAR(100) NOT NULL,
  `oficina_atencion` VARCHAR(20) NOT NULL,
  `numero_atencion` VARCHAR(20) NOT NULL,
  `correo_atencion` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`nombre_departamento`),
  UNIQUE INDEX `codigo_carrera_UNIQUE` (`nombre_departamento` ASC) VISIBLE);

CREATE TABLE `facultad2`.`carrera` (
  `codigo_carrera` INT NOT NULL AUTO_INCREMENT,
  `nombre_departamento` VARCHAR(100) NOT NULL,
  `nombre_carrera` VARCHAR(100) NOT NULL,
  `oficina_atencion` VARCHAR(20) NOT NULL,
  `numero_materias` INT NOT NULL,
  `numero_estudiantes` INT NOT NULL,
  PRIMARY KEY (`codigo_carrera`),
  UNIQUE INDEX `codigo_carrera_UNIQUE` (`codigo_carrera` ASC) VISIBLE,
  INDEX `fk_departamento_carrera_idx` (`nombre_departamento` ASC) VISIBLE,
  CONSTRAINT `fk_departamento_carrera`
    FOREIGN KEY (`nombre_departamento`)
    REFERENCES `facultad2`.`departamento` (`nombre_departamento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    

CREATE TABLE `facultad2`.`relacion_estudia` (
  `cedula` VARCHAR(20) NOT NULL,
  `codigo_carrera` INT NOT NULL,
  PRIMARY KEY (`cedula`, `codigo_carrera`),
  INDEX `fk_carrera_estudia_idx` (`codigo_carrera` ASC) VISIBLE,
  CONSTRAINT `fk_persona_estudia`
    FOREIGN KEY (`cedula`)
    REFERENCES `facultad2`.`persona` (`cedula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_carrera_estudia`
    FOREIGN KEY (`codigo_carrera`)
    REFERENCES `facultad2`.`carrera` (`codigo_carrera`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE `facultad2`.`relacion_estudia` (
  `cedula` VARCHAR(20) NOT NULL,
  `codigo_carrera` INT NOT NULL,
  PRIMARY KEY (`cedula`, `codigo_carrera`),
  INDEX `fk_carrera_estudia_idx` (`codigo_carrera` ASC) VISIBLE,
  CONSTRAINT `fk_persona_estudia`
    FOREIGN KEY (`cedula`)
    REFERENCES `facultad2`.`persona` (`cedula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_carrera_estudia`
    FOREIGN KEY (`codigo_carrera`)
    REFERENCES `facultad2`.`carrera` (`codigo_carrera`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE `facultad2`.`relacion_contiene` (
  `codigo_carrera` INT NOT NULL,
  `codigo_materia` INT NOT NULL,
  PRIMARY KEY (`codigo_carrera`, `codigo_materia`),
  INDEX `fk_materia_contiene_idx` (`codigo_materia` ASC) VISIBLE,
  CONSTRAINT `fk_materia_contiene`
    FOREIGN KEY (`codigo_materia`)
    REFERENCES `facultad2`.`materia` (`codigo_materia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_carrera_contiene`
    FOREIGN KEY (`codigo_carrera`)
    REFERENCES `facultad2`.`carrera` (`codigo_carrera`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


CREATE TABLE `facultad2`.`bloque` (
  `numero_bloque` INT NOT NULL AUTO_INCREMENT,
  `uso` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`numero_bloque`)
  );
  
CREATE TABLE `facultad2`.`salon` (
  `numero_salon` INT NOT NULL,
  `numero_bloque` INT NOT NULL,
  `numero_sillas` INT NOT NULL,
  `numero_computadores` INT NOT NULL,
  `is_proyector` VARBINARY(2) NOT NULL,
  PRIMARY KEY (`numero_salon`, `numero_bloque`),
  INDEX `fk_salon_bloque_idx` (`numero_bloque` ASC) VISIBLE,
  CONSTRAINT `fk_salon_bloque`
    FOREIGN KEY (`numero_bloque`)
    REFERENCES `facultad2`.`bloque` (`numero_bloque`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
    
    
ALTER TABLE `facultad2`.`materia` 
ADD INDEX `fk_materia_salon_idx` (`numero_salon` ASC) VISIBLE,
ADD INDEX `fk_materia_bloque_idx` (`numero_bloque` ASC) VISIBLE;
ALTER TABLE `facultad2`.`materia` 
ADD CONSTRAINT `fk_materia_salon`
  FOREIGN KEY (`numero_salon`)
  REFERENCES `facultad2`.`salon` (`numero_salon`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk_materia_bloque`
  FOREIGN KEY (`numero_bloque`)
  REFERENCES `facultad2`.`bloque` (`numero_bloque`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
  
  
  
  /*Se agrega el campo de activo a la tabla de persona*/
ALTER TABLE `facultad2`.`persona` 
ADD COLUMN `activo` VARBINARY(2) NOT NULL;

/*Se agregaron el campo activo en materia y se cambiaron las depecdencias a restrict */
ALTER TABLE `facultad2`.`materia` 
DROP FOREIGN KEY `fk_materia_bloque`,
DROP FOREIGN KEY `fk_materia_salon`;
ALTER TABLE `facultad2`.`materia` 
ADD COLUMN `activo` VARBINARY(2) NOT NULL AFTER `es_laboratorio`;
ALTER TABLE `facultad2`.`materia` 
ADD CONSTRAINT `fk_materia_bloque`
  FOREIGN KEY (`numero_bloque`)
  REFERENCES `facultad2`.`bloque` (`numero_bloque`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk_materia_salon`
  FOREIGN KEY (`numero_salon`)
  REFERENCES `facultad2`.`salon` (`numero_salon`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
ALTER TABLE `facultad2`.`salon` 
DROP FOREIGN KEY `fk_salon_bloque`;
ALTER TABLE `facultad2`.`salon` 
ADD CONSTRAINT `fk_salon_bloque`
  FOREIGN KEY (`numero_bloque`)
  REFERENCES `facultad2`.`bloque` (`numero_bloque`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  


    
/*SE PROCEDE A LLENAR LA TABLA*/
  

SHOW COLUMNS FROM persona; 
INSERT INTO persona VALUES("1033342050",24,"David","Urrego","Zapata","1997-04-17","Amaga",NULL,"50","46-08",false,true,NULL,"A27",0,0,true); 
INSERT INTO persona VALUES("1032244556",24,"Caro","Diosa","P","1995-09-18","Envigado","31","56","1-2",false,true,NULL,"B57",0,0,true); 
INSERT INTO persona VALUES("1032244123",25,"Pedro","Ossa","Q","1996-02-7","Cartagena","01","6","145A-29",false,true,NULL,"C45",0,0,true); 
INSERT INTO persona VALUES("1032232146",20,"Sebastian","Rejo","C","2001-08-29","Reionegro","45","4","1A-9",false,true,NULL,"A5",0,0,true); 
INSERT INTO persona VALUES("1054456874",34,"Jhony","Gomez","G","1987-10-31","Medellin","45","45","141B-459C",false,true,NULL,"C63",0,0,true); 
INSERT INTO persona VALUES("1054454577",30,"Robert","Nose","K","1989-11-3","Medellin","45","46","12-45",false,true,NULL,"C93",0,0,true); 
INSERT INTO persona VALUES("1033342052",24,"Miguel","Ramirez","Perez","1997-02-1","Medellin","45","35","1A-54B",false,true,NULL,"F47",0,0,true); 
INSERT INTO persona VALUES("1033342011",24,"Felipe","Sossa","Pez","1997-01-1","Gurarodta","45","35","1A-54B",false,true,NULL,"F47",0,0,false); 


INSERT INTO persona VALUES("98435546",55,"Mazo","Restrepo","Nunes","1975-06-12","Medellin",NULL,NULL,NULL,true,false,15000,NULL,NULL,NULL,true); 
INSERT INTO persona VALUES("98435547",39,"Gabriel","Roldan","Ponce","1983-01-22","Medellin",NULL,NULL,NULL,true,false,200000,NULL,NULL,NULL,true); 
INSERT INTO persona VALUES("98435544",45,"Ricardo","Gibral","Perez","1983-03-28","Andes",NULL,NULL,NULL,true,false,300000,NULL,NULL,NULL,true); 

SELECT * FROM persona;

SHOW COLUMNS FROM bloque;
INSERT INTO bloque VALUES(null,"Uso general de la facultad de facultad de ciencias, laboratorios y salones");
INSERT INTO bloque VALUES(null,"Uso general de la facultad de facultad de quimica, administrativo");
INSERT INTO bloque VALUES(null,"Uso general de fisica y matematicas, salones y laboratorios");
INSERT INTO bloque VALUES(5,"Uso general de fisica y matematicas, salones y laboratorios");
INSERT INTO bloque VALUES(19,"Bloque principal facultad de ingenieria");
INSERT INTO bloque VALUES(18,"Bloque de laboratorios diversos de electronica y teleco");
INSERT INTO bloque VALUES(null,"bloque bliblioteca");
INSERT INTO bloque VALUES(44,"teatro");
INSERT INTO bloque VALUES(null,"artes");
SELECT * FROM bloque;

SHOW COLUMNS FROM salon;
INSERT INTO salon VALUES(101,19,45,3,true);
INSERT INTO salon VALUES(102,19,36,36,true);
INSERT INTO salon VALUES(201,19,22,11,false);
INSERT INTO salon VALUES(101,1,7,1,true);
INSERT INTO salon VALUES(101,2,23,1,true);
INSERT INTO salon VALUES(102,2,31,2,true);
INSERT INTO salon VALUES(201,2,25,3,true);
INSERT INTO salon VALUES(312,18,21,2,true);
INSERT INTO salon VALUES(106,5,10,10,true);
INSERT INTO salon VALUES(107,5,10,10,true);
INSERT INTO salon VALUES(1,44,500,2,true);
SELECT * FROM salon;


SHOW COLUMNS FROM materia;
INSERT INTO materia VALUES(null,101,1,"quimica general",4,"miercoles-viernes","6pm a 8pm",true,true,true);
INSERT INTO materia VALUES(null,102,19,"calculo",4,"miercoles-viernes","5pm a 7pm",true,false,true);
INSERT INTO materia VALUES(null,102,19,"calculo2",4,"miercoles-viernes","3pm a 5pm",true,false,true);
INSERT INTO materia VALUES(null,201,19,"algebra",4,"martes-juesves","6am a 8am",true,false,true);
INSERT INTO materia VALUES(null,201,19,"algebra lineal",4,"martes-juesves","8am a 10am",true,false,true);
INSERT INTO materia VALUES(null,312,18,"Fundamentos de electronica",5,"martes-juesves","4pm a 6pm",true,true,true);
INSERT INTO materia VALUES(null,201,2,"Lectoescritura",3,"lunes-miercoles","8am a 10am",true,false,true);
INSERT INTO materia VALUES(null,106,5,"Matematicas avanzadas",4,"lunes-miercoles","8am a 10am",true,false,true);
INSERT INTO materia VALUES(null,1,44,"Artes teatrales",4,"lunes-miercoles","6pm a 8pm",true,false,true);
INSERT INTO materia VALUES(null,101,1,"quimica organica",5,"miercoles-viernes","8pm a 10pm",true,true,true);
INSERT INTO materia VALUES(null,101,1,"quimica no organica",4,"miercoles-viernes","4pm a 5pm",true,true,true);

SELECT * FROM materia;

SHOW COLUMNS FROM relacion_toma;
INSERT INTO relacion_toma VALUES("1033342050",3);
INSERT INTO relacion_toma VALUES("1033342050",2);
INSERT INTO relacion_toma VALUES("1033342050",4);
INSERT INTO relacion_toma VALUES("1033342050",6);
INSERT INTO relacion_toma VALUES("1032244556",2);
INSERT INTO relacion_toma VALUES("1032244123",3);
INSERT INTO relacion_toma VALUES("1032244123",2);
INSERT INTO relacion_toma VALUES("1032244123",4);
INSERT INTO relacion_toma VALUES("1032232146",3);
INSERT INTO relacion_toma VALUES("1032232146",2);
INSERT INTO relacion_toma VALUES("1032232146",6);


SELECT * FROM relacion_toma;

SHOW COLUMNS FROM relacion_dicta;
INSERT INTO relacion_dicta VALUES("98435546",3);
INSERT INTO relacion_dicta VALUES("98435546",4);
INSERT INTO relacion_dicta VALUES("98435547",6);
INSERT INTO relacion_dicta VALUES("2488775562",6);
INSERT INTO relacion_dicta VALUES("98435544",9);
INSERT INTO relacion_dicta VALUES("98435547",11);
INSERT INTO relacion_dicta VALUES("245684787",13);


SELECT * FROM relacion_dicta;

SHOW COLUMNS FROM departamento;
INSERT INTO departamento VALUES("Departamento de Electronica y telecomunicaciones","19-311","8472586","depelectroteleco@udea.edu.co");
INSERT INTO departamento VALUES("Departo Escuela Ambiental ","21-312","32256545","escuelaambiental@udea.edu.co");
INSERT INTO departamento VALUES("Departo Artes  ","12-312","322545","escueladertes@udea.edu.co");

SELECT * FROM departamento;

SHOW COLUMNS FROM carrera;
INSERT INTO carrera VALUES(null,"Departamento de Electronica y telecomunicaciones","Ingenieria de Telecomunicaciones","18-321",36,1324);
INSERT INTO carrera VALUES(null,"Departamento de Electronica y telecomunicaciones","Ingenieria Electronica","18-322",29,2110);
INSERT INTO carrera VALUES(null,"Departo Artes  ","Artes Escenicas","12-311",29,810);
SELECT * FROM carrera;

SHOW COLUMNS FROM relacion_contiene;
INSERT INTO relacion_contiene VALUES(1,6);
INSERT INTO relacion_contiene VALUES(2,6);
INSERT INTO relacion_contiene VALUES(1,11);
INSERT INTO relacion_contiene VALUES(2,11);
INSERT INTO relacion_contiene VALUES(3,13);




SELECT * FROM relacion_contiene;

SHOW COLUMNS FROM relacion_estudia;
INSERT INTO relacion_estudia VALUES("1033342050",1);
SELECT * FROM relacion_estudia;

SHOW COLUMNS FROM telefonos;
INSERT INTO telefonos values("3137174421","1033342050");
INSERT INTO telefonos values("8472586","1033342050");
INSERT INTO telefonos values("32145668","1033342050");
INSERT INTO telefonos values("111122223","98435547");
SELECT * FROM telefonos;


SHOW COLUMNS FROM correos;
INSERT INTO correos values("david.urregoz@udea.edu.co","1033342050");
INSERT INTO correos values("urregodavid97@gmail.com","1033342050");
SELECT * FROM correos;




/* Creando una vista*/
/*Estudiantes activos*/
CREATE   OR REPLACE VIEW vista_estudiantes as
	SELECT 
		nombre AS Estudiantes,
		apellido1 AS Apellido,
		cedula AS Documento
    FROM 
		persona WHERE es_estudiante= true AND activo = true;

SELECT * FROM vista_estudiantes;

/*Profesores activos*/
CREATE  OR REPLACE VIEW vista_esprofesores as
	SELECT 
		nombre AS PROFESORES,
		apellido1 AS Apellido,
		cedula AS Documento
    FROM 
		persona WHERE es_profesor= true AND activo = true;
SELECT * FROM vista_esprofesores;

/*Materias Activas*/
CREATE  OR REPLACE VIEW materias_disponibles as
	SELECT 
		nombre_materia AS Materia,
		numero_creditos AS Creditos,
		dias_clase AS Dias,
        horas_clase AS Horas
    FROM 
		materia WHERE activo= true;
SELECT * FROM materias_disponibles;



/*Lugares de recidencia persoans*/
DELIMITER $$
CREATE PROCEDURE sp_listar_personas()
BEGIN
	SELECT 
		nombre as Nombre,
        apellido1 as Apellido,
        cedula AS Documento,
        ciudad AS Ciudad
	FROM
		persona;
END$$
DELIMITER ;
call sp_listar_personas();

/*PROCEDIMIENTOS ALMACENADOS*/
/*FILTRADO PERSONAS */
DROP PROCEDURE IF EXISTS sp_personas_parametrico;
DELIMITER $$
CREATE PROCEDURE sp_personas_parametrico(in cedulain VARCHAR(20), in nombrein VARCHAR(100),in ciudadin VARCHAR(45), in edadin INT, in edadend INT)
BEGIN
	SELECT
		cedula AS Documento,
        nombre AS Nombre,
        ciudad AS Ciudad,
        edad AS Edad
	FROM
		persona p
	WHERE 
		p.cedula LIKE cedulain
        AND p.nombre LIKE nombrein
        AND p.ciudad LIKE ciudadin
        AND p.edad BETWEEN edadin AND edadend;
END $$
DELIMITER ; 

call sp_personas_parametrico("1033342050","David","Medellin",0,40);

/*INGRESAR NUEVA PERSONA*/
DROP PROCEDURE IF EXISTS sp_ingresar_persona;
DELIMITER $$
CREATE PROCEDURE sp_ingresar_persona(in cedulain VARCHAR(20), 
	in nombrein VARCHAR(100),
    in apellido1in VARCHAR(45),
	in apellido2in VARCHAR(45),
    in fechain DATE,
    in ciudadin VARCHAR(45), 
    in es_profesorin boolean,
    in es_estudiantein boolean,
    in activo boolean,
	out respuesta boolean)
BEGIN
	DECLARE toltal_registros int;
    SET toltal_registros = 0;
    SET toltal_registros = (SELECT COUNT(p.cedula) FROM persona p WHERE p.cedula = cedulain);
    
    if(toltal_registros)<>1 then
		INSERT INTO persona(
			cedula,
			nombre,
			apellido1,
			apellido2,
			fecha_nacimiento,
			ciudad,
			es_profesor,
			es_estudiante,
			activo
		) VALUES(
		cedulain,
		nombrein,
		apellido1in,
		apellido2in,
		fechain,
		ciudadin, 
		es_profesorin,
		es_estudiantein,
		activo
		);
		set respuesta = true;
	else
        set respuesta= false;
	end if;
    SELECT respuesta;
    
END $$
DELIMITER ;
call sp_ingresar_persona("24568555","Fidel","Castro","Castillo","1926-06-13","Cuba",false,true,false,@respuesta);
call sp_ingresar_persona("245684787","Hugo","Chavez","L","1954-04-18","Caracas",true,false,true,@respuesta);
call sp_ingresar_persona("2488775562","Gustavo","Rojas","Pinilla","1900-04-11","Bogota",true,true,true,@respuesta);
call sp_ingresar_persona("1033342000","Juan","Caavid","Rodriguez","1997-04-18","Amaga",false,true,true,@respuesta);

/*INGRESAR NUEVA MATERIA*/
DROP PROCEDURE IF EXISTS sp_ingresar_materia;
DELIMITER $$
CREATE PROCEDURE sp_ingresar_materia(in numero_salonin INT, 
	in numero_bloquein INT,
    in nombre_materiain VARCHAR(100),
    in creditosin INT,
    in dias_clasein VARCHAR(45), 
    in horas_clasein VARCHAR(45),
    in es_presencialin boolean,
    in es_laboratorioin boolean,
    in activo boolean,
	out respuesta boolean)
BEGIN
	DECLARE toltal_registros int;  
    SET toltal_registros = 0;
    SET toltal_registros = (SELECT COUNT(m.nombre_materia) FROM materia m WHERE m.nombre_materia = nombre_materiain);
    if(toltal_registros)<>1 then
		INSERT INTO materia(
			numero_salon,
			numero_bloque,
			nombre_materia,
			numero_creditos,
			dias_clase,
			horas_clase,
			es_presencial,
			es_laboratorio,
			activo
		) VALUES(
		numero_salonin, 
		numero_bloquein,
		nombre_materiain,
		creditosin ,
		dias_clasein, 
		horas_clasein,
		es_presencialin,
		es_laboratorioin,
		activo
		);
		set respuesta = true;
	else
        set respuesta= false;
	end if;
    SELECT respuesta;
END $$
DELIMITER ; 
call sp_ingresar_materia(101,19,"Geometria Vectoria",5,"Lunes-Sabado","8am a 10am",true,false,true,@respuesta);



/*INGRESAR RELACION TOMA */
DROP PROCEDURE IF EXISTS sp_ingresar_relacion_toma;
DELIMITER $$
CREATE PROCEDURE sp_ingresar_relacion_toma(in cedulain VARCHAR(20), 
    in codigo_materiain INT,
	out respuesta boolean)
BEGIN
	DECLARE toltal_registros int;  
    SET toltal_registros = 0;
    SET toltal_registros = (SELECT COUNT(rt.cedula) FROM relacion_toma rt WHERE rt.cedula = cedulain AND rt.codigo_materia=codigo_materiain);
		if(toltal_registros)<>1 then
			if(SELECT es_estudiante FROM persona where cedula=cedulain ) = true then
				INSERT INTO relacion_toma(
					cedula,
					codigo_materia
				) VALUES(
					cedulain,
					codigo_materiain
				);
				set respuesta = true;
			else
				set respuesta= false;
				end if;
        
	else
		set respuesta= false;
	end if;
	SELECT respuesta;
END $$
DELIMITER ; 
call sp_ingresar_relacion_toma("1033342011",11,@respuesta);



/*INGRESAR RELACION DICTA */
DROP PROCEDURE IF EXISTS sp_ingresar_relacion_dicta;
DELIMITER $$
CREATE PROCEDURE sp_ingresar_relacion_dicta(in cedulain VARCHAR(20), 
    in codigo_materiain INT,
	out respuesta boolean)
BEGIN
	DECLARE toltal_registros int;  
	SET toltal_registros = 0;
	SET toltal_registros = (SELECT COUNT(rd.cedula) FROM relacion_dicta rd WHERE rd.cedula = cedulain AND rd.codigo_materia = codigo_materiain);
		if(toltal_registros)>0 then
			if(SELECT es_profesor FROM persona where cedula=cedulain ) = true then
				INSERT INTO relacion_toma(
					cedula,
					codigo_materia
				) VALUES(
					cedulain,
					codigo_materiain
				);
				set respuesta = true;
			else
				set respuesta= false;
				end if;
		
		else
			set respuesta= false;
		end if;
		SELECT respuesta;
END $$
DELIMITER ; 
call sp_ingresar_relacion_dicta("2488775562",14,@respuesta);
call sp_ingresar_relacion_dicta("2488775562",17,@respuesta);
call sp_ingresar_relacion_dicta("1033342050",14,@respuesta);



/*UPDATE PERSONA ACTIVA */
DROP PROCEDURE IF EXISTS sp_update_activo_persona;
DELIMITER $$
CREATE PROCEDURE sp_update_activo_persona(in cedulain VARCHAR(20), 
    in activoin boolean,
	out respuesta boolean)
BEGIN
	DECLARE toltal_registros int;
	SET toltal_registros = 0;
	SET toltal_registros = (SELECT COUNT(p.cedula) FROM persona p WHERE p.cedula = cedulain AND activo = activoin);
	if(toltal_registros)<1 then
		UPDATE 
			persona 
		SET
			activo = activoin
		WHERE 
			cedula = cedulain;
		set respuesta = true;
	
	else
		set respuesta= false;
	end if;

	SELECT respuesta;
END $$
DELIMITER ; 
call sp_update_activo_persona("245684787",true,@respuesta);


/*UPDATE MATERIA ACTIVA */
DROP PROCEDURE IF EXISTS sp_update_activo_materia;
DELIMITER $$
CREATE PROCEDURE sp_update_activo_materia(in codigo_materiain INT, 
    in activoin boolean,
	out respuesta boolean)
BEGIN
	DECLARE toltal_registros int;
	SET toltal_registros = 0;
    SET toltal_registros = (SELECT COUNT(m.codigo_materia) FROM materia m WHERE m.codigo_materia = codigo_materiain AND activo=activoin);
	if(toltal_registros)<1 then
		
		UPDATE 
			materia
		SET
			activo = activoin
		WHERE 
			codigo_materia = codigo_materiain;
		set respuesta = true;
		
	else
		set respuesta= false;
	end if;

	SELECT respuesta;
END $$
DELIMITER ; 
call sp_update_activo_materia(16,true,@respuesta);



/*UPDATE NOTA MATERIA*/
DROP PROCEDURE IF EXISTS sp_update_nota_materia;
DELIMITER $$
CREATE PROCEDURE sp_update_nota_materia(in codigo_materiain INT, 
    in cedulain VARCHAR(20),
    in notain FLOAT,
	out respuesta boolean)
BEGIN
	DECLARE toltal_registros int;
	SET toltal_registros = 0;
	UPDATE 
		relacion_toma
	SET
		nota = notain
	WHERE 
		codigo_materia = codigo_materiain
        AND cedula = cedulain;
		
	SET toltal_registros = (SELECT COUNT(rt.codigo_materia) FROM relacion_toma rt WHERE rt.codigo_materia = codigo_materiain AND rt.cedula=cedulain);
	if(toltal_registros)<>1 then
		set respuesta = false;
	else
		set respuesta= true;
	end if;

	SELECT respuesta;
END $$
DELIMITER ; 
call sp_update_nota_materia(2,"1032244123",4.4,@respuesta);




/*TRIGGER*/


DELIMITER |
create trigger trigger_actualizar_edad before insert on persona
for each row begin
	set new.edad = (SELECT TIMESTAMPDIFF(YEAR, new.fecha_nacimiento, CURDATE()));
end |





DROP TRIGGER trigger_calcular_promedio;
DELIMITER |
create trigger trigger_calcular_promedio after update on relacion_toma
for each row begin
	declare suma_notas float;
    declare numero_notas int;
    declare promedioas float;
    set numero_notas = (SELECT COUNT(cedula) FROM relacion_toma WHERE nota IS NOT NULL AND cedula = new.cedula);
    set suma_notas =(SELECT SUM(nota) FROM relacion_toma WHERE nota IS NOT NULL AND cedula = new.cedula );
	set promedioas = (suma_notas/numero_notas);
    UPDATE persona  SET promedio = promedioas WHERE cedula= new.cedula;
end |

UPDATE relacion_toma  SET nota = 3.99  WHERE cedula= "1033342050" AND codigo_materia= 3;
UPDATE relacion_toma  SET nota = 3.1  WHERE cedula= "1033342050" AND codigo_materia= 4;


/*JOIN PRFESORES ACTIVOS */
select 
	p.nombre as 'Profesor',
    p.apellido1 as '.',
    m.nombre_materia as 'Asignatura',
    m.dias_clase as 'Horario de clase',
    m.horas_clase as '.'
from 
	persona p 
inner join 
	relacion_dicta rd on p.cedula = rd.cedula
inner join 
	materia m on rd.codigo_materia = m.codigo_materia
where p.activo = true;
 
 

DELIMITER $$
CREATE PROCEDURE sp_join_personas()
BEGIN
		select 
		p.nombre as 'Profesor',
		p.apellido1 as '.',
		m.nombre_materia as 'Asignatura',
		m.dias_clase as 'Horario de clase',
		m.horas_clase as '.'
	from 
		persona p 
	inner join 
		relacion_dicta rd on p.cedula = rd.cedula
	inner join 
		materia m on rd.codigo_materia = m.codigo_materia
	where p.activo = true;
END$$
DELIMITER ;
call sp_join_personas();

 
    
/*JOIN ESTUDIANTES ACTIVOS CON MATERIAS  */
select 
	p.nombre as 'Estudiante',
    p.apellido1 as ' ',
    m.nombre_materia as 'Asignatura',
    m.dias_clase as 'Horario de clase',
    m.horas_clase as ' '
from 
	persona p 
inner join 
	relacion_toma rt on p.cedula = rt.cedula
inner join 
	materia m on rt.codigo_materia = m.codigo_materia
where p.activo = true;




DELIMITER $$
CREATE PROCEDURE sp_join_estudiantes()
BEGIN
	select 
		p.nombre as 'Estudiante',
		p.apellido1 as ' ',
		m.nombre_materia as 'Asignatura',
		m.dias_clase as 'Horario de clase',
		m.horas_clase as ' '
	from 
		persona p 
	inner join 
		relacion_toma rt on p.cedula = rt.cedula
	inner join 
		materia m on rt.codigo_materia = m.codigo_materia
	where p.activo = true;
END$$
DELIMITER ;
call sp_join_estudiantes();






DELIMITER $$
CREATE PROCEDURE sp_join_materias_departamento()
BEGIN
	select 
		dep.nombre_departamento as 'Departamento',
		ca.nombre_carrera as 'Carrera',
		ma.nombre_materia as 'Asignatura'
	from 
		departamento dep 
	inner join 
		carrera ca on dep.nombre_departamento = ca.nombre_departamento
	inner join 
		relacion_contiene con on ca.codigo_carrera = con.codigo_carrera
	inner join 
		materia ma on con.codigo_materia = ma.codigo_materia;
END$$
DELIMITER ;
call sp_join_materias_departamento();





select 
	ma.nombre_materia as 'Nombre Materia',
	ma.numero_salon as 'Numero del Salon',
	blo.numero_bloque as 'Bloque',
    blo.uso as 'Uso del bloque'
from 
	materia ma
inner join 
	bloque blo on ma.numero_bloque = blo.numero_bloque

  

DELIMITER $$
CREATE PROCEDURE sp_join_materias_bloque()
BEGIN
	select 
		ma.nombre_materia as 'Nombre Materia',
		ma.numero_salon as 'Numero del Salon',
		blo.numero_bloque as 'Bloque',
		blo.uso as 'Uso del bloque'
	from 
		materia ma
	inner join 
		bloque blo on ma.numero_bloque = blo.numero_bloque;
END$$
DELIMITER ;
call sp_join_materias_bloque();




    
