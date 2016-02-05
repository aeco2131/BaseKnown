if(isServer) then {

	_unit = _this select 0;
	_unitClass = typeOf _unit;
	_skipUnits = [target1];
	
	if !(_unit in _skipUnits) then {
	
		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;

		//if(r3_isNight) then {_unit linkItem "NVGoggles";};
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";

		_unitform = ["U_BG_Guerilla1_1","U_BG_Guerilla2_2","U_BG_Guerilla3_1","U_BG_Guerrilla_6_1","U_BG_leader"] call BIS_fnc_selectRandom;
		_unit forceAddUniform _unitform;
		
		if(floor(random 2) == 1) then {
			_headgear = ["H_ShemagOpen_khk","none","H_Shemag_olive","H_ShemagOpen_tan","none"] call BIS_fnc_selectRandom;
			if(_headgear != "none") then { _unit addHeadgear _headgear };
		} else {
			_goggles = ["G_Balaclava_blk","none","G_Balaclava_oli"] call BIS_fnc_selectRandom;
			if(_goggles != "none") then { _unit addGoggles _goggles };
		};
		
		_vest = ["V_BandollierB_cbr","V_HarnessO_brn","V_Rangemaster_belt","V_HarnessOSpec_brn"] call BIS_fnc_selectRandom;
		_unit addVest _vest;
		
		_unit addItemToVest "FirstAidKit";
		for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
		for "_i" from 1 to 4 do {_unit addItemToUniform "30Rnd_65x39_caseless_green";};
		
		_weapon = ["arifle_Katiba_C_F","arifle_Katiba_F","arifle_Katiba_C_ACO_F","arifle_Katiba_ARCO_pointer_F"] call BIS_fnc_selectRandom;
		_unit addWeapon _weapon;
	};
};




