CREATE TABLE `alternate_ingredients` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`recipe_id` integer NOT NULL,
	`original_ingredient` text NOT NULL,
	`alternate_ingredient` text NOT NULL,
	`restrictions` text
);
--> statement-breakpoint
CREATE TABLE `cookbook_recipes` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`cookbook_id` integer NOT NULL,
	`recipe_id` integer NOT NULL,
	`ordering` integer
);
--> statement-breakpoint
CREATE TABLE `cookbooks` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`description` text,
	`created` integer
);
--> statement-breakpoint
CREATE TABLE `ingredients` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `ingredients_name_unique` ON `ingredients` (`name`);--> statement-breakpoint
CREATE TABLE `recipe_ingredients` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`recipe_id` integer NOT NULL,
	`ingredient_id` integer NOT NULL,
	`quantity` real NOT NULL,
	`unit` integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE `recipe_restrictions` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`recipe_id` integer NOT NULL,
	`restriction_id` integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE `recipes` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`title` text NOT NULL,
	`minTemp` text,
	`itemType` text,
	`portionSize` text,
	`calories` text,
	`category` text,
	`instructions` text,
	`ccp` text,
	`substitutions` text,
	`initialServings` integer
);
--> statement-breakpoint
CREATE TABLE `restrictions` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `restrictions_name_unique` ON `restrictions` (`name`);--> statement-breakpoint
CREATE TABLE `units` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`conversion_unit` text,
	`conversion_threshold` real,
	`conversion_formula` real
);
--> statement-breakpoint
CREATE UNIQUE INDEX `units_name_unique` ON `units` (`name`);