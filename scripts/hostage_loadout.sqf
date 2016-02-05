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

	_unit forceAddUniform "U_C_Journalist";
	_unit addItemToUniform "FirstAidKit";
	_unit addHeadgear "H_Cap_press";

	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";

	_unit setFace "WhiteHead_01";
	_unit setSpeaker "Male01ENGB";
};