if(!isNull player) then {
	if(isNil "moneytaken") then {

		moneytaken = true;
		publicVariable "moneytaken";
		
		removeAllActions money;

		_p = switch (toUpper (stance player)) do
		{
			case "STAND": {"erc"};
			case "CROUCH": {"knl"};
			case "PRONE": {"pne"};
		};

		_w = switch (toLower (currentWeapon player)) do
		{
			case (toLower (primaryWeapon player)): {"rfl"};
			case (toLower (handgunWeapon player)): {"pst"};
			default {"non"};
		};

		_anim = format ["AmovP%1MstpSrasW%2Dnon_AinvP%1MstpSrasW%2Dnon_Putdown", _p, _w];
		player playMove _anim;

		sleep 1.2;

		deleteVehicle money;	
	};
};