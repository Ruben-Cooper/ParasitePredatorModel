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
	populationDensity = 0.1 / 2; % Divided by two because this density is shared across two agents
	foodGrid		= A <= populationDensity;
	parasiteGrid	= A >= 1 - populationDensity;
	simGrid = foodGrid - parasiteGrid;

	subplot(2,2,1)
	
	imagesc(simGrid) % Parasites are represented by -1 and food by 1.

	for i = 1:simulationLength

		[pY, pX] = find(simGrid == -1);
		Age = zeros(length(pX), 1); % Create a matrix of ages for each parasite
		[fY, fX] = find(simGrid == 1);
		r = rand(length(pX),1);
		%% For each Parasite, iterate through and update positions
		for j = 1:length(pX) % for each parasite
			% Check if parasite is death age => kill parasite
			if Age(j) == parasiteMaxAge
				Age(j) = NaN;
				pY(j) = NaN;
				pX(j) = NaN;
				continue
			end
			% Check direction parasite wants to move for obstructions,
			% boundaries and food.
			if r(j) < 0.25 && pX(j) ~= 200 && parasiteGrid(pY(j), pX(j) + 1) ~= -1 % Move East
				if parasiteGrid(pY(j), pX(j) + 1) ~= 1 % If food in position to move to
					Age = [Age Age(j)]; % Add new age to end of age array to represent old parasite
					Age(j) = 0; % Reset age of parasite in current position to represent birth
					pX = [pX (pX(j) + 1)]; % Add an x value for a old parasite in new pos
					pY = [pY pY(j)]; % Add corresponding y value for old parasite in new pos
					continue
				end
				pX(j) = pX(j) + 1; % If no food and no obstruction then move to new position
			elseif r(j) < 0.5 && pX(j) ~= 1 && parasiteGrid(pY(j), pX(j) - 1) ~= -1 % Move West
				if parasiteGrid(pY(j), pX(j) - 1) ~= 1 % If food in position to move to
					Age = [Age Age(j)]; % Add new age to end of age array to represent old parasite
					Age(j) = 0; % Reset age of parasite in current position to represent birth
					pX = [pX (pX(j) - 1)]; % Add an x value for a old parasite in new pos
					pY = [pY pY(j)]; % Add corresponding y value for old parasite in new pos
					continue
				end
				pX(j) = pX(j) - 1;
			elseif r(j) < 0.75 && pY(j) ~= 1 && parasiteGrid(pY(j) - 1, pX(j)) ~= -1 % Move North
				if parasiteGrid(pY(j) - 1, pX(j)) ~= 1 % If food in position to move to
					Age = [Age Age(j)]; % Add new age to end of age array to represent old parasite
					Age(j) = 0; % Reset age of parasite in current position to represent birth
					pX = [pX pX(j)]; % Add an corresponding x value for old parasite in new pos
					pY = [pY (pY(j) - 1)]; % Add y value for old parasite in new pos
					continue
				end
				pY(j) = pY(j) - 1;
			elseif pY(j) ~= 200 && parasiteGrid(pY(j) + 1, pX(j)) ~= -1 % Move South
				if parasiteGrid(pY(j) + 1, pX(j)) ~= 1 % If food in position to move to
					Age = [Age Age(j)]; % Add new age to end of age array to represent old parasite
					Age(j) = 0; % Reset age of parasite in current position to represent birth
					pX = [pX pX(j)]; % Add an corresponding x value for old parasite in new pos
					pY = [pY (pY(j) + 1)]; % Add y value for old parasite in new pos
					continue
				end
				pY(j) = pY(j) + 1;
			end
		end
		%% For each piece of food, determine if rotten and deleted
		isRotten = rand(length(fX), 1) < foodRotChance;
		fx(isRotten) = NaN; % Delete xPos of all food that isRotten
		fY(isRotten) = NaN; % Delete yPos of all food that isRotten

	end
end

		
