% Pre-processing script for the EST Simulink model. This script is invoked
% before the Simulink model starts running (initFcn callback function).

%% Load the supply and demand data

timeUnit   = 's';

supplyFile = "Team08_supply.csv";
supplyUnit = "MW";

% load the supply data
Supply = loadSupplyData(supplyFile, timeUnit, supplyUnit);

demandFile = "Team08_demand.csv";
demandUnit = "MW";

% load the demand data
Demand = loadDemandData(demandFile, timeUnit, demandUnit);

%% Simulation settings

deltat = 5*unit("min");
stopt  = min([Supply.Timeinfo.End, Demand.Timeinfo.End]);

%% System parameters


% transport from supply
aSupplyTransport = 0.0000678; % Dissipation coefficient

% injection system
aInjection = 0.273; % Dissipation coefficient

    	
% storage system
EStorageMax     = 5800.*unit("MWh"); % Maximum energy
EStorageMin     = 2030*unit("MWh"); % Minimum energy
EStorageInitial = 2030*unit("MWh"); % Initial energy
bStorage        = 1.91e-7/unit("s");  % Storage dissipation coefficient
% gStorage        = 2.14e-7/unit("s"); %Storage gain coefficient

% extraction system
aExtraction = 0.388; % Dissipation coefficient

% transport to demand
aDemandTransport = 0.0001; % Dissipation coefficient