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

	_unit forceAddUniform "U_C_HunterBody_grn";
	_unit linkItem "ItemWatch";
	_unit setFace "GreekHead_A3_06";
	_unit setSpeaker "Male03PER";
};

