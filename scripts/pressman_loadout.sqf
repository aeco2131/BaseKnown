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
};