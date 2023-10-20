%% Task 4 - Spatial agent-based implementation

gridWidth = 200;
simulationLength = 400;

%% Scenario 1
parasiteMaxAge = 3;
foodRotChance = 0.1;
foodAdded = 100;
Task4Simulation(parasiteMaxAge, foodRotChance, foodAdded, gridWidth, simulationLength, "Scenario 1");

%% Scenario 2
parasiteMaxAge = 10;
foodRotChance = 0.01;
foodAdded = 100;
Task4Simulation(parasiteMaxAge, foodRotChance, foodAdded, gridWidth, simulationLength, "Scenario 2");