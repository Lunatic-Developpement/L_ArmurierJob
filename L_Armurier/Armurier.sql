INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_armurie','armurie',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_armurie','armurie',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_armurie', 'armurie', 1)
;

INSERT INTO `jobs` (`name`, `label`) VALUES
('armurie', 'armurie');


INSERT INTO `job_grades` (id, job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('1', 'armurie',0,'recrue','Recrue Armurie',12,'{}','{}'),
	('2', 'armurie',3,'chef',"Chef Armurie",48,'{}','{}'),
	('5', 'armurie',4,'boss','Patron Armurie',0,'{}','{}')
;