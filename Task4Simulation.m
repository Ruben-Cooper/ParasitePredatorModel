%% Function Description:
% TODO: this

function [output] = Task4Simulation(parasiteMaxAge, foodRotChance, foodAdded, gridWidth, simulationLength)
% Default Values
	arguments
		parasiteMaxAge = 10;
		foodRotChance = 0.01;
		foodAdded = 300;
		gridWidth = 200;
		simulationLength = 400;
	end

	A = rand(gridWidth);



	%% Subplot 1 - Density = 10% & Placement = Random
	populationDensity = 0.1 / 2; % Divided by two because this density is shared across two agents
	foodGrid		= A <= populationDensity;
	parasiteGrid	= A >= 1 - populationDensity;
	subplot(2,2,1)
	imagesc(foodGrid - parasiteGrid) % Parasites are represented by -1 and food by 1.

	for i = 1:simulationLength
		[pY, pX] = find(parasiteGrid);
		r = rand(length(pX),1);
		for j = 1:length(pX)
			if r(j) < 0.25 && pX(j) ~= 200 && parasiteGrid(pY(j), pX(j) + 1) ~= 1 % Move East
				pX(j) = pX(j) + 1;
			elseif r(j) < 0.5 && pX(j) ~= 1 && parasiteGrid(pY(j), pX(j) - 1) ~= 1 % Move West
				pX(j) = pX(j) - 1;
			elseif r(j) < 0.75 && pY(j) ~= 1 && parasiteGrid(pY(j) - 1, pX(j)) ~= 1 % Move North
				pX(j) = pX(j) - 1;
			elseif pY(j) ~= 200 && parasiteGrid(pY(j) + 1, pX(j)) ~= 1 % Move South
				pX(j) = pX(j) + 1;	
			end
		end
		test = zeros(gridWidth);
		test(pY, pX) = 1;
		imagesc(test);
		wait(0.05)
	end

end