// Drizzle ORM schema for SQLite and D1
import { numeric } from 'drizzle-orm/pg-core';
import { sqliteTable, integer, text, real } from 'drizzle-orm/sqlite-core';

export const extensions = sqliteTable('extensions', {
  id: integer('id').primaryKey({ autoIncrement: true }),
  name: text('name').notNull().unique(),
});

export const recipe_extensions = sqliteTable('recipe_extensions', {
  id: integer('id').primaryKey({ autoIncrement: true }),
  recipe_id: integer('recipe_id').notNull(),
  extension_id: integer('extension_id').notNull(),
});

export const alternate_ingredients = sqliteTable('alternate_ingredients', {
  id: integer('id').primaryKey({ autoIncrement: true }),
  recipe_id: integer('recipe_id').notNull(),
  original_ingredient: integer('original_ingredient'),
  alternate_ingredient: integer('alternate_ingredient').notNull(),
  quantity: numeric('quantity').notNull(),
  unit_id: integer('unit_id').notNull(),
  // Store extensions as a comma-separated string of IDs for simplicity
  extensions: text('extensions').notNull(), // comma-separated extension ids
});

export const ingredients = sqliteTable('ingredients', {
	id: integer('id').primaryKey({ autoIncrement: true }),
	name: text('name').notNull().unique(),
});

export const units = sqliteTable('units', {
	id: integer('id').primaryKey({ autoIncrement: true }),
	name: text('name').notNull().unique(),
	conversion_unit: text('conversion_unit'),
	conversion_threshold: numeric('conversion_threshold'),
	conversion_formula: numeric('conversion_formula'),
});

export const recipes = sqliteTable('recipes', {
	id: integer('id').primaryKey({ autoIncrement: true }),
	title: text('title').notNull(),
	minTemp: text('minTemp'),
	itemType: text('itemType'),
	portionSize: text('portionSize'),
	calories: text('calories'),
	protein: text('protein'),
	category: text('category'),
	instructions: text('instructions'),
	ccp: text('ccp'),
	substitutions: text('substitutions'),
	initialServings: integer('initialServings'),
});

// Sections within a recipe (e.g., Soup, Dumplings) with explicit ordering
export const recipe_sections = sqliteTable('recipe_sections', {
	id: integer('id').primaryKey({ autoIncrement: true }),
	recipe_id: integer('recipe_id').notNull(),
	name: text('name').notNull(),
	ordering: integer('ordering').notNull(),
});

export const cookbooks = sqliteTable('cookbooks', {
	id: integer('id').primaryKey({ autoIncrement: true }),
	name: text('name').notNull(),
	description: text('description'),
	created: integer('created'),
});

export const recipe_ingredients = sqliteTable('recipe_ingredients', {
	id: integer('id').primaryKey({ autoIncrement: true }),
	recipe_id: integer('recipe_id').notNull(),
	ingredient_id: integer('ingredient_id').notNull(),
	quantity: numeric('quantity').notNull(),
	unit: integer('unit').notNull(),
	// Legacy: "order" existed previously; prefer "ordering" going forward
	// order: integer('order'),
	ordering: integer('ordering'),
	section_id: integer('section_id'),

	
});

export const cookbook_recipes = sqliteTable('cookbook_recipes', {
	id: integer('id').primaryKey({ autoIncrement: true }),
	cookbook_id: integer('cookbook_id').notNull(),
	recipe_id: integer('recipe_id').notNull(),
	ordering: integer('ordering'),
});
