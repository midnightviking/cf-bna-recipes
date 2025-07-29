-- Migration: Rename 'restrictions' column to 'extensions' in alternate_ingredients table
-- 1. Add the new column
ALTER TABLE alternate_ingredients ADD COLUMN extensions TEXT;

-- 2. Copy data from old column to new column
UPDATE alternate_ingredients SET extensions = restrictions;

-- 3. (Optional) To drop the old column, you must recreate the table in SQLite. If you want a clean schema, uncomment and use the following steps:
--
BEGIN TRANSACTION;
CREATE TABLE alternate_ingredients_new (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  recipe_id INTEGER NOT NULL,
  original_ingredient TEXT NOT NULL,
  alternate_ingredient TEXT NOT NULL,
  unit_id INTEGER NOT NULL,
  quantity REAL NOT NULL,
  extensions TEXT
);
INSERT INTO alternate_ingredients_new (id, recipe_id, original_ingredient, alternate_ingredient, extensions)
  SELECT id, recipe_id, original_ingredient, alternate_ingredient, extensions FROM alternate_ingredients;
DROP TABLE alternate_ingredients;
ALTER TABLE alternate_ingredients_new RENAME TO alternate_ingredients;
COMMIT;

-- If you do not need to drop the old column, steps 1 and 2 are sufficient for most use cases.
