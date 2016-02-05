if(isServer) then {

	_unit = _this select 0;
	_unitClass = typeOf _unit;
	_skipUnits = [target2];
	
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

		_unit forceAddUniform "U_BG_Guerilla2_1";
		for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_65x39_caseless_mag";};
		_unit addItemToUniform "9Rnd_45ACP_Mag";
		
		_vest = ["V_TacVest_blk","V_TacVestIR_blk","V_Chestrig_blk"] call BIS_fnc_selectRandom;
		_unit addVest _vest;
		
		_unit addItemToVest "FirstAidKit";
		for "_i" from 1 to 2 do {_unit addItemToVest "9Rnd_45ACP_Mag";};
		for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
		_unit addItemToVest "DemoCharge_Remote_Mag";
		
		_headgear = ["H_Cap_blk","H_Cap_blk_CMMG","H_Bandanna_gry","H_Beret_blk"] call BIS_fnc_selectRandom;
		_unit addHeadgear _headgear;
		
		_goggles = ["G_Bandanna_sport","G_Tactical_Clear","G_Bandanna_blk","G_Spectacles_Tinted"] call BIS_fnc_selectRandom;
		_unit addGoggles _goggles;

		if(floor(random 2) == 1) then {
			_unit addWeapon "arifle_MX_Black_F";
			_unit addPrimaryWeaponItem "acc_pointer_IR";
			_unit addPrimaryWeaponItem "optic_Hamr";
			_unit addPrimaryWeaponItem "bipod_01_F_blk";
		} else {
			_unit addWeapon "arifle_MXC_Black_F";
			_unit addPrimaryWeaponItem "acc_pointer_IR";
			_unit addPrimaryWeaponItem "optic_Holosight";
		};
		
		_unit addWeapon "hgun_ACPC2_F";
		_unit addWeapon "Binocular";
	};
};





