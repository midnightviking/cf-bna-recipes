DROP TABLE IF EXISTS "alternate_ingredients";
CREATE TABLE "alternate_ingredients" (
	"id"	INTEGER,
	"recipe_id"	INTEGER NOT NULL,
	"original_ingredient"	INTEGER,
	"alternate_ingredient"	INTEGER NOT NULL,
	"quantity"	NUMERIC NOT NULL,
	"unit_id"	INTEGER NOT NULL,
	"extensions"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "cookbook_recipes";
CREATE TABLE "cookbook_recipes" (
	"id"	integer NOT NULL,
	"cookbook_id"	integer NOT NULL,
	"recipe_id"	integer NOT NULL,
	"ordering"	integer,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "cookbooks";
CREATE TABLE "cookbooks" (
	"id"	integer NOT NULL,
	"name"	text NOT NULL,
	"description"	text,
	"created"	integer,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "extensions";
CREATE TABLE "extensions" (
	"id"	integer NOT NULL,
	"name"	text NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "ingredients";
CREATE TABLE "ingredients" (
	"id"	integer NOT NULL,
	"name"	text NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "recipe_extensions";
CREATE TABLE "recipe_extensions" (
	"id"	integer NOT NULL,
	"recipe_id"	integer NOT NULL,
	"extension_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "recipe_ingredients";
CREATE TABLE "recipe_ingredients" (
	"id"	integer NOT NULL,
	"recipe_id"	integer NOT NULL,
	"ingredient_id"	integer NOT NULL,
	"quantity"	NUMERIC NOT NULL,
	"unit"	integer NOT NULL,
	"ordering"	integer,
	"section_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "recipe_sections";
CREATE TABLE "recipe_sections" (
	"id"	integer,
	"recipe_id"	integer NOT NULL,
	"name"	text NOT NULL,
	"ordering"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "recipes";
CREATE TABLE "recipes" (
	"id"	integer NOT NULL,
	"title"	text NOT NULL,
	"minTemp"	text,
	"itemType"	text,
	"portionSize"	text,
	"calories"	text,
	"category"	text,
	"instructions"	text,
	"ccp"	text,
	"substitutions"	text,
	"initialServings"	integer,
	"protein"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "units";
CREATE TABLE "units" (
	"id"	integer NOT NULL,
	"name"	text NOT NULL,
	"conversion_unit"	text,
	"conversion_threshold"	real,
	"conversion_formula"	real,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "cookbook_recipes" VALUES (262,3,76,0);
INSERT INTO "cookbook_recipes" VALUES (263,3,78,1);
INSERT INTO "cookbook_recipes" VALUES (264,3,79,2);
INSERT INTO "cookbook_recipes" VALUES (265,3,80,3);
INSERT INTO "cookbook_recipes" VALUES (266,3,84,4);
INSERT INTO "cookbook_recipes" VALUES (267,3,81,5);
INSERT INTO "cookbook_recipes" VALUES (268,3,82,6);
INSERT INTO "cookbook_recipes" VALUES (292,5,111,0);
INSERT INTO "cookbook_recipes" VALUES (293,5,112,1);
INSERT INTO "cookbook_recipes" VALUES (294,5,110,2);
INSERT INTO "cookbook_recipes" VALUES (295,4,85,0);
INSERT INTO "cookbook_recipes" VALUES (296,4,105,1);
INSERT INTO "cookbook_recipes" VALUES (297,4,106,2);
INSERT INTO "cookbook_recipes" VALUES (298,4,90,3);
INSERT INTO "cookbook_recipes" VALUES (299,4,96,4);
INSERT INTO "cookbook_recipes" VALUES (300,4,93,5);
INSERT INTO "cookbook_recipes" VALUES (301,4,107,6);
INSERT INTO "cookbook_recipes" VALUES (302,4,109,7);
INSERT INTO "cookbook_recipes" VALUES (303,4,98,8);
INSERT INTO "cookbook_recipes" VALUES (304,4,94,9);
INSERT INTO "cookbook_recipes" VALUES (305,4,108,10);
INSERT INTO "cookbook_recipes" VALUES (306,4,89,11);
INSERT INTO "cookbook_recipes" VALUES (307,4,95,12);
INSERT INTO "cookbook_recipes" VALUES (308,4,97,13);
INSERT INTO "cookbook_recipes" VALUES (309,4,86,14);
INSERT INTO "cookbook_recipes" VALUES (310,4,87,15);
INSERT INTO "cookbook_recipes" VALUES (311,4,88,16);
INSERT INTO "cookbook_recipes" VALUES (312,4,101,17);
INSERT INTO "cookbook_recipes" VALUES (313,4,91,18);
INSERT INTO "cookbook_recipes" VALUES (314,4,92,19);
INSERT INTO "cookbook_recipes" VALUES (315,4,99,20);
INSERT INTO "cookbook_recipes" VALUES (316,4,103,21);
INSERT INTO "cookbook_recipes" VALUES (317,4,104,22);
INSERT INTO "cookbook_recipes" VALUES (373,2,16,0);
INSERT INTO "cookbook_recipes" VALUES (374,2,18,1);
INSERT INTO "cookbook_recipes" VALUES (375,2,71,2);
INSERT INTO "cookbook_recipes" VALUES (376,2,19,3);
INSERT INTO "cookbook_recipes" VALUES (377,2,56,4);
INSERT INTO "cookbook_recipes" VALUES (378,2,57,5);
INSERT INTO "cookbook_recipes" VALUES (379,2,52,6);
INSERT INTO "cookbook_recipes" VALUES (380,2,54,7);
INSERT INTO "cookbook_recipes" VALUES (381,2,17,8);
INSERT INTO "cookbook_recipes" VALUES (382,2,45,9);
INSERT INTO "cookbook_recipes" VALUES (383,2,61,10);
INSERT INTO "cookbook_recipes" VALUES (384,2,20,11);
INSERT INTO "cookbook_recipes" VALUES (385,2,74,12);
INSERT INTO "cookbook_recipes" VALUES (386,2,21,13);
INSERT INTO "cookbook_recipes" VALUES (387,2,23,14);
INSERT INTO "cookbook_recipes" VALUES (388,2,25,15);
INSERT INTO "cookbook_recipes" VALUES (389,2,73,16);
INSERT INTO "cookbook_recipes" VALUES (390,2,55,17);
INSERT INTO "cookbook_recipes" VALUES (391,2,46,18);
INSERT INTO "cookbook_recipes" VALUES (392,2,65,19);
INSERT INTO "cookbook_recipes" VALUES (393,2,60,20);
INSERT INTO "cookbook_recipes" VALUES (394,2,63,21);
INSERT INTO "cookbook_recipes" VALUES (395,2,32,22);
INSERT INTO "cookbook_recipes" VALUES (396,2,51,23);
INSERT INTO "cookbook_recipes" VALUES (397,2,75,24);
INSERT INTO "cookbook_recipes" VALUES (398,2,53,25);
INSERT INTO "cookbook_recipes" VALUES (399,2,27,26);
INSERT INTO "cookbook_recipes" VALUES (400,2,39,27);
INSERT INTO "cookbook_recipes" VALUES (401,2,62,28);
INSERT INTO "cookbook_recipes" VALUES (402,2,28,29);
INSERT INTO "cookbook_recipes" VALUES (403,2,58,30);
INSERT INTO "cookbook_recipes" VALUES (404,2,29,31);
INSERT INTO "cookbook_recipes" VALUES (405,2,50,32);
INSERT INTO "cookbook_recipes" VALUES (406,2,59,33);
INSERT INTO "cookbook_recipes" VALUES (407,2,72,34);
INSERT INTO "cookbook_recipes" VALUES (408,2,37,35);
INSERT INTO "cookbook_recipes" VALUES (409,2,49,36);
INSERT INTO "cookbook_recipes" VALUES (410,2,31,37);
INSERT INTO "cookbook_recipes" VALUES (411,2,43,38);
INSERT INTO "cookbook_recipes" VALUES (412,2,33,39);
INSERT INTO "cookbook_recipes" VALUES (413,2,44,40);
INSERT INTO "cookbook_recipes" VALUES (414,2,69,41);
INSERT INTO "cookbook_recipes" VALUES (415,2,22,42);
INSERT INTO "cookbook_recipes" VALUES (416,2,48,43);
INSERT INTO "cookbook_recipes" VALUES (417,2,34,44);
INSERT INTO "cookbook_recipes" VALUES (418,2,68,45);
INSERT INTO "cookbook_recipes" VALUES (419,2,42,46);
INSERT INTO "cookbook_recipes" VALUES (420,2,41,47);
INSERT INTO "cookbook_recipes" VALUES (421,2,24,48);
INSERT INTO "cookbook_recipes" VALUES (422,2,64,49);
INSERT INTO "cookbook_recipes" VALUES (423,2,35,50);
INSERT INTO "cookbook_recipes" VALUES (424,2,36,51);
INSERT INTO "cookbook_recipes" VALUES (425,2,67,52);
INSERT INTO "cookbook_recipes" VALUES (426,2,38,53);
INSERT INTO "cookbook_recipes" VALUES (427,1,6,0);
INSERT INTO "cookbook_recipes" VALUES (428,1,113,1);
INSERT INTO "cookbook_recipes" VALUES (429,1,7,2);
INSERT INTO "cookbook_recipes" VALUES (430,1,5,3);
INSERT INTO "cookbook_recipes" VALUES (431,1,15,4);
INSERT INTO "cookbook_recipes" VALUES (432,1,1,5);
INSERT INTO "cookbook_recipes" VALUES (433,1,3,6);
INSERT INTO "cookbook_recipes" VALUES (434,1,4,7);
INSERT INTO "cookbook_recipes" VALUES (435,1,2,8);
INSERT INTO "cookbooks" VALUES (1,'Breakfast','',1750410466888);
INSERT INTO "cookbooks" VALUES (2,'Entrees','',1750410749607);
INSERT INTO "cookbooks" VALUES (3,'Veggies','',1750410833713);
INSERT INTO "cookbooks" VALUES (4,'Starches','',1750410890944);
INSERT INTO "cookbooks" VALUES (5,'Dessert','',1750410904366);
INSERT INTO "extensions" VALUES (1,'vegetarian');
INSERT INTO "extensions" VALUES (2,'soft');
INSERT INTO "ingredients" VALUES (2,'BBQ Sauce');
INSERT INTO "ingredients" VALUES (3,'Beans');
INSERT INTO "ingredients" VALUES (4,'Beef Steak Bites');
INSERT INTO "ingredients" VALUES (5,'Bell Pepper (Diced)');
INSERT INTO "ingredients" VALUES (6,'Biscuit Mix');
INSERT INTO "ingredients" VALUES (7,'Black Pepper');
INSERT INTO "ingredients" VALUES (8,'Blackened Seasoning');
INSERT INTO "ingredients" VALUES (9,'Bread/Roll Mix');
INSERT INTO "ingredients" VALUES (10,'Broccoli');
INSERT INTO "ingredients" VALUES (11,'Brown Gravy Mix');
INSERT INTO "ingredients" VALUES (12,'Cabbage');
INSERT INTO "ingredients" VALUES (13,'Carrots');
INSERT INTO "ingredients" VALUES (14,'Carrots (Diced)');
INSERT INTO "ingredients" VALUES (15,'Celery (Diced)');
INSERT INTO "ingredients" VALUES (16,'Cereal');
INSERT INTO "ingredients" VALUES (17,'Charbroil Patty');
INSERT INTO "ingredients" VALUES (18,'Cheese Sauce');
INSERT INTO "ingredients" VALUES (19,'Cheese Sauce Mix');
INSERT INTO "ingredients" VALUES (20,'Chicken Strip/Chunks');
INSERT INTO "ingredients" VALUES (21,'Chili Powder');
INSERT INTO "ingredients" VALUES (22,'Chocolate Pudding');
INSERT INTO "ingredients" VALUES (23,'Chuckwagon Patty');
INSERT INTO "ingredients" VALUES (24,'Cinnamon');
INSERT INTO "ingredients" VALUES (25,'Corn');
INSERT INTO "ingredients" VALUES (26,'Cornbread Cubed');
INSERT INTO "ingredients" VALUES (27,'Cornbread Mix');
INSERT INTO "ingredients" VALUES (28,'Diced Chicken');
INSERT INTO "ingredients" VALUES (29,'Dinner Loaf');
INSERT INTO "ingredients" VALUES (30,'Ends/Pieces');
INSERT INTO "ingredients" VALUES (31,'Flour');
INSERT INTO "ingredients" VALUES (32,'Garlic');
INSERT INTO "ingredients" VALUES (33,'Garlic Powder');
INSERT INTO "ingredients" VALUES (34,'Granulated Garlic');
INSERT INTO "ingredients" VALUES (35,'Gravy Mix');
INSERT INTO "ingredients" VALUES (36,'Green Beans');
INSERT INTO "ingredients" VALUES (37,'Green Pepper');
INSERT INTO "ingredients" VALUES (38,'Grits');
INSERT INTO "ingredients" VALUES (39,'Hot Dog');
INSERT INTO "ingredients" VALUES (40,'Italian Dressing');
INSERT INTO "ingredients" VALUES (41,'Italian Seasoning');
INSERT INTO "ingredients" VALUES (42,'Ground Turkey (MST)');
INSERT INTO "ingredients" VALUES (43,'Ketchup');
INSERT INTO "ingredients" VALUES (44,'Lettuce (Shredded)');
INSERT INTO "ingredients" VALUES (45,'Liquid Eggs');
INSERT INTO "ingredients" VALUES (46,'MST');
INSERT INTO "ingredients" VALUES (47,'Macaroni (Cooked & Drained)');
INSERT INTO "ingredients" VALUES (48,'Macaroni (Cooked, Drained & Cooled)');
INSERT INTO "ingredients" VALUES (49,'Margarine');
INSERT INTO "ingredients" VALUES (50,'Mayo/Salad Dressing');
INSERT INTO "ingredients" VALUES (51,'Meatballs');
INSERT INTO "ingredients" VALUES (52,'Meatloaf Patty');
INSERT INTO "ingredients" VALUES (53,'Mixed Vegetables');
INSERT INTO "ingredients" VALUES (54,'Muffin Mix');
INSERT INTO "ingredients" VALUES (55,'Noodles (Cooked/Drained/Cooled)');
INSERT INTO "ingredients" VALUES (56,'Oatmeal');
INSERT INTO "ingredients" VALUES (57,'Oats');
INSERT INTO "ingredients" VALUES (58,'Onion');
INSERT INTO "ingredients" VALUES (59,'Onion (Diced)');
INSERT INTO "ingredients" VALUES (60,'Onion Chopped');
INSERT INTO "ingredients" VALUES (61,'Pancake Mix');
INSERT INTO "ingredients" VALUES (62,'Peanut Butter');
INSERT INTO "ingredients" VALUES (63,'Peas');
INSERT INTO "ingredients" VALUES (64,'Pepper');
INSERT INTO "ingredients" VALUES (65,'Pepper Gravy Mix');
INSERT INTO "ingredients" VALUES (66,'Pinto Beans');
INSERT INTO "ingredients" VALUES (67,'Potato Flakes (Dehydrated)');
INSERT INTO "ingredients" VALUES (68,'Potato Shredded (Dehydrated)');
INSERT INTO "ingredients" VALUES (69,'Potato Slices (Dehydrated)');
INSERT INTO "ingredients" VALUES (70,'Potatoes (Diced)');
INSERT INTO "ingredients" VALUES (71,'Potatoes (Diced, Cooked & Drained)');
INSERT INTO "ingredients" VALUES (72,'Poultry Gravy Mix');
INSERT INTO "ingredients" VALUES (73,'Poultry Seasoning');
INSERT INTO "ingredients" VALUES (74,'Powdered Sugar');
INSERT INTO "ingredients" VALUES (75,'Preseasoned Taco Meat');
INSERT INTO "ingredients" VALUES (76,'Rice');
INSERT INTO "ingredients" VALUES (77,'Salad Dressing');
INSERT INTO "ingredients" VALUES (78,'Salsa');
INSERT INTO "ingredients" VALUES (79,'Salt');
INSERT INTO "ingredients" VALUES (80,'Sausage Links');
INSERT INTO "ingredients" VALUES (81,'Shredded Potatoes (Dehydrated)');
INSERT INTO "ingredients" VALUES (82,'Soy Sauce');
INSERT INTO "ingredients" VALUES (83,'Spaghetti Noodles');
INSERT INTO "ingredients" VALUES (84,'Sugar Cookie Mix');
INSERT INTO "ingredients" VALUES (85,'Sweet + Sour Sauce');
INSERT INTO "ingredients" VALUES (86,'Syrup');
INSERT INTO "ingredients" VALUES (87,'Taco Seasoning');
INSERT INTO "ingredients" VALUES (88,'Tomato Paste');
INSERT INTO "ingredients" VALUES (89,'Tomato Sauce');
INSERT INTO "ingredients" VALUES (90,'Tomatoes Whole');
INSERT INTO "ingredients" VALUES (91,'Turkey Ends & Pieces');
INSERT INTO "ingredients" VALUES (92,'Turkey Ham, Diced');
INSERT INTO "ingredients" VALUES (93,'Vanilla');
INSERT INTO "ingredients" VALUES (94,'Vinegar');
INSERT INTO "ingredients" VALUES (95,'Water');
INSERT INTO "ingredients" VALUES (96,'Water (100 Degrees)');
INSERT INTO "ingredients" VALUES (97,'Water (Cold)');
INSERT INTO "ingredients" VALUES (98,'Water (Hot)');
INSERT INTO "ingredients" VALUES (99,'Water For Cheese Sauce');
INSERT INTO "ingredients" VALUES (100,'Water For Gravy Mix');
INSERT INTO "ingredients" VALUES (101,'White Cake Mix');
INSERT INTO "ingredients" VALUES (102,'White Sugar');
INSERT INTO "ingredients" VALUES (103,'White Vinegar');
INSERT INTO "ingredients" VALUES (104,'Whole Eggs');
INSERT INTO "ingredients" VALUES (105,'Worcestershire');
INSERT INTO "ingredients" VALUES (106,'Yellow Cake Mix');
INSERT INTO "ingredients" VALUES (107,'Yellow Mustard');
INSERT INTO "ingredients" VALUES (109,'Bean Cooking Liquid + Water');
INSERT INTO "ingredients" VALUES (110,'Cumin');
INSERT INTO "ingredients" VALUES (111,'Potatoes');
INSERT INTO "ingredients" VALUES (112,'Sausage Poultry');
INSERT INTO "ingredients" VALUES (113,'Celery (Chopped)');
INSERT INTO "ingredients" VALUES (114,'Carrots (Frozen)');
INSERT INTO "ingredients" VALUES (115,'Corn (Frozen)');
INSERT INTO "ingredients" VALUES (116,'Polish Sausage');
INSERT INTO "ingredients" VALUES (117,'Oil');
INSERT INTO "recipe_ingredients" VALUES (56,14,16,2.5,9,56,NULL);
INSERT INTO "recipe_ingredients" VALUES (57,14,57,3,9,57,NULL);
INSERT INTO "recipe_ingredients" VALUES (58,14,93,2,10,58,NULL);
INSERT INTO "recipe_ingredients" VALUES (59,14,86,3,3,59,NULL);
INSERT INTO "recipe_ingredients" VALUES (60,14,62,1.5,9,60,NULL);
INSERT INTO "recipe_ingredients" VALUES (61,14,79,1,10,61,NULL);
INSERT INTO "recipe_ingredients" VALUES (62,14,24,2,10,62,NULL);
INSERT INTO "recipe_ingredients" VALUES (63,15,49,8,7,63,NULL);
INSERT INTO "recipe_ingredients" VALUES (64,15,79,2,10,64,NULL);
INSERT INTO "recipe_ingredients" VALUES (65,15,76,2.25,5,65,NULL);
INSERT INTO "recipe_ingredients" VALUES (66,15,95,4.5,5,66,NULL);
INSERT INTO "recipe_ingredients" VALUES (81,18,51,600,4,81,NULL);
INSERT INTO "recipe_ingredients" VALUES (82,18,2,3,9,82,NULL);
INSERT INTO "recipe_ingredients" VALUES (83,18,95,1,9,83,NULL);
INSERT INTO "recipe_ingredients" VALUES (84,19,91,25,6,84,NULL);
INSERT INTO "recipe_ingredients" VALUES (85,19,95,1,5,85,NULL);
INSERT INTO "recipe_ingredients" VALUES (86,19,2,3,9,86,NULL);
INSERT INTO "recipe_ingredients" VALUES (99,21,76,1.75,5,99,NULL);
INSERT INTO "recipe_ingredients" VALUES (100,21,30,17,6,100,NULL);
INSERT INTO "recipe_ingredients" VALUES (101,21,95,3.5,5,101,NULL);
INSERT INTO "recipe_ingredients" VALUES (102,21,79,3,10,102,NULL);
INSERT INTO "recipe_ingredients" VALUES (103,21,63,1,6,103,NULL);
INSERT INTO "recipe_ingredients" VALUES (104,21,49,3,7,104,NULL);
INSERT INTO "recipe_ingredients" VALUES (105,21,59,1,6,105,NULL);
INSERT INTO "recipe_ingredients" VALUES (106,21,13,1,6,106,NULL);
INSERT INTO "recipe_ingredients" VALUES (107,21,82,2.25,3,107,NULL);
INSERT INTO "recipe_ingredients" VALUES (114,23,46,25,6,114,NULL);
INSERT INTO "recipe_ingredients" VALUES (115,23,33,1.75,10,115,NULL);
INSERT INTO "recipe_ingredients" VALUES (116,23,59,1,6,116,NULL);
INSERT INTO "recipe_ingredients" VALUES (117,23,5,0.5,6,117,NULL);
INSERT INTO "recipe_ingredients" VALUES (118,23,31,2.5,3,118,NULL);
INSERT INTO "recipe_ingredients" VALUES (119,23,89,1.25,1,119,NULL);
INSERT INTO "recipe_ingredients" VALUES (120,23,90,1.25,1,120,NULL);
INSERT INTO "recipe_ingredients" VALUES (121,23,86,0.33,3,121,NULL);
INSERT INTO "recipe_ingredients" VALUES (122,23,21,3,3,122,NULL);
INSERT INTO "recipe_ingredients" VALUES (123,23,79,0.33,3,123,NULL);
INSERT INTO "recipe_ingredients" VALUES (124,23,18,1,2,124,NULL);
INSERT INTO "recipe_ingredients" VALUES (125,23,87,2.5,3,125,NULL);
INSERT INTO "recipe_ingredients" VALUES (147,26,51,600,4,147,NULL);
INSERT INTO "recipe_ingredients" VALUES (148,26,11,1,2,148,NULL);
INSERT INTO "recipe_ingredients" VALUES (149,26,97,1,9,149,NULL);
INSERT INTO "recipe_ingredients" VALUES (150,26,98,3,9,150,NULL);
INSERT INTO "recipe_ingredients" VALUES (151,27,51,600,4,151,NULL);
INSERT INTO "recipe_ingredients" VALUES (152,27,85,1,9,152,NULL);
INSERT INTO "recipe_ingredients" VALUES (153,27,95,1,9,153,NULL);
INSERT INTO "recipe_ingredients" VALUES (154,28,66,6,6,154,NULL);
INSERT INTO "recipe_ingredients" VALUES (155,28,59,1,6,155,NULL);
INSERT INTO "recipe_ingredients" VALUES (156,28,5,0.5,6,156,NULL);
INSERT INTO "recipe_ingredients" VALUES (157,28,87,8,7,157,NULL);
INSERT INTO "recipe_ingredients" VALUES (158,28,95,1.5,5,158,NULL);
INSERT INTO "recipe_ingredients" VALUES (159,28,75,20,6,159,NULL);
INSERT INTO "recipe_ingredients" VALUES (160,28,46,20,6,160,NULL);
INSERT INTO "recipe_ingredients" VALUES (161,28,87,16,7,161,NULL);
INSERT INTO "recipe_ingredients" VALUES (162,28,59,2,6,162,NULL);
INSERT INTO "recipe_ingredients" VALUES (163,29,47,12,6,163,NULL);
INSERT INTO "recipe_ingredients" VALUES (164,29,79,2,10,164,NULL);
INSERT INTO "recipe_ingredients" VALUES (165,29,46,20,6,165,NULL);
INSERT INTO "recipe_ingredients" VALUES (166,29,59,1,6,166,NULL);
INSERT INTO "recipe_ingredients" VALUES (167,29,5,0.5,6,167,NULL);
INSERT INTO "recipe_ingredients" VALUES (168,29,64,1,10,168,NULL);
INSERT INTO "recipe_ingredients" VALUES (169,29,49,4,7,169,NULL);
INSERT INTO "recipe_ingredients" VALUES (170,29,90,1,1,170,NULL);
INSERT INTO "recipe_ingredients" VALUES (171,29,89,1,1,171,NULL);
INSERT INTO "recipe_ingredients" VALUES (172,30,4,1,4,172,NULL);
INSERT INTO "recipe_ingredients" VALUES (173,30,65,2,2,173,NULL);
INSERT INTO "recipe_ingredients" VALUES (174,30,95,2,5,174,NULL);
INSERT INTO "recipe_ingredients" VALUES (175,31,46,20,6,175,NULL);
INSERT INTO "recipe_ingredients" VALUES (176,31,43,1,1,176,NULL);
INSERT INTO "recipe_ingredients" VALUES (177,31,7,1,10,177,NULL);
INSERT INTO "recipe_ingredients" VALUES (178,31,79,2,10,178,NULL);
INSERT INTO "recipe_ingredients" VALUES (179,31,59,1,6,179,NULL);
INSERT INTO "recipe_ingredients" VALUES (180,31,5,0.5,6,180,NULL);
INSERT INTO "recipe_ingredients" VALUES (181,31,86,0.33,3,181,NULL);
INSERT INTO "recipe_ingredients" VALUES (182,31,56,1,5,182,NULL);
INSERT INTO "recipe_ingredients" VALUES (183,32,35,2,2,183,NULL);
INSERT INTO "recipe_ingredients" VALUES (184,32,95,2,5,184,NULL);
INSERT INTO "recipe_ingredients" VALUES (205,36,91,21.25,6,205,NULL);
INSERT INTO "recipe_ingredients" VALUES (206,36,95,3,5,206,NULL);
INSERT INTO "recipe_ingredients" VALUES (207,36,64,2.5,10,207,NULL);
INSERT INTO "recipe_ingredients" VALUES (208,36,79,3.75,10,208,NULL);
INSERT INTO "recipe_ingredients" VALUES (209,36,70,7.5,6,209,NULL);
INSERT INTO "recipe_ingredients" VALUES (210,36,53,3.75,6,210,NULL);
INSERT INTO "recipe_ingredients" VALUES (211,36,49,10,7,211,NULL);
INSERT INTO "recipe_ingredients" VALUES (212,36,59,1,6,212,NULL);
INSERT INTO "recipe_ingredients" VALUES (213,36,13,2.5,6,213,NULL);
INSERT INTO "recipe_ingredients" VALUES (214,36,100,2.5,9,214,NULL);
INSERT INTO "recipe_ingredients" VALUES (215,37,91,25,6,215,NULL);
INSERT INTO "recipe_ingredients" VALUES (216,37,95,1,5,216,NULL);
INSERT INTO "recipe_ingredients" VALUES (217,37,72,1,2,217,NULL);
INSERT INTO "recipe_ingredients" VALUES (235,40,89,3,1,235,NULL);
INSERT INTO "recipe_ingredients" VALUES (236,40,41,2,10,236,NULL);
INSERT INTO "recipe_ingredients" VALUES (237,40,33,2,10,237,NULL);
INSERT INTO "recipe_ingredients" VALUES (238,40,79,2,10,238,NULL);
INSERT INTO "recipe_ingredients" VALUES (239,40,64,1,10,239,NULL);
INSERT INTO "recipe_ingredients" VALUES (240,40,46,20,6,240,NULL);
INSERT INTO "recipe_ingredients" VALUES (241,40,5,0.5,6,241,NULL);
INSERT INTO "recipe_ingredients" VALUES (242,40,59,1,6,242,NULL);
INSERT INTO "recipe_ingredients" VALUES (243,41,70,10,6,243,NULL);
INSERT INTO "recipe_ingredients" VALUES (244,41,14,5,6,244,NULL);
INSERT INTO "recipe_ingredients" VALUES (245,41,15,2.5,6,245,NULL);
INSERT INTO "recipe_ingredients" VALUES (246,41,59,1,6,246,NULL);
INSERT INTO "recipe_ingredients" VALUES (247,41,36,3,1,247,NULL);
INSERT INTO "recipe_ingredients" VALUES (248,41,89,1,3,248,NULL);
INSERT INTO "recipe_ingredients" VALUES (249,41,46,15,6,249,NULL);
INSERT INTO "recipe_ingredients" VALUES (250,41,59,1,6,250,NULL);
INSERT INTO "recipe_ingredients" VALUES (291,47,91,15,6,291,NULL);
INSERT INTO "recipe_ingredients" VALUES (292,47,77,2,9,292,NULL);
INSERT INTO "recipe_ingredients" VALUES (293,47,59,2,6,293,NULL);
INSERT INTO "recipe_ingredients" VALUES (294,47,15,2,6,294,NULL);
INSERT INTO "recipe_ingredients" VALUES (307,50,11,2,2,307,NULL);
INSERT INTO "recipe_ingredients" VALUES (308,50,5,0.5,6,308,NULL);
INSERT INTO "recipe_ingredients" VALUES (309,50,60,1,6,309,NULL);
INSERT INTO "recipe_ingredients" VALUES (310,50,52,100,8,310,NULL);
INSERT INTO "recipe_ingredients" VALUES (311,51,39,200,4,311,NULL);
INSERT INTO "recipe_ingredients" VALUES (312,51,95,12,5,312,NULL);
INSERT INTO "recipe_ingredients" VALUES (313,52,72,2,2,313,NULL);
INSERT INTO "recipe_ingredients" VALUES (314,52,23,100,8,314,NULL);
INSERT INTO "recipe_ingredients" VALUES (332,56,17,100,8,332,NULL);
INSERT INTO "recipe_ingredients" VALUES (333,57,59,1,6,333,NULL);
INSERT INTO "recipe_ingredients" VALUES (334,57,49,1.5,6,334,NULL);
INSERT INTO "recipe_ingredients" VALUES (335,57,15,1.25,6,335,NULL);
INSERT INTO "recipe_ingredients" VALUES (336,57,41,0.3,3,336,NULL);
INSERT INTO "recipe_ingredients" VALUES (337,57,46,13,6,337,NULL);
INSERT INTO "recipe_ingredients" VALUES (338,57,11,0.5,2,338,NULL);
INSERT INTO "recipe_ingredients" VALUES (339,57,95,2,9,339,NULL);
INSERT INTO "recipe_ingredients" VALUES (373,64,41,1,3,373,NULL);
INSERT INTO "recipe_ingredients" VALUES (374,64,72,2,2,374,NULL);
INSERT INTO "recipe_ingredients" VALUES (375,64,91,20,6,375,NULL);
INSERT INTO "recipe_ingredients" VALUES (384,66,46,10,6,384,NULL);
INSERT INTO "recipe_ingredients" VALUES (385,66,59,1,6,385,NULL);
INSERT INTO "recipe_ingredients" VALUES (386,66,66,12,6,386,NULL);
INSERT INTO "recipe_ingredients" VALUES (387,66,79,1,10,387,NULL);
INSERT INTO "recipe_ingredients" VALUES (388,66,90,1,1,388,NULL);
INSERT INTO "recipe_ingredients" VALUES (389,66,88,2,3,389,NULL);
INSERT INTO "recipe_ingredients" VALUES (390,66,87,0.5,3,390,NULL);
INSERT INTO "recipe_ingredients" VALUES (391,66,72,1,2,391,NULL);
INSERT INTO "recipe_ingredients" VALUES (392,66,95,1,9,392,NULL);
INSERT INTO "recipe_ingredients" VALUES (408,69,51,600,4,408,NULL);
INSERT INTO "recipe_ingredients" VALUES (409,69,11,1,2,409,NULL);
INSERT INTO "recipe_ingredients" VALUES (410,69,97,1,9,410,NULL);
INSERT INTO "recipe_ingredients" VALUES (411,69,98,3,9,411,NULL);
INSERT INTO "recipe_ingredients" VALUES (458,77,10,18,6,458,NULL);
INSERT INTO "recipe_ingredients" VALUES (459,77,79,2,10,459,NULL);
INSERT INTO "recipe_ingredients" VALUES (460,77,64,1,10,460,NULL);
INSERT INTO "recipe_ingredients" VALUES (461,77,49,8,7,461,NULL);
INSERT INTO "recipe_ingredients" VALUES (462,77,95,1,9,462,NULL);
INSERT INTO "recipe_ingredients" VALUES (463,78,12,2,2,463,NULL);
INSERT INTO "recipe_ingredients" VALUES (464,78,50,5,3,464,NULL);
INSERT INTO "recipe_ingredients" VALUES (465,78,94,1,3,465,NULL);
INSERT INTO "recipe_ingredients" VALUES (466,78,86,0.25,3,466,NULL);
INSERT INTO "recipe_ingredients" VALUES (467,79,12,2,2,467,NULL);
INSERT INTO "recipe_ingredients" VALUES (468,79,5,0.5,6,468,NULL);
INSERT INTO "recipe_ingredients" VALUES (469,79,59,1,6,469,NULL);
INSERT INTO "recipe_ingredients" VALUES (470,79,102,0.75,3,470,NULL);
INSERT INTO "recipe_ingredients" VALUES (471,79,94,2,3,471,NULL);
INSERT INTO "recipe_ingredients" VALUES (472,79,79,2,10,472,NULL);
INSERT INTO "recipe_ingredients" VALUES (473,80,25,18,6,473,NULL);
INSERT INTO "recipe_ingredients" VALUES (474,80,79,2,10,474,NULL);
INSERT INTO "recipe_ingredients" VALUES (475,80,64,1,10,475,NULL);
INSERT INTO "recipe_ingredients" VALUES (476,80,49,1,3,476,NULL);
INSERT INTO "recipe_ingredients" VALUES (477,81,36,3,1,477,NULL);
INSERT INTO "recipe_ingredients" VALUES (478,81,36,15,6,478,NULL);
INSERT INTO "recipe_ingredients" VALUES (479,81,79,2,10,479,NULL);
INSERT INTO "recipe_ingredients" VALUES (480,81,64,1,10,480,NULL);
INSERT INTO "recipe_ingredients" VALUES (481,81,49,1,3,481,NULL);
INSERT INTO "recipe_ingredients" VALUES (482,82,53,3.75,6,482,NULL);
INSERT INTO "recipe_ingredients" VALUES (483,82,53,15,6,483,NULL);
INSERT INTO "recipe_ingredients" VALUES (484,82,79,2,10,484,NULL);
INSERT INTO "recipe_ingredients" VALUES (485,82,64,1,10,485,NULL);
INSERT INTO "recipe_ingredients" VALUES (486,82,95,1,9,486,NULL);
INSERT INTO "recipe_ingredients" VALUES (487,82,49,8,7,487,NULL);
INSERT INTO "recipe_ingredients" VALUES (488,83,63,3,6,488,NULL);
INSERT INTO "recipe_ingredients" VALUES (489,83,63,18,6,489,NULL);
INSERT INTO "recipe_ingredients" VALUES (490,83,79,2,10,490,NULL);
INSERT INTO "recipe_ingredients" VALUES (491,83,64,1,10,491,NULL);
INSERT INTO "recipe_ingredients" VALUES (492,83,49,1,3,492,NULL);
INSERT INTO "recipe_ingredients" VALUES (493,84,14,15,6,493,NULL);
INSERT INTO "recipe_ingredients" VALUES (494,84,79,2,10,494,NULL);
INSERT INTO "recipe_ingredients" VALUES (495,84,64,1,10,495,NULL);
INSERT INTO "recipe_ingredients" VALUES (496,84,49,1,3,496,NULL);
INSERT INTO "recipe_ingredients" VALUES (497,84,95,1,9,497,NULL);
INSERT INTO "recipe_ingredients" VALUES (511,87,67,5,6,511,NULL);
INSERT INTO "recipe_ingredients" VALUES (512,87,95,2.5,5,512,NULL);
INSERT INTO "recipe_ingredients" VALUES (513,87,64,2,11,513,NULL);
INSERT INTO "recipe_ingredients" VALUES (514,87,79,1,10,514,NULL);
INSERT INTO "recipe_ingredients" VALUES (515,87,49,1,6,515,NULL);
INSERT INTO "recipe_ingredients" VALUES (516,88,67,10,6,516,NULL);
INSERT INTO "recipe_ingredients" VALUES (517,88,95,5,5,517,NULL);
INSERT INTO "recipe_ingredients" VALUES (518,88,64,1,10,518,NULL);
INSERT INTO "recipe_ingredients" VALUES (519,88,79,2,10,519,NULL);
INSERT INTO "recipe_ingredients" VALUES (520,88,49,1,6,520,NULL);
INSERT INTO "recipe_ingredients" VALUES (521,89,67,10,6,521,NULL);
INSERT INTO "recipe_ingredients" VALUES (522,89,95,5,5,522,NULL);
INSERT INTO "recipe_ingredients" VALUES (523,89,64,1,10,523,NULL);
INSERT INTO "recipe_ingredients" VALUES (524,89,79,2,10,524,NULL);
INSERT INTO "recipe_ingredients" VALUES (525,89,49,1,6,525,NULL);
INSERT INTO "recipe_ingredients" VALUES (526,89,34,2,10,526,NULL);
INSERT INTO "recipe_ingredients" VALUES (527,90,38,5,9,527,NULL);
INSERT INTO "recipe_ingredients" VALUES (528,90,95,5,5,528,NULL);
INSERT INTO "recipe_ingredients" VALUES (529,90,49,3,7,529,NULL);
INSERT INTO "recipe_ingredients" VALUES (530,90,79,2,10,530,NULL);
INSERT INTO "recipe_ingredients" VALUES (531,90,8,1,3,531,NULL);
INSERT INTO "recipe_ingredients" VALUES (532,90,18,1,2,532,NULL);
INSERT INTO "recipe_ingredients" VALUES (538,92,66,12,6,538,NULL);
INSERT INTO "recipe_ingredients" VALUES (539,92,59,1,6,539,NULL);
INSERT INTO "recipe_ingredients" VALUES (540,92,5,0.5,6,540,NULL);
INSERT INTO "recipe_ingredients" VALUES (541,92,87,1,3,541,NULL);
INSERT INTO "recipe_ingredients" VALUES (542,92,95,3,5,542,NULL);
INSERT INTO "recipe_ingredients" VALUES (543,93,68,15,6,543,NULL);
INSERT INTO "recipe_ingredients" VALUES (544,93,95,10,5,544,NULL);
INSERT INTO "recipe_ingredients" VALUES (545,93,64,4,10,545,NULL);
INSERT INTO "recipe_ingredients" VALUES (546,93,79,4,10,546,NULL);
INSERT INTO "recipe_ingredients" VALUES (547,93,59,1,6,547,NULL);
INSERT INTO "recipe_ingredients" VALUES (548,93,18,1,2,548,NULL);
INSERT INTO "recipe_ingredients" VALUES (549,93,99,1.5,9,549,NULL);
INSERT INTO "recipe_ingredients" VALUES (550,94,70,12,6,550,NULL);
INSERT INTO "recipe_ingredients" VALUES (551,94,95,6,5,551,NULL);
INSERT INTO "recipe_ingredients" VALUES (552,94,64,1,10,552,NULL);
INSERT INTO "recipe_ingredients" VALUES (553,94,79,1,10,553,NULL);
INSERT INTO "recipe_ingredients" VALUES (554,94,59,1,6,554,NULL);
INSERT INTO "recipe_ingredients" VALUES (562,96,38,5,9,562,NULL);
INSERT INTO "recipe_ingredients" VALUES (563,96,95,5,5,563,NULL);
INSERT INTO "recipe_ingredients" VALUES (564,96,49,3,7,564,NULL);
INSERT INTO "recipe_ingredients" VALUES (565,96,79,2,10,565,NULL);
INSERT INTO "recipe_ingredients" VALUES (566,96,18,1,2,566,NULL);
INSERT INTO "recipe_ingredients" VALUES (567,97,81,10,6,567,NULL);
INSERT INTO "recipe_ingredients" VALUES (568,97,95,6,5,568,NULL);
INSERT INTO "recipe_ingredients" VALUES (569,97,64,2,10,569,NULL);
INSERT INTO "recipe_ingredients" VALUES (570,97,79,4,10,570,NULL);
INSERT INTO "recipe_ingredients" VALUES (571,98,55,13,6,571,NULL);
INSERT INTO "recipe_ingredients" VALUES (572,98,79,2,10,572,NULL);
INSERT INTO "recipe_ingredients" VALUES (573,99,55,13,6,573,NULL);
INSERT INTO "recipe_ingredients" VALUES (574,99,79,2,10,574,NULL);
INSERT INTO "recipe_ingredients" VALUES (575,100,48,20,6,575,NULL);
INSERT INTO "recipe_ingredients" VALUES (576,100,5,0.5,6,576,NULL);
INSERT INTO "recipe_ingredients" VALUES (577,100,59,1,6,577,NULL);
INSERT INTO "recipe_ingredients" VALUES (578,100,79,2,10,578,NULL);
INSERT INTO "recipe_ingredients" VALUES (579,100,64,1,10,579,NULL);
INSERT INTO "recipe_ingredients" VALUES (580,100,40,6,3,580,NULL);
INSERT INTO "recipe_ingredients" VALUES (581,101,69,10,6,581,NULL);
INSERT INTO "recipe_ingredients" VALUES (582,101,95,6,5,582,NULL);
INSERT INTO "recipe_ingredients" VALUES (583,101,64,2,10,583,NULL);
INSERT INTO "recipe_ingredients" VALUES (584,101,79,4,10,584,NULL);
INSERT INTO "recipe_ingredients" VALUES (585,101,59,1,6,585,NULL);
INSERT INTO "recipe_ingredients" VALUES (586,101,5,0.5,6,586,NULL);
INSERT INTO "recipe_ingredients" VALUES (587,101,49,1,6,587,NULL);
INSERT INTO "recipe_ingredients" VALUES (588,102,49,1,7,588,NULL);
INSERT INTO "recipe_ingredients" VALUES (589,102,59,1,6,589,NULL);
INSERT INTO "recipe_ingredients" VALUES (590,102,8,1,3,590,NULL);
INSERT INTO "recipe_ingredients" VALUES (591,102,76,2.25,5,591,NULL);
INSERT INTO "recipe_ingredients" VALUES (592,102,95,4.5,5,592,NULL);
INSERT INTO "recipe_ingredients" VALUES (593,103,78,1,1,593,NULL);
INSERT INTO "recipe_ingredients" VALUES (594,103,76,2.25,5,594,NULL);
INSERT INTO "recipe_ingredients" VALUES (595,103,95,4,5,595,NULL);
INSERT INTO "recipe_ingredients" VALUES (596,103,59,1,6,596,NULL);
INSERT INTO "recipe_ingredients" VALUES (597,103,87,1,3,597,NULL);
INSERT INTO "recipe_ingredients" VALUES (598,103,49,1,3,598,NULL);
INSERT INTO "recipe_ingredients" VALUES (599,104,49,8,7,599,NULL);
INSERT INTO "recipe_ingredients" VALUES (600,104,59,1,6,600,NULL);
INSERT INTO "recipe_ingredients" VALUES (601,104,79,2,10,601,NULL);
INSERT INTO "recipe_ingredients" VALUES (602,104,76,2.25,5,602,NULL);
INSERT INTO "recipe_ingredients" VALUES (603,104,95,4.5,5,603,NULL);
INSERT INTO "recipe_ingredients" VALUES (614,109,71,45,6,614,NULL);
INSERT INTO "recipe_ingredients" VALUES (615,109,79,2,10,615,NULL);
INSERT INTO "recipe_ingredients" VALUES (625,114,74,4,6,625,NULL);
INSERT INTO "recipe_ingredients" VALUES (626,114,86,1,3,626,NULL);
INSERT INTO "recipe_ingredients" VALUES (627,114,93,2.5,11,627,NULL);
INSERT INTO "recipe_ingredients" VALUES (628,114,95,1.5,3,628,NULL);
INSERT INTO "recipe_ingredients" VALUES (730,6,106,8.5,6,730,NULL);
INSERT INTO "recipe_ingredients" VALUES (731,6,57,1.25,9,731,NULL);
INSERT INTO "recipe_ingredients" VALUES (732,6,49,2,6,732,NULL);
INSERT INTO "recipe_ingredients" VALUES (733,6,86,1,3,733,NULL);
INSERT INTO "recipe_ingredients" VALUES (734,6,24,2,10,734,NULL);
INSERT INTO "recipe_ingredients" VALUES (735,6,31,1,3,735,NULL);
INSERT INTO "recipe_ingredients" VALUES (736,6,95,3,9,736,NULL);
INSERT INTO "recipe_ingredients" VALUES (740,7,61,10,6,740,NULL);
INSERT INTO "recipe_ingredients" VALUES (741,7,86,2,3,741,NULL);
INSERT INTO "recipe_ingredients" VALUES (742,7,49,2,6,742,NULL);
INSERT INTO "recipe_ingredients" VALUES (749,2,45,6.5,9,749,NULL);
INSERT INTO "recipe_ingredients" VALUES (750,2,5,0.5,6,750,NULL);
INSERT INTO "recipe_ingredients" VALUES (751,2,59,1,6,751,NULL);
INSERT INTO "recipe_ingredients" VALUES (752,2,71,13,6,752,NULL);
INSERT INTO "recipe_ingredients" VALUES (753,3,38,5,9,753,NULL);
INSERT INTO "recipe_ingredients" VALUES (754,3,95,5,5,754,NULL);
INSERT INTO "recipe_ingredients" VALUES (755,3,49,1,6,755,NULL);
INSERT INTO "recipe_ingredients" VALUES (756,3,79,3,10,756,NULL);
INSERT INTO "recipe_ingredients" VALUES (757,3,7,2,10,757,NULL);
INSERT INTO "recipe_ingredients" VALUES (758,5,54,10,6,758,NULL);
INSERT INTO "recipe_ingredients" VALUES (759,5,49,2,6,759,NULL);
INSERT INTO "recipe_ingredients" VALUES (766,4,56,1.25,5,766,NULL);
INSERT INTO "recipe_ingredients" VALUES (767,4,95,5,5,767,NULL);
INSERT INTO "recipe_ingredients" VALUES (768,4,49,3,6,768,NULL);
INSERT INTO "recipe_ingredients" VALUES (769,4,86,1.5,3,769,NULL);
INSERT INTO "recipe_ingredients" VALUES (798,17,46,15,6,798,NULL);
INSERT INTO "recipe_ingredients" VALUES (799,17,59,1,6,799,NULL);
INSERT INTO "recipe_ingredients" VALUES (800,17,5,0.5,6,800,NULL);
INSERT INTO "recipe_ingredients" VALUES (801,17,66,5,6,801,NULL);
INSERT INTO "recipe_ingredients" VALUES (802,17,8,2.5,3,802,NULL);
INSERT INTO "recipe_ingredients" VALUES (803,17,90,1,1,803,NULL);
INSERT INTO "recipe_ingredients" VALUES (804,17,49,3.75,7,804,NULL);
INSERT INTO "recipe_ingredients" VALUES (805,20,20,25,6,805,NULL);
INSERT INTO "recipe_ingredients" VALUES (806,20,95,1.5,5,806,NULL);
INSERT INTO "recipe_ingredients" VALUES (807,20,64,2,10,807,NULL);
INSERT INTO "recipe_ingredients" VALUES (808,20,79,3,10,808,NULL);
INSERT INTO "recipe_ingredients" VALUES (809,20,5,0.5,6,809,NULL);
INSERT INTO "recipe_ingredients" VALUES (810,20,63,2,6,810,NULL);
INSERT INTO "recipe_ingredients" VALUES (811,20,15,2,6,811,NULL);
INSERT INTO "recipe_ingredients" VALUES (812,20,14,4,6,812,NULL);
INSERT INTO "recipe_ingredients" VALUES (813,20,49,8,7,813,NULL);
INSERT INTO "recipe_ingredients" VALUES (814,20,59,1,6,814,NULL);
INSERT INTO "recipe_ingredients" VALUES (815,20,72,1,2,815,NULL);
INSERT INTO "recipe_ingredients" VALUES (816,20,100,1,9,816,NULL);
INSERT INTO "recipe_ingredients" VALUES (817,22,59,1,6,817,NULL);
INSERT INTO "recipe_ingredients" VALUES (818,22,5,0.5,6,818,NULL);
INSERT INTO "recipe_ingredients" VALUES (819,22,28,16,6,819,NULL);
INSERT INTO "recipe_ingredients" VALUES (820,22,85,1,5,820,NULL);
INSERT INTO "recipe_ingredients" VALUES (821,22,49,4,7,821,NULL);
INSERT INTO "recipe_ingredients" VALUES (822,22,95,1,9,822,NULL);
INSERT INTO "recipe_ingredients" VALUES (833,121,66,9.25,6,833,NULL);
INSERT INTO "recipe_ingredients" VALUES (834,121,46,13.75,6,834,NULL);
INSERT INTO "recipe_ingredients" VALUES (835,121,60,1,6,835,NULL);
INSERT INTO "recipe_ingredients" VALUES (836,121,88,1.25,1,836,NULL);
INSERT INTO "recipe_ingredients" VALUES (837,121,109,0.33,5,837,NULL);
INSERT INTO "recipe_ingredients" VALUES (838,121,21,2.5,3,838,NULL);
INSERT INTO "recipe_ingredients" VALUES (839,121,110,2.5,10,839,NULL);
INSERT INTO "recipe_ingredients" VALUES (840,121,33,0.5,3,840,NULL);
INSERT INTO "recipe_ingredients" VALUES (841,121,7,2.5,10,841,NULL);
INSERT INTO "recipe_ingredients" VALUES (842,121,79,0.5,3,842,NULL);
INSERT INTO "recipe_ingredients" VALUES (843,25,46,18,6,843,NULL);
INSERT INTO "recipe_ingredients" VALUES (844,25,33,1.5,10,844,NULL);
INSERT INTO "recipe_ingredients" VALUES (845,25,59,1.25,6,845,NULL);
INSERT INTO "recipe_ingredients" VALUES (846,25,5,0.5,6,846,NULL);
INSERT INTO "recipe_ingredients" VALUES (847,25,89,1.25,1,847,NULL);
INSERT INTO "recipe_ingredients" VALUES (848,25,90,1.25,1,848,NULL);
INSERT INTO "recipe_ingredients" VALUES (849,25,86,5,10,849,NULL);
INSERT INTO "recipe_ingredients" VALUES (850,25,87,2,3,850,NULL);
INSERT INTO "recipe_ingredients" VALUES (851,25,3,2,6,851,NULL);
INSERT INTO "recipe_ingredients" VALUES (852,25,95,3.5,9,852,NULL);
INSERT INTO "recipe_ingredients" VALUES (853,25,47,12,6,853,NULL);
INSERT INTO "recipe_ingredients" VALUES (854,24,91,19,6,854,NULL);
INSERT INTO "recipe_ingredients" VALUES (855,24,95,3,5,855,NULL);
INSERT INTO "recipe_ingredients" VALUES (856,24,5,0.5,6,856,NULL);
INSERT INTO "recipe_ingredients" VALUES (857,24,59,1,6,857,NULL);
INSERT INTO "recipe_ingredients" VALUES (858,24,14,1.5,6,858,NULL);
INSERT INTO "recipe_ingredients" VALUES (859,24,49,2,6,859,NULL);
INSERT INTO "recipe_ingredients" VALUES (860,24,90,1,1,860,NULL);
INSERT INTO "recipe_ingredients" VALUES (861,24,100,2.5,9,861,NULL);
INSERT INTO "recipe_ingredients" VALUES (862,24,72,2.5,2,862,NULL);
INSERT INTO "recipe_ingredients" VALUES (863,24,8,1.25,3,863,NULL);
INSERT INTO "recipe_ingredients" VALUES (864,122,79,2,10,864,NULL);
INSERT INTO "recipe_ingredients" VALUES (865,122,46,20,6,865,NULL);
INSERT INTO "recipe_ingredients" VALUES (866,122,59,1,6,866,NULL);
INSERT INTO "recipe_ingredients" VALUES (867,122,5,0.5,6,867,NULL);
INSERT INTO "recipe_ingredients" VALUES (868,122,64,1,10,868,NULL);
INSERT INTO "recipe_ingredients" VALUES (869,122,49,4,7,869,NULL);
INSERT INTO "recipe_ingredients" VALUES (870,122,90,1,1,870,NULL);
INSERT INTO "recipe_ingredients" VALUES (871,122,89,1,1,871,NULL);
INSERT INTO "recipe_ingredients" VALUES (872,33,79,2,11,872,NULL);
INSERT INTO "recipe_ingredients" VALUES (873,33,42,8,6,873,NULL);
INSERT INTO "recipe_ingredients" VALUES (874,33,59,1,6,874,NULL);
INSERT INTO "recipe_ingredients" VALUES (875,33,5,0.5,6,875,NULL);
INSERT INTO "recipe_ingredients" VALUES (876,33,7,1,11,876,NULL);
INSERT INTO "recipe_ingredients" VALUES (877,33,49,1.5,7,877,NULL);
INSERT INTO "recipe_ingredients" VALUES (878,33,11,0.5,2,878,NULL);
INSERT INTO "recipe_ingredients" VALUES (879,33,95,0.5,5,879,NULL);
INSERT INTO "recipe_ingredients" VALUES (880,34,46,20,6,880,NULL);
INSERT INTO "recipe_ingredients" VALUES (881,34,87,16,7,881,NULL);
INSERT INTO "recipe_ingredients" VALUES (882,34,59,1,6,882,NULL);
INSERT INTO "recipe_ingredients" VALUES (883,34,18,1,2,883,NULL);
INSERT INTO "recipe_ingredients" VALUES (884,35,47,12,6,884,NULL);
INSERT INTO "recipe_ingredients" VALUES (885,35,19,1.25,2,885,NULL);
INSERT INTO "recipe_ingredients" VALUES (886,35,65,1.25,2,886,NULL);
INSERT INTO "recipe_ingredients" VALUES (887,35,95,7.25,9,887,NULL);
INSERT INTO "recipe_ingredients" VALUES (888,35,64,1.25,10,888,NULL);
INSERT INTO "recipe_ingredients" VALUES (889,35,79,2.5,10,889,NULL);
INSERT INTO "recipe_ingredients" VALUES (890,35,92,14.5,6,890,NULL);
INSERT INTO "recipe_ingredients" VALUES (891,38,79,2.5,10,891,NULL);
INSERT INTO "recipe_ingredients" VALUES (892,38,46,16,6,892,NULL);
INSERT INTO "recipe_ingredients" VALUES (893,38,59,1,6,893,NULL);
INSERT INTO "recipe_ingredients" VALUES (894,38,5,0.5,6,894,NULL);
INSERT INTO "recipe_ingredients" VALUES (895,38,49,5,7,895,NULL);
INSERT INTO "recipe_ingredients" VALUES (896,38,18,1.25,2,896,NULL);
INSERT INTO "recipe_ingredients" VALUES (897,38,72,1.25,2,897,NULL);
INSERT INTO "recipe_ingredients" VALUES (898,38,100,5,9,898,NULL);
INSERT INTO "recipe_ingredients" VALUES (899,39,89,3,1,899,NULL);
INSERT INTO "recipe_ingredients" VALUES (900,39,41,2,10,900,NULL);
INSERT INTO "recipe_ingredients" VALUES (901,39,33,2,10,901,NULL);
INSERT INTO "recipe_ingredients" VALUES (902,39,79,2,10,902,NULL);
INSERT INTO "recipe_ingredients" VALUES (903,39,64,1,10,903,NULL);
INSERT INTO "recipe_ingredients" VALUES (904,39,5,0.5,6,904,NULL);
INSERT INTO "recipe_ingredients" VALUES (905,39,59,1,6,905,NULL);
INSERT INTO "recipe_ingredients" VALUES (906,39,51,600,4,906,NULL);
INSERT INTO "recipe_ingredients" VALUES (912,42,46,19,6,912,NULL);
INSERT INTO "recipe_ingredients" VALUES (913,42,59,1,6,913,NULL);
INSERT INTO "recipe_ingredients" VALUES (914,42,18,2,2,914,NULL);
INSERT INTO "recipe_ingredients" VALUES (915,42,72,1,2,915,NULL);
INSERT INTO "recipe_ingredients" VALUES (916,42,41,3,3,916,NULL);
INSERT INTO "recipe_ingredients" VALUES (917,42,111,15,6,917,NULL);
INSERT INTO "recipe_ingredients" VALUES (925,43,49,2.5,3,925,NULL);
INSERT INTO "recipe_ingredients" VALUES (926,43,59,1.25,6,926,NULL);
INSERT INTO "recipe_ingredients" VALUES (927,43,87,3,3,927,NULL);
INSERT INTO "recipe_ingredients" VALUES (928,43,76,2.5,5,928,NULL);
INSERT INTO "recipe_ingredients" VALUES (929,43,78,1.25,1,929,NULL);
INSERT INTO "recipe_ingredients" VALUES (930,43,3,16,6,930,NULL);
INSERT INTO "recipe_ingredients" VALUES (931,43,18,2.5,2,931,NULL);
INSERT INTO "recipe_ingredients" VALUES (932,44,49,1.3,3,932,NULL);
INSERT INTO "recipe_ingredients" VALUES (933,44,46,10,6,933,NULL);
INSERT INTO "recipe_ingredients" VALUES (934,44,59,1,6,934,NULL);
INSERT INTO "recipe_ingredients" VALUES (935,44,5,0.5,6,935,NULL);
INSERT INTO "recipe_ingredients" VALUES (936,44,41,1.25,10,936,NULL);
INSERT INTO "recipe_ingredients" VALUES (937,44,105,1.25,10,937,NULL);
INSERT INTO "recipe_ingredients" VALUES (938,44,90,2,1,938,NULL);
INSERT INTO "recipe_ingredients" VALUES (939,44,76,8,6,939,NULL);
INSERT INTO "recipe_ingredients" VALUES (940,44,18,0.5,2,940,NULL);
INSERT INTO "recipe_ingredients" VALUES (941,45,91,15,6,941,NULL);
INSERT INTO "recipe_ingredients" VALUES (942,45,8,1.5,10,942,NULL);
INSERT INTO "recipe_ingredients" VALUES (943,45,49,1.25,10,943,NULL);
INSERT INTO "recipe_ingredients" VALUES (944,45,58,1,6,944,NULL);
INSERT INTO "recipe_ingredients" VALUES (945,45,90,1,1,945,NULL);
INSERT INTO "recipe_ingredients" VALUES (946,45,72,0.5,2,946,NULL);
INSERT INTO "recipe_ingredients" VALUES (947,45,18,0.5,2,947,NULL);
INSERT INTO "recipe_ingredients" VALUES (948,46,46,12,6,948,NULL);
INSERT INTO "recipe_ingredients" VALUES (949,46,95,5,5,949,NULL);
INSERT INTO "recipe_ingredients" VALUES (950,46,59,1,6,950,NULL);
INSERT INTO "recipe_ingredients" VALUES (951,46,89,0.5,1,951,NULL);
INSERT INTO "recipe_ingredients" VALUES (952,46,94,0.5,3,952,NULL);
INSERT INTO "recipe_ingredients" VALUES (953,46,32,3,10,953,NULL);
INSERT INTO "recipe_ingredients" VALUES (954,46,105,2.5,10,954,NULL);
INSERT INTO "recipe_ingredients" VALUES (955,46,22,2,7,955,NULL);
INSERT INTO "recipe_ingredients" VALUES (956,46,8,1,3,956,NULL);
INSERT INTO "recipe_ingredients" VALUES (957,46,79,1,10,957,NULL);
INSERT INTO "recipe_ingredients" VALUES (958,46,24,1.2,10,958,NULL);
INSERT INTO "recipe_ingredients" VALUES (959,60,91,15,6,959,NULL);
INSERT INTO "recipe_ingredients" VALUES (960,60,72,2,2,960,NULL);
INSERT INTO "recipe_ingredients" VALUES (961,60,20,25,6,961,NULL);
INSERT INTO "recipe_ingredients" VALUES (962,60,95,1.5,5,962,NULL);
INSERT INTO "recipe_ingredients" VALUES (963,60,64,2,10,963,NULL);
INSERT INTO "recipe_ingredients" VALUES (964,60,79,3,10,964,NULL);
INSERT INTO "recipe_ingredients" VALUES (965,60,49,8,7,965,NULL);
INSERT INTO "recipe_ingredients" VALUES (966,60,59,1,6,966,NULL);
INSERT INTO "recipe_ingredients" VALUES (967,60,72,1,2,967,NULL);
INSERT INTO "recipe_ingredients" VALUES (968,60,100,1,9,968,NULL);
INSERT INTO "recipe_ingredients" VALUES (969,48,11,2,2,969,NULL);
INSERT INTO "recipe_ingredients" VALUES (970,48,41,2,10,970,NULL);
INSERT INTO "recipe_ingredients" VALUES (971,48,98,6,9,971,NULL);
INSERT INTO "recipe_ingredients" VALUES (972,48,97,2,9,972,NULL);
INSERT INTO "recipe_ingredients" VALUES (973,48,64,1,10,973,NULL);
INSERT INTO "recipe_ingredients" VALUES (974,48,52,100,8,974,NULL);
INSERT INTO "recipe_ingredients" VALUES (975,48,59,1,6,975,NULL);
INSERT INTO "recipe_ingredients" VALUES (976,48,5,0.5,6,976,NULL);
INSERT INTO "recipe_ingredients" VALUES (977,49,11,2,2,977,NULL);
INSERT INTO "recipe_ingredients" VALUES (978,49,41,2,10,978,NULL);
INSERT INTO "recipe_ingredients" VALUES (979,49,64,1,10,979,NULL);
INSERT INTO "recipe_ingredients" VALUES (980,49,52,100,8,980,NULL);
INSERT INTO "recipe_ingredients" VALUES (991,53,59,1,6,991,NULL);
INSERT INTO "recipe_ingredients" VALUES (992,53,49,0.33,3,992,NULL);
INSERT INTO "recipe_ingredients" VALUES (993,53,15,0.5,6,993,NULL);
INSERT INTO "recipe_ingredients" VALUES (994,53,79,1.5,10,994,NULL);
INSERT INTO "recipe_ingredients" VALUES (995,53,33,0.5,10,995,NULL);
INSERT INTO "recipe_ingredients" VALUES (996,53,41,1.5,10,996,NULL);
INSERT INTO "recipe_ingredients" VALUES (997,53,90,0.5,1,997,NULL);
INSERT INTO "recipe_ingredients" VALUES (998,53,88,2.5,3,998,NULL);
INSERT INTO "recipe_ingredients" VALUES (999,53,100,2.75,5,999,NULL);
INSERT INTO "recipe_ingredients" VALUES (1000,53,72,0.25,2,1000,NULL);
INSERT INTO "recipe_ingredients" VALUES (1001,53,112,15,6,1001,NULL);
INSERT INTO "recipe_ingredients" VALUES (1002,54,46,19,6,1002,NULL);
INSERT INTO "recipe_ingredients" VALUES (1003,54,87,16,7,1003,NULL);
INSERT INTO "recipe_ingredients" VALUES (1004,54,59,1,6,1004,NULL);
INSERT INTO "recipe_ingredients" VALUES (1005,54,19,1,2,1005,NULL);
INSERT INTO "recipe_ingredients" VALUES (1006,54,44,1,6,1006,NULL);
INSERT INTO "recipe_ingredients" VALUES (1007,55,65,2,2,1007,NULL);
INSERT INTO "recipe_ingredients" VALUES (1008,55,23,100,8,1008,NULL);
INSERT INTO "recipe_ingredients" VALUES (1011,123,59,1,6,1011,NULL);
INSERT INTO "recipe_ingredients" VALUES (1012,123,49,1.5,6,1012,NULL);
INSERT INTO "recipe_ingredients" VALUES (1013,123,113,1.25,6,1013,NULL);
INSERT INTO "recipe_ingredients" VALUES (1014,123,41,0.33,3,1014,NULL);
INSERT INTO "recipe_ingredients" VALUES (1015,123,46,13,6,1015,NULL);
INSERT INTO "recipe_ingredients" VALUES (1016,123,11,0.5,2,1016,NULL);
INSERT INTO "recipe_ingredients" VALUES (1017,123,95,2,9,1017,NULL);
INSERT INTO "recipe_ingredients" VALUES (1018,123,114,5.25,6,1018,NULL);
INSERT INTO "recipe_ingredients" VALUES (1019,123,115,5.25,6,1019,NULL);
INSERT INTO "recipe_ingredients" VALUES (1028,58,59,1,6,1028,NULL);
INSERT INTO "recipe_ingredients" VALUES (1029,58,87,0.5,3,1029,NULL);
INSERT INTO "recipe_ingredients" VALUES (1030,58,86,0.66,3,1030,NULL);
INSERT INTO "recipe_ingredients" VALUES (1031,58,90,2.5,1,1031,NULL);
INSERT INTO "recipe_ingredients" VALUES (1032,58,46,15,6,1032,NULL);
INSERT INTO "recipe_ingredients" VALUES (1033,58,11,1.25,2,1033,NULL);
INSERT INTO "recipe_ingredients" VALUES (1034,58,95,2.5,9,1034,NULL);
INSERT INTO "recipe_ingredients" VALUES (1035,58,6,4.5,6,1035,NULL);
INSERT INTO "recipe_ingredients" VALUES (1036,58,95,1.5,9,1036,NULL);
INSERT INTO "recipe_ingredients" VALUES (1037,58,18,1.25,2,1037,NULL);
INSERT INTO "recipe_ingredients" VALUES (1040,59,95,12,5,1040,NULL);
INSERT INTO "recipe_ingredients" VALUES (1041,59,116,200,4,1041,NULL);
INSERT INTO "recipe_ingredients" VALUES (1046,62,29,100,4,1046,NULL);
INSERT INTO "recipe_ingredients" VALUES (1047,62,2,3,9,1047,NULL);
INSERT INTO "recipe_ingredients" VALUES (1048,63,59,1,6,1048,NULL);
INSERT INTO "recipe_ingredients" VALUES (1049,63,47,12,6,1049,NULL);
INSERT INTO "recipe_ingredients" VALUES (1050,63,95,12,5,1050,NULL);
INSERT INTO "recipe_ingredients" VALUES (1051,63,46,14.5,6,1051,NULL);
INSERT INTO "recipe_ingredients" VALUES (1052,63,11,0.5,2,1052,NULL);
INSERT INTO "recipe_ingredients" VALUES (1053,63,90,1,1,1053,NULL);
INSERT INTO "recipe_ingredients" VALUES (1054,63,19,2.5,2,1054,NULL);
INSERT INTO "recipe_ingredients" VALUES (1055,65,26,6,5,1055,NULL);
INSERT INTO "recipe_ingredients" VALUES (1056,65,49,1.25,6,1056,NULL);
INSERT INTO "recipe_ingredients" VALUES (1057,65,59,1.25,6,1057,NULL);
INSERT INTO "recipe_ingredients" VALUES (1058,65,91,10,6,1058,NULL);
INSERT INTO "recipe_ingredients" VALUES (1059,65,15,0.5,6,1059,NULL);
INSERT INTO "recipe_ingredients" VALUES (1060,65,73,0.5,3,1060,NULL);
INSERT INTO "recipe_ingredients" VALUES (1061,65,72,1.25,2,1061,NULL);
INSERT INTO "recipe_ingredients" VALUES (1062,65,100,1.25,9,1062,NULL);
INSERT INTO "recipe_ingredients" VALUES (1063,67,49,1.25,3,1063,NULL);
INSERT INTO "recipe_ingredients" VALUES (1064,67,59,1.25,6,1064,NULL);
INSERT INTO "recipe_ingredients" VALUES (1065,67,72,2.5,2,1065,NULL);
INSERT INTO "recipe_ingredients" VALUES (1066,67,76,2.5,5,1066,NULL);
INSERT INTO "recipe_ingredients" VALUES (1067,67,46,14.5,6,1067,NULL);
INSERT INTO "recipe_ingredients" VALUES (1068,68,66,6,6,1068,NULL);
INSERT INTO "recipe_ingredients" VALUES (1069,68,59,1,6,1069,NULL);
INSERT INTO "recipe_ingredients" VALUES (1070,68,5,0.5,6,1070,NULL);
INSERT INTO "recipe_ingredients" VALUES (1071,68,87,1.25,3,1071,NULL);
INSERT INTO "recipe_ingredients" VALUES (1072,68,95,1.75,5,1072,NULL);
INSERT INTO "recipe_ingredients" VALUES (1073,68,90,1.25,1,1073,NULL);
INSERT INTO "recipe_ingredients" VALUES (1074,68,46,18,6,1074,NULL);
INSERT INTO "recipe_ingredients" VALUES (1075,68,25,25,6,1075,NULL);
INSERT INTO "recipe_ingredients" VALUES (1076,68,19,2.5,2,1076,NULL);
INSERT INTO "recipe_ingredients" VALUES (1077,68,27,10,6,1077,NULL);
INSERT INTO "recipe_ingredients" VALUES (1078,70,46,20,6,1078,NULL);
INSERT INTO "recipe_ingredients" VALUES (1079,70,87,16,7,1079,NULL);
INSERT INTO "recipe_ingredients" VALUES (1080,70,59,1,6,1080,NULL);
INSERT INTO "recipe_ingredients" VALUES (1081,70,18,2,2,1081,NULL);
INSERT INTO "recipe_ingredients" VALUES (1082,71,17,100,8,1082,NULL);
INSERT INTO "recipe_ingredients" VALUES (1083,71,2,3,9,1083,NULL);
INSERT INTO "recipe_ingredients" VALUES (1084,72,59,1,6,1084,NULL);
INSERT INTO "recipe_ingredients" VALUES (1085,72,95,12,5,1085,NULL);
INSERT INTO "recipe_ingredients" VALUES (1086,72,49,0.5,6,1086,NULL);
INSERT INTO "recipe_ingredients" VALUES (1087,72,46,19,6,1087,NULL);
INSERT INTO "recipe_ingredients" VALUES (1088,72,95,1.25,5,1088,NULL);
INSERT INTO "recipe_ingredients" VALUES (1089,72,11,0.5,2,1089,NULL);
INSERT INTO "recipe_ingredients" VALUES (1090,72,89,1,1,1090,NULL);
INSERT INTO "recipe_ingredients" VALUES (1091,72,79,0.25,3,1091,NULL);
INSERT INTO "recipe_ingredients" VALUES (1092,72,64,1,10,1092,NULL);
INSERT INTO "recipe_ingredients" VALUES (1093,72,86,0.5,3,1093,NULL);
INSERT INTO "recipe_ingredients" VALUES (1094,72,105,1.5,3,1094,NULL);
INSERT INTO "recipe_ingredients" VALUES (1095,72,107,1,3,1095,NULL);
INSERT INTO "recipe_ingredients" VALUES (1096,73,59,1,6,1096,NULL);
INSERT INTO "recipe_ingredients" VALUES (1097,73,82,1.5,3,1097,NULL);
INSERT INTO "recipe_ingredients" VALUES (1098,73,46,16,6,1098,NULL);
INSERT INTO "recipe_ingredients" VALUES (1099,73,95,1.4,5,1099,NULL);
INSERT INTO "recipe_ingredients" VALUES (1100,73,72,0.5,2,1100,NULL);
INSERT INTO "recipe_ingredients" VALUES (1101,73,32,1.5,11,1101,NULL);
INSERT INTO "recipe_ingredients" VALUES (1102,73,113,5.5,6,1102,NULL);
INSERT INTO "recipe_ingredients" VALUES (1103,73,64,1.5,11,1103,NULL);
INSERT INTO "recipe_ingredients" VALUES (1126,75,59,1,6,1126,NULL);
INSERT INTO "recipe_ingredients" VALUES (1127,75,80,5,6,1127,NULL);
INSERT INTO "recipe_ingredients" VALUES (1128,75,91,11,6,1128,NULL);
INSERT INTO "recipe_ingredients" VALUES (1129,75,72,0.5,2,1129,NULL);
INSERT INTO "recipe_ingredients" VALUES (1130,75,49,0.25,6,1130,NULL);
INSERT INTO "recipe_ingredients" VALUES (1131,75,41,1,10,1131,NULL);
INSERT INTO "recipe_ingredients" VALUES (1132,75,37,0.5,6,1132,NULL);
INSERT INTO "recipe_ingredients" VALUES (1133,75,86,0.5,3,1133,NULL);
INSERT INTO "recipe_ingredients" VALUES (1141,85,59,1,6,1141,NULL);
INSERT INTO "recipe_ingredients" VALUES (1142,85,43,2.5,3,1142,NULL);
INSERT INTO "recipe_ingredients" VALUES (1143,85,94,3.5,7,1143,NULL);
INSERT INTO "recipe_ingredients" VALUES (1144,85,86,1,3,1144,NULL);
INSERT INTO "recipe_ingredients" VALUES (1145,85,107,2,7,1145,NULL);
INSERT INTO "recipe_ingredients" VALUES (1146,85,95,1.5,5,1146,NULL);
INSERT INTO "recipe_ingredients" VALUES (1147,85,66,6,6,1147,NULL);
INSERT INTO "recipe_ingredients" VALUES (1148,86,47,12,6,1148,NULL);
INSERT INTO "recipe_ingredients" VALUES (1149,86,18,2,2,1149,NULL);
INSERT INTO "recipe_ingredients" VALUES (1150,86,65,1,2,1150,NULL);
INSERT INTO "recipe_ingredients" VALUES (1151,86,95,8,9,1151,NULL);
INSERT INTO "recipe_ingredients" VALUES (1152,86,64,1,10,1152,NULL);
INSERT INTO "recipe_ingredients" VALUES (1153,86,79,2,10,1153,NULL);
INSERT INTO "recipe_ingredients" VALUES (1154,91,66,17,6,1154,NULL);
INSERT INTO "recipe_ingredients" VALUES (1155,91,59,1,6,1155,NULL);
INSERT INTO "recipe_ingredients" VALUES (1156,91,5,0.5,6,1156,NULL);
INSERT INTO "recipe_ingredients" VALUES (1157,91,87,1,3,1157,NULL);
INSERT INTO "recipe_ingredients" VALUES (1158,91,95,3,5,1158,NULL);
INSERT INTO "recipe_ingredients" VALUES (1166,95,71,34,6,1166,NULL);
INSERT INTO "recipe_ingredients" VALUES (1167,95,5,0.5,6,1167,NULL);
INSERT INTO "recipe_ingredients" VALUES (1168,95,59,1,6,1168,NULL);
INSERT INTO "recipe_ingredients" VALUES (1169,95,79,2,10,1169,NULL);
INSERT INTO "recipe_ingredients" VALUES (1170,95,64,1,10,1170,NULL);
INSERT INTO "recipe_ingredients" VALUES (1171,95,103,3,3,1171,NULL);
INSERT INTO "recipe_ingredients" VALUES (1172,95,86,1,3,1172,NULL);
INSERT INTO "recipe_ingredients" VALUES (1173,95,117,1,3,1173,NULL);
INSERT INTO "recipe_ingredients" VALUES (1177,105,9,10,6,1177,NULL);
INSERT INTO "recipe_ingredients" VALUES (1178,105,96,5,5,1178,NULL);
INSERT INTO "recipe_ingredients" VALUES (1179,105,49,2,6,1179,NULL);
INSERT INTO "recipe_ingredients" VALUES (1180,106,6,10,6,1180,NULL);
INSERT INTO "recipe_ingredients" VALUES (1181,106,49,2,6,1181,NULL);
INSERT INTO "recipe_ingredients" VALUES (1182,107,27,10,6,1182,NULL);
INSERT INTO "recipe_ingredients" VALUES (1183,107,49,2,6,1183,NULL);
INSERT INTO "recipe_ingredients" VALUES (1184,108,9,10,6,1184,NULL);
INSERT INTO "recipe_ingredients" VALUES (1185,108,96,7.5,5,1185,NULL);
INSERT INTO "recipe_ingredients" VALUES (1186,108,49,2,6,1186,NULL);
INSERT INTO "recipe_ingredients" VALUES (1187,108,34,2,10,1187,NULL);
INSERT INTO "recipe_ingredients" VALUES (1188,108,79,1,10,1188,NULL);
INSERT INTO "recipe_ingredients" VALUES (1189,76,14,15,6,1189,NULL);
INSERT INTO "recipe_ingredients" VALUES (1190,76,79,2,10,1190,NULL);
INSERT INTO "recipe_ingredients" VALUES (1191,76,64,1,10,1191,NULL);
INSERT INTO "recipe_ingredients" VALUES (1192,76,49,1,3,1192,NULL);
INSERT INTO "recipe_ingredients" VALUES (1193,76,95,1,9,1193,NULL);
INSERT INTO "recipe_ingredients" VALUES (1194,111,84,10,6,1194,NULL);
INSERT INTO "recipe_ingredients" VALUES (1195,111,49,2,6,1195,NULL);
INSERT INTO "recipe_ingredients" VALUES (1196,112,101,10,6,1196,NULL);
INSERT INTO "recipe_ingredients" VALUES (1197,112,49,2,6,1197,NULL);
INSERT INTO "recipe_ingredients" VALUES (1198,110,106,10,6,1198,NULL);
INSERT INTO "recipe_ingredients" VALUES (1199,110,49,2,6,1199,NULL);
INSERT INTO "recipe_ingredients" VALUES (1200,113,106,9,6,1200,NULL);
INSERT INTO "recipe_ingredients" VALUES (1201,113,86,10,3,1201,NULL);
INSERT INTO "recipe_ingredients" VALUES (1202,113,24,0.75,3,1202,NULL);
INSERT INTO "recipe_ingredients" VALUES (1203,113,74,3.8,6,1203,NULL);
INSERT INTO "recipe_ingredients" VALUES (1204,113,93,3,10,1204,NULL);
INSERT INTO "recipe_ingredients" VALUES (1205,113,95,2.5,3,1205,NULL);
INSERT INTO "recipe_ingredients" VALUES (1206,61,11,1,2,1206,NULL);
INSERT INTO "recipe_ingredients" VALUES (1207,61,97,1,9,1207,NULL);
INSERT INTO "recipe_ingredients" VALUES (1208,61,98,3,9,1208,NULL);
INSERT INTO "recipe_ingredients" VALUES (1209,61,17,100,4,1209,NULL);
INSERT INTO "recipe_ingredients" VALUES (1210,16,85,0.5,5,1210,NULL);
INSERT INTO "recipe_ingredients" VALUES (1211,16,30,17,6,1211,NULL);
INSERT INTO "recipe_ingredients" VALUES (1212,16,5,0.5,6,1212,NULL);
INSERT INTO "recipe_ingredients" VALUES (1213,16,49,2.75,7,1213,NULL);
INSERT INTO "recipe_ingredients" VALUES (1214,16,59,1,6,1214,NULL);
INSERT INTO "recipe_ingredients" VALUES (1215,16,95,0.75,9,1215,NULL);
INSERT INTO "recipe_ingredients" VALUES (1216,16,10,8,6,1216,NULL);
INSERT INTO "recipe_ingredients" VALUES (1248,1,65,6,2,1,-1);
INSERT INTO "recipe_ingredients" VALUES (1249,1,46,12.5,6,0,-1);
INSERT INTO "recipe_ingredients" VALUES (1250,1,95,6,5,2,-1);
INSERT INTO "recipe_ingredients" VALUES (1276,74,59,1,6,0,NULL);
INSERT INTO "recipe_ingredients" VALUES (1277,74,113,0.5,6,1,NULL);
INSERT INTO "recipe_ingredients" VALUES (1278,74,46,17,6,3,NULL);
INSERT INTO "recipe_ingredients" VALUES (1279,74,72,1,2,4,NULL);
INSERT INTO "recipe_ingredients" VALUES (1280,74,63,3.5,6,2,NULL);
INSERT INTO "recipe_ingredients" VALUES (1281,74,49,0.5,6,5,NULL);
INSERT INTO "recipe_ingredients" VALUES (1282,74,41,2,10,6,NULL);
INSERT INTO "recipe_ingredients" VALUES (1283,74,6,10,6,0,6);
INSERT INTO "recipe_sections" VALUES (6,74,'Dumplings',0);
INSERT INTO "recipes" VALUES (1,'SAUSAGE GRAVY','165F','protein','8oz','','breakfast','In a large pan mix peppered gravy per package directions
Heat MST and add to gravy mix
Heat to 165 degree
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Sausage Patty',100,NULL);
INSERT INTO "recipes" VALUES (2,'WESTERN SCRAMBLED EGGS','165F','protein','5 oz','130','breakfast','Add all ingredients and heat to 165 degrees 
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','',100,NULL);
INSERT INTO "recipes" VALUES (3,'SWEET GRITS','165F','Starch','8oz','195','breakfast','Bring water to boil on large pot/tilt skillet
Add salt , pepper and margarine
Slowly add grits, while constantly stirring to avoid lumps
Bring back to a boil, reduce heat.
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Rice',100,NULL);
INSERT INTO "recipes" VALUES (4,'SWEET OATMEAL','165 degrees','Starch','8oz','120','breakfast','In a large pan, bring water to a boil

Add syrup and margarine to water

Slowly at oatmeal, while stirring constantly to avoid clumping

Bring back to a boil

Serve hot or hold at 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (5,'MUFFIN','165F','bread','1/54 cut Grid Cut','','breakfast','Follow Instructions on bag. Add margarine.  Bake

Use grid to cut, based on menus grid size.

Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (6,'COFFEE CAKE','N/A','dessert','1/54 cut','260','breakfast','Make your yellow cake mix following the instructions on the bag (5lbs of mix to 5 cups of water per pan)

Pour cake mix into greased sheet pans and level

In a separate bowl, mix oats, white Sugar, cinnamon, flour and softened margarine

With gloves on, hand mix crumble topping

Sprinkle on top of each cake pan

Bake at 350 dgrees for 15-20 minutes','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (7,'MAPLE PANCAKE SQUARE','165F','bread','Grid Cut 1/54','193.0','breakfast','Follow Instructions on bag

Swirl in syrup evenly across the top of pancake batter.

Use grid to cut, based on menus grid size.

Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (14,'OKIE CEREAL BAR','N/A','Dessert','1/48 cut','','breakfast','HEAT SYRUP, PEANUT BUTTER TIL SMOOTH ADD VANILLA.  ADD CINNAMON AND SALT

POUR OVER CEREAL PRESS INTO PAN  CHILL','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (15,'RICE','165F','Starch','8oz','','breakfast','In a large pot/tilt skillet, add all ingredients but the rice, and stir

Bring to a boil

Add rice and stir

Cover and cook for 10-15 minutes

Remove from heat and let stand for 10-15 minutes

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (16,'ASIAN BEEF','165F','protein','4oz','296 calories','entrees','In large pan,  melt margarine																
Add diced peppers and onions, sauté, stir frequently 																
Add sweet & sour sauce and water, heat to 165 degrees.																
Add ends and pieces and heat in oven to 165 degrees (DO NOT OVERCOOK)																
Serve hot or hold above 140 degrees																
																
SERVING NOTES:																
Tray up broccoli in separate hole. Tray rice in large hole, top with 3oz vegetable sauce.  																
 																
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Meatballs,',100,'25g');
INSERT INTO "recipes" VALUES (17,'CAJUN BEANS','165F','Starch','10oz','344','entrees','Inspect beans for rocks, sticks prior to rinse.

Rinse and soak beans overnight in large pan/pot or tub

2 hrs before service start cooking beans, until tender.

Add MST and cook until reaches 165 degrees

In a separate pan, saute onions and bell peppers

Add onions, peppers, tomatoes and blackened seasoning to beans.

Simmer for 10 minutes

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:  MSC, Ground Chicken',100,NULL);
INSERT INTO "recipes" VALUES (18,'BBQ MEATBALLS','165F','Protein','3oz (6 meatballs per serving)','215.0','entrees','In a hotel pan, heat water and BBQ sauce to a boil.

Pan up meatballs and heat in oven until 165 degrees.  (DO NOT OVER COOK)

Pour sauce over meatballs and put back into oven, heat until 165 degrees

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (19,'BBQ TURKEY','165F','Protein','4oz','275.0','entrees','Heat turkey to above 165 degrees.

Chop turkey by hand or shred in mixer.

Combine water, BBQ sauce and turkey and heat up to above 165 degrees

BLAND DIET:  No BBQ sauce','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (20,'CHICKEN A LA KING','165F','protein','4oz','182cal 11g protein','entrees','In a large pan/tilt skillet, melt margarine

Add celery, bell peppers and onions, saute

Add water to the celery and carrots.  Add chicken, salt and pepper

Bring to a boil

Add peas, return to a boil

In a bowl mix gravy with cold water until smooth

Add gravy slurry to boiling mixture, stirring until thickened

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Turkey Ends & Pieces, Diced Chicken',100,NULL);
INSERT INTO "recipes" VALUES (21,'CHICKEN FRIED RICE','165F','Protein','10oz','416.0','entrees','In a large pot/tilt skillet, add water, salt, carrots, peas, and stir

Bring to a boil

Add Ends and Pieces and cook for 10 minutes.  Add rice and stir, cook for additional 10 minutes.

Remove from heat and let stand for 10-15 minutes

In a separate pan, saute onions in oil.   

Add soy sauce  and onions to rice

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:  MSC, Ground Chicken',100,NULL);
INSERT INTO "recipes" VALUES (22,'SWEET & SOUR CHICKEN','165F','protein','4oz ','194.0','entrees','In a large pot/tilt skillet, melt margarine in pan with peppers and onions, saute

Add chicken & water, heat to 165 degrees

Cook off water, add sweet & sour sauce. Heat to 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:  Ground Chicken, MSC',100,NULL);
INSERT INTO "recipes" VALUES (23,'CHILI CON CARNE','165F','Protein','10 OZ','','entrees','Add dry beans to kettle and cover beans with water 6 inches above surface of beans.

Retain bean cooking liquid..

Remove beans and hold.

Turn heat back on and cook at a low simmer until tender, approximately one more hour.

Bring water to a boil, turn off heat and allow beans to soak in hot water for one hour.

Combine fully thawed MST and onion. Cook and stir until pink is gone

Add all remaining ingredients including beans, heat to a simmer, pan and serve

GLUTEN RESTRICTED:  No cheese','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MSC, Chicken Sliced/Diced, Turkey Ends and Pieces,',100,NULL);
INSERT INTO "recipes" VALUES (24,'TURKEY GUMBO','165F','protein','4 OZ ','347 Calories','entrees','Heat turkey to above 165 degrees.

Chop turkey by hand or shred in mixer.

In a large pan/tilt skillet, melt margarine and add peppers, celery, carrots and onions, saute ingredients

Add water to vegetables, then add turkey, tomatoes, blackened seasoning, salt and pepper, bring to a boil

In a bowl, mix gravy with cold water until smooth. 

Add gravy slurry to boiling mixture and stir until thickened 

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:  MSC, Ground Chicken',100,NULL);
INSERT INTO "recipes" VALUES (25,'CHILI MAC','165F','protein','12 0Z  ','501 cal','entrees','Inspect beans for rocks, sticks prior to rinse.

Rinse and soak beans overnight in large pan/pot or tub

2 hrs before service start cooking beans, until tender.  Drain water.

In another pan, partially brown meat, then add margarine, bell peppers and onion.

Once the vegetables are tender, add flour and stir well

In a separate pan, add water and cook pasta, drain and set aside

Add remaining ingredients to meat mixture , except beans.  Cook until thickened up

Once beans are fully cooked, add bean and pasta to mixture and stir thoroughly','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Chicken Sliced/Diced, Turkey Ends and Pieces, MST/MSC',100,NULL);
INSERT INTO "recipes" VALUES (26,'MEATBALLS - GRAVY','165F','Protein','3oz (6 meatballs per serving)    ','205.0','entrees','Heat turkey to above 165 degrees.

Chop turkey by hand or shred in mixer.

In a large pan/tilt skillet, melt margarine and add peppers, celery, carrots and onions, saute ingredients

Add water to vegetables, then add turkey, tomatoes, blackened seasoning, salt and pepper, bring to a boil

In a bowl, mix gravy with cold water until smooth. 

Add gravy slurry to boiling mixture and stir until thickened 

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (27,'MEATBALLS  - SWEET & SOUR','165F','Protein','3oz (6 meatballs per serving)  ','224.0','entrees','Bring water and sweet & sauce to a boil in pan.

Pan up meatballs and cook in oven until temp reaches 165 degrees

Pour sauce over meatballs and put back into oven, heat until 165 degrees

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (28,'NACHO MEAT W/ BEANS','165F','Protein','8oz','','entrees','Inspect beans for rocks, sticks prior to rinse.

Rinse and soak beans overnight in large pan/pot or tub

2 hrs before service start cooking beans, until tender.

Drain Water

Add onions, pepper and taco seasoning to beans, simmer for 20 minutes (DON’T BURN BEANS)

Use a masher/mixer to mash the beans

In another pan, cook meat, then add to beans. Heat to 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MSC, Chicken Sliced/Diced, Turkey Ends and Pieces,',100,NULL);
INSERT INTO "recipes" VALUES (29,'PASTA BAKE','165F','Starch','10oz ','434.0','entrees','In a large pot/tilt skillet, brown MST, heat to 165 degrees and drain.

Add margarine to pan, melt and saute celery, peppers, and onions

Mix pasta with remaining ingredients, stir to combine

Heat mixture to 165 degrees

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (30,'STEAK BITES','165F','Protein','3oz','','entrees','Pan up steak bites and cook in oven until temp reaches 165 degrees, don’t overcook

Make gravy per package directions

Pour gravy over steak bites and put back into oven,

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MSC, Ground Chicken',100,NULL);
INSERT INTO "recipes" VALUES (31,'SLOPPY JOE','165F','Protein','4oz    ','341.0','entrees','In a large pan/tilt skillet, brown meat

Add  peppers and onions and saute

Add remaining ingredients.  Cook until thickened up and 165 degrees

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MSC, Ground Chicken',100,NULL);
INSERT INTO "recipes" VALUES (32,'GRAVY','165F','Sauce','2oz','','entrees','Follow directions on gravy package

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (33,'STROGANOFF','165F','protein','4oz  ','338 cal 13 Protein','entrees','In a pan/tilt skillet, partially brown meat, then add margarine, bell peppers and onion.

Mix gravy, per package instructions in separate pot.

Mix in pasta, meat, gravy with remaining ingredients and combine.

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MST, Taco Meat, Ground Chicken',100,NULL);
INSERT INTO "recipes" VALUES (34,'TACO MEAT','165F','protein','4oz ','280.0','entrees','In a large pan/tilt skillet brown MST to 165 degrees

Add onions and taco seasoning, stir well

Serve hot or hold above 140 dgrees

GLUTEN RESTRICTED:    No cheese	','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Taco Meat, MSC',100,NULL);
INSERT INTO "recipes" VALUES (35,'TURKEY MAC & CHEESE','165F','protein','10oz     ','499.0','entrees','Heat up diced ham to 165 degrees using stock pot/tilt skillet

In separate pot heat 5 qts of water to a boil, mix 1 qt of cold water to bag of gravy mix. Stir in cheese sauce until smooth

Mix turkey ham and cooked pasta together.  

Add salt and pepper and mix sauce with pasta/turkey.

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Chicken Sliced/Diced, Turkey Ends and Pieces, MST/MSC',100,NULL);
INSERT INTO "recipes" VALUES (36,'TURKEY POT PIE','165F','Protein','10 OZ','','entrees','Heat turkey to above 165 degrees.

Chop turkey by hand or shred in mixer.

In a large pan/tilt skillet, melt margarine and add celery, carrots and onions, saute ingredients

Add water to veggies, then add potatoes, turkey and salt/pepper

Bring to a boil

Add peas, return to boil

In a bowl mix gravy bag and cold water til smooth, adding gravy slurry to boiling mixture.  Stir until thickened

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Chicken Sliced/Diced, Turkey Ends and Pieces, MST/MSC; Sliced Potatoes. Shredded Potatoes',100,NULL);
INSERT INTO "recipes" VALUES (37,'ROASTED TURKEY','165F','Protein','4oz  ','290.0','entrees','Heat turkey to above 165 degrees.

Chop turkey by hand or shred in mixer.

Combine water and turkey and heat up to above 165 degrees

Cook off most of the water and add poultry gravy

Stir well

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','Chicken: Sliced/Diced',100,NULL);
INSERT INTO "recipes" VALUES (38,'TURKEY TETRAZINI','165F','protein','4oz','669.0','entrees','Cook and drain pasta

Brown MST in a large pan/tilt skillet

Add margarine to pan, melt, saute onions and bell peppers.  Add salt.

In a bowl mix gravy bag and cold water til smooth, adding gravy slurry to boiling mixture.  Stir until thickened

Add cheese sauce, stirring until smooth.  

Heat to 165 degrees

Serve hot or hold above 140 degrees','','',100,NULL);
INSERT INTO "recipes" VALUES (39,'MEATBALLS MARINARA SAUCE','165F','Sauce/Gravy','3oz','','entrees','Put all ingredients into pan and simmer.  Stir frequently

Cover and heat to 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (40,'MEAT SAUCE','165F','Sauce/Gravy','6oz','','entrees','In a large pan/tilt skillet, brown off MST, cooking off excess liquid

Put all ingredients into pan and simmer.  Stir frequently

Cover and heat to 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (41,'TURKEY CASSEROLE','165F','Protein','6oz','','entrees','LAYER VEGETABLES IN ORDER GIVEN.  SEASON WITH SALT AND PEPPER.  PUT COOKED MST ON TOP OF VEGGIES.  POUR SAUCE OVER ALL

BAKE AT 350 DEGREES FOR 2 HOURS

 

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (42,'TURKEY AUGRATIN','165F','sauce/gravy','12 oz','548 cals','entrees','COOK MST WITH ONIONS. LAYER HALF THE POTATOES AND SEASON;  ADD HALF THE ONION AND MST; TOP WITH HALF CHEESE SAUCE;  REPEAT.  

BAKE AT 350 DEGREES FOR 2 HOURS	 

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (43,'SPANISH RICE AND BEANS','165F','sauce/gravy','12oz','398','entrees','SAUTE ONION; ADD SEASONING.  STIR IN RICE.  STIR IN SALSA AND BEANS; COOK TIL RICE AND BEANS ARE TENDER	

BAKE AT 350 DEGREES FOR 2 HOURS	

GLUTEN RESTRICTED DIET:  No cheese sauce	

Serve hot or hold above 140 degrees	','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,'16');
INSERT INTO "recipes" VALUES (44,'STUFFED PEPPER CASSEROLE','165F','sauce/gravy','4oz','375','entrees','SAUTE ONION ADD MST.  DRAIN, ADD PEPPERS ADD SEASONING, TOMATOES,  BRING TO A BOIL;  				
BAKE AT 350 DEGREES FOR 30 minutes				
 				
Serve hot or hold above 140 degrees				
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,'27');
INSERT INTO "recipes" VALUES (45,'CAJUN CHICKEN','165F','sauce/gravy','4 oz ','311','entrees','COOK PASTA.    
SEASON AND COOK ENDS/PIECES; SAUTE ONIONS; ADD TOMATOES ADD GRAVY AND CHEESE SAUCE; ADD CHICKEN				
 				
 				
Serve hot or hold above 140 degrees				
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,'21');
INSERT INTO "recipes" VALUES (46,'CINNCINATI CHILI','165F','sauce/gravy','4 oz','328.0','entrees','Place MST in a large pan, cover with cold water, and bring to a boil, stirring and breaking up with a fork to a fine texture. Slowly boil until meat is thoroughly cooked, about 30 minutes.
														
Add onions, tomato sauce, vinegar, spices, Worcestershire sauce, and chocolate. Stir in chili powder, salt, cumin, cinnamon, and cayenne pepper until well mixed. 																			
Bring to a boil, reduce heat to a simmer, and cook, stirring occasionally, for 3 hours. 

Add water if necessary to prevent chili from burning																			
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,'17');
INSERT INTO "recipes" VALUES (47,'TURKEY SALAD','40 F','Entrée','3 OZ','','entrees','Mix all ingredients together.  Chill at 41 degrees or less','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (48,'SWISS PATTY','165F','protein','3oz     ','201.0','entrees','In a large pan mix brown gravy per package directions			
Add seasonings to gravy			
Place meatloaf patties in hotel pan and cover patties with gravy			
Bake until patties reach 165 degrees			
Serve hot or hold above 140 degrees			
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (49,'SALISBURY PATTY','165F','protein','3oz   ','187.0','entrees','In a large pan mix brown gravy per package directions			
Add seasonings to gravy			
Place meatloaf patties in hotel pan and cover patties with gravy			
Bake until patties reach 165 degrees			
Serve hot or hold above 140 degrees			
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100,NULL);
INSERT INTO "recipes" VALUES (50,'PEPPER PATTY','165F','Protein','3oz   ','199.0','entrees','In a large pan mix brown gravy per package directions

Add onions and green peppers to gravy

Place patties in hotel pan and cover patties with gravy

Bake until patties reach 165 degrees

Serve hot or hold above 140 dgrees','2.5 Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100,NULL);
INSERT INTO "recipes" VALUES (51,'HOT DOG','165F','Protein','2.0','300.0','entrees','Bring water to a boil.  Add hot dogs.  Bring back to a full boil and heat for 10 minutes

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (52,'BREADED CHICKEN PATTY','165F','Protein','3oz','180.0','entrees','In a large pan mix gravy per package directions

Place patties in hotel pan and cover patties with gravy

Bake until patties reach 165 degrees

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100,NULL);
INSERT INTO "recipes" VALUES (53,'JAMBALAYA SAUSAGE','165F','protein','4oz  ','282.0','entrees','Saute Onions and Celery until tender
Add salt, herbs and spices.  Cook and stir for 2 minutes
Add Tomatoes, paste, water and GRAVY MIX.  Stir well, bring to a simmer, cover and cook for 30 minutes.  Stir occasionally
Add diced sausage.  When all liquid is absorbed , pan for service
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Turkey Ends & Pieces, Diced Chicken',100,'25');
INSERT INTO "recipes" VALUES (54,'BURRITO BOWL','165F','protein','12 oz','342','entrees','In a large pan/tilt skillet brown MST to 165 degrees			
Add onions and taco seasoning, stir well			
Make cheese sauce per package directions			
			
Serve hot or hold above 140 degrees			
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Taco Meat, MSC',100,NULL);
INSERT INTO "recipes" VALUES (55,'CHUCKWAGON PATTY','165F','protein','3oz','220.0','entrees','In a large pan/tilt skillet brown MST to 165 degrees
Add onions and taco seasoning, stir well
Make cheese sauce per package directions.  Add to MST,  Heat to 165 degrees.   
Serve on top of Lettuce
Serve hot or hold above 140 degrees
GLUTEN RESTRICTED:  No cheese','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100,NULL);
INSERT INTO "recipes" VALUES (56,'BEEF PATTY','165F','Protein','3oz  ','160.0','entrees','Place patties in hotel pan. 

Bake until patties reach 165 degrees

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100,NULL);
INSERT INTO "recipes" VALUES (57,'BEEF STEW','165F','Protein','10 OZ LADLE  ','415.0','entrees','1.  MELT MARGARINE IN KETTLE.  Add celery and onions.  Saute until tender

2.  Add seasoning.  Saute one minute

3.  Combine water and  gravy mix.  Add to kettle. Simmer and blend til well mixed.  Add fully cooked MST.  Return to simmer for 15 minutes.

4.  Thaw vegetables in warm water.  Drain well.  Add to meat mixture and return to simmer.

5.  Pan and Serve','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100,NULL);
INSERT INTO "recipes" VALUES (58,'OKIE CASSEROLE','165F','protein','10 OZ ','620.0','entrees','1.  BROWN MST TIL INTERNAL TEMPERATURE REACHES 165 DEGREES F. FOR 15 SECONDS.  DRAIN OFF EXCESS FAT.

2.  ADD ONIONS, COOK UNTIL TENDER

3.  ADD SEASONINGS AND TOMATOES.  SIMMER 30 MINUTES OR UNTIL THICK

4.  SCALE MEAT MIXTURE INTO 12X20X2 INCH PANS; 9 LBS PER PAN

5.  PREPARE CHEESE SAUCE.  POUR OVER EACH PAN.

5.  PREPARE BISCUIT MIX ACCORDING TO DIRECTIONS.   

6.  USING A #20 DIPPER, PLACE BISCUIT TOPPING 4X6 OVER MEAT MIXTURE JUST BEORE BAKING.

7.  BAKE AT 400 DEGREES f. FOR 30-35 MINUTES.  Allow to rest for 5 minutes.  Cut into 4x6 pieces.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100,NULL);
INSERT INTO "recipes" VALUES (59,'POLISH SAUSAGE','165F','protein','3oz','300.0','entrees','Bring water to a boil.  Add hot dogs.  Bring back to a full boil and heat for 10 minutes			
Serve hot or hold above 140 degrees			
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (60,'CREAMED CHICKEN','40F','protein','4oz','225','entrees','In a large pan/tilt skillet, melt margarine; saute onions

Add water to the vegetables, then chicken, salt and pepper

Bring to a boil

In a bowl mix gravy with cold water until smooth

Add gravy slurry to boiling mixture, stirring until thickened

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Turkey Ends & Pieces, Diced Chicken',100,'19');
INSERT INTO "recipes" VALUES (61,'CHARBROIL PATTY - GRAVY','165F','protein','3oz','','entrees','Bring hot water to a boil in pan.

In a bowl mix gravy bag and cold water til smooth, adding gravy slurry to boiling mixture.  Stir until thickened

Pan up dinner loaf patties and cook in oven until temp reaches 165 degrees

Pour gravy over dinner loaf patties and put back into oven, heat until 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (62,'MEATLOAF PATTY - BBQ','165F','protein','3oz','197 Calories','entrees','Bring hot water to a boil in pan.
In a bowl mix gravy bag and cold water til smooth, adding gravy slurry to boiling mixture.  Stir until thickened
Pan up dinner loaf patties and cook in oven until temp reaches 165 degrees
Pour gravy over dinner loaf patties and put back into oven, heat until 165 degrees
Serve hot or hold above 140 degrees
BLAND DIET:  No BBQ sauces','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (63,'GOULASH','165F      ','protein','12 OZ','449','entrees','1.  PLACE 1 GALLON OF WATER FOR EACH POUND OF MARCARONI AND 1 OZ OF SALT PER GALLON OF WATER.  BRING TO A HARD BOIL.  ADD MARCARONI.  STIR ONCE EVERY MINUTE UNTIL WATER RETURNS TO  A BOIL.  CONTINUE COOKING AND STIRRING OCCASIONALLY UNTIL MACARONI IS TENDER.  DO NOT OVERCOOK.  DRAIN WATER AND COOL MARCARONI WITH COLD RUNNING WATER.																			
2.  PLACE MEAT AND ONIONS IN KETTLE.  HEAT AND STIR UNTIL MEAT IS BROWN AND REACHES AN INTERNALTEMPERATURE OF 165 DEGREES FOR 15 SECONDS.																			
3.  ADD WATER,TOMATOES, GRAVY MIX, AND SEASONINGS.  WHIP UNTIL FULLY INCORPORATED.  RETURN TO A SIMMER																			
4.  ADD MACARONI AND FOLD TOGETHER.  HEAT ENTIRE MIXTURE TO 165 F.  TASTE.  ADD SALT IF NECESSARY.  PAN AND SERVE.																			
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands									
Use clean and sanitized utensils/equipment while prepping/cooking									
Return ingredients to refrigerated storage if preparation is interrupted									
','In order of availability:',100,'23');
INSERT INTO "recipes" VALUES (64,'TURKEY ITALIAN','165F','Sauce/Gravy','4 OZ      ','180.0','entrees','MAKE GRAVY PER PACKAGE DIRECTIONS.  ADD SEASONING.  ADD ENDS/PIECES.

BAKE AT 350 DEGREES FOR 2 HOURS

 

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (65,'CORNBREAD TURKEY','165F','protein','12oz ','434','entrees','TOAST CUBED CORNBREAD.  COOL.  SAUTE VEGGIES.  STIR IN CORNBREAD, END/PIECES, GRAVY AND SEASONINGS.  COOK TIL REACHES 165 DEGREES									
Add water to the vegetables, then chicken, salt and pepper									
Bring to a boil									
In a bowl mix gravy with cold water until smooth									
Add gravy slurry to boiling mixture, stirring until thickened									
Serve hot or hold above 140 degrees									
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Turkey Ends & Pieces, Diced Chicken',100,NULL);
INSERT INTO "recipes" VALUES (66,'BEAN STEW','165F','Starch','10 OZ ','346.0','entrees','PREPARE BEANS PER PACKAGE.  SAUTE ONIONS, ADD SEASONING  COMBINE BEANS AND MST.  ADD REMAINING INGREDIENTS

Rinse and soak beans overnight in large pan/pot or tub

2 hrs before service start cooking beans, until tender.

Add MST and cook until reaches 165 degrees

In a separate pan, saute onions and bell peppers

Add onions, peppers, tomatoes and blackened seasoning to beans.

Simmer for 10 minutes

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:  MSC, Ground Chicken',100,NULL);
INSERT INTO "recipes" VALUES (67,'TURKEY RICE CASSEROLE','165F','sauce/gravy','12 OZ ','417','entrees','SAUTE ONION; ADD SEASONING.  STIR IN RICE AND GRAVY.  STIR IN TURKEY; COOK TIL TENDER				
BAKE AT 350 DEGREES FOR 2 HOURS				
 				
Serve hot or hold above 140 degrees				
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,'24');
INSERT INTO "recipes" VALUES (68,'TAMALE PIE','165F','protein','12 OZ ','744.0','entrees','Inspect beans for rocks, sticks prior to rinse.  Rinse and soak beans overnight in large pan/pot or tub												
2 hrs before service start cooking beans, until tender.												
Drain Water												
Add onions, pepper and taco seasoning to beans, simmer for 20 minutes (DON’T BURN BEANS).  Use a masher/mixer to mash the beans												
In another pan, partially brown meat, then add taco seasoning and diced onions. Heat to 165 degrees												
Mix meat and beans together and heat to 165 degrees.  Add tomatoes, corn.  Pour into steamtable pan												
Make cheese sauce per package directions.  Pour over meat mixture												
Make cornbread per package directions.  Pour batter over cheese.												
Bake at 375 degrees for 40 minutes until top is browned. Serve hot or hold above 140 degrees												
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MSC, Chicken Sliced/Diced, Turkey Ends and Pieces,',100,NULL);
INSERT INTO "recipes" VALUES (69,'SWEDISH MEATBALLS','165F','Protein','3oz (6 meatballs per serving)  ','205.0','entrees','Bring hot water to a boil in pan.

In a bowl mix gravy bag and cold water til smooth, adding gravy slurry to boiling mixture.  Stir until thickened

Pan up meatballs and cook in oven until temp reaches 165 degrees

Pour gravy over meatballs and put back into oven, heat until 165 degrees

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (70,'TURKEY TACOS','165F','protein','3oz','313.0','entrees','In a large pan/tilt skillet brown MST to 165 degrees				
Add onions and taco seasoning, stir well				
Serve hot or hold above 140 degrees				
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Taco Meat, MSC',100,NULL);
INSERT INTO "recipes" VALUES (71,'BBQ PATTY','165F','protein','3oz','160.0','entrees','Place patties in hotel pan and cover patties with sauce

Bake until patties reach 165 degrees

Serve hot or hold above 140 dgrees

BLAND DIET:  No BBQ sauce','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100,NULL);
INSERT INTO "recipes" VALUES (72,'Ranchers Bake','165F','protein','4 OZ','347','entrees','1.  PLACE 1 GALLON OF WATER FOR EACH POUND OF MARCARONI AND 1 OZ OF SALT PER GALLON OF WATER.  BRING TO A HARD BOIL.  ADD MARCARONI.  STIR ONCE EVERY MINUTE UNTIL WATER RETURNS TO  A BOIL.  CONTINUE COOKING AND STIRRING OCCASIONALLY UNTIL MACARONI IS TENDER.  DO NOT OVERCOOK.  DRAIN WATER AND COOL MARCARONI WITH COLD RUNNING WATER.																			
2.  PLACE MEAT AND ONIONS IN KETTLE.  HEAT AND STIR UNTIL MEAT IS BROWN AND REACHES AN INTERNAL TEMPERATURE OF 165 DEGREES FOR 15 SECONDS.																			
3.  ADD WATER TOMATORES GRAVY MIX AND SEASONINGS.  WHIP UNTIL FULLY INCORPORATED.  RETURN TO A SIMMER																			
4.  ADD MACARONI AND FOLD TOGETHER.  HEAT ENTIRE MIXTURE TO 165 F.  TASTE.  ADD SALT IF NECESSARY.  PAN AND SERVE.																			
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ends and pieces',100,'23');
INSERT INTO "recipes" VALUES (73,'CHOP SUEY','165F','protein','4 OZ','227','entrees','PLACE MEAT AND ONIONS IN KETTLE.  HEAT AND STIR UNTIL MEAT IS BROWN AND REACHES AN INTERNALTEMPERATURE OF 165 DEGREES FOR 15 SECONDS.

ADD VEGETABLES,  GRAVY MIX, SOY SAUCE, AND SEASONINGS.  WHIP UNTIL FULLY INCORPORATED.  RETURN TO A SIMMER

HEAT ENTIRE MIXTURE TO 165 F.  TASTE.  ADD SALT IF NECESSARY.  PAN AND SERVE.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ends and pieces',100,'22');
INSERT INTO "recipes" VALUES (74,'CHICKEN DUMPLINGS','165F      ','protein','12 OZ','530','entrees','2.  PLACE MEAT, CELERY, AND ONIONS IN KETTLE.  HEAT AND STIR UNTIL MEAT IS BROWN AND REACHES AN INTERNALTEMPERATURE OF 165 DEGREES FOR 15 SECONDS.																			
3.  ADD WATER AND GRAVY MIX AND SEASONINGS.  WHIP UNTIL FULLY INCORPORATED.  RETURN TO A SIMMER																			
4.  ADD PEAS AND FOLD TOGETHER.  HEAT ENTIRE MIXTURE TO 165 F.  TASTE.  ADD SALT IF NECESSARY.  PAN.																			
5.  MAKE BISCUIT PER PACKAGE DIRECTIONS.  SPOON ON TOP OF MIXTURE BAKE AT 350 DEGREES FOR 20 MINUTES.  SERVE																			
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ends and pieces',100,NULL);
INSERT INTO "recipes" VALUES (75,'ITALIAN CHICKEN SAUSAGE','165F','protein','4 OZ','439','entrees','PLACE MEAT AND ONIONS, GREEN PEPPERS IN KETTLE.  HEAT AND STIR UNTIL MEAT IS BROWN AND REACHES AN INTERNALTEMPERATURE OF 165 DEGREES FOR 15 SECONDS.

MAKE GRAVY MIX PER PACKAGE DIRECTIONS.  ADD SYRUP, SEASONING.  ADD TO MEAT MIXTURE

STIR WELL.

HEAT ENTIRE MIXTURE TO 165 F.  TASTE.  ADD SALT IF NECESSARY.  PAN AND SERVE.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MST',100,NULL);
INSERT INTO "recipes" VALUES (76,'CARROTS (DICED) Seasoned','165F','veggie','4oz','','veggies','Put carrots, water and remaining ingredients into a pan

Cover and heat to 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Sliced Carrots, Whipped Margarine',100,NULL);
INSERT INTO "recipes" VALUES (77,'BROCCOLI','165F','Vegetable','4oz','','veggies','In large pan,  combine all ingredients

Cover and heat to 165 degrees, stirring occasionally

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (78,'COLESLAW','MAX TEMP : 40F','Vegetable ','4oz','','veggies','In large pan,  combine all ingredients

Prepare 2 hours prior to serving and refrigerate

Serve cold, hold at 40 degree or below','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (79,'COLESLAW - SWEET & SOUR','MAX Temp: 40F','Vegetable','4oz','','veggies','In large pan,  combine all ingredients

Prepare 2 hours prior to serving and refrigerate

Serve cold, hold at 40 degree or below','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (80,'CORN','165F','Vegetable','4oz','','veggies','Put corn, water and remaining ingredients into a pan

Cover and heat to 165 degrees

Serve hot or hold above 140 degrees

MECH SOFT DIET:  Blend corn til creamed.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (81,'GREEN BEANS','165F','Vegetable','4oz','','veggies','Put green beans, water and remaining ingredients into a pan

Cover and heat to 165 degrees

Serve hot or hold above 140 degrees

MECH SOFT DIET:  Chop beans into 1/4 inch pieces.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (82,'MIXED VEGETABLES','165F','Vegetable','4oz','','veggies','Put mixed vegetables, water and remaining ingredients into a pan

Cover and heat to 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (83,'PEAS','165F','Vegetable','4oz','','veggies','Put peas, water and remaining ingredients into a pan

Cover and heat to 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (84,'GLAZED CARROTS (DICED)','165F','Vegetable','4oz','','veggies','Put carrots, water and remaining ingredients into a pan

Cover and heat to 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Sliced Carrots, Whipped Margarine',100,NULL);
INSERT INTO "recipes" VALUES (85,'BAKED BEANS','165F','starch','8oz     ','290','starch','Inspect beans for rocks, sticks prior to rinse.															
Rinse and soak beans overnight in large pan/pot or tub															
2 hrs before service start cooking beans, until tender.															
Drain Water															
Add all remaining ingredients, stir occasionally on low heat															
Heat to 165 degrees															
Serve hot or hold above 140 degrees															
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (86,'MAC & CHEESE','165F','starch','8oz  ','175','starch','In separate pot heat 5 qts of water to a boil, mix 1 qt of cold water to bag of gravy mix. Stir in cheese sauce until smooth															
Add salt and pepper and mix sauce with pasta															
Serve hot or hold above 140 degrees															
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (87,'MASHED POTATOES (4OZ)','165F','Starch','4oz','','starch','In large pot/tilt skillet, add 1/2 cold water and slowly mix in 1/2 of potato flakes

Add remaining water and heat to boil.  

Stir in salt, pepper and margarine. 

Slowly stir in remaining potatoes

Heat to 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (88,'MASHED POTATOES (8OZ)','165F','Starch','8oz','','starch','In large pot/tilt skillet, add 1/2 cold water and slowly mix in 1/2 of potato flakes

Add remaining water and heat to boil.  

Stir in salt, pepper and margarine. 

Slowly stir in remaining potatoes

Heat to 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (89,'GARLIC MASHED POTATOES','165F','Starch','8oz','','starch','In large pot/tilt skillet, add 1/2 cold water and slowly mix in 1/2 of potato flakes

Add remaining water and heat to boil.  

Stir in salt, pepper, garlic and margarine. 

Slowly stir in remaining potatoes

Heat to 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (90,'CAJUN CHEESE GRITS','165F','Starch','8oz','','starch','Bring water to boil on large pot/tilt skillet

Add salt , pepper and margarine

Slowly add grits, while constantly stirring to avoid lumps

Bring back to a boil, reduce heat.

Stir in cheese sauce and cajun seasoning

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (91,'RANCHERO BEANS','165F','starch','8oz','262','starch','Inspect beans for rocks, sticks prior to rinse.															
Rinse and soak beans overnight in large pan/pot or tub															
2 hrs before service start cooking beans, until tender.															
In a separate pan, use oil to saute onions and bell peppers															
Add onions, peppers, and blackened seasoning to beans.															
Simmer for 10 minutes or until temp reaches 165 degrees															
Serve hot or hold above 140 degrees															','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (92,'REFRIED BEANS','165F','Starch','8oz','','starch','Inspect beans for rocks, sticks prior to rinse.

Rinse and soak beans overnight in large pan/pot or tub

2 hrs before service start cooking beans, until tender.

In a separate pan, use oil to saute onions and bell peppers

Add onions, peppers,  and taco seasoning to beans.

Simmer for 10 minutes or until temp reaches 165 degrees

Put in mixer to mash beans up

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (93,'CHEESY POTATOES','165F','Starch','8oz','','starch','In a large pan, boil water and pour over potatoes

Let stand for at least 15 minutes, the longer time allowed to stand the better the yield

Drain off excess water

In a pan, gently mix water, onions and cheese sauce

Pour cheese sauce over potatoes and salt/pepper and gently fold into mix

Bake at 350 degrees for at least 30 minutes, or until reached 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (94,'FRIED POTATOES','165F','Starch','8oz','','starch','Cut potato into bitesize pieces.  

In a large pan, boil water and add potatoes

In a sheet pan, coat margarine, then scatter on sheet with onions, salt and pepper.  Top with oil

Bake at 450 degrees for at least 10 minutes, or until reached 165 degrees

Flip potatoes gently, cook for additional 5 minutes

Serve hot or hold above 140 degrees 



PREP VARIATION:

Soak potatoes in the refridgerator overnight, drain excess water and cook in oven','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (95,'GERMAN POTATO SALAD ','165F','starch','8oz','','starch','In a large pan, use oil to sauté peppers and onions															
Add in remaining ingredients except for potatoes															
Drain off excess water															
Mix well and pour over warm potatoes and stir															
Heat to 165 degrees															
Serve hot or hold above 140 degrees															
															
SERVING VARIATION:															
Can be served chilled, Follow proper HCCP cooling procedures. Serve cold or hold below 40 degrees.															
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (96,'CHEESE GRITS','165F','Starch','8oz     ','326.0','starch','Bring water to boil on large pot/tilt skillet

Add salt , pepper and margarine

Slowly add grits, while constantly stirring to avoid lumps

Bring back to a boil, reduce heat.

Stir in cheese sauce

Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (97,'HASHBROWNS','165F','Starch','8oz','','starch','In a large pan, boil water and pour over potatoes

Let stand for at least 15 minutes, the longer time allowed to stand the better the yield

Drain off excess water

In a sheet pan, coat margarine, then scatter on sheet salt and pepper.  Top with oil

Bake at 450 degrees for at least 10 minutes, or until reached 165 degrees

Flip potatoes gently, cook for additional 5 minutes

Serve hot or hold above 140 degrees ','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (98,'ELBOW NOODLES','165 degrees','Starch','8oz','','starch','In a large pan, combine all ingredients and heat to 165 and noodles are tender 

Serve hot or hold at 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (99,'SPAGHETTI NOODLES','165 degrees','Starch','8oz','','starch','In a large pan, combine all ingredients and heat to 165 and noodles are tender 

Serve hot or hold at 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (100,'ITALIAN PASTA SALAD','40 degrees','Starch','8oz','168.0','starch','In a large pan, combine all ingredients and refrigerate

Serve cold or hold at 40 degrees or less','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (101,'POTATOES OBRIEN','165F','Starch','8oz','','starch','In a large pan, boil water and pour over potatoes

Let stand for at least 15 minutes, the longer time allowed to stand the better the yield

Drain off excess water

Coat sheet pans with margarine then scatter potatoes, peppers and onions, salt and pepper.  Top with oil.

Bake in oven at 450 degrees for 10 minutes, flip potatoes gently and cook for 5 minutes or until 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (102,'CAJUN RICE','165F','Starch','8oz','','starch','In a large pot/tilt skillet, add all ingredients but the rice, and stir

Bring to a boil

Add rice and stir

Cover and cook for 10-15 minutes

Remove from heat and let stand for 10-15 minutes

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (103,'SPANISH RICE','165F','Starch','8oz','','starch','In a large pot/tilt skillet, add all ingredients but the rice, and stir

Bring to a boil

Add rice and stir

Cover and cook for 10-15 minutes

Remove from heat and let stand for 10-15 minutes

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100,NULL);
INSERT INTO "recipes" VALUES (104,'WHITE RICE','165F','Starch','8oz','','starch','In a large pot/tilt skillet, add all ingredients but the rice, and stir

Bring to a boil

Add rice and stir

Cover and cook for 10-15 minutes

Remove from heat and let stand for 10-15 minutes

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100,NULL);
INSERT INTO "recipes" VALUES (105,'BAKED BREAD','165F','bread','4oz','','starch','Pour warm water into mixer bowl, add Bread/Roll mix.  Blend on low speed for 1 minute using a dough hook															
Stop Mixer, Scrap bowl and hook															
Blend on medium speed for 7-10 minutes until dough is well mixed. Do not over mix.															
Oil top of dough and allow to rest for 10-15 minutes															
Divide dough into  workable units.  Place dough on well-floured surface and knead, incorporating flour.															
Form into 3 oz balls and place into greased pan															
Proof in a warm spot until double in size (near oven is typically a good spot)															
Bake at 350 degrees for 10-15 minutes															
Dough can be made early, divided into 3oz balls and frozen for future use.  															
To Bake, thaw, covered in fridge. Pull early in the morning and put in warm spot to proof (double in size) 															
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100,NULL);
INSERT INTO "recipes" VALUES (106,'BISCUIT','165F','bread','Grid Cut','','starch','Follow Instructions on bag

Use grid to cut, based on menus grid size.

Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100,NULL);
INSERT INTO "recipes" VALUES (107,'CORN BREAD','165F','bread','Grid Cut','','starch','Follow Instructions on bag

Use grid to cut, based on menus grid size.

Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100,NULL);
INSERT INTO "recipes" VALUES (108,'GARLIC BREAD','165F','bread','4oz','','starch','Pour warm water into mixer bowl, add Bread/Roll mix																			
Blend on low speed for 1 minute using a dough hook.  Stop Mixer, Scrap bowl and hook																			
Blend on medium speed for 7-10 minutes until dough is well mixed. Do not over mix.																			
Oil top of dough and allow to rest for 10-15 minutes																			
Divide dough into  workable units.  Place dough on well-floured surface and knead, incorporating flour.																			
Form into 3 oz balls and place into greased pan.  Proof in a warm spot until double in size (near oven is typically a good spot)																			
Bake at 350 degrees for 10-15 minutes																			
																			
Dough can be made early, divided into 3oz balls and frozen for future use.  																			
To Bake, thaw, covered in fridge. Pull early in the morning and put in warm spot to proof (double in size) 																			
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100,NULL);
INSERT INTO "recipes" VALUES (109,'CUBED POTATOES','165F','Starch','8oz','','starch','In a large pan, use oil to saute peppers and onions

Add potatoes. Stir well

Heat to 165 degrees

Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100,NULL);
INSERT INTO "recipes" VALUES (110,'Yellow Cake','165F','bread','Grid Cut 1/54','','dessert','Follow Instructions on bag

Use grid to cut, based on menus grid size.

Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ',100,NULL);
INSERT INTO "recipes" VALUES (111,'Sugar Cookie Cake','165F','bread','Grid Cut 1/54','','dessert','Follow Instructions on bag

Use grid to cut, based on menus grid size.

Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands																
Use clean and sanitized utensils/equipment while prepping/cooking																
Return ingredients to refrigerated storage if preparation is interrupted																
','In order of availability: ',100,NULL);
INSERT INTO "recipes" VALUES (112,'White Cake','165F','bread','Grid Cut','','dessert','Follow Instructions on bag

Use grid to cut, based on menus grid size.

Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ',100,NULL);
INSERT INTO "recipes" VALUES (113,'HONEY BUN COFFEE CAKE','N/A','bread','1/54 cut','500','breakfast','Make your yellow cake mix following the instructions on the bag (5lbs of mix to 5 cups of water per pan)
Pour HALF cake mix into greased sheet pans and level
In a separate bowl, mix syrup, cinnamon, powdered sugar vanilla ; pour over batter
add remaining batter;  swirl
Bake at 350 degrees for 15-20 minutes','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100,NULL);
INSERT INTO "recipes" VALUES (114,'POWDERED SUGAR GLAZE','','','1/48 cut','791.0','Dessert','Mix all ingredients until smooth, adding more water if necessary.  

Cover tightly until needed.  Stir before using','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ',100,NULL);
INSERT INTO "recipes" VALUES (115,'ICED CAKE','N/A','','1/48 cut','295.0','Dessert','Follow Instructions on bag to make cake.  

Mix until smooth, adding more water if necessary.  Allow cake to cool.  Drizzle glaze on top

Use grid to cut, based on menus grid size. Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands

Use clean and sanitized utensils/equipment while prepping/cooking

Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ',100,NULL);
INSERT INTO "recipes" VALUES (120,'Test 33','','veggie','','',NULL,'TEststst 12344','','',100,NULL);
INSERT INTO "recipes" VALUES (121,'Carl''s Chili Con Carne','165F','protein','8oz','185','entrees','1. Add dry beans to kettle and cover beans with water 6 inches above surface of beans.  Bring water to a boil, turn off heat and allow beans to soak in hot water for one hour.  Turn heat back on and cook at a low simmer until tender, approximately one more hour.  Remove beans and hold.  Retain bean cooking liquid.																			
2. Combine fully thawed MSP and onion. Cook and stir until pink is gone																			
3. Add all remaining ingredients including beans, heat to a simmer, pan and serve																			
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands																			
Use clean and sanitized utensils/equipment while prepping/cooking																			
Return ingredients to refrigerated storage if preparation is interrupted																			
','In order of availability: MSC, Chicken Sliced/Diced, Turkey Ends and Pieces, 																',100,NULL);
INSERT INTO "recipes" VALUES (122,'Italian Sauce','165F','entree','4oz','325 cal 29protein','starches','In a large pot/tilt skillet, brown MST, heat to 165 degrees and drain.																
Add margarine to pan, melt and saute peppers, and onions																
Add remaining ingredients																
Heat mixture to 165 degrees																
Serve hot or hold above 140 degrees																
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands									
Use clean and sanitized utensils/equipment while prepping/cooking									
Return ingredients to refrigerated storage if preparation is interrupted									
','',100,NULL);
INSERT INTO "recipes" VALUES (123,'Caballero Stew','165F','protein','10 oz Ladle','415',NULL,'1.  MELT MARGARINE IN KETTLE.  Add celery and onions and carrots.  Sauté until tender																			
2.  Add seasoning.  Sauté one minute																			
3.  Combine water and  gravy mix.  Add to kettle. Simmer and blend til well mixed.  Add fully cooked MST.  Return to simmer for 15 minutes.																			
4.  Thaw vegetables in warm water.  Drain well.  Add to meat mixture and return to simmer.																			
5.  Pan and Serve																			
','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands								
Use clean and sanitized utensils/equipment while prepping/cooking								
Return ingredients to refrigerated storage if preparation is interrupted								
','In order of availability: Charbroiled Patty',100,'');
INSERT INTO "units" VALUES (1,'#10',NULL,NULL,NULL);
INSERT INTO "units" VALUES (2,'bag',NULL,NULL,NULL);
INSERT INTO "units" VALUES (3,'cups',NULL,NULL,NULL);
INSERT INTO "units" VALUES (4,'ea',NULL,NULL,NULL);
INSERT INTO "units" VALUES (5,'gal',NULL,NULL,NULL);
INSERT INTO "units" VALUES (6,'lbs',NULL,NULL,NULL);
INSERT INTO "units" VALUES (7,'oz',NULL,NULL,NULL);
INSERT INTO "units" VALUES (8,'patty',NULL,NULL,NULL);
INSERT INTO "units" VALUES (9,'qts','gals',20.0,4.0);
INSERT INTO "units" VALUES (10,'tbsp','cups',24.0,16.0);
INSERT INTO "units" VALUES (11,'tsp',NULL,NULL,NULL);
DROP INDEX IF EXISTS "extensions_name_unique";
CREATE UNIQUE INDEX "extensions_name_unique" ON "extensions" (
	"name"
);
DROP INDEX IF EXISTS "ingredients_name_unique";
CREATE UNIQUE INDEX "ingredients_name_unique" ON "ingredients" (
	"name"
);
DROP INDEX IF EXISTS "units_name_unique";
CREATE UNIQUE INDEX "units_name_unique" ON "units" (
	"name"
);
