function adjustedGrid = placeFood(foodToAdd, locationVec, simGrid)
% Takes in the amount of food to add, the position to attempt to add that
% food, and the current simGrid and returns a new simGrid with new food
% added in the nearest positions around the position to attempt.

row = locationVec(1);
col = locationVec(2);

% Find the indices of all empty cells in the grid
[empty_row, empty_col] = find(simGrid == 0);

% Calculate the distance from each empty cell to the location
dist = sqrt((empty_row - row).^2 + (empty_col - col).^2);

% Sort the distances in ascending order and get the corresponding indices
[~,sorted_idx] = sort(dist);

% Get the first n indices of the sorted empty cells
selected_idx = sorted_idx(1:foodToAdd);

% Place n particles at the selected empty cells
simGrid(sub2ind(size(simGrid), empty_row(selected_idx), empty_col(selected_idx))) = 1;

% Return the updated grid
adjustedGrid = simGrid;
end