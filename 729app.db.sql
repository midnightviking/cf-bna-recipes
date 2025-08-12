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
INSERT INTO "alternate_ingredients" VALUES (6,1,65,7,2,7,'2');
INSERT INTO "alternate_ingredients" VALUES (7,1,46,3,2,7,'1');
INSERT INTO "cookbook_recipes" VALUES (1,1,1,0);
INSERT INTO "cookbook_recipes" VALUES (2,1,2,1);
INSERT INTO "cookbook_recipes" VALUES (3,1,3,2);
INSERT INTO "cookbook_recipes" VALUES (4,1,4,3);
INSERT INTO "cookbook_recipes" VALUES (5,1,5,4);
INSERT INTO "cookbook_recipes" VALUES (6,1,6,5);
INSERT INTO "cookbook_recipes" VALUES (7,1,7,6);
INSERT INTO "cookbook_recipes" VALUES (8,1,8,7);
INSERT INTO "cookbook_recipes" VALUES (9,1,9,8);
INSERT INTO "cookbook_recipes" VALUES (10,1,10,9);
INSERT INTO "cookbook_recipes" VALUES (11,1,11,10);
INSERT INTO "cookbook_recipes" VALUES (12,1,12,11);
INSERT INTO "cookbook_recipes" VALUES (13,1,13,12);
INSERT INTO "cookbook_recipes" VALUES (14,1,14,13);
INSERT INTO "cookbook_recipes" VALUES (15,1,15,14);
INSERT INTO "cookbook_recipes" VALUES (16,2,16,0);
INSERT INTO "cookbook_recipes" VALUES (17,2,17,1);
INSERT INTO "cookbook_recipes" VALUES (18,2,18,2);
INSERT INTO "cookbook_recipes" VALUES (19,2,19,3);
INSERT INTO "cookbook_recipes" VALUES (20,2,20,4);
INSERT INTO "cookbook_recipes" VALUES (21,2,21,5);
INSERT INTO "cookbook_recipes" VALUES (22,2,22,6);
INSERT INTO "cookbook_recipes" VALUES (23,2,23,7);
INSERT INTO "cookbook_recipes" VALUES (24,2,24,8);
INSERT INTO "cookbook_recipes" VALUES (25,2,25,9);
INSERT INTO "cookbook_recipes" VALUES (26,2,26,10);
INSERT INTO "cookbook_recipes" VALUES (27,2,27,11);
INSERT INTO "cookbook_recipes" VALUES (28,2,28,12);
INSERT INTO "cookbook_recipes" VALUES (29,2,29,13);
INSERT INTO "cookbook_recipes" VALUES (30,2,30,14);
INSERT INTO "cookbook_recipes" VALUES (31,2,31,15);
INSERT INTO "cookbook_recipes" VALUES (32,2,32,16);
INSERT INTO "cookbook_recipes" VALUES (33,2,33,17);
INSERT INTO "cookbook_recipes" VALUES (34,2,34,18);
INSERT INTO "cookbook_recipes" VALUES (35,2,35,19);
INSERT INTO "cookbook_recipes" VALUES (36,2,36,20);
INSERT INTO "cookbook_recipes" VALUES (37,2,37,21);
INSERT INTO "cookbook_recipes" VALUES (38,2,38,22);
INSERT INTO "cookbook_recipes" VALUES (39,2,39,23);
INSERT INTO "cookbook_recipes" VALUES (40,2,40,24);
INSERT INTO "cookbook_recipes" VALUES (41,2,41,25);
INSERT INTO "cookbook_recipes" VALUES (42,2,42,26);
INSERT INTO "cookbook_recipes" VALUES (43,2,43,27);
INSERT INTO "cookbook_recipes" VALUES (44,2,44,28);
INSERT INTO "cookbook_recipes" VALUES (45,2,45,29);
INSERT INTO "cookbook_recipes" VALUES (46,2,46,30);
INSERT INTO "cookbook_recipes" VALUES (47,2,47,31);
INSERT INTO "cookbook_recipes" VALUES (48,2,48,32);
INSERT INTO "cookbook_recipes" VALUES (49,2,49,33);
INSERT INTO "cookbook_recipes" VALUES (50,2,50,34);
INSERT INTO "cookbook_recipes" VALUES (51,2,51,35);
INSERT INTO "cookbook_recipes" VALUES (52,2,52,36);
INSERT INTO "cookbook_recipes" VALUES (53,2,53,37);
INSERT INTO "cookbook_recipes" VALUES (54,2,54,38);
INSERT INTO "cookbook_recipes" VALUES (55,2,55,39);
INSERT INTO "cookbook_recipes" VALUES (56,2,56,40);
INSERT INTO "cookbook_recipes" VALUES (57,2,57,41);
INSERT INTO "cookbook_recipes" VALUES (58,2,58,42);
INSERT INTO "cookbook_recipes" VALUES (59,2,59,43);
INSERT INTO "cookbook_recipes" VALUES (60,2,60,44);
INSERT INTO "cookbook_recipes" VALUES (61,2,61,45);
INSERT INTO "cookbook_recipes" VALUES (62,2,62,46);
INSERT INTO "cookbook_recipes" VALUES (63,2,63,47);
INSERT INTO "cookbook_recipes" VALUES (64,2,64,48);
INSERT INTO "cookbook_recipes" VALUES (65,2,65,49);
INSERT INTO "cookbook_recipes" VALUES (66,2,66,50);
INSERT INTO "cookbook_recipes" VALUES (67,2,67,51);
INSERT INTO "cookbook_recipes" VALUES (68,2,68,52);
INSERT INTO "cookbook_recipes" VALUES (69,2,69,53);
INSERT INTO "cookbook_recipes" VALUES (70,2,70,54);
INSERT INTO "cookbook_recipes" VALUES (71,2,71,55);
INSERT INTO "cookbook_recipes" VALUES (72,2,72,56);
INSERT INTO "cookbook_recipes" VALUES (73,2,73,57);
INSERT INTO "cookbook_recipes" VALUES (74,2,74,58);
INSERT INTO "cookbook_recipes" VALUES (75,2,75,59);
INSERT INTO "cookbook_recipes" VALUES (76,3,76,0);
INSERT INTO "cookbook_recipes" VALUES (77,3,77,1);
INSERT INTO "cookbook_recipes" VALUES (78,3,78,2);
INSERT INTO "cookbook_recipes" VALUES (79,3,79,3);
INSERT INTO "cookbook_recipes" VALUES (80,3,80,4);
INSERT INTO "cookbook_recipes" VALUES (81,3,81,5);
INSERT INTO "cookbook_recipes" VALUES (82,3,82,6);
INSERT INTO "cookbook_recipes" VALUES (83,3,83,7);
INSERT INTO "cookbook_recipes" VALUES (84,3,84,8);
INSERT INTO "cookbook_recipes" VALUES (85,4,85,0);
INSERT INTO "cookbook_recipes" VALUES (86,4,86,1);
INSERT INTO "cookbook_recipes" VALUES (87,4,87,2);
INSERT INTO "cookbook_recipes" VALUES (88,4,88,3);
INSERT INTO "cookbook_recipes" VALUES (89,4,89,4);
INSERT INTO "cookbook_recipes" VALUES (90,4,90,5);
INSERT INTO "cookbook_recipes" VALUES (91,4,91,6);
INSERT INTO "cookbook_recipes" VALUES (92,4,92,7);
INSERT INTO "cookbook_recipes" VALUES (93,4,93,8);
INSERT INTO "cookbook_recipes" VALUES (94,4,94,9);
INSERT INTO "cookbook_recipes" VALUES (95,4,95,10);
INSERT INTO "cookbook_recipes" VALUES (96,4,96,11);
INSERT INTO "cookbook_recipes" VALUES (97,4,97,12);
INSERT INTO "cookbook_recipes" VALUES (98,4,98,13);
INSERT INTO "cookbook_recipes" VALUES (99,4,99,14);
INSERT INTO "cookbook_recipes" VALUES (100,4,100,15);
INSERT INTO "cookbook_recipes" VALUES (101,4,101,16);
INSERT INTO "cookbook_recipes" VALUES (102,4,102,17);
INSERT INTO "cookbook_recipes" VALUES (103,4,103,18);
INSERT INTO "cookbook_recipes" VALUES (104,4,104,19);
INSERT INTO "cookbook_recipes" VALUES (105,4,105,20);
INSERT INTO "cookbook_recipes" VALUES (106,4,106,21);
INSERT INTO "cookbook_recipes" VALUES (107,4,107,22);
INSERT INTO "cookbook_recipes" VALUES (108,4,108,23);
INSERT INTO "cookbook_recipes" VALUES (109,4,109,24);
INSERT INTO "cookbook_recipes" VALUES (110,5,110,0);
INSERT INTO "cookbook_recipes" VALUES (111,5,111,1);
INSERT INTO "cookbook_recipes" VALUES (112,5,112,2);
INSERT INTO "cookbook_recipes" VALUES (113,5,113,3);
INSERT INTO "cookbook_recipes" VALUES (114,5,114,4);
INSERT INTO "cookbook_recipes" VALUES (115,5,115,5);
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
INSERT INTO "ingredients" VALUES (85,'Sweet & Sour Sauce');
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
INSERT INTO "ingredients" VALUES (108,'Magic Powder');
INSERT INTO "recipe_ingredients" VALUES (4,2,45,6.5,9);
INSERT INTO "recipe_ingredients" VALUES (5,2,5,2,6);
INSERT INTO "recipe_ingredients" VALUES (6,2,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (7,2,104,100,4);
INSERT INTO "recipe_ingredients" VALUES (8,3,38,5,9);
INSERT INTO "recipe_ingredients" VALUES (9,3,95,5,5);
INSERT INTO "recipe_ingredients" VALUES (10,3,49,6,7);
INSERT INTO "recipe_ingredients" VALUES (11,3,79,3,10);
INSERT INTO "recipe_ingredients" VALUES (12,3,7,2,10);
INSERT INTO "recipe_ingredients" VALUES (13,4,56,1.25,5);
INSERT INTO "recipe_ingredients" VALUES (14,4,95,5,5);
INSERT INTO "recipe_ingredients" VALUES (15,4,49,4,7);
INSERT INTO "recipe_ingredients" VALUES (16,4,86,1.5,3);
INSERT INTO "recipe_ingredients" VALUES (19,6,106,12.5,6);
INSERT INTO "recipe_ingredients" VALUES (20,6,57,1.25,9);
INSERT INTO "recipe_ingredients" VALUES (21,6,49,1,6);
INSERT INTO "recipe_ingredients" VALUES (22,6,86,1,3);
INSERT INTO "recipe_ingredients" VALUES (23,6,24,2,10);
INSERT INTO "recipe_ingredients" VALUES (24,6,31,1,3);
INSERT INTO "recipe_ingredients" VALUES (25,6,95,3,9);
INSERT INTO "recipe_ingredients" VALUES (26,7,61,15,6);
INSERT INTO "recipe_ingredients" VALUES (27,7,86,2,3);
INSERT INTO "recipe_ingredients" VALUES (28,7,49,8,7);
INSERT INTO "recipe_ingredients" VALUES (29,8,57,1.75,5);
INSERT INTO "recipe_ingredients" VALUES (30,8,86,0.5,5);
INSERT INTO "recipe_ingredients" VALUES (31,8,62,1.25,3);
INSERT INTO "recipe_ingredients" VALUES (32,9,16,5,3);
INSERT INTO "recipe_ingredients" VALUES (33,9,62,3.75,3);
INSERT INTO "recipe_ingredients" VALUES (34,9,86,2.5,3);
INSERT INTO "recipe_ingredients" VALUES (35,10,106,12.5,6);
INSERT INTO "recipe_ingredients" VALUES (36,10,86,10,3);
INSERT INTO "recipe_ingredients" VALUES (37,10,24,0.75,3);
INSERT INTO "recipe_ingredients" VALUES (38,10,74,2.5,9);
INSERT INTO "recipe_ingredients" VALUES (39,10,93,0.5,3);
INSERT INTO "recipe_ingredients" VALUES (40,10,95,2.5,3);
INSERT INTO "recipe_ingredients" VALUES (41,11,106,12.5,6);
INSERT INTO "recipe_ingredients" VALUES (42,11,86,1.5,9);
INSERT INTO "recipe_ingredients" VALUES (43,11,49,3,6);
INSERT INTO "recipe_ingredients" VALUES (44,11,31,1.5,9);
INSERT INTO "recipe_ingredients" VALUES (45,11,24,0.25,3);
INSERT INTO "recipe_ingredients" VALUES (46,11,79,1,10);
INSERT INTO "recipe_ingredients" VALUES (47,12,106,12.5,6);
INSERT INTO "recipe_ingredients" VALUES (48,12,49,0.75,6);
INSERT INTO "recipe_ingredients" VALUES (49,12,86,1.5,9);
INSERT INTO "recipe_ingredients" VALUES (50,12,24,0.67,3);
INSERT INTO "recipe_ingredients" VALUES (51,13,16,3,9);
INSERT INTO "recipe_ingredients" VALUES (52,13,57,1.5,9);
INSERT INTO "recipe_ingredients" VALUES (53,13,93,2,10);
INSERT INTO "recipe_ingredients" VALUES (54,13,86,3,3);
INSERT INTO "recipe_ingredients" VALUES (55,13,62,3,3);
INSERT INTO "recipe_ingredients" VALUES (56,14,16,2.5,9);
INSERT INTO "recipe_ingredients" VALUES (57,14,57,3,9);
INSERT INTO "recipe_ingredients" VALUES (58,14,93,2,10);
INSERT INTO "recipe_ingredients" VALUES (59,14,86,3,3);
INSERT INTO "recipe_ingredients" VALUES (60,14,62,1.5,9);
INSERT INTO "recipe_ingredients" VALUES (61,14,79,1,10);
INSERT INTO "recipe_ingredients" VALUES (62,14,24,2,10);
INSERT INTO "recipe_ingredients" VALUES (63,15,49,8,7);
INSERT INTO "recipe_ingredients" VALUES (64,15,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (65,15,76,2.25,5);
INSERT INTO "recipe_ingredients" VALUES (66,15,95,4.5,5);
INSERT INTO "recipe_ingredients" VALUES (67,16,4,700,4);
INSERT INTO "recipe_ingredients" VALUES (68,16,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (69,16,49,4,7);
INSERT INTO "recipe_ingredients" VALUES (70,16,85,1,5);
INSERT INTO "recipe_ingredients" VALUES (71,16,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (72,16,95,1,9);
INSERT INTO "recipe_ingredients" VALUES (73,16,10,12,6);
INSERT INTO "recipe_ingredients" VALUES (74,17,46,15,6);
INSERT INTO "recipe_ingredients" VALUES (75,17,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (76,17,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (77,17,66,5,6);
INSERT INTO "recipe_ingredients" VALUES (78,17,8,2.5,3);
INSERT INTO "recipe_ingredients" VALUES (79,17,90,1,1);
INSERT INTO "recipe_ingredients" VALUES (80,17,49,3.75,7);
INSERT INTO "recipe_ingredients" VALUES (81,18,51,600,4);
INSERT INTO "recipe_ingredients" VALUES (82,18,2,3,9);
INSERT INTO "recipe_ingredients" VALUES (83,18,95,1,9);
INSERT INTO "recipe_ingredients" VALUES (84,19,91,25,6);
INSERT INTO "recipe_ingredients" VALUES (85,19,95,1,5);
INSERT INTO "recipe_ingredients" VALUES (86,19,2,3,9);
INSERT INTO "recipe_ingredients" VALUES (87,20,20,25,6);
INSERT INTO "recipe_ingredients" VALUES (88,20,95,1.5,5);
INSERT INTO "recipe_ingredients" VALUES (89,20,64,2,10);
INSERT INTO "recipe_ingredients" VALUES (90,20,79,3,10);
INSERT INTO "recipe_ingredients" VALUES (91,20,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (92,20,63,2,6);
INSERT INTO "recipe_ingredients" VALUES (93,20,15,2,6);
INSERT INTO "recipe_ingredients" VALUES (94,20,14,4,6);
INSERT INTO "recipe_ingredients" VALUES (95,20,49,8,7);
INSERT INTO "recipe_ingredients" VALUES (96,20,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (97,20,72,1,2);
INSERT INTO "recipe_ingredients" VALUES (98,20,100,1,9);
INSERT INTO "recipe_ingredients" VALUES (99,21,76,1.75,5);
INSERT INTO "recipe_ingredients" VALUES (100,21,30,17,6);
INSERT INTO "recipe_ingredients" VALUES (101,21,95,3.5,5);
INSERT INTO "recipe_ingredients" VALUES (102,21,79,3,10);
INSERT INTO "recipe_ingredients" VALUES (103,21,63,1,6);
INSERT INTO "recipe_ingredients" VALUES (104,21,49,3,7);
INSERT INTO "recipe_ingredients" VALUES (105,21,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (106,21,13,1,6);
INSERT INTO "recipe_ingredients" VALUES (107,21,82,2.25,3);
INSERT INTO "recipe_ingredients" VALUES (108,22,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (109,22,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (110,22,28,25,6);
INSERT INTO "recipe_ingredients" VALUES (111,22,85,1,5);
INSERT INTO "recipe_ingredients" VALUES (112,22,49,4,7);
INSERT INTO "recipe_ingredients" VALUES (113,22,95,1,9);
INSERT INTO "recipe_ingredients" VALUES (114,23,46,25,6);
INSERT INTO "recipe_ingredients" VALUES (115,23,33,1.75,10);
INSERT INTO "recipe_ingredients" VALUES (116,23,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (117,23,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (118,23,31,2.5,3);
INSERT INTO "recipe_ingredients" VALUES (119,23,89,1.25,1);
INSERT INTO "recipe_ingredients" VALUES (120,23,90,1.25,1);
INSERT INTO "recipe_ingredients" VALUES (121,23,86,0.33,3);
INSERT INTO "recipe_ingredients" VALUES (122,23,21,3,3);
INSERT INTO "recipe_ingredients" VALUES (123,23,79,0.33,3);
INSERT INTO "recipe_ingredients" VALUES (124,23,18,1,2);
INSERT INTO "recipe_ingredients" VALUES (125,23,87,2.5,3);
INSERT INTO "recipe_ingredients" VALUES (126,24,91,21,6);
INSERT INTO "recipe_ingredients" VALUES (127,24,95,3,5);
INSERT INTO "recipe_ingredients" VALUES (128,24,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (129,24,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (130,24,14,2.5,6);
INSERT INTO "recipe_ingredients" VALUES (131,24,49,3,6);
INSERT INTO "recipe_ingredients" VALUES (132,24,90,1.25,1);
INSERT INTO "recipe_ingredients" VALUES (133,24,100,2.5,9);
INSERT INTO "recipe_ingredients" VALUES (134,24,72,2.5,2);
INSERT INTO "recipe_ingredients" VALUES (135,24,8,1.25,3);
INSERT INTO "recipe_ingredients" VALUES (136,25,46,15,6);
INSERT INTO "recipe_ingredients" VALUES (137,25,33,1.25,10);
INSERT INTO "recipe_ingredients" VALUES (138,25,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (139,25,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (140,25,89,1,1);
INSERT INTO "recipe_ingredients" VALUES (141,25,90,1,1);
INSERT INTO "recipe_ingredients" VALUES (142,25,86,0.25,3);
INSERT INTO "recipe_ingredients" VALUES (143,25,87,1.75,3);
INSERT INTO "recipe_ingredients" VALUES (144,25,3,1.75,6);
INSERT INTO "recipe_ingredients" VALUES (145,25,95,3,9);
INSERT INTO "recipe_ingredients" VALUES (146,25,47,10,6);
INSERT INTO "recipe_ingredients" VALUES (147,26,51,600,4);
INSERT INTO "recipe_ingredients" VALUES (148,26,11,1,2);
INSERT INTO "recipe_ingredients" VALUES (149,26,97,1,9);
INSERT INTO "recipe_ingredients" VALUES (150,26,98,3,9);
INSERT INTO "recipe_ingredients" VALUES (151,27,51,600,4);
INSERT INTO "recipe_ingredients" VALUES (152,27,85,1,9);
INSERT INTO "recipe_ingredients" VALUES (153,27,95,1,9);
INSERT INTO "recipe_ingredients" VALUES (154,28,66,6,6);
INSERT INTO "recipe_ingredients" VALUES (155,28,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (156,28,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (157,28,87,8,7);
INSERT INTO "recipe_ingredients" VALUES (158,28,95,1.5,5);
INSERT INTO "recipe_ingredients" VALUES (159,28,75,20,6);
INSERT INTO "recipe_ingredients" VALUES (160,28,46,20,6);
INSERT INTO "recipe_ingredients" VALUES (161,28,87,16,7);
INSERT INTO "recipe_ingredients" VALUES (162,28,59,2,6);
INSERT INTO "recipe_ingredients" VALUES (163,29,47,12,6);
INSERT INTO "recipe_ingredients" VALUES (164,29,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (165,29,46,20,6);
INSERT INTO "recipe_ingredients" VALUES (166,29,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (167,29,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (168,29,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (169,29,49,4,7);
INSERT INTO "recipe_ingredients" VALUES (170,29,90,1,1);
INSERT INTO "recipe_ingredients" VALUES (171,29,89,1,1);
INSERT INTO "recipe_ingredients" VALUES (172,30,4,1,4);
INSERT INTO "recipe_ingredients" VALUES (173,30,65,2,2);
INSERT INTO "recipe_ingredients" VALUES (174,30,95,2,5);
INSERT INTO "recipe_ingredients" VALUES (175,31,46,20,6);
INSERT INTO "recipe_ingredients" VALUES (176,31,43,1,1);
INSERT INTO "recipe_ingredients" VALUES (177,31,7,1,10);
INSERT INTO "recipe_ingredients" VALUES (178,31,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (179,31,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (180,31,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (181,31,86,0.33,3);
INSERT INTO "recipe_ingredients" VALUES (182,31,56,1,5);
INSERT INTO "recipe_ingredients" VALUES (183,32,35,2,2);
INSERT INTO "recipe_ingredients" VALUES (184,32,95,2,5);
INSERT INTO "recipe_ingredients" VALUES (185,33,47,10,6);
INSERT INTO "recipe_ingredients" VALUES (186,33,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (187,33,42,20,6);
INSERT INTO "recipe_ingredients" VALUES (188,33,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (189,33,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (190,33,7,1,10);
INSERT INTO "recipe_ingredients" VALUES (191,33,49,4,7);
INSERT INTO "recipe_ingredients" VALUES (192,33,11,1,2);
INSERT INTO "recipe_ingredients" VALUES (193,33,95,1,5);
INSERT INTO "recipe_ingredients" VALUES (194,34,46,20,6);
INSERT INTO "recipe_ingredients" VALUES (195,34,87,16,7);
INSERT INTO "recipe_ingredients" VALUES (196,34,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (197,34,18,1,2);
INSERT INTO "recipe_ingredients" VALUES (198,35,47,10,6);
INSERT INTO "recipe_ingredients" VALUES (199,35,19,1,2);
INSERT INTO "recipe_ingredients" VALUES (200,35,65,1,2);
INSERT INTO "recipe_ingredients" VALUES (201,35,95,6,9);
INSERT INTO "recipe_ingredients" VALUES (202,35,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (203,35,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (204,35,92,12,6);
INSERT INTO "recipe_ingredients" VALUES (205,36,91,21.25,6);
INSERT INTO "recipe_ingredients" VALUES (206,36,95,3,5);
INSERT INTO "recipe_ingredients" VALUES (207,36,64,2.5,10);
INSERT INTO "recipe_ingredients" VALUES (208,36,79,3.75,10);
INSERT INTO "recipe_ingredients" VALUES (209,36,70,7.5,6);
INSERT INTO "recipe_ingredients" VALUES (210,36,53,3.75,6);
INSERT INTO "recipe_ingredients" VALUES (211,36,49,10,7);
INSERT INTO "recipe_ingredients" VALUES (212,36,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (213,36,13,2.5,6);
INSERT INTO "recipe_ingredients" VALUES (214,36,100,2.5,9);
INSERT INTO "recipe_ingredients" VALUES (215,37,91,25,6);
INSERT INTO "recipe_ingredients" VALUES (216,37,95,1,5);
INSERT INTO "recipe_ingredients" VALUES (217,37,72,1,2);
INSERT INTO "recipe_ingredients" VALUES (218,38,83,15,6);
INSERT INTO "recipe_ingredients" VALUES (219,38,95,8,5);
INSERT INTO "recipe_ingredients" VALUES (220,38,79,2.5,10);
INSERT INTO "recipe_ingredients" VALUES (221,38,46,25,6);
INSERT INTO "recipe_ingredients" VALUES (222,38,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (223,38,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (224,38,49,5,7);
INSERT INTO "recipe_ingredients" VALUES (225,38,18,1.25,2);
INSERT INTO "recipe_ingredients" VALUES (226,38,72,1.25,2);
INSERT INTO "recipe_ingredients" VALUES (227,38,100,5,9);
INSERT INTO "recipe_ingredients" VALUES (228,39,89,3,1);
INSERT INTO "recipe_ingredients" VALUES (229,39,41,2,10);
INSERT INTO "recipe_ingredients" VALUES (230,39,33,2,10);
INSERT INTO "recipe_ingredients" VALUES (231,39,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (232,39,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (233,39,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (234,39,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (235,40,89,3,1);
INSERT INTO "recipe_ingredients" VALUES (236,40,41,2,10);
INSERT INTO "recipe_ingredients" VALUES (237,40,33,2,10);
INSERT INTO "recipe_ingredients" VALUES (238,40,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (239,40,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (240,40,46,20,6);
INSERT INTO "recipe_ingredients" VALUES (241,40,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (242,40,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (243,41,70,10,6);
INSERT INTO "recipe_ingredients" VALUES (244,41,14,5,6);
INSERT INTO "recipe_ingredients" VALUES (245,41,15,2.5,6);
INSERT INTO "recipe_ingredients" VALUES (246,41,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (247,41,36,3,1);
INSERT INTO "recipe_ingredients" VALUES (248,41,89,1,3);
INSERT INTO "recipe_ingredients" VALUES (249,41,46,15,6);
INSERT INTO "recipe_ingredients" VALUES (250,41,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (251,42,70,15,6);
INSERT INTO "recipe_ingredients" VALUES (252,42,46,15,6);
INSERT INTO "recipe_ingredients" VALUES (253,42,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (254,42,18,2,2);
INSERT INTO "recipe_ingredients" VALUES (255,42,72,1,2);
INSERT INTO "recipe_ingredients" VALUES (256,42,41,3,3);
INSERT INTO "recipe_ingredients" VALUES (257,43,49,2,3);
INSERT INTO "recipe_ingredients" VALUES (258,43,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (259,43,87,2.5,3);
INSERT INTO "recipe_ingredients" VALUES (260,43,76,2,5);
INSERT INTO "recipe_ingredients" VALUES (261,43,78,1,1);
INSERT INTO "recipe_ingredients" VALUES (262,43,3,13,6);
INSERT INTO "recipe_ingredients" VALUES (263,43,18,2,2);
INSERT INTO "recipe_ingredients" VALUES (264,44,49,2,3);
INSERT INTO "recipe_ingredients" VALUES (265,44,46,15,6);
INSERT INTO "recipe_ingredients" VALUES (266,44,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (267,44,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (268,44,41,2,10);
INSERT INTO "recipe_ingredients" VALUES (269,44,105,2,10);
INSERT INTO "recipe_ingredients" VALUES (270,44,90,3,1);
INSERT INTO "recipe_ingredients" VALUES (271,44,76,12,6);
INSERT INTO "recipe_ingredients" VALUES (272,44,18,1,2);
INSERT INTO "recipe_ingredients" VALUES (273,45,76,20,6);
INSERT INTO "recipe_ingredients" VALUES (274,45,91,12,6);
INSERT INTO "recipe_ingredients" VALUES (275,45,8,0.25,3);
INSERT INTO "recipe_ingredients" VALUES (276,45,49,3,10);
INSERT INTO "recipe_ingredients" VALUES (277,45,58,1,6);
INSERT INTO "recipe_ingredients" VALUES (278,45,90,2,1);
INSERT INTO "recipe_ingredients" VALUES (279,45,72,1,2);
INSERT INTO "recipe_ingredients" VALUES (280,45,18,1,2);
INSERT INTO "recipe_ingredients" VALUES (281,46,46,20,6);
INSERT INTO "recipe_ingredients" VALUES (282,46,95,5,5);
INSERT INTO "recipe_ingredients" VALUES (283,46,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (284,46,89,1,1);
INSERT INTO "recipe_ingredients" VALUES (285,46,94,1.25,3);
INSERT INTO "recipe_ingredients" VALUES (286,46,32,0.5,3);
INSERT INTO "recipe_ingredients" VALUES (287,46,105,0.33,3);
INSERT INTO "recipe_ingredients" VALUES (288,46,22,5,7);
INSERT INTO "recipe_ingredients" VALUES (289,46,8,2,3);
INSERT INTO "recipe_ingredients" VALUES (290,46,79,1,10);
INSERT INTO "recipe_ingredients" VALUES (291,47,91,15,6);
INSERT INTO "recipe_ingredients" VALUES (292,47,77,2,9);
INSERT INTO "recipe_ingredients" VALUES (293,47,59,2,6);
INSERT INTO "recipe_ingredients" VALUES (294,47,15,2,6);
INSERT INTO "recipe_ingredients" VALUES (295,48,11,2,2);
INSERT INTO "recipe_ingredients" VALUES (296,48,41,2,10);
INSERT INTO "recipe_ingredients" VALUES (297,48,98,6,9);
INSERT INTO "recipe_ingredients" VALUES (298,48,97,2,9);
INSERT INTO "recipe_ingredients" VALUES (299,48,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (300,48,52,100,8);
INSERT INTO "recipe_ingredients" VALUES (301,48,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (302,48,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (303,49,11,2,2);
INSERT INTO "recipe_ingredients" VALUES (304,49,41,2,10);
INSERT INTO "recipe_ingredients" VALUES (305,49,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (306,49,52,100,8);
INSERT INTO "recipe_ingredients" VALUES (307,50,11,2,2);
INSERT INTO "recipe_ingredients" VALUES (308,50,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (309,50,60,1,6);
INSERT INTO "recipe_ingredients" VALUES (310,50,52,100,8);
INSERT INTO "recipe_ingredients" VALUES (311,51,39,200,4);
INSERT INTO "recipe_ingredients" VALUES (312,51,95,12,5);
INSERT INTO "recipe_ingredients" VALUES (313,52,72,2,2);
INSERT INTO "recipe_ingredients" VALUES (314,52,23,100,8);
INSERT INTO "recipe_ingredients" VALUES (315,53,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (316,53,49,0.75,3);
INSERT INTO "recipe_ingredients" VALUES (317,53,15,1.5,6);
INSERT INTO "recipe_ingredients" VALUES (318,53,79,0.25,3);
INSERT INTO "recipe_ingredients" VALUES (319,53,33,1.5,10);
INSERT INTO "recipe_ingredients" VALUES (320,53,41,0.25,3);
INSERT INTO "recipe_ingredients" VALUES (321,53,90,1.5,1);
INSERT INTO "recipe_ingredients" VALUES (322,53,88,1.5,9);
INSERT INTO "recipe_ingredients" VALUES (323,53,76,12,6);
INSERT INTO "recipe_ingredients" VALUES (324,53,100,2.75,5);
INSERT INTO "recipe_ingredients" VALUES (325,54,46,20,6);
INSERT INTO "recipe_ingredients" VALUES (326,54,87,16,7);
INSERT INTO "recipe_ingredients" VALUES (327,54,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (328,54,19,1,2);
INSERT INTO "recipe_ingredients" VALUES (329,54,44,1,6);
INSERT INTO "recipe_ingredients" VALUES (330,55,65,2,2);
INSERT INTO "recipe_ingredients" VALUES (331,55,23,100,8);
INSERT INTO "recipe_ingredients" VALUES (332,56,17,100,8);
INSERT INTO "recipe_ingredients" VALUES (333,57,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (334,57,49,1.5,6);
INSERT INTO "recipe_ingredients" VALUES (335,57,15,1.25,6);
INSERT INTO "recipe_ingredients" VALUES (336,57,41,0.3,3);
INSERT INTO "recipe_ingredients" VALUES (337,57,46,13,6);
INSERT INTO "recipe_ingredients" VALUES (338,57,11,0.5,2);
INSERT INTO "recipe_ingredients" VALUES (339,57,95,2,9);
INSERT INTO "recipe_ingredients" VALUES (340,58,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (341,58,87,0.5,3);
INSERT INTO "recipe_ingredients" VALUES (342,58,86,0.66,3);
INSERT INTO "recipe_ingredients" VALUES (343,58,90,2.5,1);
INSERT INTO "recipe_ingredients" VALUES (344,58,46,15,6);
INSERT INTO "recipe_ingredients" VALUES (345,58,11,1.25,2);
INSERT INTO "recipe_ingredients" VALUES (346,58,95,2.5,9);
INSERT INTO "recipe_ingredients" VALUES (347,58,6,4.5,6);
INSERT INTO "recipe_ingredients" VALUES (348,59,39,200,4);
INSERT INTO "recipe_ingredients" VALUES (349,59,95,12,5);
INSERT INTO "recipe_ingredients" VALUES (350,60,91,15,6);
INSERT INTO "recipe_ingredients" VALUES (351,60,72,2,2);
INSERT INTO "recipe_ingredients" VALUES (352,60,20,25,6);
INSERT INTO "recipe_ingredients" VALUES (353,60,95,1.5,5);
INSERT INTO "recipe_ingredients" VALUES (354,60,64,2,10);
INSERT INTO "recipe_ingredients" VALUES (355,60,79,3,10);
INSERT INTO "recipe_ingredients" VALUES (356,60,49,8,7);
INSERT INTO "recipe_ingredients" VALUES (357,60,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (358,60,72,1,2);
INSERT INTO "recipe_ingredients" VALUES (359,60,100,1,9);
INSERT INTO "recipe_ingredients" VALUES (360,61,29,100,4);
INSERT INTO "recipe_ingredients" VALUES (361,61,11,1,2);
INSERT INTO "recipe_ingredients" VALUES (362,61,97,1,9);
INSERT INTO "recipe_ingredients" VALUES (363,61,98,3,9);
INSERT INTO "recipe_ingredients" VALUES (364,62,29,100,4);
INSERT INTO "recipe_ingredients" VALUES (365,62,2,3,9);
INSERT INTO "recipe_ingredients" VALUES (366,63,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (367,63,47,10,6);
INSERT INTO "recipe_ingredients" VALUES (368,63,95,10,5);
INSERT INTO "recipe_ingredients" VALUES (369,63,46,12,6);
INSERT INTO "recipe_ingredients" VALUES (370,63,11,0.5,2);
INSERT INTO "recipe_ingredients" VALUES (371,63,90,1,1);
INSERT INTO "recipe_ingredients" VALUES (372,63,19,2,2);
INSERT INTO "recipe_ingredients" VALUES (373,64,41,1,3);
INSERT INTO "recipe_ingredients" VALUES (374,64,72,2,2);
INSERT INTO "recipe_ingredients" VALUES (375,64,91,20,6);
INSERT INTO "recipe_ingredients" VALUES (376,65,26,5,5);
INSERT INTO "recipe_ingredients" VALUES (377,65,49,1,6);
INSERT INTO "recipe_ingredients" VALUES (378,65,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (379,65,91,10,6);
INSERT INTO "recipe_ingredients" VALUES (380,65,15,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (381,65,73,0.5,3);
INSERT INTO "recipe_ingredients" VALUES (382,65,72,1,2);
INSERT INTO "recipe_ingredients" VALUES (383,65,100,1,9);
INSERT INTO "recipe_ingredients" VALUES (384,66,46,10,6);
INSERT INTO "recipe_ingredients" VALUES (385,66,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (386,66,66,12,6);
INSERT INTO "recipe_ingredients" VALUES (387,66,79,1,10);
INSERT INTO "recipe_ingredients" VALUES (388,66,90,1,1);
INSERT INTO "recipe_ingredients" VALUES (389,66,88,2,3);
INSERT INTO "recipe_ingredients" VALUES (390,66,87,0.5,3);
INSERT INTO "recipe_ingredients" VALUES (391,66,72,1,2);
INSERT INTO "recipe_ingredients" VALUES (392,66,95,1,9);
INSERT INTO "recipe_ingredients" VALUES (393,67,49,1,3);
INSERT INTO "recipe_ingredients" VALUES (394,67,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (395,67,72,2,2);
INSERT INTO "recipe_ingredients" VALUES (396,67,76,2,5);
INSERT INTO "recipe_ingredients" VALUES (397,67,46,12,6);
INSERT INTO "recipe_ingredients" VALUES (398,68,66,5,6);
INSERT INTO "recipe_ingredients" VALUES (399,68,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (400,68,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (401,68,87,1,3);
INSERT INTO "recipe_ingredients" VALUES (402,68,95,1.5,5);
INSERT INTO "recipe_ingredients" VALUES (403,68,90,1,1);
INSERT INTO "recipe_ingredients" VALUES (404,68,46,15,6);
INSERT INTO "recipe_ingredients" VALUES (405,68,25,10,6);
INSERT INTO "recipe_ingredients" VALUES (406,68,19,2,2);
INSERT INTO "recipe_ingredients" VALUES (407,68,27,15,6);
INSERT INTO "recipe_ingredients" VALUES (408,69,51,600,4);
INSERT INTO "recipe_ingredients" VALUES (409,69,11,1,2);
INSERT INTO "recipe_ingredients" VALUES (410,69,97,1,9);
INSERT INTO "recipe_ingredients" VALUES (411,69,98,3,9);
INSERT INTO "recipe_ingredients" VALUES (412,70,46,20,6);
INSERT INTO "recipe_ingredients" VALUES (413,70,87,16,7);
INSERT INTO "recipe_ingredients" VALUES (414,70,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (415,70,18,2,2);
INSERT INTO "recipe_ingredients" VALUES (416,71,17,100,8);
INSERT INTO "recipe_ingredients" VALUES (417,71,2,3,9);
INSERT INTO "recipe_ingredients" VALUES (418,72,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (419,72,47,12,6);
INSERT INTO "recipe_ingredients" VALUES (420,72,95,12,5);
INSERT INTO "recipe_ingredients" VALUES (421,72,49,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (422,72,46,15,6);
INSERT INTO "recipe_ingredients" VALUES (423,72,95,1.25,5);
INSERT INTO "recipe_ingredients" VALUES (424,72,11,0.5,2);
INSERT INTO "recipe_ingredients" VALUES (425,72,89,1,1);
INSERT INTO "recipe_ingredients" VALUES (426,72,79,0.25,3);
INSERT INTO "recipe_ingredients" VALUES (427,72,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (428,72,86,0.5,3);
INSERT INTO "recipe_ingredients" VALUES (429,73,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (430,73,82,3.5,3);
INSERT INTO "recipe_ingredients" VALUES (431,73,15,14,6);
INSERT INTO "recipe_ingredients" VALUES (432,73,46,21,6);
INSERT INTO "recipe_ingredients" VALUES (433,73,95,3.5,5);
INSERT INTO "recipe_ingredients" VALUES (434,73,72,1,2);
INSERT INTO "recipe_ingredients" VALUES (435,73,32,1,10);
INSERT INTO "recipe_ingredients" VALUES (436,74,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (437,74,15,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (438,74,46,15,6);
INSERT INTO "recipe_ingredients" VALUES (439,74,72,1,2);
INSERT INTO "recipe_ingredients" VALUES (440,74,49,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (441,74,41,2,10);
INSERT INTO "recipe_ingredients" VALUES (442,74,63,3,6);
INSERT INTO "recipe_ingredients" VALUES (443,74,6,10,6);
INSERT INTO "recipe_ingredients" VALUES (444,75,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (445,75,80,5,6);
INSERT INTO "recipe_ingredients" VALUES (446,75,91,10,6);
INSERT INTO "recipe_ingredients" VALUES (447,75,72,1,2);
INSERT INTO "recipe_ingredients" VALUES (448,75,49,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (449,75,41,2,10);
INSERT INTO "recipe_ingredients" VALUES (450,75,37,3,6);
INSERT INTO "recipe_ingredients" VALUES (451,75,86,0.75,3);
INSERT INTO "recipe_ingredients" VALUES (452,76,14,15,6);
INSERT INTO "recipe_ingredients" VALUES (453,76,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (454,76,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (455,76,49,1,3);
INSERT INTO "recipe_ingredients" VALUES (456,76,95,1,9);
INSERT INTO "recipe_ingredients" VALUES (457,76,86,1,3);
INSERT INTO "recipe_ingredients" VALUES (458,77,10,18,6);
INSERT INTO "recipe_ingredients" VALUES (459,77,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (460,77,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (461,77,49,8,7);
INSERT INTO "recipe_ingredients" VALUES (462,77,95,1,9);
INSERT INTO "recipe_ingredients" VALUES (463,78,12,2,2);
INSERT INTO "recipe_ingredients" VALUES (464,78,50,5,3);
INSERT INTO "recipe_ingredients" VALUES (465,78,94,1,3);
INSERT INTO "recipe_ingredients" VALUES (466,78,86,0.25,3);
INSERT INTO "recipe_ingredients" VALUES (467,79,12,2,2);
INSERT INTO "recipe_ingredients" VALUES (468,79,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (469,79,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (470,79,102,0.75,3);
INSERT INTO "recipe_ingredients" VALUES (471,79,94,2,3);
INSERT INTO "recipe_ingredients" VALUES (472,79,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (473,80,25,18,6);
INSERT INTO "recipe_ingredients" VALUES (474,80,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (475,80,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (476,80,49,1,3);
INSERT INTO "recipe_ingredients" VALUES (477,81,36,3,1);
INSERT INTO "recipe_ingredients" VALUES (478,81,36,15,6);
INSERT INTO "recipe_ingredients" VALUES (479,81,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (480,81,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (481,81,49,1,3);
INSERT INTO "recipe_ingredients" VALUES (482,82,53,3.75,6);
INSERT INTO "recipe_ingredients" VALUES (483,82,53,15,6);
INSERT INTO "recipe_ingredients" VALUES (484,82,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (485,82,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (486,82,95,1,9);
INSERT INTO "recipe_ingredients" VALUES (487,82,49,8,7);
INSERT INTO "recipe_ingredients" VALUES (488,83,63,3,6);
INSERT INTO "recipe_ingredients" VALUES (489,83,63,18,6);
INSERT INTO "recipe_ingredients" VALUES (490,83,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (491,83,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (492,83,49,1,3);
INSERT INTO "recipe_ingredients" VALUES (493,84,14,15,6);
INSERT INTO "recipe_ingredients" VALUES (494,84,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (495,84,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (496,84,49,1,3);
INSERT INTO "recipe_ingredients" VALUES (497,84,95,1,9);
INSERT INTO "recipe_ingredients" VALUES (498,85,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (499,85,43,2.5,3);
INSERT INTO "recipe_ingredients" VALUES (500,85,94,3.5,7);
INSERT INTO "recipe_ingredients" VALUES (501,85,86,1,3);
INSERT INTO "recipe_ingredients" VALUES (502,85,107,2,7);
INSERT INTO "recipe_ingredients" VALUES (503,85,95,1.5,5);
INSERT INTO "recipe_ingredients" VALUES (504,85,66,6,6);
INSERT INTO "recipe_ingredients" VALUES (505,86,47,10,6);
INSERT INTO "recipe_ingredients" VALUES (506,86,18,2,2);
INSERT INTO "recipe_ingredients" VALUES (507,86,65,1,2);
INSERT INTO "recipe_ingredients" VALUES (508,86,95,6,9);
INSERT INTO "recipe_ingredients" VALUES (509,86,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (510,86,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (511,87,67,5,6);
INSERT INTO "recipe_ingredients" VALUES (512,87,95,2.5,5);
INSERT INTO "recipe_ingredients" VALUES (513,87,64,2,11);
INSERT INTO "recipe_ingredients" VALUES (514,87,79,1,10);
INSERT INTO "recipe_ingredients" VALUES (515,87,49,1,6);
INSERT INTO "recipe_ingredients" VALUES (516,88,67,10,6);
INSERT INTO "recipe_ingredients" VALUES (517,88,95,5,5);
INSERT INTO "recipe_ingredients" VALUES (518,88,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (519,88,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (520,88,49,1,6);
INSERT INTO "recipe_ingredients" VALUES (521,89,67,10,6);
INSERT INTO "recipe_ingredients" VALUES (522,89,95,5,5);
INSERT INTO "recipe_ingredients" VALUES (523,89,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (524,89,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (525,89,49,1,6);
INSERT INTO "recipe_ingredients" VALUES (526,89,34,2,10);
INSERT INTO "recipe_ingredients" VALUES (527,90,38,5,9);
INSERT INTO "recipe_ingredients" VALUES (528,90,95,5,5);
INSERT INTO "recipe_ingredients" VALUES (529,90,49,3,7);
INSERT INTO "recipe_ingredients" VALUES (530,90,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (531,90,8,1,3);
INSERT INTO "recipe_ingredients" VALUES (532,90,18,1,2);
INSERT INTO "recipe_ingredients" VALUES (533,91,66,12,6);
INSERT INTO "recipe_ingredients" VALUES (534,91,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (535,91,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (536,91,87,1,3);
INSERT INTO "recipe_ingredients" VALUES (537,91,95,3,5);
INSERT INTO "recipe_ingredients" VALUES (538,92,66,12,6);
INSERT INTO "recipe_ingredients" VALUES (539,92,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (540,92,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (541,92,87,1,3);
INSERT INTO "recipe_ingredients" VALUES (542,92,95,3,5);
INSERT INTO "recipe_ingredients" VALUES (543,93,68,15,6);
INSERT INTO "recipe_ingredients" VALUES (544,93,95,10,5);
INSERT INTO "recipe_ingredients" VALUES (545,93,64,4,10);
INSERT INTO "recipe_ingredients" VALUES (546,93,79,4,10);
INSERT INTO "recipe_ingredients" VALUES (547,93,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (548,93,18,1,2);
INSERT INTO "recipe_ingredients" VALUES (549,93,99,1.5,9);
INSERT INTO "recipe_ingredients" VALUES (550,94,70,12,6);
INSERT INTO "recipe_ingredients" VALUES (551,94,95,6,5);
INSERT INTO "recipe_ingredients" VALUES (552,94,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (553,94,79,1,10);
INSERT INTO "recipe_ingredients" VALUES (554,94,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (555,95,71,45,6);
INSERT INTO "recipe_ingredients" VALUES (556,95,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (557,95,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (558,95,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (559,95,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (560,95,103,3,3);
INSERT INTO "recipe_ingredients" VALUES (561,95,86,0.75,3);
INSERT INTO "recipe_ingredients" VALUES (562,96,38,5,9);
INSERT INTO "recipe_ingredients" VALUES (563,96,95,5,5);
INSERT INTO "recipe_ingredients" VALUES (564,96,49,3,7);
INSERT INTO "recipe_ingredients" VALUES (565,96,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (566,96,18,1,2);
INSERT INTO "recipe_ingredients" VALUES (567,97,81,10,6);
INSERT INTO "recipe_ingredients" VALUES (568,97,95,6,5);
INSERT INTO "recipe_ingredients" VALUES (569,97,64,2,10);
INSERT INTO "recipe_ingredients" VALUES (570,97,79,4,10);
INSERT INTO "recipe_ingredients" VALUES (571,98,55,13,6);
INSERT INTO "recipe_ingredients" VALUES (572,98,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (573,99,55,13,6);
INSERT INTO "recipe_ingredients" VALUES (574,99,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (575,100,48,20,6);
INSERT INTO "recipe_ingredients" VALUES (576,100,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (577,100,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (578,100,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (579,100,64,1,10);
INSERT INTO "recipe_ingredients" VALUES (580,100,40,6,3);
INSERT INTO "recipe_ingredients" VALUES (581,101,69,10,6);
INSERT INTO "recipe_ingredients" VALUES (582,101,95,6,5);
INSERT INTO "recipe_ingredients" VALUES (583,101,64,2,10);
INSERT INTO "recipe_ingredients" VALUES (584,101,79,4,10);
INSERT INTO "recipe_ingredients" VALUES (585,101,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (586,101,5,0.5,6);
INSERT INTO "recipe_ingredients" VALUES (587,101,49,1,6);
INSERT INTO "recipe_ingredients" VALUES (588,102,49,1,7);
INSERT INTO "recipe_ingredients" VALUES (589,102,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (590,102,8,1,3);
INSERT INTO "recipe_ingredients" VALUES (591,102,76,2.25,5);
INSERT INTO "recipe_ingredients" VALUES (592,102,95,4.5,5);
INSERT INTO "recipe_ingredients" VALUES (593,103,78,1,1);
INSERT INTO "recipe_ingredients" VALUES (594,103,76,2.25,5);
INSERT INTO "recipe_ingredients" VALUES (595,103,95,4,5);
INSERT INTO "recipe_ingredients" VALUES (596,103,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (597,103,87,1,3);
INSERT INTO "recipe_ingredients" VALUES (598,103,49,1,3);
INSERT INTO "recipe_ingredients" VALUES (599,104,49,8,7);
INSERT INTO "recipe_ingredients" VALUES (600,104,59,1,6);
INSERT INTO "recipe_ingredients" VALUES (601,104,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (602,104,76,2.25,5);
INSERT INTO "recipe_ingredients" VALUES (603,104,95,4.5,5);
INSERT INTO "recipe_ingredients" VALUES (604,105,9,15,6);
INSERT INTO "recipe_ingredients" VALUES (605,105,96,7.5,5);
INSERT INTO "recipe_ingredients" VALUES (606,106,6,15,6);
INSERT INTO "recipe_ingredients" VALUES (607,106,49,3,6);
INSERT INTO "recipe_ingredients" VALUES (608,107,27,15,6);
INSERT INTO "recipe_ingredients" VALUES (609,107,49,3,6);
INSERT INTO "recipe_ingredients" VALUES (610,108,9,15,6);
INSERT INTO "recipe_ingredients" VALUES (611,108,96,7.5,5);
INSERT INTO "recipe_ingredients" VALUES (612,108,49,1,6);
INSERT INTO "recipe_ingredients" VALUES (613,108,34,2,10);
INSERT INTO "recipe_ingredients" VALUES (614,109,71,45,6);
INSERT INTO "recipe_ingredients" VALUES (615,109,79,2,10);
INSERT INTO "recipe_ingredients" VALUES (616,110,106,15,6);
INSERT INTO "recipe_ingredients" VALUES (617,111,84,15,6);
INSERT INTO "recipe_ingredients" VALUES (618,112,101,15,6);
INSERT INTO "recipe_ingredients" VALUES (625,114,74,4,6);
INSERT INTO "recipe_ingredients" VALUES (626,114,86,1,3);
INSERT INTO "recipe_ingredients" VALUES (627,114,93,2.5,11);
INSERT INTO "recipe_ingredients" VALUES (628,114,95,1.5,3);
INSERT INTO "recipe_ingredients" VALUES (629,5,54,10,6);
INSERT INTO "recipe_ingredients" VALUES (630,5,49,3,6);
INSERT INTO "recipe_ingredients" VALUES (631,113,106,10,6);
INSERT INTO "recipe_ingredients" VALUES (632,113,86,10,3);
INSERT INTO "recipe_ingredients" VALUES (633,113,24,0.75,3);
INSERT INTO "recipe_ingredients" VALUES (634,113,74,2.5,9);
INSERT INTO "recipe_ingredients" VALUES (635,113,93,0.5,3);
INSERT INTO "recipe_ingredients" VALUES (636,113,95,2.5,3);
INSERT INTO "recipe_ingredients" VALUES (697,1,46,12.5,6);
INSERT INTO "recipe_ingredients" VALUES (698,1,65,6,2);
INSERT INTO "recipe_ingredients" VALUES (699,1,95,6,5);
INSERT INTO "recipes" VALUES (1,'SAUSAGE GRAVY','165F','protein','8oz','','breakfast','In a large pan mix peppered gravy per package directions
Heat MST and add to gravy mix
Heat to 165 degree
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Sausage Patty',100);
INSERT INTO "recipes" VALUES (2,'WESTERN SCRAMBLED EGGS','165F','Protein','2oz','','breakfast','Add all ingredients and heat to 165 degrees 
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','',100);
INSERT INTO "recipes" VALUES (3,'GRITS','165F','Starch','8oz','','breakfast','Bring water to boil on large pot/tilt skillet
Add salt , pepper and margarine
Slowly add grits, while constantly stirring to avoid lumps
Bring back to a boil, reduce heat.
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Rice',100);
INSERT INTO "recipes" VALUES (4,'OATMEAL','165 degrees','Starch','8oz','','breakfast','In a large pan, bring water to a boil
Add syrup and margarine to water
Slowly at oatmeal, while stirring constantly to avoid clumping
Bring back to a boil
Serve hot or hold at 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (5,'MUFFIN','165F','bread','1/48 cut Grid Cut','','breakfast','Follow Instructions on bag. Add margarine.  Bake
Use grid to cut, based on menus grid size.
Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (6,'COFFEE CAKE','N/A','Dessert','1/48 cut','','breakfast','Make your yellow cake mix following the instructions on the bag (5lbs of mix to 5 cups of water per pan)
Pour cake mix into greased sheet pans and level
In a separate bowl, mix oats, white Sugar, cinnamon, flour and softened margarine
With gloves on, hand mix crumble topping
Sprinkle on top of each cake pan
Bake at 350 dgrees for 15-20 minutes','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (7,'PANCAKE','165F','Bread','Grid Cut','129.0','breakfast','Follow Instructions on bag
Swirl in syrup evenly across the top of pancake batter.
Use grid to cut, based on menus grid size.
Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (8,'CEREAL BAR','N/A','Dessert','1/48 cut','165F','breakfast','Mix all ingredients together.  Press into sheet pan.  Chill.  Cut and serve','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (9,'PEANUT BUTTER CEREAL BAR','N/A','Dessert','1/48 cut','','breakfast','Mix all ingredients together.  Press into sheet pan.  Chill  Cut and serve.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (10,'HONEY BUN COFFEE CAKE','N/A','bread','1/48 cut','','breakfast','Make your yellow cake mix following the instructions on the bag (5lbs of mix to 5 cups of water per pan)
Pour HALF cake mix into greased sheet pans and level
In a separate bowl, mix syrup, cinnamon, powdered sugar vanilla ; pour over batter
add remaining batter;  swirl
Bake at 350 dgrees for 15-20 minutes','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (11,'STREUSAL COFFEE CAKE','N/A','Dessert','1/48 cut','','breakfast','Make your yellow cake mix following the instructions on the bag (5lbs of mix to 5 cups of water per pan)
Pour cake mix into greased sheet pans and level
In a separate bowl, mix oats, white Sugar, cinnamon, flour and softened margarine
With gloves on, hand mix crumble topping
Sprinkle on top of each cake pan
Bake at 350 dgrees for 15-20 minutes','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (12,'CINNAMON COFFEE CAKE','N/A','Dessert','1/48 cut','','breakfast','Make your yellow cake mix following the instructions on the bag (5lbs of mix to 5 cups of water per pan)
Pour HALF cake mix into greased sheet pans and level
In a separate bowl, mix SYRUP, cinnamon, and softened margarine
SPREAD OVER BATTER;   ADD REMAINING BATTER
Bake at 350 dgrees for 15-20 minutes','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (13,'OAT CEREAL BAR','N/A','Dessert','1/48 cut','','breakfast','HEAT SYRUP, PEANUT BUTTER TIL SMOOTH ADD VANILLA
POUR OVER CEREAL PRESS INTO PAN  CHILL','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (14,'OKIE CEREAL BAR','N/A','Dessert','1/48 cut','','breakfast','HEAT SYRUP, PEANUT BUTTER TIL SMOOTH ADD VANILLA.  ADD CINNAMON AND SALT
POUR OVER CEREAL PRESS INTO PAN  CHILL','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (15,'RICE','165F','Starch','8oz','','breakfast','In a large pot/tilt skillet, add all ingredients but the rice, and stir
Bring to a boil
Add rice and stir
Cover and cook for 10-15 minutes
Remove from heat and let stand for 10-15 minutes
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (16,'ASIAN BEEF','165F','Protein','3oz +7 steak bites per serving','309.0','entrees','In large pan,  melt margarine
Add diced peppers and onions, saute, stir frequently 
Add sweet & sour sauce and water, heat to 165 degrees.  Add broccoli.  
Put steak bites in pans and heat in oven to 165 degrees (DO NOT OVERCOOK).  Add steak bites to sauce. Stir well.
Serve hot or hold above 140 dgrees

SERVING NOTES:
Tray up broccoli in separate hole. Tray rice in large hole, top with 3oz vegetable sauce.  
Place 6 steak bite on top of rice, unless there is an extra open slot on tray','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Meatballs,',100);
INSERT INTO "recipes" VALUES (17,'CAJUN BEANS','165F','Starch','3oz (6 meatballs per serving)  ','215.0','entrees','Inspect beans for rocks, sticks prior to rinse.
Rinse and soak beans overnight in large pan/pot or tub
2 hrs before service start cooking beans, until tender.
Add MST and cook until reaches 165 degrees
In a separate pan, saute onions and bell peppers
Add onions, peppers, tomatoes and blackened seasoning to beans.
Simmer for 10 minutes
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:  MSC, Ground Chicken',100);
INSERT INTO "recipes" VALUES (18,'BBQ MEATBALLS','165F','Protein','3oz (6 meatballs per serving)','215.0','entrees','In a hotel pan, heat water and BBQ sauce to a boil.
Pan up meatballs and heat in oven until 165 degrees.  (DO NOT OVER COOK)
Pour sauce over meatballs and put back into oven, heat until 165 degrees
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (19,'BBQ TURKEY','165F','Protein','4oz','275.0','entrees','Heat turkey to above 165 degrees.
Chop turkey by hand or shred in mixer.
Combine water, BBQ sauce and turkey and heat up to above 165 degrees
BLAND DIET:  No BBQ sauce','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (20,'CHICKEN A LA KING','165F','Protein','10oz     ','285.0','entrees','In a large pan/tilt skillet, melt margarine
Add celery, bell peppers and onions, saute
Add water to the celery and carrots.  Add chicken, salt and pepper
Bring to a boil
Add peas, return to a boil
In a bowl mix gravy with cold water until smooth
Add gravy slurry to boiling mixture, stirring until thickened
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Turkey Ends & Pieces, Diced Chicken',100);
INSERT INTO "recipes" VALUES (21,'CHICKEN FRIED RICE','165F','Protein','10oz','416.0','entrees','In a large pot/tilt skillet, add water, salt, carrots, peas, and stir
Bring to a boil
Add Ends and Pieces and cook for 10 minutes.  Add rice and stir, cook for additional 10 minutes.
Remove from heat and let stand for 10-15 minutes
In a separate pan, saute onions in oil.   
Add soy sauce  and onions to rice
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:  MSC, Ground Chicken',100);
INSERT INTO "recipes" VALUES (22,'SWEET & SOUR CHICKEN','165F','Protein','4oz ','194.0','entrees','In a large pot/tilt skillet, melt margarine in pan with peppers and onions, saute
Add chicken & water, heat to 165 degrees
Cook off water, add sweet & sour sauce. Heat to 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:  Ground Chicken, MSC',100);
INSERT INTO "recipes" VALUES (23,'CHILI CON CARNE','165F','Protein','10 OZ','','entrees','Add dry beans to kettle and cover beans with water 6 inches above surface of beans.
Retain bean cooking liquid..
Remove beans and hold.
Turn heat back on and cook at a low simmer until tender, approximately one more hour.
Bring water to a boil, turn off heat and allow beans to soak in hot water for one hour.
Combine fully thawed MST and onion. Cook and stir until pink is gone
Add all remaining ingredients including beans, heat to a simmer, pan and serve
GLUTEN RESTRICTED:  No cheese','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MSC, Chicken Sliced/Diced, Turkey Ends and Pieces,',100);
INSERT INTO "recipes" VALUES (24,'GUMBO','165F','Protein','10 OZ ','347 Calories','entrees','Heat turkey to above 165 degrees.
Chop turkey by hand or shred in mixer.
In a large pan/tilt skillet, melt margarine and add peppers, celery, carrots and onions, saute ingredients
Add water to vegetables, then add turkey, tomatoes, blackened seasoning, salt and pepper, bring to a boil
In a bowl, mix gravy with cold water until smooth. 
Add gravy slurry to boiling mixture and stir until thickened 
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:  MSC, Ground Chicken',100);
INSERT INTO "recipes" VALUES (25,'CHILI MAC','165F','Protein','10 0Z  ','421.0','entrees','Inspect beans for rocks, sticks prior to rinse.
Rinse and soak beans overnight in large pan/pot or tub
2 hrs before service start cooking beans, until tender.  Drain water.
In another pan, partially brown meat, then add margarine, bell peppers and onion.
Once the vegetables are tender, add flour and stir well
In a separate pan, add water and cook pasta, drain and set aside
Add remaining ingredients to meat mixture , except beans.  Cook until thickened up
Once beans are fully cooked, add bean and pasta to mixture and stir thoroughly','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Chicken Sliced/Diced, Turkey Ends and Pieces, MST/MSC',100);
INSERT INTO "recipes" VALUES (26,'MEATBALLS - GRAVY','165F','Protein','3oz (6 meatballs per serving)    ','205.0','entrees','Heat turkey to above 165 degrees.
Chop turkey by hand or shred in mixer.
In a large pan/tilt skillet, melt margarine and add peppers, celery, carrots and onions, saute ingredients
Add water to vegetables, then add turkey, tomatoes, blackened seasoning, salt and pepper, bring to a boil
In a bowl, mix gravy with cold water until smooth. 
Add gravy slurry to boiling mixture and stir until thickened 
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (27,'MEATBALLS  - SWEET & SOUR','165F','Protein','3oz (6 meatballs per serving)  ','224.0','entrees','Bring water and sweet & sauce to a boil in pan.
Pan up meatballs and cook in oven until temp reaches 165 degrees
Pour sauce over meatballs and put back into oven, heat until 165 degrees
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (28,'NACHO MEAT W/ BEANS','165F','Protein','8oz','','entrees','Inspect beans for rocks, sticks prior to rinse.
Rinse and soak beans overnight in large pan/pot or tub
2 hrs before service start cooking beans, until tender.
Drain Water
Add onions, pepper and taco seasoning to beans, simmer for 20 minutes (DON’T BURN BEANS)
Use a masher/mixer to mash the beans
In another pan, cook meat, then add to beans. Heat to 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MSC, Chicken Sliced/Diced, Turkey Ends and Pieces,',100);
INSERT INTO "recipes" VALUES (29,'PASTA BAKE','165F','Starch','10oz ','434.0','entrees','In a large pot/tilt skillet, brown MST, heat to 165 degrees and drain.
Add margarine to pan, melt and saute celery, peppers, and onions
Mix pasta with remaining ingredients, stir to combine
Heat mixture to 165 degrees
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (30,'STEAK BITES','165F','Protein','3oz','','entrees','Pan up steak bites and cook in oven until temp reaches 165 degrees, don’t overcook
Make gravy per package directions
Pour gravy over steak bites and put back into oven,
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MSC, Ground Chicken',100);
INSERT INTO "recipes" VALUES (31,'SLOPPY JOE','165F','Protein','4oz    ','341.0','entrees','In a large pan/tilt skillet, brown meat
Add  peppers and onions and saute
Add remaining ingredients.  Cook until thickened up and 165 degrees
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MSC, Ground Chicken',100);
INSERT INTO "recipes" VALUES (32,'GRAVY','165F','Sauce','2oz','','entrees','Follow directions on gravy package
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (33,'STROGANOFF','165F','Protein','10oz  ','529.0','entrees','In a pan/tilt skillet, partially brown meat, then add margarine, bell peppers and onion.
Mix gravy, per package instructions in separate pot.
Mix in pasta, meat, gravy with remaining ingredients and combine.
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MST, Taco Meat, Ground Chicken',100);
INSERT INTO "recipes" VALUES (34,'TACO MEAT','165F','Protein','3oz ','500.0','entrees','In a large pan/tilt skillet brown MST to 165 degrees
Add onions and taco seasoning, stir well
Serve hot or hold above 140 dgrees
GLUTEN RESTRICTED:    No cheese	','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Taco Meat, MSC',100);
INSERT INTO "recipes" VALUES (35,'TURKEY MAC & CHEESE','165F','Protein','10oz     ','499.0','entrees','Heat up diced ham to 165 degrees using stock pot/tilt skillet
In separate pot heat 5 qts of water to a boil, mix 1 qt of cold water to bag of gravy mix. Stir in cheese sauce until smooth
Mix turkey ham and cooked pasta together.  
Add salt and pepper and mix sauce with pasta/turkey.
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Chicken Sliced/Diced, Turkey Ends and Pieces, MST/MSC',100);
INSERT INTO "recipes" VALUES (36,'TURKEY POT PIE','165F','Protein','10 OZ','','entrees','Heat turkey to above 165 degrees.
Chop turkey by hand or shred in mixer.
In a large pan/tilt skillet, melt margarine and add celery, carrots and onions, saute ingredients
Add water to veggies, then add potatoes, turkey and salt/pepper
Bring to a boil
Add peas, return to boil
In a bowl mix gravy bag and cold water til smooth, adding gravy slurry to boiling mixture.  Stir until thickened
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Chicken Sliced/Diced, Turkey Ends and Pieces, MST/MSC; Sliced Potatoes. Shredded Potatoes',100);
INSERT INTO "recipes" VALUES (37,'ROASTED TURKEY','165F','Protein','4oz  ','290.0','entrees','Heat turkey to above 165 degrees.
Chop turkey by hand or shred in mixer.
Combine water and turkey and heat up to above 165 degrees
Cook off most of the water and add poultry gravy
Stir well
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','Chicken: Sliced/Diced',100);
INSERT INTO "recipes" VALUES (38,'TURKEY TETRAZINI','165F','Protein','10oz','669.0','entrees','Cook and drain pasta
Brown MST in a large pan/tilt skillet
Add margarine to pan, melt, saute onions and bell peppers.  Add salt.
In a bowl mix gravy bag and cold water til smooth, adding gravy slurry to boiling mixture.  Stir until thickened
Add cheese sauce, stirring until smooth.  
Heat to 165 degrees
Serve hot or hold above 140 degrees','','',100);
INSERT INTO "recipes" VALUES (39,'MARINARA SAUCE','165F','Sauce/Gravy','3oz','','entrees','Put all ingredients into pan and simmer.  Stir frequently
Cover and heat to 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (40,'MEAT SAUCE','165F','Sauce/Gravy','6oz','','entrees','In a large pan/tilt skillet, brown off MST, cooking off excess liquid
Put all ingredients into pan and simmer.  Stir frequently
Cover and heat to 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (41,'TURKEY CASSEROLE','165F','Protein','6oz','','entrees','LAYER VEGETABLES IN ORDER GIVEN.  SEASON WITH SALT AND PEPPER.  PUT COOKED MST ON TOP OF VEGGIES.  POUR SAUCE OVER ALL
BAKE AT 350 DEGREES FOR 2 HOURS
 
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (42,'TURKEY & POTATO AUGRATIN','165F','Sauce/Gravy','10 oz','','entrees','COOK MST WITH ONIONS. LAYER HALF THE POTATOES AND SEASON;  ADD HALF THE ONION AND MST; TOP WITH HALF CHEESE SAUCE;  REPEAT.  
BAKE AT 350 DEGREES FOR 2 HOURS	 
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (43,'SPANISH RICE AND BEANS','165F','Sauce/Gravy','10 oz','371.0','entrees','SAUTE ONION; ADD SEASONING.  STIR IN RICE.  STIR IN SALSA AND BEANS; COOK TIL RICE AND BEANS ARE TENDER	
BAKE AT 350 DEGREES FOR 2 HOURS	
GLUTEN RESTRICTED DIET:  No cheese sauce	
Serve hot or hold above 140 degrees	','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (44,'STUFFED PEPPER CASSEROLE','165F','Sauce/Gravy','6oz','','entrees','SAUTE ONION ADD MST.  DRAIN, ADD PEPPERS ADD SEASONING, TOMATOES, ADD RICE AND WATER; BRING TO A BOIL;  	
BAKE AT 350 DEGREES FOR 30 minutes	
GLUTEN RESTRICTED:  No cheese	
Serve hot or hold above 140 degrees	','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (45,'CAJUN CHICKEN PASTA','165F','Sauce/Gravy','10 oz ','527.0','entrees','COOK PASTA.    SEASON AND COOK ENDS/PIECES; SAUTE ONIONS; ADD TOMATOES AND SEASONING.  MAKE GRAVY PER PACKAGE DIRECTIONS.   ADD  CH EESE SAUCE MIX TO GRAVY; ADD GRAVY TO CHICKEN MIXTURE
PAN AND BAKE AT 350 DEGREES FOR 30 MINUTES TIL 165 DEGREES 
 
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (46,'CINNCINATI CHILI','165F','Sauce/Gravy','10 oz','326.0','entrees','Place MST in a large pan, cover with cold water, and bring to a boil, stirring and breaking up with a fork to a fine texture. Slowly boil until meat is thoroughly cooked, about 30 minutes.
Add onions, tomato sauce, vinegar, spices, Worcestershire sauce, and chocolate pudding. Stir in seasonings.  Mix well
Bring to a boil, reduce heat to a simmer, and cook, stirring occasionally, for 3 hours. Add water if necessary to prevent chili from burning','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (47,'TURKEY SALAD','40 F','Entrée','3 OZ','','entrees','Mix all ingredients together.  Chill at 41 degrees or less','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (48,'SWISS STEAK','165F','Protein','3oz     ','201.0','entrees','In a large pan mix brown gravy per package directions
Add seasonings to gravy
Place meatloaf patties, onions and peppers  in hotel pan and cover patties with gravy
Bake until patties reach 165 degrees
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (49,'SALISBURY STEAK','165F','Protein','3oz   ','187.0','entrees','In a large pan mix brown gravy per package directions
Add seasonings to gravy
Place meatloaf patties in hotel pan and cover patties with gravy
Bake until patties reach 165 degrees
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100);
INSERT INTO "recipes" VALUES (50,'PEPPER PATTY','165F','Protein','3oz   ','199.0','entrees','In a large pan mix brown gravy per package directions
Add onions and green peppers to gravy
Place patties in hotel pan and cover patties with gravy
Bake until patties reach 165 degrees
Serve hot or hold above 140 dgrees','2.5 Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100);
INSERT INTO "recipes" VALUES (51,'HOT DOG','165F','Protein','2.0','300.0','entrees','Bring water to a boil.  Add hot dogs.  Bring back to a full boil and heat for 10 minutes
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (52,'BREADED CHICKEN PATTY','165F','Protein','3oz','180.0','entrees','In a large pan mix gravy per package directions
Place patties in hotel pan and cover patties with gravy
Bake until patties reach 165 degrees
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100);
INSERT INTO "recipes" VALUES (53,'JAMBALAYA SAUSAGE','165F','Protein','10oz  ','282.0','entrees','Saute Onions and Celery until tender
Add salt, herbs and spices.  Cook and stir for 2 minutes
Add Tomatoes, paste, rice, and water.  Stir well, bring to a simmer, cover and cook for 30 minutes.  Stir occasionally.  Add gravy.
Add diced sausage.  When all liquid is absorbed and rice is tender, pan for service','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Turkey Ends & Pieces, Diced Chicken',100);
INSERT INTO "recipes" VALUES (54,'BURRITO BOWL','165F','Protein','3oz','502.0','entrees','In a large pan/tilt skillet brown MST to 165 degrees
Add onions and taco seasoning, stir well
Make cheese sauce per package directions.  Add to MST,  Heat to 165 degrees.   
Serve on top of Lettuce
Serve hot or hold above 140 dgrees
GLUTEN RESTRICTED:  No cheese','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Taco Meat, MSC',100);
INSERT INTO "recipes" VALUES (55,'CHICKEN FRIED STEAK','165F','Protein','3oz','220.0','entrees','In a large pan/tilt skillet brown MST to 165 degrees
Add onions and taco seasoning, stir well
Make cheese sauce per package directions.  Add to MST,  Heat to 165 degrees.   
Serve on top of Lettuce
Serve hot or hold above 140 dgrees
GLUTEN RESTRICTED:  No cheese','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100);
INSERT INTO "recipes" VALUES (56,'BEEF PATTY','165F','Protein','3oz  ','160.0','entrees','Place patties in hotel pan. 
Bake until patties reach 165 degrees
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100);
INSERT INTO "recipes" VALUES (57,'BEEF STEW','165F','Protein','10 OZ LADLE  ','415.0','entrees','1.  MELT MARGARINE IN KETTLE.  Add celery and onions.  Saute until tender
2.  Add seasoning.  Saute one minute
3.  Combine water and  gravy mix.  Add to kettle. Simmer and blend til well mixed.  Add fully cooked MST.  Return to simmer for 15 minutes.
4.  Thaw vegetables in warm water.  Drain well.  Add to meat mixture and return to simmer.
5.  Pan and Serve','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100);
INSERT INTO "recipes" VALUES (58,'HAMBURGER CASSEROLE','165F','Protein','10 OZ ','620.0','entrees','1.  BROWN MST TIL INTERNAL TEMPERATURE REACHES 165 DEGREES F. FOR 15 SECONDS.  DRAIN OFF EXCESS FAT.
2.  ADD ONIONS, COOK UNTIL TENDER
3.  ADD SEASONINGS AND TOMATOES.  SIMMER 30 MINUTES OR UNTIL THICK
4.  SCALE MEAT MIXTURE INTO 12X20X2 INCH PANS; 9 LBS PER PAN
5.  PREPARE CHEESE SAUCE.  POUR OVER EACH PAN.
5.  PREPARE BISCUIT MIX ACCORDING TO DIRECTIONS.   
6.  USING A #20 DIPPER, PLACE BISCUIT TOPPING 4X6 OVER MEAT MIXTURE JUST BEORE BAKING.
7.  BAKE AT 400 DEGREES f. FOR 30-35 MINUTES.  Allow to rest for 5 minutes.  Cut into 4x6 pieces.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100);
INSERT INTO "recipes" VALUES (59,'POLISH SAUSAGE','165F','Protein','2.0','300.0','entrees','Bring water to a boil.  Add Polish Sausage.  Bring back to a full boil and heat for 10 minutes
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (60,'CREAMED CHICKEN','165F','Protein','10oz','210.0','entrees','In a large pan/tilt skillet, melt margarine; saute onions
Add water to the vegetables, then chicken, salt and pepper
Bring to a boil
In a bowl mix gravy with cold water until smooth
Add gravy slurry to boiling mixture, stirring until thickened
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Turkey Ends & Pieces, Diced Chicken',100);
INSERT INTO "recipes" VALUES (61,'MEATLOAF - GRAVY','165F','Protein','3oz','','entrees','Bring hot water to a boil in pan.
In a bowl mix gravy bag and cold water til smooth, adding gravy slurry to boiling mixture.  Stir until thickened
Pan up dinner loaf patties and cook in oven until temp reaches 165 degrees
Pour gravy over dinner loaf patties and put back into oven, heat until 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (62,'MEATLOAF - BBQ','165F','Protein','3oz','197 Calories','entrees','Bring hot water to a boil in pan.
In a bowl mix gravy bag and cold water til smooth, adding gravy slurry to boiling mixture.  Stir until thickened
Pan up dinner loaf patties and cook in oven until temp reaches 165 degrees
Pour gravy over dinner loaf patties and put back into oven, heat until 165 degrees
Serve hot or hold above 140 degrees
BLAND DIET:  No BBQ saucesp','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (63,'GOULASH','165F      ','Protein','10 OZ','408.0','entrees','COOK MACARONI.
DRAIN WATER AND COOL MARCARONI WITH COLD RUNNING WATER..
DO NOT OVERCOOK.
BROWN MST AND ONIONS.  ADD MACARONI, TOMATOES. HEAT TO 165 DEGREES
PREPARE GRAVY MIX PER PACKAGE DIRECTIONS.  ADD CHEESE SAUCE. 
ADD GRAVY TO MST MIXTURE.
BRING TO A HARD BOIL.
HOLD AND SERVE AT 140 DEGREES

2. HEAT AND STIR UNTIL MEAT IS BROWN AND REACHES AN INTERNALTEMPERATURE OF 165 DEGREES FOR 15 SECONDS..
	PLACE MEAT AND ONIONS IN KETTLE.
3.  ADD WATER,TOMATOES, GRAVY MIX, AND SEASONINGS.  WHIP UNTIL FULLY INCORPORATED.  RETURN TO A SIMMER
4.  ADD MACARONI AND FOLD TOGETHER.  HEAT ENTIRE MIXTURE TO 165 F.  TASTE.  ADD SALT IF NECESSARY.  PAN AND SERVE.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (64,'TURKEY ITALIAN','165F','Sauce/Gravy','4 OZ      ','180.0','entrees','MAKE GRAVY PER PACKAGE DIRECTIONS.  ADD SEASONING.  ADD ENDS/PIECES.
BAKE AT 350 DEGREES FOR 2 HOURS
 
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (65,'CHICKEN CORNBREAD CASSEROLE','165F','Protein','10oz ','343.0','entrees','TOAST CUBED CORNBREAD.
SAUTE VEGGIES. COOL.   STIR IN CORNBREAD, END/PIECES, AND SEASONING
MAKE GRAVY PER PACKAGE DIRECTIONS.  ADD TO CHICKEN MIXTURE
BRING TO A BOIL. 
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Turkey Ends & Pieces, Diced Chicken',100);
INSERT INTO "recipes" VALUES (66,'BEAN STEW','165F','Starch','10 OZ ','346.0','entrees','PREPARE BEANS PER PACKAGE.  SAUTE ONIONS, ADD SEASONING  COMBINE BEANS AND MST.  ADD REMAINING INGREDIENTS
Rinse and soak beans overnight in large pan/pot or tub
2 hrs before service start cooking beans, until tender.
Add MST and cook until reaches 165 degrees
In a separate pan, saute onions and bell peppers
Add onions, peppers, tomatoes and blackened seasoning to beans.
Simmer for 10 minutes
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:  MSC, Ground Chicken',100);
INSERT INTO "recipes" VALUES (67,'TURKEY RICE CASSEROLE','165F','Sauce/Gravy','10 OZ ','391.0','entrees','SAUTE ONION; ADD SEASONING.  STIR IN RICE AND GRAVY.  STIR IN TURKEY; COOK TIL TENDER
BAKE AT 350 DEGREES FOR 2 HOURS
 
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (68,'TAMALE PIE','165F','Protein','10 OZ ','744.0','entrees','Inspect beans for rocks, sticks prior to rinse.  Rinse and soak beans overnight in large pan/pot or tub
2 hrs before service start cooking beans, until tender.
Drain Water
Add onions, pepper and taco seasoning to beans, simmer for 20 minutes (DON’T BURN BEANS).  Use a masher/mixer to mash the beans
In another pan, partially brown meat, then add taco seasoning and diced onions. Heat to 165 degrees
Mix meat and beans together and heat to 165 degrees.  Add tomatoes, corn.  Pour into steamtable pan
Make cheese sauce per package directions.  Pour over meat mixture
Make cornbread per package directions.  Pour batter over cheese.
Bake at 375 degrees for 40 minutes until top is browned. Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MSC, Chicken Sliced/Diced, Turkey Ends and Pieces,',100);
INSERT INTO "recipes" VALUES (69,'SWEDISH MEATBALLS','165F','Protein','3oz (6 meatballs per serving)  ','205.0','entrees','Bring hot water to a boil in pan.
In a bowl mix gravy bag and cold water til smooth, adding gravy slurry to boiling mixture.  Stir until thickened
Pan up meatballs and cook in oven until temp reaches 165 degrees
Pour gravy over meatballs and put back into oven, heat until 165 degrees
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (70,'TURKEY TACOS','165F','Protein','3oz','313.0','entrees','In a large pan/tilt skillet brown MST to 165 degrees
Add onions and taco seasoning, stir well
Make cheese sauce per package direction.  Pour over turkey mixture.  
Serve hot or hold above 140 dgrees
GLUTEN RESTRICTED:    No cheese','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Taco Meat, MSC',100);
INSERT INTO "recipes" VALUES (71,'BBQ  BEEF PATTY','165F','Protein','3oz','160.0','entrees','Place patties in hotel pan and cover patties with sauce
Bake until patties reach 165 degrees
Serve hot or hold above 140 dgrees
BLAND DIET:  No BBQ sauce','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Charbroiled Patty',100);
INSERT INTO "recipes" VALUES (72,'BEEF A RONI','165F','Protein','10 OZ','443.0','entrees','1.  PLACE 1 GALLON OF WATER FOR EACH POUND OF MARCARONI AND 1 OZ OF SALT PER GALLON OF WATER.  BRING TO A HARD BOIL.  ADD MARCARONI.  STIR ONCE EVERY MINUTE UNTIL WATER RETURNS TO  A BOIL.  CONTINUE COOKING AND STIRRING OCCASIONALLY UNTIL MACARONI IS TENDER.  DO NOT OVERCOOK.  DRAIN WATER AND COOL MARCARONI WITH COLD RUNNING WATER.
2.  PLACE MEAT AND ONIONS IN KETTLE.  HEAT AND STIR UNTIL MEAT IS BROWN AND REACHES AN INTERNAL TEMPERATURE OF 165 DEGREES FOR 15 SECONDS.
3.  ADD WATER, TOMATOES, GRAVY MIX AND SEASONINGS.  WHIP UNTIL FULLY INCORPORATED.  RETURN TO A SIMMER
4.  ADD MACARONI AND FOLD TOGETHER.  HEAT ENTIRE MIXTURE TO 165 F.  TASTE.  ADD SALT IF NECESSARY.  PAN AND SERVE.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ends and pieces',100);
INSERT INTO "recipes" VALUES (73,'CHOP SUEY','165F','Protein','10 OZ','322.0','entrees','PLACE MEAT AND ONIONS IN KETTLE.  HEAT AND STIR UNTIL MEAT IS BROWN AND REACHES AN INTERNALTEMPERATURE OF 165 DEGREES FOR 15 SECONDS.
ADD VEGETABLES,  GRAVY MIX, SOY SAUCE, AND SEASONINGS.  WHIP UNTIL FULLY INCORPORATED.  RETURN TO A SIMMER
HEAT ENTIRE MIXTURE TO 165 F.  TASTE.  ADD SALT IF NECESSARY.  PAN AND SERVE.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ends and pieces',100);
INSERT INTO "recipes" VALUES (74,'CHICKEN DUMPLINGS','165F      ','Protein','10 OZ','512.0','entrees','PLACE MEAT, CELERY, AND ONIONS IN KETTLE.  HEAT AND STIR UNTIL MEAT IS BROWN AND REACHES AN INTERNAL TEMPERATURE OF 165 DEGREES FOR 15 SECONDS.
ADD WATER AND GRAVY MIX AND SEASONINGS.  WHIP UNTIL FULLY INCORPORATED.  RETURN TO A SIMMER
ADD PEAS AND FOLD TOGETHER.  HEAT ENTIRE MIXTURE TO 165 F.  TASTE.  ADD SALT IF NECESSARY.  PAN.
MAKE BISCUIT PER PACKAGE DIRECTIONS.  SPOON ON TOP OF MIXTURE BAKE AT 350 DEGREES FOR 20 MINUTS.  SERVE','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ends and pieces',100);
INSERT INTO "recipes" VALUES (75,'ITALIAN CHICKEN SAUSAGE','165F','Protein','10 OZ','455.0','entrees','PLACE MEAT AND ONIONS, GREEN PEPPERS IN KETTLE.  HEAT AND STIR UNTIL MEAT IS BROWN AND REACHES AN INTERNALTEMPERATURE OF 165 DEGREES FOR 15 SECONDS.
MAKE GRAVY MIX PER PACKAGE DIRECTIONS.  ADD SYRUP, SEASONING.  ADD TO MEAT MIXTURE
STIR WELL.
HEAT ENTIRE MIXTURE TO 165 F.  TASTE.  ADD SALT IF NECESSARY.  PAN AND SERVE.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: MST',100);
INSERT INTO "recipes" VALUES (76,'CARROTS (DICED)','165F','Vegetable','4oz','','veggies','Put carrots, water and remaining ingredients into a pan
Cover and heat to 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Sliced Carrots, Whipped Margarine',100);
INSERT INTO "recipes" VALUES (77,'BROCCOLI','165F','Vegetable','4oz','','veggies','In large pan,  combine all ingredients
Cover and heat to 165 degrees, stirring occasionally
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (78,'COLESLAW','MAX TEMP : 40F','Vegetable ','4oz','','veggies','In large pan,  combine all ingredients
Prepare 2 hours prior to serving and refrigerate
Serve cold, hold at 40 degree or below','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (79,'COLESLAW - SWEET & SOUR','MAX Temp: 40F','Vegetable','4oz','','veggies','In large pan,  combine all ingredients
Prepare 2 hours prior to serving and refrigerate
Serve cold, hold at 40 degree or below','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (80,'CORN','165F','Vegetable','4oz','','veggies','Put corn, water and remaining ingredients into a pan
Cover and heat to 165 degrees
Serve hot or hold above 140 degrees
MECH SOFT DIET:  Blend corn til creamed.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (81,'GREEN BEANS','165F','Vegetable','4oz','','veggies','Put green beans, water and remaining ingredients into a pan
Cover and heat to 165 degrees
Serve hot or hold above 140 degrees
MECH SOFT DIET:  Chop beans into 1/4 inch pieces.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (82,'MIXED VEGETABLES','165F','Vegetable','4oz','','veggies','Put mixed vegetables, water and remaining ingredients into a pan
Cover and heat to 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (83,'PEAS','165F','Vegetable','4oz','','veggies','Put peas, water and remaining ingredients into a pan
Cover and heat to 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (84,'GLAZED CARROTS (DICED)','165F','Vegetable','4oz','','veggies','Put carrots, water and remaining ingredients into a pan
Cover and heat to 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Sliced Carrots, Whipped Margarine',100);
INSERT INTO "recipes" VALUES (85,'BAKED BEANS','165F','Starch','4oz     ','144.0','starch','Inspect beans for rocks, sticks prior to rinse.
Rinse and soak beans overnight in large pan/pot or tub
2 hrs before service start cooking beans, until tender.
Drain Water
Add all remaining ingredients, stir occasionally on low heat
Heat to 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (86,'MAC & CHEESE','165F','Starch','8oz  ','334.0','starch','In a separate pot heat water to a boil.  Mix 1 quart cold water per bag of gravy mix.  Add to boiling water.  Add bags of cheese sauce.  Stir til smooth.
Add salt and pepper and mix sauce with cooked macaroni
 Serve hot; hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (87,'MASHED POTATOES (4OZ)','165F','Starch','4oz','','starch','In large pot/tilt skillet, add 1/2 cold water and slowly mix in 1/2 of potato flakes
Add remaining water and heat to boil.  
Stir in salt, pepper and margarine. 
Slowly stir in remaining potatoes
Heat to 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (88,'MASHED POTATOES (8OZ)','165F','Starch','8oz','','starch','In large pot/tilt skillet, add 1/2 cold water and slowly mix in 1/2 of potato flakes
Add remaining water and heat to boil.  
Stir in salt, pepper and margarine. 
Slowly stir in remaining potatoes
Heat to 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (89,'GARLIC MASHED POTATOES','165F','Starch','8oz','','starch','In large pot/tilt skillet, add 1/2 cold water and slowly mix in 1/2 of potato flakes
Add remaining water and heat to boil.  
Stir in salt, pepper, garlic and margarine. 
Slowly stir in remaining potatoes
Heat to 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (90,'CAJUN CHEESE GRITS','165F','Starch','8oz','','starch','Bring water to boil on large pot/tilt skillet
Add salt , pepper and margarine
Slowly add grits, while constantly stirring to avoid lumps
Bring back to a boil, reduce heat.
Stir in cheese sauce and cajun seasoning
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (91,'RANCHERO BEANS','165F','Starch','8oz','','starch','Inspect beans for rocks, sticks prior to rinse.
Rinse and soak beans overnight in large pan/pot or tub
2 hrs before service start cooking beans, until tender.
In a separate pan, use oil to saute onions and bell peppers
Add onions, peppers, and taco seasoning to beans.
Simmer for 10 minutes or until temp reaches 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (92,'REFRIED BEANS','165F','Starch','8oz','','starch','Inspect beans for rocks, sticks prior to rinse.
Rinse and soak beans overnight in large pan/pot or tub
2 hrs before service start cooking beans, until tender.
In a separate pan, use oil to saute onions and bell peppers
Add onions, peppers,  and taco seasoning to beans.
Simmer for 10 minutes or until temp reaches 165 degrees
Put in mixer to mash beans up
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (93,'CHEESY POTATOES','165F','Starch','8oz','','starch','In a large pan, boil water and pour over potatoes
Let stand for at least 15 minutes, the longer time allowed to stand the better the yield
Drain off excess water
In a pan, gently mix water, onions and cheese sauce
Pour cheese sauce over potatoes and salt/pepper and gently fold into mix
Bake at 350 degrees for at least 30 minutes, or until reached 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (94,'FRIED POTATOES','165F','Starch','8oz','','starch','Cut potato into bitesize pieces.  
In a large pan, boil water and add potatoes
In a sheet pan, coat margarine, then scatter on sheet with onions, salt and pepper.  Top with oil
Bake at 450 degrees for at least 10 minutes, or until reached 165 degrees
Flip potatoes gently, cook for additional 5 minutes
Serve hot or hold above 140 degrees 

PREP VARIATION:
Soak potatoes in the refridgerator overnight, drain excess water and cook in oven','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (95,'GERMAN POTATO SALAD ','165F','Starch','4oz','','starch','In a large pan, use oil to saute peppers and onions
Add in remaining ingredients except for potatoes
Mix well and pour over warm potatoes and stir
Heat to 165 degrees
Serve hot or hold above 140 degrees


SERVING VARIATION:
Can be served chilled, Follow proper HACCP cooling procedures. Serve cold or hold below 40 degrees.','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (96,'CHEESE GRITS','165F','Starch','8oz     ','326.0','starch','Bring water to boil on large pot/tilt skillet
Add salt , pepper and margarine
Slowly add grits, while constantly stirring to avoid lumps
Bring back to a boil, reduce heat.
Stir in cheese sauce
Serve hot or hold above 140 dgrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (97,'HASHBROWNS','165F','Starch','8oz','','starch','In a large pan, boil water and pour over potatoes
Let stand for at least 15 minutes, the longer time allowed to stand the better the yield
Drain off excess water
In a sheet pan, coat margarine, then scatter on sheet salt and pepper.  Top with oil
Bake at 450 degrees for at least 10 minutes, or until reached 165 degrees
Flip potatoes gently, cook for additional 5 minutes
Serve hot or hold above 140 degrees ','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (98,'ELBOW NOODLES','165 degrees','Starch','8oz','','starch','In a large pan, combine all ingredients and heat to 165 and noodles are tender 
Serve hot or hold at 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (99,'SPAGHETTI NOODLES','165 degrees','Starch','8oz','','starch','In a large pan, combine all ingredients and heat to 165 and noodles are tender 
Serve hot or hold at 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (100,'ITALIAN PASTA SALAD','40 degrees','Starch','8oz','168.0','starch','In a large pan, combine all ingredients and refrigerate
Serve cold or hold at 40 degrees or less','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (101,'POTATOES OBRIEN','165F','Starch','8oz','','starch','In a large pan, boil water and pour over potatoes
Let stand for at least 15 minutes, the longer time allowed to stand the better the yield
Drain off excess water
Coat sheet pans with margarine then scatter potatoes, peppers and onions, salt and pepper.  Top with oil.
Bake in oven at 450 degrees for 10 minutes, flip potatoes gently and cook for 5 minutes or until 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (102,'CAJUN RICE','165F','Starch','8oz','','starch','In a large pot/tilt skillet, add all ingredients but the rice, and stir
Bring to a boil
Add rice and stir
Cover and cook for 10-15 minutes
Remove from heat and let stand for 10-15 minutes
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (103,'SPANISH RICE','165F','Starch','8oz','','starch','In a large pot/tilt skillet, add all ingredients but the rice, and stir
Bring to a boil
Add rice and stir
Cover and cook for 10-15 minutes
Remove from heat and let stand for 10-15 minutes
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100);
INSERT INTO "recipes" VALUES (104,'WHITE RICE','165F','Starch','8oz','','starch','In a large pot/tilt skillet, add all ingredients but the rice, and stir
Bring to a boil
Add rice and stir
Cover and cook for 10-15 minutes
Remove from heat and let stand for 10-15 minutes
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100);
INSERT INTO "recipes" VALUES (105,'BAKED BREAD','165F','Bread','4oz','','starch','Pour warm water into mixer bowl, add Bread/Roll mix.  Blend on low speed for 1 minute using a dough hook
Stop Mixer, Scrap bowl and hook
Blend on medium speed for 7-10 minutes until dough is well mixed. Do not over mix.
Oil top of dough and allow to rest for 10-15 minutes
Divide dough into  workable units.  Place dough on well-floured surface and knead, incorporating flour.
Form into 3 oz balls and place into greased pan
Proof in a warm spot until double in size (near oven is typically a good spot)
Bake at 350 dgrees for 10-15 minutes
Dough can be made early, divided into 3oz balls and frozen for future use.  
To Bake, thaw, covered in fridge. Pull early in th morning and put in warm spot to proof (double in size) ','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100);
INSERT INTO "recipes" VALUES (106,'BISCUIT','165F','Bread','Grid Cut','','starch','Follow Instructions on bag
Use grid to cut, based on menus grid size.
Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100);
INSERT INTO "recipes" VALUES (107,'CORN BREAD','165F','Bread','Grid Cut','','starch','Follow Instructions on bag
Use grid to cut, based on menus grid size.
Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100);
INSERT INTO "recipes" VALUES (108,'GARLIC BREAD','165F','Bread','4oz','','starch','Pour warm water into mixer bowl, add Bread/Roll mix Blend on low speed for 1 minute using a dough hook.  Stop Mixer, Scrap bowl and hook Blend on medium speed for 7-109 minutes until dough is well mixed. Do not over mix. Oil top of dough and allow to rest for 10-15 minutes Divide dough into  workable units.  Place dough on well-floured surface and knead, incorporating flour. Form into 3 oz balls and place into greased pan.  Proof in a warm spot until double in size (near oven is typically a good spot) Bake at 350 dgrees for 10-15 minutes  Dough can be made early, divided into 3oz balls and frozen for future use.   To Bake, thaw, covered in fridge. Pull early in th morning and put in warm spot to proof (double in size)','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100);
INSERT INTO "recipes" VALUES (109,'CUBED POTATOES','165F','Starch','8oz','','starch','In a large pan, use oil to saute peppers and onions
Add potatoes. Stir well
Heat to 165 degrees
Serve hot or hold above 140 degrees','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: Shredded Potato',100);
INSERT INTO "recipes" VALUES (110,'Yellow Cake','165F','Bread','Grid Cut','','Dessert','Follow Instructions on bag
Use grid to cut, based on menus grid size.
Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ',100);
INSERT INTO "recipes" VALUES (111,'Sugar Cookie Cake','165F','Bread','Grid Cut','','dessert','Follow Instructions on bag
Use grid to cut, based on menus grid size.
Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ',100);
INSERT INTO "recipes" VALUES (112,'White Cake','165F','Bread','Grid Cut','','Dessert','Follow Instructions on bag
Use grid to cut, based on menus grid size.
Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ',100);
INSERT INTO "recipes" VALUES (113,'HONEY BUN COFFEE CAKE','N/A','bread','1/48 cut','','breakfast','Make your yellow cake mix following the instructions on the bag (5lbs of mix to 5 cups of water per pan)
Pour HALF cake mix into greased sheet pans and level
In a separate bowl, mix syrup, cinnamon, powdered sugar vanilla ; pour over batter
add remaining batter;  swirl
Bake at 350 dgrees for 15-20 minutes','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands Use clean and sanitized utensils/equipment while prepping/cooking Return ingredients to refrigerated storage if preparation is interrupted','In order of availability:',100);
INSERT INTO "recipes" VALUES (114,'POWDERED SUGAR GLAZE','','','1/48 cut','791.0','Dessert','Mix all ingredients until smooth, adding more water if necessary.  
Cover tightly until needed.  Stir before using','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ',100);
INSERT INTO "recipes" VALUES (115,'ICED CAKE','N/A','','1/48 cut','295.0','Dessert','Follow Instructions on bag to make cake.  
Mix until smooth, adding more water if necessary.  Allow cake to cool.  Drizzle glaze on top
Use grid to cut, based on menus grid size. Cover, serve within 2 days','Wash hands before handling food and after handling any raw food, or if any interruptions that may contaminate hands
Use clean and sanitized utensils/equipment while prepping/cooking
Return ingredients to refrigerated storage if preparation is interrupted','In order of availability: ',100);
INSERT INTO "recipes" VALUES (120,'Test 33','','veggie','','',NULL,'TEststst 12344','','',100);
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
