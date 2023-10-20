%% Function Description:
% TODO: this

function Task4Simulation(parasiteMaxAge, foodRotChance, foodAdded, gridSize, simulationLength, title)
% Default Values I was using for testing the function
	arguments
		parasiteMaxAge = 10;
		foodRotChance = 0.01;
		foodAdded = 300;
		gridSize = 200;
		simulationLength = 400;
		title = "Simulation"
	end

	A = rand(gridSize);
	maxPopulation = gridSize * gridSize * 100;
	

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
	foodNeeded = populationDensity3 * gridSize * gridSize;
	foodGrid = placeFood(foodNeeded/2,[50, 50], zeros(gridSize));
	foodGrid = placeFood(foodNeeded/2,[150, 150], foodGrid);
	parasiteGrid	= A >= 1 - populationDensity3;
	simGrid3 = foodGrid - parasiteGrid;

	%% Subplot 4 - Density = 40% & Placement = Localised
	populationDensity4 = 0.4 / 2; % Divided by two because this density is shared across two agents
	foodNeeded = populationDensity4 * gridSize * gridSize;
	foodGrid = placeFood(foodNeeded/2,[50, 50], zeros(gridSize));
	foodGrid = placeFood(foodNeeded/2,[150, 150], foodGrid);
	parasiteGrid	= A >= 1 - populationDensity4;
	simGrid4 = foodGrid - parasiteGrid;

	%% Initialise VideoWriter
	vidObj = VideoWriter(title);
	vidObj.FrameRate = 10;
	open(vidObj);

	fig = figure('Position',[100 100 1200 1200]);
		color = [255 127 0; % Orange
				127 127 127; % Grey
				0 127 255]./255; % Blue
	colormap(color);
	pbaspect([1 1 1]);

	%% Initial plotting of simGrid to show placement of parasites and food
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

	numParasites = zeros(simulationLength, 4);

	%% Simulation itself
	for i = 1:simulationLength
		
		numParasites1 = sum(~isnan(parasiteXPos1));
		numParasites2 = sum(~isnan(parasiteXPos2));
		numParasites3 = sum(~isnan(parasiteXPos3));
		numParasites4 = sum(~isnan(parasiteXPos4));

		r1 = rand(maxPopulation, 1);
		r2 = rand(maxPopulation, 1);
		r3 = rand(maxPopulation, 1);
		r4 = rand(maxPopulation, 1);
		
				%% Subplot 1
		% Check if parasite is too old => kill parasite
		isDead = simGrid1 == (parasiteMaxAge) *(-1);
		numParasites1 = numParasites1 - sum(sum(isDead));
		parasiteYPos1(isDead) = NaN;
		parasiteXPos1(isDead) = NaN;
		simGrid1(isDead) = 0;

		% For each Parasite, iterate through and update positions
		
		numParasitesTemp = numParasites1;
		for j = 1:numParasitesTemp % for each parasite
			% Check direction parasite wants to move for obstructions,
			% boundaries and food.
			if isnan(parasiteXPos1(j))
				continue
			end
			if r1(j) < 0.25 && parasiteXPos1(j) ~= 200 && simGrid1(parasiteYPos1(j), parasiteXPos1(j) + 1) >= 0 % Move East
				if simGrid1(parasiteYPos1(j), parasiteXPos1(j) + 1) == 1 % If food in position to move to
					numParasites1 = numParasites1 + 1; % Number of parasites will increase by one
					simGrid1(parasiteYPos1(j), parasiteXPos1(j) + 1) = simGrid1(parasiteYPos1(j), parasiteXPos1(j)); % Add new age to end of age array to represent old parasite
					simGrid1(parasiteYPos1(j), parasiteXPos1(j)) = -1;
					parasiteXPos1(numParasites1) = parasiteXPos1(j) + 1; % Add an x value for a old parasite in new pos
					parasiteYPos1(numParasites1) = parasiteYPos1(j); % Add corresponding y value for old parasite in new pos
				else
					parasiteXPos1(j) = parasiteXPos1(j) + 1; % If no food and no obstruction then move to new position
				end
			elseif r1(j) < 0.5 && parasiteXPos1(j) ~= 1 && simGrid1(parasiteYPos1(j), parasiteXPos1(j) - 1) >= 0 % Move West
				if simGrid1(parasiteYPos1(j), parasiteXPos1(j) - 1) == 1 % If food in position to move to
					numParasites1 = numParasites1 + 1;
					simGrid1(parasiteYPos1(j), parasiteXPos1(j) - 1) = simGrid1(parasiteYPos1(j), parasiteXPos1(j)); % Add new age to end of age array to represent old parasite
					simGrid1(parasiteYPos1(j), parasiteXPos1(j)) = -1;
					parasiteXPos1(numParasites1) = parasiteXPos1(j) - 1; % Add an x value for a old parasite in new pos
					parasiteYPos1(numParasites1) = parasiteYPos1(j); % Add corresponding y value for old parasite in new pos
				else
					parasiteXPos1(j) = parasiteXPos1(j) - 1;
				end
			elseif r1(j) < 0.75 && parasiteYPos1(j) ~= 1 && simGrid1(parasiteYPos1(j) - 1, parasiteXPos1(j)) >= 0 % Move North
				if simGrid1(parasiteYPos1(j) - 1, parasiteXPos1(j)) == 1 % If food in position to move to
					numParasites1 = numParasites1 + 1;
					simGrid1(parasiteYPos1(j)-1, parasiteXPos1(j)) = simGrid1(parasiteYPos1(j), parasiteXPos1(j)); % Add new age to end of age array to represent old parasite
					simGrid1(parasiteYPos1(j), parasiteXPos1(j)) = -1;
					parasiteXPos1(numParasites1) = parasiteXPos1(j); % Add an corresponding x value for old parasite in new pos
					parasiteYPos1(numParasites1) = parasiteYPos1(j) - 1; % Add y value for old parasite in new pos
				else
					parasiteYPos1(j) = parasiteYPos1(j) - 1;
				end
			elseif parasiteYPos1(j) ~= 200 && simGrid1(parasiteYPos1(j) + 1, parasiteXPos1(j)) >= 0 % Move South
				if simGrid1(parasiteYPos1(j) + 1, parasiteXPos1(j)) == 1 % If food in position to move to
					numParasites1 = numParasites1 + 1;
					simGrid1(parasiteYPos1(j)+1, parasiteXPos1(j)) = simGrid1(parasiteYPos1(j), parasiteXPos1(j)); % Add new age to end of age array to represent old parasite
					simGrid1(parasiteYPos1(j), parasiteXPos1(j)) = -1;
					parasiteXPos1(numParasites1) = parasiteXPos1(j); % Add an corresponding x value for old parasite in new pos
					parasiteYPos1(numParasites1) = parasiteYPos1(j) + 1; % Add y value for old parasite in new pos
				else
					parasiteYPos1(j) = parasiteYPos1(j) + 1;
				end
			end

		end

		


		
		%% Subplot 2
		% Check if parasite is too old => kill parasite
		isDead = simGrid2 == (parasiteMaxAge) *(-1);
		numParasites2 = numParasites2 - sum(sum(isDead));
		parasiteYPos2(isDead) = NaN;
		parasiteXPos2(isDead) = NaN;
		simGrid2(isDead) = 0;
		% For each Parasite, iterate through and update positions

		numParasitesTemp = numParasites2;
		for j = 1:numParasitesTemp % for each parasite
			% Check direction parasite wants to move for obstructions,
			% boundaries and food.
			if isnan(parasiteXPos2(j))
				continue
			end
			if r2(j) < 0.25 && parasiteXPos2(j) ~= 200 && simGrid2(parasiteYPos2(j), parasiteXPos2(j) + 1) >= 0 % Move East
				if simGrid2(parasiteYPos2(j), parasiteXPos2(j) + 1) == 1 % If food in position to move to
					numParasites2 = numParasites2 + 1; % Number of parasites will increase by one
					simGrid2(parasiteYPos2(j), parasiteXPos2(j) + 1) = simGrid2(parasiteYPos2(j), parasiteXPos2(j)); % Add new age to end of age array to represent old parasite
					simGrid2(parasiteYPos2(j), parasiteXPos2(j)) = -1;
					parasiteXPos2(numParasites2) = parasiteXPos2(j) + 1; % Add an x value for a old parasite in new pos
					parasiteYPos2(numParasites2) = parasiteYPos2(j); % Add corresponding y value for old parasite in new pos
				else
					parasiteXPos2(j) = parasiteXPos2(j) + 1; % If no food and no obstruction then move to new position
				end
			elseif r2(j) < 0.5 && parasiteXPos2(j) ~= 1 && simGrid2(parasiteYPos2(j), parasiteXPos2(j) - 1) >= 0 % Move West
				if simGrid2(parasiteYPos2(j), parasiteXPos2(j) - 1) == 1 % If food in position to move to
					numParasites2 = numParasites2 + 1;
					simGrid2(parasiteYPos2(j), parasiteXPos2(j) - 1) = simGrid2(parasiteYPos2(j), parasiteXPos2(j)); % Add new age to end of age array to represent old parasite
					simGrid2(parasiteYPos2(j), parasiteXPos2(j)) = -1;
					parasiteXPos2(numParasites2) = parasiteXPos2(j) - 1; % Add an x value for a old parasite in new pos
					parasiteYPos2(numParasites2) = parasiteYPos2(j); % Add corresponding y value for old parasite in new pos
				else
					parasiteXPos2(j) = parasiteXPos2(j) - 1;
				end
			elseif r2(j) < 0.75 && parasiteYPos2(j) ~= 1 && simGrid2(parasiteYPos2(j) - 1, parasiteXPos2(j)) >= 0 % Move North
				if simGrid2(parasiteYPos2(j) - 1, parasiteXPos2(j)) == 1 % If food in position to move to
					numParasites2 = numParasites2 + 1;
					simGrid2(parasiteYPos2(j)-1, parasiteXPos2(j)) = simGrid2(parasiteYPos2(j), parasiteXPos2(j)); % Add new age to end of age array to represent old parasite
					simGrid2(parasiteYPos2(j), parasiteXPos2(j)) = -1;
					parasiteXPos2(numParasites2) = parasiteXPos2(j); % Add an corresponding x value for old parasite in new pos
					parasiteYPos2(numParasites2) = parasiteYPos2(j) - 1; % Add y value for old parasite in new pos
				else
					parasiteYPos2(j) = parasiteYPos2(j) - 1;
				end
			elseif parasiteYPos2(j) ~= 200 && simGrid2(parasiteYPos2(j) + 1, parasiteXPos2(j)) >= 0 % Move South
				if simGrid2(parasiteYPos2(j) + 1, parasiteXPos2(j)) == 1 % If food in position to move to
					numParasites2 = numParasites2 + 1;
					simGrid2(parasiteYPos2(j)+1, parasiteXPos2(j)) = simGrid2(parasiteYPos2(j), parasiteXPos2(j)); % Add new age to end of age array to represent old parasite
					simGrid2(parasiteYPos2(j), parasiteXPos2(j)) = -1;
					parasiteXPos2(numParasites2) = parasiteXPos2(j); % Add an corresponding x value for old parasite in new pos
					parasiteYPos2(numParasites2) = parasiteYPos2(j) + 1; % Add y value for old parasite in new pos
				else
					parasiteYPos2(j) = parasiteYPos2(j) + 1;
				end
			end

		end


	%% Subplot 3
		% Check if parasite is too old => kill parasite
		isDead = simGrid3 == (parasiteMaxAge) *(-1);
		numParasites3 = numParasites3 - sum(sum(isDead));
		parasiteYPos3(isDead) = NaN;
		parasiteXPos3(isDead) = NaN;
		simGrid3(isDead) = 0;
		% For each Parasite, iterate through and update positions

		numParasitesTemp = numParasites3;
		for j = 1:numParasitesTemp % for each parasite
			% Check direction parasite wants to move for obstructions,
			% boundaries and food.
			if isnan(parasiteXPos3(j))
				continue
			end
			if r3(j) < 0.25 && parasiteXPos3(j) ~= 200 && simGrid3(parasiteYPos3(j), parasiteXPos3(j) + 1) >= 0 % Move East
				if simGrid3(parasiteYPos3(j), parasiteXPos3(j) + 1) == 1 % If food in position to move to
					numParasites3 = numParasites3 + 1; % Number of parasites will increase by one
					simGrid3(parasiteYPos3(j), parasiteXPos3(j) + 1) = simGrid3(parasiteYPos3(j), parasiteXPos3(j)); % Add new age to end of age array to represent old parasite
					simGrid3(parasiteYPos3(j), parasiteXPos3(j)) = -1;
					parasiteXPos3(numParasites3) = parasiteXPos3(j) + 1; % Add an x value for a old parasite in new pos
					parasiteYPos3(numParasites3) = parasiteYPos3(j); % Add corresponding y value for old parasite in new pos
				else
					parasiteXPos3(j) = parasiteXPos3(j) + 1; % If no food and no obstruction then move to new position
				end
			elseif r3(j) < 0.5 && parasiteXPos3(j) ~= 1 && simGrid3(parasiteYPos3(j), parasiteXPos3(j) - 1) >= 0 % Move West
				if simGrid3(parasiteYPos3(j), parasiteXPos3(j) - 1) == 1 % If food in position to move to
					numParasites3 = numParasites3 + 1;
					simGrid3(parasiteYPos3(j), parasiteXPos3(j) - 1) = simGrid3(parasiteYPos3(j), parasiteXPos3(j)); % Add new age to end of age array to represent old parasite
					simGrid3(parasiteYPos3(j), parasiteXPos3(j)) = -1;
					parasiteXPos3(numParasites3) = parasiteXPos3(j) - 1; % Add an x value for a old parasite in new pos
					parasiteYPos3(numParasites3) = parasiteYPos3(j); % Add corresponding y value for old parasite in new pos
				else
					parasiteXPos3(j) = parasiteXPos3(j) - 1;
				end
			elseif r3(j) < 0.75 && parasiteYPos3(j) ~= 1 && simGrid3(parasiteYPos3(j) - 1, parasiteXPos3(j)) >= 0 % Move North
				if simGrid3(parasiteYPos3(j) - 1, parasiteXPos3(j)) == 1 % If food in position to move to
					numParasites3 = numParasites3 + 1;
					simGrid3(parasiteYPos3(j)-1, parasiteXPos3(j)) = simGrid3(parasiteYPos3(j), parasiteXPos3(j)); % Add new age to end of age array to represent old parasite
					simGrid3(parasiteYPos3(j), parasiteXPos3(j)) = -1;
					parasiteXPos3(numParasites3) = parasiteXPos3(j); % Add an corresponding x value for old parasite in new pos
					parasiteYPos3(numParasites3) = parasiteYPos3(j) - 1; % Add y value for old parasite in new pos
				else
					parasiteYPos3(j) = parasiteYPos3(j) - 1;
				end
			elseif parasiteYPos3(j) ~= 200 && simGrid3(parasiteYPos3(j) + 1, parasiteXPos3(j)) >= 0 % Move South
				if simGrid3(parasiteYPos3(j) + 1, parasiteXPos3(j)) == 1 % If food in position to move to
					numParasites3 = numParasites3 + 1;
					simGrid3(parasiteYPos3(j)+1, parasiteXPos3(j)) = simGrid3(parasiteYPos3(j), parasiteXPos3(j)); % Add new age to end of age array to represent old parasite
					simGrid3(parasiteYPos3(j), parasiteXPos3(j)) = -1;
					parasiteXPos3(numParasites3) = parasiteXPos3(j); % Add an corresponding x value for old parasite in new pos
					parasiteYPos3(numParasites3) = parasiteYPos3(j) + 1; % Add y value for old parasite in new pos
				else
					parasiteYPos3(j) = parasiteYPos3(j) + 1;
				end
			end

		end


	%% Subplot 4
		% Check if parasite is too old => kill parasite
		isDead = simGrid4 == (parasiteMaxAge) *(-1);
		numParasites4 = numParasites4 - sum(sum(isDead));
		parasiteYPos4(isDead) = NaN;
		parasiteXPos4(isDead) = NaN;
		simGrid4(isDead) = 0;
		% For each Parasite, iterate through and update positions

		numParasitesTemp = numParasites4;
		for j = 1:numParasitesTemp % for each parasite
			% Check direction parasite wants to move for obstructions,
			% boundaries and food.
			if isnan(parasiteXPos4(j))
				continue
			end
			if r4(j) < 0.25 && parasiteXPos4(j) ~= 200 && simGrid4(parasiteYPos4(j), parasiteXPos4(j) + 1) >= 0 % Move East
				if simGrid4(parasiteYPos4(j), parasiteXPos4(j) + 1) == 1 % If food in position to move to
					numParasites4 = numParasites4 + 1; % Number of parasites will increase by one
					simGrid4(parasiteYPos4(j), parasiteXPos4(j) + 1) = simGrid4(parasiteYPos4(j), parasiteXPos4(j)); % Add new age to end of age array to represent old parasite
					simGrid4(parasiteYPos4(j), parasiteXPos4(j)) = -1;
					parasiteXPos4(numParasites4) = parasiteXPos4(j) + 1; % Add an x value for a old parasite in new pos
					parasiteYPos4(numParasites4) = parasiteYPos4(j); % Add corresponding y value for old parasite in new pos
				else
					parasiteXPos4(j) = parasiteXPos4(j) + 1; % If no food and no obstruction then move to new position
				end
			elseif r4(j) < 0.5 && parasiteXPos4(j) ~= 1 && simGrid4(parasiteYPos4(j), parasiteXPos4(j) - 1) >= 0 % Move West
				if simGrid4(parasiteYPos4(j), parasiteXPos4(j) - 1) == 1 % If food in position to move to
					numParasites4 = numParasites4 + 1;
					simGrid4(parasiteYPos4(j), parasiteXPos4(j) - 1) = simGrid4(parasiteYPos4(j), parasiteXPos4(j)); % Add new age to end of age array to represent old parasite
					simGrid4(parasiteYPos4(j), parasiteXPos4(j)) = -1;
					parasiteXPos4(numParasites4) = parasiteXPos4(j) - 1; % Add an x value for a old parasite in new pos
					parasiteYPos4(numParasites4) = parasiteYPos4(j); % Add corresponding y value for old parasite in new pos
				else
					parasiteXPos4(j) = parasiteXPos4(j) - 1;
				end
			elseif r4(j) < 0.75 && parasiteYPos4(j) ~= 1 && simGrid4(parasiteYPos4(j) - 1, parasiteXPos4(j)) >= 0 % Move North
				if simGrid4(parasiteYPos4(j) - 1, parasiteXPos4(j)) == 1 % If food in position to move to
					numParasites4 = numParasites4 + 1;
					simGrid4(parasiteYPos4(j)-1, parasiteXPos4(j)) = simGrid4(parasiteYPos4(j), parasiteXPos4(j)); % Add new age to end of age array to represent old parasite
					simGrid4(parasiteYPos4(j), parasiteXPos4(j)) = -1;
					parasiteXPos4(numParasites4) = parasiteXPos4(j); % Add an corresponding x value for old parasite in new pos
					parasiteYPos4(numParasites4) = parasiteYPos4(j) - 1; % Add y value for old parasite in new pos
				else
					parasiteYPos4(j) = parasiteYPos4(j) - 1;
				end
			elseif parasiteYPos4(j) ~= 200 && simGrid4(parasiteYPos4(j) + 1, parasiteXPos4(j)) >= 0 % Move South
				if simGrid4(parasiteYPos4(j) + 1, parasiteXPos4(j)) == 1 % If food in position to move to
					numParasites4 = numParasites4 + 1;
					simGrid4(parasiteYPos4(j)+1, parasiteXPos4(j)) = simGrid4(parasiteYPos4(j), parasiteXPos4(j)); % Add new age to end of age array to represent old parasite
					simGrid4(parasiteYPos4(j), parasiteXPos4(j)) = -1;
					parasiteXPos4(numParasites4) = parasiteXPos4(j); % Add an corresponding x value for old parasite in new pos
					parasiteYPos4(numParasites4) = parasiteYPos4(j) + 1; % Add y value for old parasite in new pos
				else
					parasiteYPos4(j) = parasiteYPos4(j) + 1;
				end
			end

		end

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
		% simGrid1 = zeros(size(simGrid1)); % Clear simGrid ready for inputting new parasite and food locations
		
		% Food is added to grid before parasites because some parasites
		% will overwrite food
		foodIndices = sub2ind(size(simGrid1), foodYPos1, foodXPos1); % convert subscripts to linear indices
		simGrid1(foodIndices) = 1; % assign 1 to the elements at the linear indices to represent food

		% parasiteIndices = sub2ind(size(simGrid1), parasiteYPos1(~isnan(parasiteYPos1)), parasiteXPos1(~isnan(parasiteXPos1))); % convert subscripts to linear indices
		% simGrid1(parasiteIndices) = -1; % assign -1 to the elements at the linear indices to represent parasites

		
		% Place food on empty squares within grid
		emptyGridSquares = find(simGrid1 == 0);
		if length(emptyGridSquares) > foodAdded
		newFoodSquares = emptyGridSquares(randperm(length(emptyGridSquares), foodAdded));
		simGrid1(newFoodSquares) = 1;
		end

		numParasites(i, 1) = numParasites1;
		simGridAdjusted = simGrid1;
		simGridAdjusted(simGrid1 < 0) = -1;
		if 	numParasites(i, 1) > 0
		subplot(2, 2, 1);
		imagesc(simGridAdjusted);
		end

		%% Subplot 2
		% simGrid2 = zeros(size(simGrid2)); % Clear simGrid ready for inputting new parasite and food locations

		foodIndices = sub2ind(size(simGrid2), foodYPos2, foodXPos2); % convert subscripts to linear indices
		simGrid2(foodIndices) = 1; % assign 1 to the elements at the linear indices to represent food		
		
		% parasiteIndices = sub2ind(size(simGrid2), parasiteYPos2(~isnan(parasiteYPos2)), parasiteXPos2(~isnan(parasiteXPos2))); % convert subscripts to linear indices
		% simGrid2(parasiteIndices) = -1; % assign -1 to the elements at the linear indices to represent parasites

		emptyGridSquares = find(simGrid2 == 0);
		if length(emptyGridSquares) > foodAdded
		newFoodSquares = emptyGridSquares(randperm(length(emptyGridSquares), foodAdded));
		simGrid2(newFoodSquares) = 1;
		end
		numParasites(i, 2) = numParasites2;
		
			simGridAdjusted = simGrid2;
		simGridAdjusted(simGrid2 < 0) = -1;
		if numParasites(i, 2) > 0
		subplot(2, 2, 2);
		imagesc(simGridAdjusted);
		end

		%% Subplot 3
		% simGrid3 = zeros(size(simGrid3)); % Clear simGrid ready for inputting new parasite and food locations

		foodIndices = sub2ind(size(simGrid3), foodYPos3, foodXPos3); % convert subscripts to linear indices
		simGrid3(foodIndices) = 1; % assign 1 to the elements at the linear indices to represent food

		% parasiteIndices = sub2ind(size(simGrid3), parasiteYPos3(~isnan(parasiteYPos3)), parasiteXPos3(~isnan(parasiteXPos3))); % convert subscripts to linear indices
		% simGrid3(parasiteIndices) = -1; % assign -1 to the elements at the linear indices to represent parasites

		
		simGrid3 = placeFood(foodAdded/2,[50, 50], simGrid3);
		simGrid3 = placeFood(foodAdded/2,[150, 150], simGrid3);
		
		numParasites(i, 3) = numParasites3;

				simGridAdjusted = simGrid3;
		simGridAdjusted(simGrid3 < 0) = -1;
		if numParasites(i, 3) > 0
		subplot(2, 2, 3);
		imagesc(simGridAdjusted);
		end
		
		%% Subplot 4
		% simGrid4 = zeros(size(simGrid4)); % Clear simGrid ready for inputting new parasite and food locations
		
		foodIndices = sub2ind(size(simGrid4), foodYPos4, foodXPos4); % convert subscripts to linear indices
		simGrid4(foodIndices) = 1; % assign 1 to the elements at the linear indices to represent food
		
		% parasiteIndices = sub2ind(size(simGrid4), parasiteYPos4(~isnan(parasiteYPos4)), parasiteXPos4(~isnan(parasiteXPos4))); % convert subscripts to linear indices
		% simGrid4(parasiteIndices) = -1; % assign -1 to the elements at the linear indices to represent parasites
		
		simGrid4 = placeFood(foodAdded/2,[50, 50], simGrid4);
		simGrid4 = placeFood(foodAdded/2,[150, 150], simGrid4);

		numParasites(i, 4) = numParasites4;

				simGridAdjusted = simGrid4;
		simGridAdjusted(simGrid4 < 0) = -1;
		if numParasites(i, 4) > 0
		subplot(2, 2, 4);
		imagesc(simGridAdjusted);
		end
		
		% Dont create a frame if there are no more parasites in any subplot
		if (numParasites4 + numParasites3 + numParasites2 + numParasites1) == 0
			continue
		end
		%% Create Frame

		currentFrame = getframe(fig);
		writeVideo(vidObj, currentFrame);
		
		simGrid1(simGrid1 < 0) = simGrid1(simGrid1 < 0) - 1;
		simGrid2(simGrid2 < 0) = simGrid2(simGrid2 < 0) - 1;
		simGrid3(simGrid3 < 0) = simGrid3(simGrid3 < 0) - 1;
		simGrid4(simGrid4 < 0) = simGrid4(simGrid4 < 0) - 1;
		% Age1(~isnan(parasiteXPos1)) = Age1(~isnan(parasiteXPos1)) + 1;
		% Age2(~isnan(parasiteXPos2)) = Age2(~isnan(parasiteXPos2)) + 1;
		% Age3(~isnan(parasiteXPos3)) = Age3(~isnan(parasiteXPos3)) + 1;
		% Age4(~isnan(parasiteXPos4)) = Age4(~isnan(parasiteXPos4)) + 1;

	end
	close(vidObj);
end