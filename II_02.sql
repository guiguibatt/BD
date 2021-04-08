DROP TABLE Passer;
DROP TABLE UV;
DROP TABLE Etudiants;
DROP TABLE Classes;
DROP TABLE Profs;


CREATE TABLE Profs(
	codeProf CHAR(2),
	nomProf VARCHAR(30),
	prenomProf VARCHAR(30),
	sexeProf CHAR(1),
	typeProf CHAR(9),
	dateProf date,
	CONSTRAINT pk_Profs PRIMARY KEY (codeProf),
	CONSTRAINT ck_type_Prof CHECK (typeProf='Titulaire' OR typeProf='Vacataire'),
	CONSTRAINT ck_sexe_Prof CHECK (sexeProf='M' OR sexeProf='F'),
	CONSTRAINT nn_type_Prof CHECK (typeProf IS NOT NULL),
	CONSTRAINT nn_sexe_Prof CHECK (sexeProf IS NOT NULL),
	CONSTRAINT nn_nom_Prof CHECK (nomProf IS NOT NULL)
);

CREATE TABLE Classes(
	nomClasse CHAR(2),
	codeProfPrincipal CHAR(2),
	CONSTRAINT pk_Classes PRIMARY KEY (nomClasse),
	CONSTRAINT fk_codeProf_Classes FOREIGN KEY (codeProfPrincipal) REFERENCES Profs(codeProf),
	CONSTRAINT nn_code_Prof_Principal CHECK (codeProfPrincipal IS NOT NULL),
	CONSTRAINT un_code_Prof_Principal UNIQUE (codeProfPrincipal)
);

CREATE TABLE Etudiants(
	numEtudiant CHAR(2),
	nomEtudiant VARCHAR(30),
	prenomEtudiant VARCHAR(30),
	classeEtudiant CHAR(2),
	numEtudiantParrain CHAR(2),
	CONSTRAINT pk_Etudiants PRIMARY KEY (numEtudiant),
	CONSTRAINT nn_nom_Etudiant CHECK (nomEtudiant IS NOT NULL),
	CONSTRAINT nn_classe_Etudiant CHECK (classeEtudiant IS NOT NULL),
	CONSTRAINT fk_classeEtudiant_Etudiant FOREIGN KEY (classeEtudiant) REFERENCES Classes(nomClasse),
	CONSTRAINT fk_codeEtudiant_Etudiant FOREIGN KEY (numEtudiantParrain) REFERENCES Etudiants(numEtudiant)
);

CREATE TABLE UV(
	codeUV CHAR(2),
	nomUV VARCHAR(30),
	nomComposante VARCHAR(30),
	codeProfResponsable CHAR(2),
	CONSTRAINT pk_UV PRIMARY KEY (codeUV),
	CONSTRAINT nn_nom_Composante CHECK (nomComposante IS NOT NULL),
	CONSTRAINT nn_code_Prof_Responsable CHECK (codeProfResponsable IS NOT NULL),
	CONSTRAINT fk_codeProf_UV FOREIGN KEY (codeProfResponsable) REFERENCES Profs(codeProf)
);

CREATE TABLE Passer(
	numEtudiant CHAR(2),
	codeUV CHAR(2),
	note NUMBER(2,0),
	CONSTRAINT pk_Passer PRIMARY KEY (numEtudiant,codeUV),
	CONSTRAINT fk_numEtudiant_Passer FOREIGN KEY (numEtudiant) REFERENCES Etudiants(numEtudiant),
	CONSTRAINT fk_codeUV_Passer FOREIGN KEY (codeUV) REFERENCES UV(codeUV),
	CONSTRAINT ck_note CHECK (note>=0 AND note<=20)
);

-----------------------------------------------insertion valeur-----------------------------------------------

INSERT INTO Profs (codeProf, nomProf, prenomProf, sexeProf, typeProf, dateProf) VALUES('P1','Palleja','Xavier','M','Titulaire','11/04/1966');
INSERT INTO Profs (codeProf, nomProf, prenomProf, sexeProf, typeProf, dateProf) VALUES('P2','Palleja','Nathalie','F','Vacataire','17/11/1982');
INSERT INTO Profs (codeProf, nomProf, prenomProf, sexeProf, typeProf, dateProf) VALUES('P3','Mugnier','Marie-Laure','F','Titulaire','02/09/1970');
INSERT INTO Profs (codeProf, nomProf, prenomProf, sexeProf, typeProf, dateProf) VALUES('P4','Garcia','Francis','M','Titulaire','26/06/1969');
INSERT INTO Profs (codeProf, nomProf, prenomProf, sexeProf, typeProf, dateProf) VALUES('P5','Bellahsene','Zorah','F','Titulaire','01/01/1967');
INSERT INTO Profs (codeProf, nomProf, prenomProf, sexeProf, typeProf, dateProf) VALUES('P6','Palaysi','Jérôme','M','Vacataire','08/04/1992');

INSERT INTO Classes (nomClasse, codeProfPrincipal) VALUES('S1','P3');
INSERT INTO Classes (nomClasse, codeProfPrincipal) VALUES('S2','P5');

INSERT INTO Etudiants (numEtudiant, nomEtudiant, prenomEtudiant, classeEtudiant) VALUES('E1','Terieur','Alain','S1');
INSERT INTO Etudiants (numEtudiant, nomEtudiant, prenomEtudiant, classeEtudiant, numEtudiantParrain) VALUES('E2','Bricot','Judas','S2','E1');
INSERT INTO Etudiants (numEtudiant, nomEtudiant, prenomEtudiant, classeEtudiant, numEtudiantParrain) VALUES('E3','Némard','Jean','S1','E2');
INSERT INTO Etudiants (numEtudiant, nomEtudiant, prenomEtudiant, classeEtudiant, numEtudiantParrain) VALUES('E4','Zeblouse','Agathe','S1','E1');
INSERT INTO Etudiants (numEtudiant, nomEtudiant, prenomEtudiant, classeEtudiant, numEtudiantParrain) VALUES('E5','Terieur','Alex','S2','E3');

INSERT INTO UV (codeUV, nomUV, nomComposante, codeProfResponsable) VALUES('01','PROG','Informatique','P1');
INSERT INTO UV (codeUV, nomUV, nomComposante, codeProfResponsable) VALUES('02','IHM','Communication','P3');
INSERT INTO UV (codeUV, nomUV, nomComposante, codeProfResponsable) VALUES('03','DB','Informatique','P4');

INSERT INTO Passer (numEtudiant, codeUV, note) VALUES('E1','01','14');
INSERT INTO Passer (numEtudiant, codeUV, note) VALUES('E1','02','19');
INSERT INTO Passer (numEtudiant, codeUV, note) VALUES('E1','03','9');
INSERT INTO Passer (numEtudiant, codeUV, note) VALUES('E3','02','10');
INSERT INTO Passer (numEtudiant, codeUV, note) VALUES('E3','03','16');
INSERT INTO Passer (numEtudiant, codeUV) VALUES('E4','01');
INSERT INTO Passer (numEtudiant, codeUV, note) VALUES('E4','03','14');
INSERT INTO Passer (numEtudiant, codeUV, note) VALUES('E5','02','9');

-------------------------------------------modif pour date etudiant-------------------------------------------

ALTER TABLE Etudiants ADD (dateEtudiant date);

---------------------------------------------ajoute date etudiant---------------------------------------------

UPDATE Etudiants SET dateEtudiant='17/11/1992' WHERE numEtudiant='E1';
UPDATE Etudiants SET dateEtudiant='18/10/1993' WHERE numEtudiant='E2';
UPDATE Etudiants SET dateEtudiant='02/09/1992' WHERE numEtudiant='E3';
UPDATE Etudiants SET dateEtudiant='25/12/1992' WHERE numEtudiant='E4';
UPDATE Etudiants SET dateEtudiant='25/12/1989' WHERE numEtudiant='E5';

--------------------------------------------------ajoue note--------------------------------------------------

UPDATE Passer SET note='8'WHERE numEtudiant='E4' AND codeUV='01';

------------------------------------------------Création index------------------------------------------------

CREATE INDEX idx_nomEtudiant_Etudiants ON Etudiants(nomEtudiant);
CREATE INDEX idx_nomProfs_Profs ON Profs(nomProf);
CREATE INDEX idx_nomUV_UV ON UV(nomUV);

CREATE INDEX idx_sexeProf_Profs ON Profs(sexeProf);
CREATE INDEX idx_typeProf_Profs ON Profs(typeProf);

----------------------------------------------------requete---------------------------------------------------

--R01

SELECT e.nomEtudiant, e.prenomEtudiant
FROM Etudiants e
WHERE e.dateEtudiant>='01/01/1992'AND e.dateEtudiant<='31/12/1992'
ORDER BY (e.nomEtudiant) ASC;

--R02

SELECT p.nomProf, p.prenomProf
FROM Profs p
JOIN Classes c ON c.codeProfPrincipal  = p.codeProf 
JOIN Etudiants e ON e.classeEtudiant = c.nomClasse
WHERE e.prenomEtudiant = 'Alex'
AND e.nomEtudiant = 'Terieur';

--R03

SELECT e.nomEtudiant, e.prenomEtudiant
FROM Etudiants e
WHERE e.numEtudiant IN (
	SELECT e1.numEtudiantParrain
	FROM Etudiants e1
	WHERE e1.nomEtudiant='Terieur' AND e1.prenomEtudiant='Alex');

--R04

SELECT COUNT(*)
FROM Etudiants
WHERE classeEtudiant='S1';

--R05

SELECT e.nomEtudiant, e.prenomEtudiant
FROM Etudiants e
WHERE e.numEtudiant NOT IN (
	SELECT p.numEtudiant
	FROM Passer p);

--R06

SELECT p.codeUV
FROM Passer p
JOIN Etudiants e ON e.numEtudiant=p.numEtudiant
WHERE e.nomEtudiant='Zeblouse' AND e.prenomEtudiant='Agathe'
INTERSECT
SELECT p.codeUV
FROM Passer p
JOIN Etudiants e ON e.numEtudiant=p.numEtudiant
WHERE e.nomEtudiant='Némard' AND e.prenomEtudiant='Jean'