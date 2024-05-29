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

%Changeable Parameters
D = 4; %Diameter (m)
h = 291; %height (m)
H = 40; %head of the pump
f = 0.0021; %friction factor
L = 291; %length (m)
C_v = 0.98; %jet coef
P_tot= 87425136; %Power that the pumps need to generate
Q = 30; %flow
Q_pump = 20; %flow of the pump
eta = 0.94; %efficiency of a pump
k = 0.0003; %pipe roughness value of ordinsary concrete (range is 0.0003-0.001)
n_1 = 8; %numbers of pumps chosen in series
n_2 = 10; %numbers of pumps chosen in parallel.

%parameters
rho = 998; %Density
g = 9.81; %gravitation (m/s^2)
pi= 3.14;
mu = (0.00089); %dynamic viscosity of water
K = 0; %constant for pressure loss because of a 90 degree bend in the pipe


%V= 4*unit("m^.3"); %Volume of the reservoir
%v = sqrt((2*g*h)/(1-K-((f*L)/(2*D)))); %velocity at the end of the pipe (m/s)



% transport from supply
etaTransformer = 0.99; % Transformer efficiency
distanceSupplyEST = 16; % distance in km form EST to windmillpark
resistanceOverDist = 0.035; % resistance over distance in ohm/km
nCables = 2; % Maximum current divided by maximum allowed currents thourgh cable
supplyTransportResistance = 1/(1/(resistanceOverDist*distanceSupplyEST)*nCables); % Calculation of the resistance
voltageTransport = 765000; % voltage through cables

% injection system
%pump_efficiency= 0000; 
%friction = (g*h)/((1/2)*v^2); %efficiency of the pipes
%aInjection = friction * pump_efficiency; % Dissipation coefficient
%aInjection = ; % Dissipation coefficient

    	
% storage system
EStorageMax     = 5800.*unit("MWh"); % Maximum energy
EStorageMin     = 2030*unit("MWh"); % Minimum energy
EStorageInitial = 2030*unit("MWh"); % Initial energy
bStorage        = 1.91e-7/unit("s");  % Storage dissipation coefficient
% gStorage        = 2.14e-7/unit("s"); %Storage gain coefficient

% extraction system
aExtraction = 0.388; % Dissipation coefficient

% transport to demand
distanceDemandEST = 37; % distance in km form EST to luxemburg city for transportation supplier
resistanceOverDist = 0.035; % resistance over distance in ohm/km
nCables = 1; % Maximum current divided by maximum allowed currents thourgh cable
demandTransportResistance = 1/(1/(resistanceOverDist*distanceSupplyEST)*nCables); % Calculation of the resistance


