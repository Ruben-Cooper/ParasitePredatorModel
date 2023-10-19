%% Function Description:
% TODO: this

function [output] = Task4Simulation(parasiteMaxAge, foodRotChance, foodAdded, gridSize, simulationLength)
% Default Values
	arguments
		parasiteMaxAge = 10;
		foodRotChance = 0.01;
		foodAdded = 300;
		gridSize = 200;
		simulationLength = 400;
	end

	A = rand(gridSize);

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
	vidObj = VideoWriter('Simulation.avi');
	vidObj.FrameRate = 10;
	open(vidObj);

	fig = figure;
	subplot(2,2,1);
	imagesc(simGrid1); % Parasites are represented by -1 and food by 1.

	subplot(2,2,2);
	imagesc(simGrid2);

	subplot(2,2,3);
	imagesc(simGrid3);

	subplot(2,2,4);
	imagesc(simGrid4);

	currentFrame = getframe(fig);
	writeVideo(vidObj, currentFrame);

	for i = 1:simulationLength

		[parasiteYPos, parasiteXPos] = find(simGrid1 == -1);
		Age = zeros(length(parasiteXPos), 1); % Create a matrix of ages for each parasite
		[foodYPos, foodXPos] = find(simGrid1 == 1);
		r = rand(length(parasiteXPos),1);
		
		% Check if parasite is death age => kill parasite
		isDead = Age == parasiteMaxAge;
		Age = Age(~isDead); % Keep only values that aren't dead
		parasiteYPos = parasiteYPos(~isDead);
		parasiteXPos = parasiteXPos(~isDead);
				
		%% For each Parasite, iterate through and update positions
		for j = 1:length(parasiteXPos) % for each parasite
			
			
			% Check direction parasite wants to move for obstructions,
			% boundaries and food.
			if r(j) < 0.25 && parasiteXPos(j) ~= 200 && parasiteGrid(parasiteYPos(j), parasiteXPos(j) + 1) ~= -1 % Move East
				if parasiteGrid(parasiteYPos(j), parasiteXPos(j) + 1) ~= 1 % If food in position to move to
					Age = [Age; Age(j)]; % Add new age to end of age array to represent old parasite
					Age(j) = 0; % Reset age of parasite in current position to represent birth
					parasiteXPos = [parasiteXPos; (parasiteXPos(j) + 1)]; % Add an x value for a old parasite in new pos
					parasiteYPos = [parasiteYPos; parasiteYPos(j)]; % Add corresponding y value for old parasite in new pos
					continue
				end
				parasiteXPos(j) = parasiteXPos(j) + 1; % If no food and no obstruction then move to new position
			elseif r(j) < 0.5 && parasiteXPos(j) ~= 1 && parasiteGrid(parasiteYPos(j), parasiteXPos(j) - 1) ~= -1 % Move West
				if parasiteGrid(parasiteYPos(j), parasiteXPos(j) - 1) ~= 1 % If food in position to move to
					Age = [Age; Age(j)]; % Add new age to end of age array to represent old parasite
					Age(j) = 0; % Reset age of parasite in current position to represent birth
					parasiteXPos = [parasiteXPos; (parasiteXPos(j) - 1)]; % Add an x value for a old parasite in new pos
					parasiteYPos = [parasiteYPos; parasiteYPos(j)]; % Add corresponding y value for old parasite in new pos
					continue
				end
				parasiteXPos(j) = parasiteXPos(j) - 1;
			elseif r(j) < 0.75 && parasiteYPos(j) ~= 1 && parasiteGrid(parasiteYPos(j) - 1, parasiteXPos(j)) ~= -1 % Move North
				if parasiteGrid(parasiteYPos(j) - 1, parasiteXPos(j)) ~= 1 % If food in position to move to
					Age = [Age; Age(j)]; % Add new age to end of age array to represent old parasite
					Age(j) = 0; % Reset age of parasite in current position to represent birth
					parasiteXPos = [parasiteXPos; parasiteXPos(j)]; % Add an corresponding x value for old parasite in new pos
					parasiteYPos = [parasiteYPos; (parasiteYPos(j) - 1)]; % Add y value for old parasite in new pos
					continue
				end
				parasiteYPos(j) = parasiteYPos(j) - 1;
			elseif parasiteYPos(j) ~= 200 && parasiteGrid(parasiteYPos(j) + 1, parasiteXPos(j)) ~= -1 % Move South
				if parasiteGrid(parasiteYPos(j) + 1, parasiteXPos(j)) ~= 1 % If food in position to move to
					Age = [Age; Age(j)]; % Add new age to end of age array to represent old parasite
					Age(j) = 0; % Reset age of parasite in current position to represent birth
					parasiteXPos = [parasiteXPos; parasiteXPos(j)]; % Add an corresponding x value for old parasite in new pos
					parasiteYPos = [parasiteYPos; (parasiteYPos(j) + 1)]; % Add y value for old parasite in new pos
					continue
				end
				parasiteYPos(j) = parasiteYPos(j) + 1;
			end
		end
		%% For each piece of food, determine if rotten and deleted
		isRotten = rand(length(foodXPos), 1) < foodRotChance;
		foodXPos = foodXPos(~isRotten); % Delete xPos of all food that isRotten
		foodYPos = foodYPos(~isRotten); % Delete yPos of all food that isRotten
		
		%% Recreate simGrid with updated locations
		simGrid1 = zeros(size(simGrid1)); % Clear simGrid ready for inputting new parasite and food locations
		parasiteIndices = sub2ind(size(simGrid1), parasiteYPos, parasiteXPos); % convert subscripts to linear indices
		simGrid1(parasiteIndices) = -1; % assign -1 to the elements at the linear indices to represent parasites
		foodIndices = sub2ind(size(simGrid1), foodYPos, foodXPos); % convert subscripts to linear indices
		simGrid1(foodIndices) = 1; % assign 1 to the elements at the linear indices to represent food
		
		subplot(2, 2, 1);
		imagesc(simGrid1);

		currentFrame = getframe(fig);
		writeVideo(vidObj, currentFrame);

	end
	close(vidObj);
end

		
