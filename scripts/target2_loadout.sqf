if(isServer) then {
	_unit = _this select 0;

	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	_unit forceAddUniform "U_Marshal";
	_unit addVest "V_Rangemaster_belt";
	
	if(floor(random 2) == 1) then {
		_unit addHeadgear "H_Cap_blk";
	};
	
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";

	_unit setFace "WhiteHead_20";
	_unit setSpeaker "Male02PER";
};
