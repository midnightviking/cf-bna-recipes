/**
 * Drag and Drop utilities for recipe reordering with SortableJS
 */

/**
 * Reorder an array by moving element from 'from' index to 'to' index
 * @param {number[]} order - The current order array
 * @param {number} from - Source index
 * @param {number} to - Target index
 * @returns {number[]} - New reordered array
 */
export function reorderArray(order, from, to) {
	if (from === to || from == null || to == null) return order;
	const newOrder = [...order];
	const [moved] = newOrder.splice(from, 1);
	newOrder.splice(to, 0, moved);
	return newOrder;
}

/**
 * Get displayable recipe objects from IDs
 * @param {number[]} selectedIds - Array of selected recipe IDs
 * @param {Object[]} allRecipes - All available recipes
 * @returns {Object[]} - Filtered and ordered recipes
 */
export function getOrderedRecipes(selectedIds, allRecipes) {
	return selectedIds
		.map((id) => allRecipes.find((r) => r?.id === id))
		.filter(Boolean);
}

/**
 * Handle keyboard navigation for reordering (Arrow keys)
 * @param {KeyboardEvent} event - The keyboard event
 * @param {number} idx - Current index
 * @param {number} maxIdx - Maximum valid index
 * @param {number[]} selectedIds - Selected recipe IDs
 * @returns {number[]|null} - New selectedIds if reordered, null otherwise
 */
export function handleKeyboardReorder(event, idx, maxIdx, selectedIds) {
	if (event.key === 'ArrowUp' && idx > 0) {
		event.preventDefault();
		return reorderArray(selectedIds, idx, idx - 1);
	} else if (event.key === 'ArrowDown' && idx < maxIdx) {
		event.preventDefault();
		return reorderArray(selectedIds, idx, idx + 1);
	}
	return null;
}
