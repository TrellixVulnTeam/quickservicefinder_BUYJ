USE quickservicefinder;
DELIMITER $$
CREATE PROCEDURE ownerService_GetOwnerService (IN idownerservice INT)
BEGIN
	SELECT os.idownerservice, os.names, os.surnames, os.sex, os.phonenumber1, os.phonenumber2,
	uos.username, uos.email
	FROM ownerservice AS os
	INNER JOIN user_ownerservice as uos
	ON uos.idownerservice = os.idownerservice
	WHERE os.idownerservice = idownerservice;
END$$

DELIMITER $$
CREATE PROCEDURE ownerService_InsertOwnerService(
username VARCHAR(20),
password TEXT,
email VARCHAR(45),
names VARCHAR(45),
surnames VARCHAR(45),
sex VARCHAR(20),
phonenumber1 VARCHAR(10),
phonenumber2 VARCHAR(10))
BEGIN
DECLARE id_owner_service INT;
INSERT INTO ownerservice (names, surnames, sex, phonenumber1, phonenumber2)
VALUES (names, surnames, sex, phonenumber1, phonenumber2);
SET id_owner_service = LAST_INSERT_ID();
INSERT INTO user_ownerservice (idownerservice, username, password, email)
VALUES (id_owner_service, username, password, email);
END$$

DELIMITER $$
CREATE PROCEDURE customer_GetCustomer (IN idcustomer INT)
BEGIN
	SELECT c.idcustomer, c.names, c.surnames, c.sex, c.phonenumber1, c.phonenumber2,
	uc.username, uc.email
	FROM customer AS c
	INNER JOIN user_customer AS uc
	ON c.idcustomer = uc.idcustomer
	WHERE c.idcustomer = idcustomer;
END$$

DELIMITER $$
CREATE PROCEDURE customer_InsertCustomer(
username VARCHAR(20),
password TEXT,
email VARCHAR(45),
names VARCHAR(45),
surnames VARCHAR(45),
sex VARCHAR(10),
phonenumber1 VARCHAR(15),
phonenumber2 VARCHAR(15))
BEGIN
DECLARE id_customer INT;
INSERT INTO customer (names, surnames, sex, phonenumber1, phonenumber2)
VALUES (names, surnames, sex, phonenumber1, phonenumber2);
SET id_customer = LAST_INSERT_ID();
INSERT INTO user_customer (idcustomer, username, password, email)
VALUES (id_customer, username, password, email);
END$$

DELIMITER $$
CREATE PROCEDURE service_GetService (IN idservice INT)
BEGIN
	SELECT s.idservice, s.name, s.address, s.description, sns.idsocialnetworkservice AS idsns, 
    sns.name AS socialnetworkname, sns.link AS socialnetworklink, ss.idsubsector AS subsector, 
    ss.names AS subsectorname, ss.idsector, sec.name AS sectorname, s.idowner AS idowner, 
    os.names AS ownerservicename, os.surnames AS ownersurnames
FROM service AS s
	INNER JOIN ownerservice as os
		ON os.idownerservice = s.idowner
	INNER JOIN socialnetworkservice as sns
		ON sns.idservice = s.idservice
	INNER JOIN subsector as ss
		ON ss.idsubsector = s.idsubsector
	INNER JOIN sector as sec
		ON sec.idsector = ss.idsector
	WHERE s.idservice = idservice;
END$$

DELIMITER $$
CREATE PROCEDURE service_InsertService(
idownerservice INT,
idsubsector INT,
name VARCHAR(45),
address VARCHAR(100),
description VARCHAR(100))
BEGIN
INSERT INTO service (idownerservice, idsubsector, name, address, description)
VALUES (idownerservice, idsubsector, name, address, description);
END$$

DELIMITER $$
CREATE PROCEDURE notification_InsertNotification(
idservice INT,
iduser_customer INT,
Message VARCHAR(150),
isAccepted INT,
Date DATE, 
ResponseMessage VARCHAR(150))
BEGIN
INSERT INTO valoration (idservice, iduser_customer, Message, isAccepted, Date, ResponseMessage)
VALUES (idservice, iduser_customer, Message, isAccepted, Date, ResponseMessage);
END$$

DELIMITER $$
CREATE PROCEDURE socialnetworkservice_InsertSNS(
idservice INT,
name VARCHAR(45),
link VARCHAR(45))
BEGIN
INSERT INTO socialnetworkservice (idservice, name, link)
VALUES (idservice, name, link);
END$$

DELIMITER $$
CREATE PROCEDURE valoration_InsertValoration(
idservice INT,
iduser_customer INT,
comment NVARCHAR(100),
rate INT)
BEGIN
INSERT INTO valoration (idservice, iduser_customer, comment, rate)
VALUES (idservice, iduser_customer, comment, rate);
END$$

DELIMITER $$
CREATE PROCEDURE customer_validateCustomer (IN username VARCHAR(20))
BEGIN
	SELECT *
	FROM user_customer AS uc
	WHERE uc.username = username;
END$$

DELIMITER $$
CREATE PROCEDURE ownerservice_validateOwnerService (IN username VARCHAR(20))
BEGIN
	SELECT *
	FROM user_ownerservice AS uos
	WHERE uos.username = username;
END$$

DELIMITER $$
CREATE PROCEDURE subsector_GetSubsector ()
BEGIN
	SELECT * 
	FROM subsector AS ss;
END$$

