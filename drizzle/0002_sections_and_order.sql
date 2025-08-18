-- Add recipe_sections table and ordering/section_id to recipe_ingredients
-- D1 note: avoid explicit transactions; run statements individually.

-- Create sections table
CREATE TABLE IF NOT EXISTS "recipe_sections" (
  "id" integer PRIMARY KEY AUTOINCREMENT,
  "recipe_id" integer NOT NULL,
  "name" text NOT NULL,
  "ordering" integer NOT NULL
);

-- Add new columns to recipe_ingredients if not present
ALTER TABLE "recipe_ingredients" ADD COLUMN "ordering" integer;
ALTER TABLE "recipe_ingredients" ADD COLUMN "section_id" integer;

-- Optional backfill: set ordering to rowid (or 0) where null
UPDATE "recipe_ingredients"
SET "ordering" = COALESCE("ordering", rowid);
