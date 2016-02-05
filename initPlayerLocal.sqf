waitUntil {!isNull player};

0 fadeSound 0;

// Saving 
if(!isMultiplayer) then {
	enableSaving [true,true];
}else{
	enableSaving [false,false];
};

// Disable Teamswitching
enableTeamSwitch false;

// Disable Radio
enableSentences false;

// Set needed ViewDistance
if(viewDistance < 1000) then {
	setViewDistance 1000;
};

// briefing first !
//call compile preprocessFileLineNumbers "briefing.sqf";

////////////////////////////////////////
//////   R34P3Rs Framework    //////////
////////////////////////////////////////
call compile preprocessFileLineNumbers "R34P3R\r3_init_client.sqf";
call r3_LoadingOverlay;
/////////////////////////////////////////

1000 cutText ["Loading mission stuff...", "BLACK FADED", 0];
sleep 2;

// Functions
call compile preprocessFileLineNumbers "scripts\fnc_client.sqf";

// Actions
_paramArsenal = paramsArray select 1;
if(_paramArsenal == 0) then {
	ammo1 addAction ["<t color='#ff9b00'>Open Virtual Arsenal</t>", { ["Open",true] spawn BIS_fnc_arsenal; }, [], 10, true, true, "", "player distance ammo1 < 2.5"];
	ammo2 addAction ["<t color='#ff9b00'>Open Virtual Arsenal</t>", { ["Open",true] spawn BIS_fnc_arsenal; }, [], 10, true, true, "", "player distance ammo2 < 2.5"];
};

money addAction ["<t color='#ff9b00'>Pick up money</t>", "scripts\money_pickup.sqf", [], 10, true, true, "", "isNil 'moneytaken' && player distance money < 2.5"];
intel addAction ["<t color='#ff9b00'>Pick up intel</t>", "scripts\intel_pickup.sqf", [], 10, true, true, "", "isNil 'inteltaken' && player distance intel < 2.5"];
informant addAction ["<t color='#ff9b00'>Talk !</t>", {infotalk = true; publicVariable "infotalk"}, [], 10, true, true, "", "isNil 'infotalk' && !isNil 'introPlayed' && player distance informant < 2.5"];

target1 addAction ["<t color='#ff9b00'>Browse corpse</t>", "scripts\browse_corpse.sqf", [], 10, true, true, "", "!alive target1 && isNil 'target1browsed' && player distance target1 < 2.5"];
target2 addAction ["<t color='#ff9b00'>Browse corpse</t>", "scripts\browse_corpse.sqf", [], 10, true, true, "", "!alive target2 && isNil 'target2browsed' && player distance target2 < 2.5"];

hostage addAction ["<t color='#ff9b00'>Heal hostage</t>", "scripts\hostage_rescue.sqf", [], 10, true, true, "", "alive hostage && isNil 'removeHostageAction' && player distance hostage < 2.5"];

// Set Loadout and Settings
[player] execVM "scripts\loadout_blue.sqf";

[] spawn {
	{
		if(!isPlayer _x) then {
			if(leader _x == player) then {
				waitUntil{local _x};
				[_x] execVM "scripts\loadout_blue.sqf"; 
				_x enableFatigue false;
			};
		};
	}forEach units group player;
	
	if(leader player == player) then {
		player setFormation "LINE";
		player setSpeedMode "FULL";
	};
};

// Mohawk Setup
mohawk setVariable ["BIS_enableRandomization", false];
mohawk setObjectTexture [0,"skins\lionheart0.paa"];
mohawk setObjectTexture [1,"skins\lionheart1.paa"];
mohawk setObjectTexture [2,"skins\lionheart2.paa"];

// PressCar
press_car setVariable ["BIS_enableRandomization", false];
press_car setObjectTexture [0,"skins\offroad_press.paa"];

//Events
player addEventHandler ["fired", {_this execVM "scripts\weaponFired_client.sqf"}];
player addEventHandler ["HandleRating", { if((_this select 1) < 0) then {0}; }];

//Ambient
[] spawn {
	_paramAmbient = paramsArray select 2;
	if(_paramAmbient == 0) then {
		while {true} do {
			if((vehicle player) == player) then {
				if((getPosATL player select 2) < 10) then {
					if(r3_isNight) then {
						playSound ["AmbientBirds_night",true];
						sleep 27;
					} else {
						if((getPosASL player select 2) < 60) then {
							playSound ["AmbientBirds_low",true];
							sleep 27;
						} else {
							playSound ["AmbientBirds_high",true];
							sleep 27;		
						};
					};
				};
			} else {
				if((typeOf vehicle player) == "Steerable_Parachute_F") then {
					if((getPosATL player select 2) > 15) then {
						playSound ["Parachute",true];			
						sleep 6;
					};
				};				
			};
			sleep 2;
		};
	};
};

[] spawn {
	_paramAmbient = paramsArray select 2;
	if(_paramAmbient == 0) then {
		while{true} do {
			if((player distance goat_center) < 150) then {
				goat_center say3D "goats";
				sleep 23;
			};
			sleep 2;
		};
	};
};

// Wait until Server is Ready...
1000 cutText ["Hang on... Server still loading.", "BLACK FADED", 0];
sleep 1;
waitUntil{sleep 1; !isNil "ServerReady"};
1000 cutFadeOut 5;
5 fadeSound 1;
//Enable Radio
enableSentences true;

//Player is Ready
call compile format ["%1_ready = true; publicVariable '%1_ready'", player];

if(player in mohawk && (player distance fire1) > 1000) then {
	sleep 3;
	playSound ["mohawk_radio",true];
};




