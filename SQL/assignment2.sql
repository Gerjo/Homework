use aaaa;



-- Dropping first for easy copy-paste. Not so suitable for production.

DROP TABLE IF EXISTS inventory, counterfeiting, replies, topics, users, cities;

DROP TRIGGER IF EXISTS onNewUser;
DROP TRIGGER IF EXISTS onNewReplyPosted;


CREATE TABLE cities (

	cityname 			varchar(20)			NOT null,

	gunstore_owner		varchar(20)			NOT null default "",

	airport_owner		varchar(20)			NOT null default "",

	roulette_owner		varchar(20)			NOT null default "",

	blackjack_owner		varchar(20)			NOT null default "",

	travel_prices		varchar(20)			NOT null default "",

	videopoker_owner	varchar(20)			NOT null default "",



	PRIMARY KEY (cityname)

	

) ENGINE = INNODB;


CREATE TABLE users (

	displayname 	varchar(20) 		NOT null,

	-- Money column intentionally left signed.

	money			int 				NOT null default '0',

	age				timestamp 			NOT null default '00-00-00 00:00:00',

	xp				int unsigned 		NOT null default '0',

	date_killed		timestamp 			NOT null default '00-00-00 00:00:00',

	email			varchar(80) 		NOT null,

	alive			enum('0', '1') 		NOT null default '1',

	health			tinyint unsigned 	NOT null default '100',

  	cityname		varchar(20)			NOT null,
  	

	PRIMARY KEY (displayname),




	CONSTRAINT city_info FOREIGN KEY (cityname) 

	REFERENCES cities (cityname)
	

) ENGINE = INNODB;



CREATE TABLE inventory (

	displayname varchar(20) 			NOT null,



	pistols smallint 					NOT null default '0',

	balaclavas smallint 				NOT null default '0',

	vaultburners smallint 				NOT null default '0',



	PRIMARY KEY (displayname),

	CONSTRAINT inventory_taxonomy FOREIGN KEY (displayname) 

	REFERENCES users (displayname) ON DELETE CASCADE ON UPDATE CASCADE

	

) ENGINE = INNODB;







CREATE TABLE counterfeiting (

	cityname 		varchar(20)					NOT null,

	displayname 	varchar(20)					NOT null,

	size 			enum('small','medium','large') NOT null default 'small',

	last_raid 		timestamp					NOT null default '00-00-00 00:00:00',

	date_purchased 	timestamp					NOT null default CURRENT_TIMESTAMP,

	

	PRIMARY KEY (displayname, cityname),

	

	CONSTRAINT counterfeiting_taxonomy FOREIGN KEY (displayname) 

	REFERENCES users (displayname) ON DELETE CASCADE ON UPDATE CASCADE

) ENGINE = INNODB;



-- When creating a new user, an inventory row is automatically added.

DELIMITER $>.<$

CREATE TRIGGER onNewUser

	AFTER INSERT ON users

	FOR EACH ROW

	BEGIN

		INSERT INTO inventory (displayname) VALUES (new.displayname);

	END

$>.<$

DELIMITER ;


CREATE TABLE topics (
	topicid			int AUTO_INCREMENT PRIMARY KEY	NOT null, 				
	displayname		varchar(20)						NOT null,
	title 			varchar(60)						NOT null,
	date 			timestamp						NOT null default CURRENT_TIMESTAMP,
	lastpost 		timestamp						NOT null default '00-00-00 00:00:00',
	content			text							NOT null,
	type 			enum('normal','sticky')			NOT null default 'normal',

	KEY(displayname),

	CONSTRAINT author_topic_taxonomy FOREIGN KEY (displayname) 

	REFERENCES users (displayname) ON DELETE CASCADE ON UPDATE CASCADE
	
) ENGINE = INNODB;

CREATE TABLE replies (
	topicid			int 							NOT null, 			
	displayname		varchar(20)						NOT null,
	date			timestamp						NOT null default CURRENT_TIMESTAMP,
	content			text							NOT null,

	KEY(displayname),
	KEY(topicid),

	CONSTRAINT topicowner_taxonomy FOREIGN KEY (topicid) 

	REFERENCES topics (topicid) ON DELETE CASCADE,

	CONSTRAINT author_reply_taxonomy FOREIGN KEY (displayname) 

	REFERENCES users (displayname) ON DELETE CASCADE ON UPDATE CASCADE
	
) ENGINE = INNODB;






-- Populate the database:

INSERT INTO cities (cityname) VALUES ('Las Vegas'), ('Amsterdam'), ('London'), ('Manchester'), ('Moscow'), ('Kaliningrad'), ('St. Petersburg');

INSERT INTO users (displayname, email, cityname) VALUES 

('Gerjo', 		'gerjo@gmail.com',		'Moscow'), 

('Nico', 		'nico@gmail.com',		'Kaliningrad'), 

('Craig', 		'craig@gmail.com',		'Amsterdam'), 

('Burger', 		'mcdonalds@gmail.com',	'Manchester'), 
('Sandra', 		'sandra@gmail.com',		'Manchester'), 

('Neil', 		'kfc@gmail.com','Moscow'), 

('Maaike', 		'maaike@gmail.com',		'Kaliningrad'), 
('Remove',		'example@example.org',	'Manchester'),

('Vladimir',	'sexiboi@gmail.com',	'St. Petersburg');



-- Bunch of dead users.

INSERT INTO users (displayname, email, cityname, alive) VALUES 

('Logan',		'craig@gmail.com', 'Moscow', '0'), 

('Zorro',		'craig@gmail.com', 'Amsterdam', '0'), 

('DeathStalker','craig@gmail.com', 'Kaliningrad', '0');





-- Add a couple random owners:

UPDATE cities SET 

	blackjack_owner 	= (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1),

	gunstore_owner 		= (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1),

	airport_owner		= (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1),

	roulette_owner		= (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1),

	videopoker_owner	= (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1);



INSERT INTO topics (displayname, title, content) VALUES 
	((SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), SUBSTRING(MD5(RAND()), 1, 10), MD5(RAND())),
	((SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), SUBSTRING(MD5(RAND()), 1, 10), MD5(RAND())),
	((SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), SUBSTRING(MD5(RAND()), 1, 10), MD5(RAND())),
	((SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), SUBSTRING(MD5(RAND()), 1, 10), MD5(RAND())),
	((SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), SUBSTRING(MD5(RAND()), 1, 10), MD5(RAND())),
	((SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), SUBSTRING(MD5(RAND()), 1, 10), MD5(RAND())),
	((SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), SUBSTRING(MD5(RAND()), 1, 10), MD5(RAND())),
	((SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), SUBSTRING(MD5(RAND()), 1, 10), MD5(RAND())),
	((SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), SUBSTRING(MD5(RAND()), 1, 10), MD5(RAND())),
	((SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), SUBSTRING(MD5(RAND()), 1, 10), MD5(RAND()));

INSERT INTO replies (topicid, displayname, content) VALUES 
	((SELECT topicid FROM topics ORDER BY RAND() LIMIT 1), (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), MD5(RAND())),
	((SELECT topicid FROM topics ORDER BY RAND() LIMIT 1), (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), MD5(RAND())),
	((SELECT topicid FROM topics ORDER BY RAND() LIMIT 1), (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), MD5(RAND())),
	((SELECT topicid FROM topics ORDER BY RAND() LIMIT 1), (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), MD5(RAND())),
	((SELECT topicid FROM topics ORDER BY RAND() LIMIT 1), (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), MD5(RAND())),
	((SELECT topicid FROM topics ORDER BY RAND() LIMIT 1), (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), MD5(RAND())),
	((SELECT topicid FROM topics ORDER BY RAND() LIMIT 1), (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), MD5(RAND())),
	((SELECT topicid FROM topics ORDER BY RAND() LIMIT 1), (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), MD5(RAND())),
	((SELECT topicid FROM topics ORDER BY RAND() LIMIT 1), (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), MD5(RAND())),
	((SELECT topicid FROM topics ORDER BY RAND() LIMIT 1), (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), MD5(RAND())),
	((SELECT topicid FROM topics ORDER BY RAND() LIMIT 1), (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), MD5(RAND())),
	((SELECT topicid FROM topics ORDER BY RAND() LIMIT 1), (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), MD5(RAND())),
	((SELECT topicid FROM topics ORDER BY RAND() LIMIT 1), (SELECT displayname FROM users WHERE alive = '1' ORDER BY RAND() LIMIT 1), MD5(RAND()));


INSERT INTO counterfeiting (displayname, cityname) VALUES 
	('Gerjo', 'Las Vegas'),
	('DeathStalker', 'Kaliningrad'),
	('Gerjo', 'Moscow'),
	('Vladimir', 'Las Vegas'),
	('Vladimir', 'Amsterdam'),
	('Gerjo', 'Kaliningrad'),
	('DeathStalker', 'Manchester'),
	('Logan', 'Manchester'),
	('Gerjo', 'Amsterdam');


-- When creating a reply, the lastpost date in the topic is updated.

DELIMITER $>.<$

CREATE TRIGGER onNewReplyPosted

	AFTER INSERT ON replies

	FOR EACH ROW

	BEGIN
		UPDATE topics SET lastpost = NOW() WHERE topicid = new.topicid;

	END

$>.<$

DELIMITER ;



-- Insert at least two test rows:
INSERT INTO topics (displayname) VALUES ('Remove');
INSERT INTO replies (topicid, displayname) VALUES (1, 'Remove');

-- Delete the user, the delete call should propegate to the topics / replies:
DELETE FROM users WHERE displayname = 'Remove' LIMIT 1;

-- Test: verify that there are no results left:
SELECT displayname FROM topics WHERE displayname = 'Remove' 
UNION ALL SELECT displayname FROM topics WHERE displayname = 'Remove';


-- A 3 table join:
SELECT users.displayname, cities.blackjack_owner, inventory.balaclavas FROM users 
    LEFT JOIN cities USING (cityname)
    LEFT JOIN inventory USING (displayname);

-- A join using subqueries:
SELECT users.displayname, 
(SELECT blackjack_owner FROM cities WHERE cities.cityname = users.cityname) AS blackjack_owner, 
(SELECT balaclavas FROM inventory WHERE inventory.displayname = users.displayname) AS balaclavas FROM users;

-- A 3 table simple join:
SELECT users.displayname, inventory.balaclavas, cities.blackjack_owner FROM users, cities, inventory WHERE users.displayname = inventory.displayname AND cities.cityname = users.cityname;
-- Result: least amount of rows scanned before a result was formed.

-- A product between two tables: (lists all cities that a user can visit) (cartesian join):
SELECT displayname, cities.cityname FROM users CROSS JOIN cities ORDER BY displayname ASC;

-- A projection, only select the cityname of users who have a forum topic:
SELECT displayname, cityname, topicid FROM users RIGHT JOIN topics USING (displayname);

-- or as a left join, kinda cool how this shows that left and right join *could* do the same.
SELECT displayname, cityname, topicid FROM topics LEFT JOIN users USING (displayname);

-- Update query, shows the foreign key power, this updates all relationships, too! amazing!
UPDATE users SET displayname = 'Gerard' WHERE displayname = 'Gerjo';
