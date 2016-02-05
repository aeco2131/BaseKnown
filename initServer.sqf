if (!isServer) exitWith {};

RESISTANCE setFriend [CIVILIAN, 1]; 
RESISTANCE setFriend [EAST, 1]; 
RESISTANCE setFriend [WEST, 0]; 
EAST setFriend [RESISTANCE, 1];
EAST setFriend [CIVILIAN, 1];
EAST setFriend [WEST, 0];
WEST setFriend [RESISTANCE, 0];
WEST setFriend [CIVILIAN, 1];
WEST setFriend [EAST, 0];
CIVILIAN setFriend [WEST, 1];
CIVILIAN setFriend [RESISTANCE, 0];
CIVILIAN setFriend [EAST, 0];

setDate [2015, 5, 25, 19, 15];

// saving
if(isMultiplayer) then {
	deleteVehicle saveTrigger1;
	deleteVehicle saveTrigger2;
};

// Server VARS
target1onTable = false;
target2onTable = false;
target1escape_fired = false;
target2escape_fired = false;
alarm_fired = false;

ammo1destroyed = false;
ammo2destroyed = false;
ammo3destroyed = false;

// Marker
"pa1" setMarkerAlpha 0; 
"pa2" setMarkerAlpha 0; 
"pr_point" setMarkerAlpha 0; 
"observe_marker" setMarkerAlpha 0; 
"mine_field" setMarkerAlpha 0;
"mine_radius" setMarkerAlpha 0;
"hostage_marker" setMarkerAlpha 0;
"arsenal_marker" setMarkerAlpha 0;
"ammo2_marker" setMarkerAlpha 0;

//ParamsArray
_paramWeather = paramsArray select 0;
r3_weatherParam = "MIN";
switch (_paramWeather) do {
	case 0: { r3_weatherParam = "MIN"; };
	case 1: { r3_weatherParam = "MAX"; };
	case 2: { r3_weatherParam = "RANDOM"; };
};

// Server Scripts
call compile preprocessFileLineNumbers "scripts\tasksClient.sqf";
call compile preprocessFileLineNumbers "R34P3R\r3_init_server.sqf";
call compile preprocessFileLineNumbers "scripts\ammobox.sqf";
call compile preprocessFileLineNumbers "scripts\fnc_server.sqf";
execVM "scripts\tasksServer.sqf";

_newGrp = createGroup WEST;
{[_x] joinSilent _newGrp; _x allowDamage false;}forEach units group (driver mohawk);

// PressCar
press_car setVariable ["BIS_enableRandomization", false, true];
press_car animate ["HideBackpacks", 1]; 
press_car animate ["HideDoor3", 0]; 
press_car animate ["HideDoor1", 0]; 
press_car animate ["HideDoor2", 0]; 
press_car animate ["HideConstruction", 0];

// Ammmo 2
_ammo2Pos = [[6045.08,5231.24,0.1],[5294.68,5895.21,0.1]] call BIS_fnc_selectRandom;
ammo2 setPosATL _ammo2Pos;
"ammo2_marker" setMarkerPos getPos ammo2;

// Targets EH
target1 addEventHandler ["HandleDamage", { _this call target_damageEH }];
target1 addEventHandler ["FiredNear", { target1 removeAllEventHandlers "FiredNear"; [] execVM "scripts\alarm.sqf"}];
target2 addEventHandler ["HandleDamage", { _this call target_damageEH }];

// Targets Loadout
[target1] execVM "scripts\target1_loadout.sqf"; 
[target2] execVM "scripts\target2_loadout.sqf";

// Target1 pos
_target1pos = [[6071.8,5613.61,4.1],[6041.86,5614.59,0.17],[6066.88,5656.06,0.7],[6046.62,5589.21,0.17]] call BIS_fnc_selectRandom;
target1 setPosATL _target1pos;

// Arsenal EH
d_ammo1 addEventHandler ["HandleDamage",{ _this call ammoCache_damageEH }];
d_ammo2 addEventHandler ["HandleDamage",{ _this call ammoCache_damageEH }];
d_ammo3 addEventHandler ["HandleDamage",{ _this call ammoCache_damageEH }];

// Hostage
hostage disableAI "MOVE";
hostage disableAI "ANIM";
hostage disableAI "FSM";
[hostage] execVM "scripts\hostage_loadout.sqf";
_rndPos = [[6456.26,5391.38,0.084],[6593.24,5346.75,0.29],[6564.56,5042.73,1.31]] call BIS_fnc_selectRandom;
hostage setPosATL _rndPos;
htrigger setPos getPos hostage;
"hostage_marker" setMarkerPos getPos hostage;
[[hostage, "Acts_InjuredCoughRifle02"], "switchMoveMP"] call BIS_fnc_MP; 

[pressman] execVM "scripts\pressman_loadout.sqf"; 

// Ziegenhirte
hirte addEventHandler ["killed", { ["End4",false, 4] call r3_endMissionMP }];
[hirte] execVM "scripts\hirte_loadout.sqf"; 

if(floor(random 3) == 1) then {
	doStop hirte;
	hirte disableAI "ANIM";
	hirte switchMove "AmovPsitMstpSrasWrflDnon";
	hirte setDir 215;
	hirte setVelocity [0,0,2];
};

dog = (group hirte) createUnit ["Alsatian_Sandblack_F", getPos hirte, [], 1, "CAN_COLLIDE"];
dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
dog doFollow hirte;

//Server is Full Loaded ! Fire Players now..
sleep 1;
ServerReady = true;
publicVariable "ServerReady";


// Set AI Lodout and Skill
_paramSkill = paramsArray select 3;
{
	if(side _x == EAST) then {
		[_x] execVM "scripts\loadout_red.sqf";
		if(_paramSkill == 0) then { [_x] call setSkill_normal_red };
		if(_paramSkill == 1) then { [_x] call setSkill_hard_red };
		sleep 1;
	};
	
	if(side _x == RESISTANCE) then {
		[_x] execVM "scripts\loadout_green.sqf";
		if(_paramSkill == 0) then { [_x] call setSkill_normal_green };
		if(_paramSkill == 1) then { [_x] call setSkill_hard_green };
		sleep 1;
	};
}forEach allUnits;


