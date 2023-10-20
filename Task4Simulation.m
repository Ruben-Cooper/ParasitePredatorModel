%% Function Description:
% TODO: this

function Task4Simulation(parasiteMaxAge, foodRotChance, foodAdded, gridSize, simulationLength, title)
% Default Values I was using for testing the function
	arguments
		parasiteMaxAge = 3;
		foodRotChance = 0.1;
		foodAdded = 100;
		gridSize = 200;
		simulationLength = 400;
		title = "Simulation"
	end

	A = rand(gridSize);
	maxPopulation = gridSize * gridSize;

	%% Subplot 1 - Density = 10% & Placement = Random
	populationDensity1 = 0.1 / 2; % Divided by two because this density is shared across two agents
	foodGrid		= A <= populationDensity1;
	parasiteGrid	= A >= 1 - populationDensity1;
	simGrid1 = foodGrid - parasiteGrid;

	%% Subplot 2 - Density = 40% & Placement = Random
	populationDensity2 = 0.4 / 2; % Divided by two because this density is shared across two agents
	foodGrid		= A <= populationDensity2;
	parasiteGrid	= A >= 1 - populationDensity2;
	simGrid2 = foodGrid - parasiteGrid;

	%% Subplot 3 - Density = 10% & Placement = Localised
	populationDensity3 = 0.1 / 2; % Divided by two because this density is shared across two agents
	foodGrid		= A <= populationDensity3;
	parasiteGrid	= A >= 1 - populationDensity3;
	simGrid3 = foodGrid - parasiteGrid;

	%% Subplot 4 - Density = 40% & Placement = Localised
	populationDensity4 = 0.4 / 2; % Divided by two because this density is shared across two agents
	foodGrid		= A <= populationDensity4;
	parasiteGrid	= A >= 1 - populationDensity4;
	simGrid4 = foodGrid - parasiteGrid;

	%% Initialise VideoWriter
	vidObj = VideoWriter(title);
	vidObj.FrameRate = 10;
	open(vidObj);

	fig = figure;
		color = [255 127 0; % Orange
				127 127 127; % Grey
				0 127 255]./255; % Blue
	colormap(color);

	subplot(2,2,1);
	imagesc(simGrid1); % Parasites are represented by -1 and food by 1.
	[parasiteYPos1, parasiteXPos1] = find(simGrid1 == -1);
	numParasites1 = length(parasiteXPos1);
	parasiteXPos1 = [parasiteXPos1; NaN((maxPopulation - numParasites1), 1)];
	parasiteYPos1 = [parasiteYPos1; NaN((maxPopulation - numParasites1), 1)];
	Age1 = zeros(maxPopulation, 1); % Create a matrix of ages for each parasite
	[foodYPos1, foodXPos1] = find(simGrid1 == 1);

	subplot(2,2,2);
	imagesc(simGrid2);
	[parasiteYPos2, parasiteXPos2] = find(simGrid2 == -1);
	numParasites2 = length(parasiteXPos2);
	parasiteXPos2 = [parasiteXPos2; NaN((maxPopulation - numParasites2), 1)];
	parasiteYPos2 = [parasiteYPos2; NaN((maxPopulation - numParasites2), 1)];
	Age2 = zeros(maxPopulation, 1); % Create a matrix of ages for each parasite
	[foodYPos2, foodXPos2] = find(simGrid2 == 1);

	subplot(2,2,3);
	imagesc(simGrid3);
	[parasiteYPos3, parasiteXPos3] = find(simGrid3 == -1);
	numParasites3 = length(parasiteXPos3);
	parasiteXPos3 = [parasiteXPos3; NaN((maxPopulation - numParasites3), 1)];
	parasiteYPos3 = [parasiteYPos3; NaN((maxPopulation - numParasites3), 1)];
	Age3 = zeros(maxPopulation, 1); % Create a matrix of ages for each parasite
	[foodYPos3, foodXPos3] = find(simGrid3 == 1);

	subplot(2,2,4);
	imagesc(simGrid4);
	[parasiteYPos4, parasiteXPos4] = find(simGrid4 == -1);
	numParasites4 = length(parasiteXPos4);
	parasiteXPos4 = [parasiteXPos4; NaN((maxPopulation - numParasites4), 1)];
	parasiteYPos4 = [parasiteYPos4; NaN((maxPopulation - numParasites4), 1)];
	Age4 = zeros(maxPopulation, 1); % Create a matrix of ages for each parasite
	[foodYPos4, foodXPos4] = find(simGrid4 == 1);

	currentFrame = getframe(fig);
	writeVideo(vidObj, currentFrame);

	for i = 1:simulationLength
		
		numParasites1 = sum(~isnan(parasiteXPos1));
		numParasites2 = sum(~isnan(parasiteXPos2));
		numParasites3 = sum(~isnan(parasiteXPos3));
		numParasites4 = sum(~isnan(parasiteXPos4));

		r1 = rand(numParasites1, 1);
		r2 = rand(numParasites2, 1);
		r3 = rand(numParasites3, 1);
		r4 = rand(numParasites4, 1);
		
		%% Subplot 1
		% Check if parasite is too old => kill parasite
		isDead = Age1 > parasiteMaxAge;
		numParasites1 = numParasites1 - sum(isDead);
		Age1(isDead) = NaN;
		parasiteYPos1(isDead) = NaN;
		parasiteXPos1(isDead) = NaN;
		
		% For each Parasite, iterate through and update positions
		
		numParasitesTemp = numParasites1;
		for j = 1:numParasitesTemp % for each parasite
			% Check direction parasite wants to move for obstructions,
			% boundaries and food.
			if isnan(parasiteXPos1(j))
				continue
			end
			if r1(j) < 0.25 && parasiteXPos1(j) ~= 200 && simGrid1(parasiteYPos1(j), parasiteXPos1(j) + 1) ~= -1 % Move East
				if simGrid1(parasiteYPos1(j), parasiteXPos1(j) + 1) == 1 % If food in position to move to
					numParasites1 = numParasites1 + 1; % Number of parasites will increase by one
					Age1(numParasites1) = Age1(j); % Add new age to end of age array to represent old parasite
					Age1(j) = 0; % Reset age of parasite in current position to represent birth
					parasiteXPos1(numParasites1) = parasiteXPos1(j) + 1; % Add an x value for a old parasite in new pos
					parasiteYPos1(numParasites1) = parasiteYPos1(j); % Add corresponding y value for old parasite in new pos
					continue
				end
				parasiteXPos1(j) = parasiteXPos1(j) + 1; % If no food and no obstruction then move to new position
			elseif r1(j) < 0.5 && parasiteXPos1(j) ~= 1 && simGrid1(parasiteYPos1(j), parasiteXPos1(j) - 1) ~= -1 % Move West
				if simGrid1(parasiteYPos1(j), parasiteXPos1(j) - 1) == 1 % If food in position to move to
					numParasites1 = numParasites1 + 1;
					Age1(numParasites1) = Age1(j);
					Age1(j) = 0; % Reset age of parasite in current position to represent birth
					parasiteXPos1(numParasites1) = parasiteXPos1(j) - 1; % Add an x value for a old parasite in new pos
					parasiteYPos1(numParasites1) = parasiteYPos1(j); % Add corresponding y value for old parasite in new pos
					continue
				end
				parasiteXPos1(j) = parasiteXPos1(j) - 1;
			elseif r1(j) < 0.75 && parasiteYPos1(j) ~= 1 && simGrid1(parasiteYPos1(j) - 1, parasiteXPos1(j)) ~= -1 % Move North
				if simGrid1(parasiteYPos1(j) - 1, parasiteXPos1(j)) == 1 % If food in position to move to
					numParasites1 = numParasites1 + 1;
					Age1(numParasites1) = Age1(j);
					Age1(j) = 0; % Reset age of parasite in current position to represent birth
					parasiteXPos1(numParasites1) = parasiteXPos1(j); % Add an corresponding x value for old parasite in new pos
					parasiteYPos1(numParasites1) = parasiteYPos1(j) - 1; % Add y value for old parasite in new pos
					continue
				end
				parasiteYPos1(j) = parasiteYPos1(j) - 1;
			elseif parasiteYPos1(j) ~= 200 && simGrid1(parasiteYPos1(j) + 1, parasiteXPos1(j)) ~= -1 % Move South
				if simGrid1(parasiteYPos1(j) + 1, parasiteXPos1(j)) == 1 % If food in position to move to
					numParasites1 = numParasites1 + 1;
					Age1(numParasites1) = Age1(j);
					Age1(j) = 0; % Reset age of parasite in current position to represent birth
					parasiteXPos1(numParasites1) = parasiteXPos1(j); % Add an corresponding x value for old parasite in new pos
					parasiteYPos1(numParasites1) = parasiteYPos1(j) + 1; % Add y value for old parasite in new pos
					continue
				end
				parasiteYPos1(j) = parasiteYPos1(j) + 1;
			end

		end

		
		%% Subplot 2
		% Check if parasite is too old => kill parasite
		isDead = Age2 > parasiteMaxAge;
		numParasites2 = numParasites2 - sum(isDead);
		Age2(isDead) = NaN;
		parasiteYPos2(isDead) = NaN;
		parasiteXPos2(isDead) = NaN;

		% For each Parasite, iterate through and update positions

		numParasitesTemp = numParasites2;
		for j = 1:numParasitesTemp % for each parasite
			% Check direction parasite wants to move for obstructions,
			% boundaries and food.
			if isnan(parasiteXPos2(j))
				continue
			end
			if r2(j) < 0.25 && parasiteXPos2(j) ~= 200 && simGrid2(parasiteYPos2(j), parasiteXPos2(j) + 1) ~= -1 % Move East
				if simGrid2(parasiteYPos2(j), parasiteXPos2(j) + 1) == 1 % If food in position to move to
					numParasites2 = numParasites2 + 1; % Number of parasites will increase by one
					Age2(numParasites2) = Age2(j); % Add new age to end of age array to represent old parasite
					Age2(j) = 0; % Reset age of parasite in current position to represent birth
					parasiteXPos2(numParasites2) = parasiteXPos2(j) + 1; % Add an x value for a old parasite in new pos
					parasiteYPos2(numParasites2) = parasiteYPos2(j); % Add corresponding y value for old parasite in new pos
					continue
				end
				parasiteXPos2(j) = parasiteXPos2(j) + 1; % If no food and no obstruction then move to new position
			elseif r2(j) < 0.5 && parasiteXPos2(j) ~= 1 && simGrid2(parasiteYPos2(j), parasiteXPos2(j) - 1) ~= -1 % Move West
				if simGrid2(parasiteYPos2(j), parasiteXPos2(j) - 1) == 1 % If food in position to move to
					numParasites2 = numParasites2 + 1;
					Age2(numParasites2) = Age2(j);
					Age2(j) = 0; % Reset age of parasite in current position to represent birth
					parasiteXPos2(numParasites2) = parasiteXPos2(j) - 1; % Add an x value for a old parasite in new pos
					parasiteYPos2(numParasites2) = parasiteYPos2(j); % Add corresponding y value for old parasite in new pos
					continue
				end
				parasiteXPos2(j) = parasiteXPos2(j) - 1;
			elseif r2(j) < 0.75 && parasiteYPos2(j) ~= 1 && simGrid2(parasiteYPos2(j) - 1, parasiteXPos2(j)) ~= -1 % Move North
				if simGrid2(parasiteYPos2(j) - 1, parasiteXPos2(j)) == 1 % If food in position to move to
					numParasites2 = numParasites2 + 1;
					Age2(numParasites2) = Age2(j);
					Age2(j) = 0; % Reset age of parasite in current position to represent birth
					parasiteXPos2(numParasites2) = parasiteXPos2(j); % Add an corresponding x value for old parasite in new pos
					parasiteYPos2(numParasites2) = parasiteYPos2(j) - 1; % Add y value for old parasite in new pos
					continue
				end
				parasiteYPos2(j) = parasiteYPos2(j) - 1;
			elseif parasiteYPos2(j) ~= 200 && simGrid2(parasiteYPos2(j) + 1, parasiteXPos2(j)) ~= -1 % Move South
				if simGrid2(parasiteYPos2(j) + 1, parasiteXPos2(j)) == 1 % If food in position to move to
					numParasites2 = numParasites2 + 1;
					Age2(numParasites2) = Age2(j);
					Age2(j) = 0; % Reset age of parasite in current position to represent birth
					parasiteXPos2(numParasites2) = parasiteXPos2(j); % Add an corresponding x value for old parasite in new pos
					parasiteYPos2(numParasites2) = parasiteYPos2(j) + 1; % Add y value for old parasite in new pos
					continue
				end
				parasiteYPos2(j) = parasiteYPos2(j) + 1;
			end

		end


		% %% Subplot 3
		% % Check if parasite is too old => kill parasite
		% isDead = Age3 > parasiteMaxAge;
		% numParasites3 = numParasites3 - sum(isDead);
		% Age3(isDead) = NaN;
		% parasiteYPos3(isDead) = NaN;
		% parasiteXPos3(isDead) = NaN;
		% 
		% % For each Parasite, iterate through and update positions
		% 
		% numParasitesTemp = numParasites3;
		% for j = 1:numParasitesTemp % for each parasite
		% 	% Check direction parasite wants to move for obstructions,
		% 	% boundaries and food.
		% 	if isnan(parasiteXPos3(j))
			% 	continue
		% 	end
		% 	if r3(j) < 0.25 && parasiteXPos3(j) ~= 200 && simGrid3(parasiteYPos3(j), parasiteXPos3(j) + 1) ~= -1 % Move East
			% 	if simGrid3(parasiteYPos3(j), parasiteXPos3(j) + 1) == 1 % If food in position to move to
				% 	numParasites3 = numParasites3 + 1; % Number of parasites will increase by one
				% 	Age3(numParasites3) = Age3(j); % Add new age to end of age array to represent old parasite
				% 	Age3(j) = 0; % Reset age of parasite in current position to represent birth
				% 	parasiteXPos3(numParasites3) = parasiteXPos3(j) + 1; % Add an x value for a old parasite in new pos
				% 	parasiteYPos3(numParasites3) = parasiteYPos3(j); % Add corresponding y value for old parasite in new pos
				% 	continue
			% 	end
			% 	parasiteXPos3(j) = parasiteXPos3(j) + 1; % If no food and no obstruction then move to new position
		% 	elseif r3(j) < 0.5 && parasiteXPos3(j) ~= 1 && simGrid3(parasiteYPos3(j), parasiteXPos3(j) - 1) ~= -1 % Move West
			% 	if simGrid3(parasiteYPos3(j), parasiteXPos3(j) - 1) == 1 % If food in position to move to
				% 	numParasites3 = numParasites3 + 1;
				% 	Age3(numParasites3) = Age3(j);
				% 	Age3(j) = 0; % Reset age of parasite in current position to represent birth
				% 	parasiteXPos3(numParasites3) = parasiteXPos3(j) - 1; % Add an x value for a old parasite in new pos
				% 	parasiteYPos3(numParasites3) = parasiteYPos3(j); % Add corresponding y value for old parasite in new pos
				% 	continue
			% 	end
			% 	parasiteXPos3(j) = parasiteXPos3(j) - 1;
		% 	elseif r3(j) < 0.75 && parasiteYPos3(j) ~= 1 && simGrid3(parasiteYPos3(j) - 1, parasiteXPos3(j)) ~= -1 % Move North
			% 	if simGrid3(parasiteYPos3(j) - 1, parasiteXPos3(j)) == 1 % If food in position to move to
				% 	numParasites3 = numParasites3 + 1;
				% 	Age3(numParasites3) = Age3(j);
				% 	Age3(j) = 0; % Reset age of parasite in current position to represent birth
				% 	parasiteXPos3(numParasites3) = parasiteXPos3(j); % Add an corresponding x value for old parasite in new pos
				% 	parasiteYPos3(numParasites3) = parasiteYPos3(j) - 1; % Add y value for old parasite in new pos
				% 	continue
			% 	end
			% 	parasiteYPos3(j) = parasiteYPos3(j) - 1;
		% 	elseif parasiteYPos3(j) ~= 200 && simGrid3(parasiteYPos3(j) + 1, parasiteXPos3(j)) ~= -1 % Move South
			% 	if simGrid3(parasiteYPos3(j) + 1, parasiteXPos3(j)) == 1 % If food in position to move to
				% 	numParasites3 = numParasites3 + 1;
				% 	Age3(numParasites3) = Age3(j);
				% 	Age3(j) = 0; % Reset age of parasite in current position to represent birth
				% 	parasiteXPos3(numParasites3) = parasiteXPos3(j); % Add an corresponding x value for old parasite in new pos
				% 	parasiteYPos3(numParasites3) = parasiteYPos3(j) + 1; % Add y value for old parasite in new pos
				% 	continue
			% 	end
			% 	parasiteYPos3(j) = parasiteYPos3(j) + 1;
		% 	end
		% 
		% end


		% %% Subplot 4
		% Check if parasite is too old => kill parasite
		% isDead = Age4 > parasiteMaxAge;
		% numParasites4 = numParasites4 - sum(isDead);
		% Age4(isDead) = NaN;
		% parasiteYPos4(isDead) = NaN;
		% parasiteXPos4(isDead) = NaN;
		% 
		% For each Parasite, iterate through and update positions
		% 
		% numParasitesTemp = numParasites4;
		% for j = 1:numParasitesTemp % for each parasite
		% 	Check direction parasite wants to move for obstructions,
		% 	boundaries and food.
		% 	if isnan(parasiteXPos4(j))
			% 	continue
		% 	end
		% 	if r4(j) < 0.25 && parasiteXPos4(j) ~= 200 && simGrid4(parasiteYPos4(j), parasiteXPos4(j) + 1) ~= -1 % Move East
			% 	if simGrid4(parasiteYPos4(j), parasiteXPos4(j) + 1) == 1 % If food in position to move to
				% 	numParasites4 = numParasites4 + 1; % Number of parasites will increase by one
				% 	Age4(numParasites4) = Age4(j); % Add new age to end of age array to represent old parasite
				% 	Age4(j) = 0; % Reset age of parasite in current position to represent birth
				% 	parasiteXPos4(numParasites4) = parasiteXPos4(j) + 1; % Add an x value for a old parasite in new pos
				% 	parasiteYPos4(numParasites4) = parasiteYPos4(j); % Add corresponding y value for old parasite in new pos
				% 	continue
			% 	end
			% 	parasiteXPos4(j) = parasiteXPos4(j) + 1; % If no food and no obstruction then move to new position
		% 	elseif r4(j) < 0.5 && parasiteXPos4(j) ~= 1 && simGrid4(parasiteYPos4(j), parasiteXPos4(j) - 1) ~= -1 % Move West
			% 	if simGrid4(parasiteYPos4(j), parasiteXPos4(j) - 1) == 1 % If food in position to move to
				% 	numParasites4 = numParasites4 + 1;
				% 	Age4(numParasites4) = Age4(j);
				% 	Age4(j) = 0; % Reset age of parasite in current position to represent birth
				% 	parasiteXPos4(numParasites4) = parasiteXPos4(j) - 1; % Add an x value for a old parasite in new pos
				% 	parasiteYPos4(numParasites4) = parasiteYPos4(j); % Add corresponding y value for old parasite in new pos
				% 	continue
			% 	end
			% 	parasiteXPos4(j) = parasiteXPos4(j) - 1;
		% 	elseif r4(j) < 0.75 && parasiteYPos4(j) ~= 1 && simGrid4(parasiteYPos4(j) - 1, parasiteXPos4(j)) ~= -1 % Move North
			% 	if simGrid4(parasiteYPos4(j) - 1, parasiteXPos4(j)) == 1 % If food in position to move to
				% 	numParasites4 = numParasites4 + 1;
				% 	Age4(numParasites4) = Age4(j);
				% 	Age4(j) = 0; % Reset age of parasite in current position to represent birth
				% 	parasiteXPos4(numParasites4) = parasiteXPos4(j); % Add an corresponding x value for old parasite in new pos
				% 	parasiteYPos4(numParasites4) = parasiteYPos4(j) - 1; % Add y value for old parasite in new pos
				% 	continue
			% 	end
			% 	parasiteYPos4(j) = parasiteYPos4(j) - 1;
		% 	elseif parasiteYPos4(j) ~= 200 && simGrid4(parasiteYPos4(j) + 1, parasiteXPos4(j)) ~= -1 % Move South
			% 	if simGrid4(parasiteYPos4(j) + 1, parasiteXPos4(j)) == 1 % If food in position to move to
				% 	numParasites4 = numParasites4 + 1;
				% 	Age4(numParasites4) = Age4(j);
				% 	Age4(j) = 0; % Reset age of parasite in current position to represent birth
				% 	parasiteXPos4(numParasites4) = parasiteXPos4(j); % Add an corresponding x value for old parasite in new pos
				% 	parasiteYPos4(numParasites4) = parasiteYPos4(j) + 1; % Add y value for old parasite in new pos
				% 	continue
			% 	end
			% 	parasiteYPos4(j) = parasiteYPos4(j) + 1;
		% 	end
		% 
		% end


		%% For each piece of food, determine if rotten and deleted
		isRotten = rand(length(foodXPos1), 1) < foodRotChance;
		foodXPos1 = foodXPos1(~isRotten); % Delete xPos of all food that isRotten
		foodYPos1 = foodYPos1(~isRotten); % Delete yPos of all food that isRotten
		
		isRotten = rand(length(foodXPos2), 1) < foodRotChance;
		foodXPos2 = foodXPos2(~isRotten); % Delete xPos of all food that isRotten
		foodYPos2 = foodYPos2(~isRotten); % Delete yPos of all food that isRotten

		isRotten = rand(length(foodXPos3), 1) < foodRotChance;
		foodXPos3 = foodXPos3(~isRotten); % Delete xPos of all food that isRotten
		foodYPos3 = foodYPos3(~isRotten); % Delete yPos of all food that isRotten

		isRotten = rand(length(foodXPos4), 1) < foodRotChance;
		foodXPos4 = foodXPos4(~isRotten); % Delete xPos of all food that isRotten
		foodYPos4 = foodYPos4(~isRotten); % Delete yPos of all food that isRotten

		%% Recreate simGrid with updated locations
		%% Subplot 1
		simGrid1 = zeros(size(simGrid1)); % Clear simGrid ready for inputting new parasite and food locations
		
		parasiteIndices = sub2ind(size(simGrid1), parasiteYPos1(~isnan(parasiteYPos1)), parasiteXPos1(~isnan(parasiteXPos1))); % convert subscripts to linear indices
		simGrid1(parasiteIndices) = -1; % assign -1 to the elements at the linear indices to represent parasites
		foodIndices = sub2ind(size(simGrid1), foodYPos1, foodXPos1); % convert subscripts to linear indices
		simGrid1(foodIndices) = 1; % assign 1 to the elements at the linear indices to represent food
		
		% Place food on empty squares within grid
		emptyGridSquares = find(simGrid1 == 0);
		newFoodSquares = emptyGridSquares(randperm(length(emptyGridSquares), foodAdded));
		simGrid1(newFoodSquares) = 1;

		subplot(2, 2, 1);
		imagesc(simGrid1);
		
		%% Subplot 2
		simGrid2 = zeros(size(simGrid2)); % Clear simGrid ready for inputting new parasite and food locations
		
		parasiteIndices = sub2ind(size(simGrid2), parasiteYPos2(~isnan(parasiteYPos2)), parasiteXPos2(~isnan(parasiteXPos2))); % convert subscripts to linear indices
		simGrid2(parasiteIndices) = -1; % assign -1 to the elements at the linear indices to represent parasites
		foodIndices = sub2ind(size(simGrid2), foodYPos2, foodXPos2); % convert subscripts to linear indices
		simGrid2(foodIndices) = 1; % assign 1 to the elements at the linear indices to represent food
		
		emptyGridSquares = find(simGrid2 == 0);
		newFoodSquares = emptyGridSquares(randperm(length(emptyGridSquares), foodAdded));
		simGrid2(newFoodSquares) = 1;
		
		subplot(2, 2, 2);
		imagesc(simGrid2);
		
		%% Subplot 3
		simGrid3 = zeros(size(simGrid3)); % Clear simGrid ready for inputting new parasite and food locations
		
		parasiteIndices = sub2ind(size(simGrid3), parasiteYPos3(~isnan(parasiteYPos3)), parasiteXPos3(~isnan(parasiteXPos3))); % convert subscripts to linear indices
		simGrid3(parasiteIndices) = -1; % assign -1 to the elements at the linear indices to represent parasites
		foodIndices = sub2ind(size(simGrid3), foodYPos3, foodXPos3); % convert subscripts to linear indices
		simGrid3(foodIndices) = 1; % assign 1 to the elements at the linear indices to represent food
		
		emptyGridSquares = find(simGrid3 == 0);
		newFoodSquares = emptyGridSquares(randperm(length(emptyGridSquares), foodAdded));
		simGrid3(newFoodSquares) = 1;

		subplot(2, 2, 3);
		imagesc(simGrid3);
		
		%% Subplot 4
		simGrid4 = zeros(size(simGrid4)); % Clear simGrid ready for inputting new parasite and food locations
		
		parasiteIndices = sub2ind(size(simGrid4), parasiteYPos4(~isnan(parasiteYPos4)), parasiteXPos4(~isnan(parasiteXPos4))); % convert subscripts to linear indices
		simGrid4(parasiteIndices) = -1; % assign -1 to the elements at the linear indices to represent parasites
		foodIndices = sub2ind(size(simGrid4), foodYPos4, foodXPos4); % convert subscripts to linear indices
		simGrid4(foodIndices) = 1; % assign 1 to the elements at the linear indices to represent food
		
		emptyGridSquares = find(simGrid4 == 0);
		newFoodSquares = emptyGridSquares(randperm(length(emptyGridSquares), foodAdded));
		simGrid4(newFoodSquares) = 1;

		subplot(2, 2, 4);
		imagesc(simGrid4);

		%% Create Frame

		currentFrame = getframe(fig);
		writeVideo(vidObj, currentFrame);
		
		Age1(1:numParasites1) = Age1(1:numParasites1) + 1;
		Age2(1:numParasites2) = Age2(1:numParasites2) + 1;
		Age3(1:numParasites3) = Age3(1:numParasites3) + 1;
		Age4(1:numParasites4) = Age4(1:numParasites4) + 1;
	end
	close(vidObj);
end