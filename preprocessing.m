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
etaTransformer = 0.99; % Transformer efficiency
distanceSupplyEST = 16; % distance in km form EST to windmillpark
resistanceOverDist = 0.035; % resistance over distance in ohm/km
nCables = 2; % Maximum current divided by maximum allowed currents thourgh cable
supplyTransportResistance = 1/(1/(resistanceOverDist*distanceSupplyEST)*nCables); % Calculation of the resistance
voltageTransport = 765000; % voltage through cables



% injection system
aInjection = 0.1; % Dissipation coefficient
    	
% storage system
EStorageMax     = 5.8*unit("GWh"); % Maximum energy
EStorageMin     = 5.8*0.35*unit("GWh"); % Minimum energy
EStorageInitial = 5.8*0.35*unit("GWh"); % Initial energy
bStorage        = 1e-6/unit("s");  % Storage dissipation coefficient

% extraction system
aExtraction = 0.1; % Dissipation coefficient

% transport to demand
distanceDemandEST = 37; % distance in km form EST to luxemburg city for transportation supplier
resistanceOverDist = 0.035; % resistance over distance in ohm/km
nCables = 1; % Maximum current divided by maximum allowed currents thourgh cable
demandTransportResistance = 1/(1/(resistanceOverDist*distanceSupplyEST)*nCables); % Calculation of the resistance
voltageTransport = 765000; % voltage through cables