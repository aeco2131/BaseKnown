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
	_unit addVest "V_TacVestIR_blk";
	_unit addHeadgear "H_ShemagOpen_tan";

	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";

	_unit setFace "WhiteHead_17";
	_unit setSpeaker "Male01PER";
};
