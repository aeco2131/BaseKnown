// SyncTime
r3_syncTime = { 
	setDate [2015, 5, 26, 7, 0];
};

// SetDir global
setDirMP = compileFinal "if(local (_this select 0)) then {_this select 0 setDir (_this select 1) };";

// Hint Messages
r3_clientHint = {

	_msgNr = [_this, 0, 0] call BIS_fnc_param;
	_msg = "";
	
	if(_msgNr > 0) then {
		switch(_msgNr) do {
			case 1: {_msg = parseText "<img image='images\hint2.jpg' size='11' shadow='2'/><br/><br/><t color='#ffffff' size='1.1' shadow='1' shadowColor='#000000' align='center'>A goat herder, we should have an eye on him.</t>" };
			case 2: {_msg = parseText "<img image='images\hint2.jpg' size='11' shadow='2'/><br/><br/><t color='#ff0000' size='1.1' shadow='1' shadowColor='#000000' align='center'>You are betrayed by the goat herder.</t>" };
			case 3: {_msg = parseText "<img image='images\hint3.jpg' size='11' shadow='2'/><br/><br/><t color='#ffffff' size='1.1' shadow='1' shadowColor='#000000' align='center'>You found information about a hostage near you. Rescue or leave it, your choice.</t>" };
			case 4: {_msg = parseText "<img image='images\hint4.jpg' size='11' shadow='2'/><br/><br/><t color='#ffffff' size='1.1' shadow='1' shadowColor='#000000' align='center'>You found information about Yuris hidden arsenal. Your choice to destroy it.</t>" };
			case 5: {_msg = parseText "<img image='images\hint1.jpg' size='11' shadow='2'/><br/><br/><t color='#ffffff' size='1.1' shadow='1' shadowColor='#000000' align='center'>The negotiations have begun.</t>" };
		};
		hintSilent _msg;
	};
};

// check SmokeGreen
r3_chkGreenSmoke = {
	if(leader player == player) then {
		if!("SmokeShellGreen" in (items player)) then {
			player addItemToVest "SmokeShellGreen";
		};
	};
};

// Auto-open parachute
r3_openPara = { 
	if(vehicle player == player) then {
		if(getPosATL player select 2 > 100) then {
			player action ["OpenParachute", player];
			player allowDamage false;
		};
	};
	
	if(leader player == player) then {
		{
			if(!isPlayer _x) then {
				if(local _x) then { [_x] spawn r3_aiParaFollow };
			};
		}forEach units group player;
	};
	
	waitUntil{sleep 3; (vehicle player) == player};
	
	player allowDamage true;
	player action ["GunLightOn", player];
};

// AI Para follow player
r3_aiParaFollow =
{
	_unit = _this select 0;
	_unit action ["OpenParachute", _unit];
	_unit allowDamage false;
	waitUntil{sleep 1; (typeOf vehicle _unit) == "Steerable_Parachute_F"};
	
	_vehicle = vehicle _unit;
	_vehicle allowDamage false;
	_dir = floor(random 9);
	_speed = floor(random 4) +10;
	
	while{(getPosATL _unit select 2) > 8} do {
		_vehicle setDir _dir;
		_vehicle setVelocity [(sin _dir * _speed),(cos _dir * _speed),(velocity _vehicle select 2) - (_speed -5)];
		sleep 0.1;
	};
	
	waitUntil{sleep 2; (vehicle _unit) == _unit};
	
	_unit enableGunLights "forceOn";
	_unit allowDamage true;
};

// skipTimeMP
r3_skipTime = {

	while{daytime > 19 OR daytime < 7} do {
		if(daytime > 19 && daytime < 5) then {
			skipTime 0.2;
		} else {
			skipTime 0.024;
		};
		sleep 0.08;
	};
};

// Add Backpacks
r3_addBackpack =
{
	_unit = _this select 0;
	
	switch(_unit) do {
		case p1: {
			//TEAM-LEADER
			_unit addBackpackGlobal "B_Kitbag_rgr";
			clearBackpackCargoGlobal _unit;
			sleep 0.1;
			for "_i" from 1 to 2 do {_unit addItemToBackpack "FirstAidKit";};
			for "_i" from 1 to 3 do {_unit addItemToBackpack "30Rnd_65x39_caseless_mag";};
			for "_i" from 1 to 2 do {_unit addItemToBackpack "11Rnd_45ACP_Mag";};
			for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
		};
		case p2: {
			// MEDIC
			_unit addBackpackGlobal "B_TacticalPack_mcamo";
			clearBackpackCargoGlobal _unit;
			sleep 0.1;
			_unit addItemToBackpack "Medikit";
			for "_i" from 1 to 5 do {_unit addItemToBackpack "FirstAidKit";};
			
			if(332350 in (getDLCs 1)) then {
				for "_i" from 1 to 2 do {_unit addItemToBackpack "20Rnd_762x51_Mag";};
			} else {
				for "_i" from 1 to 2 do {_unit addItemToBackpack "30Rnd_65x39_caseless_mag";};
			};
		};
		case p4: {
			// AMMO
			_unit addBackpackGlobal "B_Kitbag_cbr";
			clearBackpackCargoGlobal _unit;
			sleep 0.1;
			_unit addItemToBackpack "FirstAidKit";
			for "_i" from 1 to 2 do {_unit addItemToBackpack "200Rnd_65x39_cased_Box";};
			for "_i" from 1 to 2 do {_unit addItemToBackpack "30Rnd_65x39_caseless_mag";};
			for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
		};
	};
};
