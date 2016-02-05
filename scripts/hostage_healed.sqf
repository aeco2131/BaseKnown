if(isServer) then {

	_caller = [_this, 0, objNull] call BIS_fnc_param;
	
	if(alive hostage && !isNull _caller) then {
	
		removeHostageAction = true;
		publicVariable "removeHostageAction";
		
		sleep 2;
		
		hostage setBehaviour "SAFE";
		hostage setCombatMode "BLUE";
		
		hostage setDamage 0;
		[[hostage, "AinjPpneMstpSnonWrflDnon"], "switchMoveMP"] call BIS_fnc_MP;
		sleep 0.05;
		hostage playMoveNow "AmovPpneMstpSrasWrflDnon";
		hostage setDir ((getDir hostage) -180);
		sleep 2;
		hostage enableAI "ANIM";
		hostage enableAI "MOVE";
		sleep 1.8;
		[[hostage, ""], "switchMoveMP"] call BIS_fnc_MP;
		
		sleep 1;
		
		_deadL = hostage nearSupplies 10;
		
		if((count _deadL) > 0) then {
			{
				if(_x isKindOf "Man" && side _x == CIVILIAN) exitWith {
					
					hostage forceWalk true;
					hostage move getPos _x;
					
					while{(hostage distance _x) > 4} do {
						hostage doMove getPos _x;
						hostage moveTo getPos _x;
						sleep 1;
					};						
					
					sleep 2;
					
					if(alive hostage) then {
						hostage playActionNow "PutDown";
						sleep 1.5;
						hostage playActionNow "PutDownEnd";
						
						if((vest _x) != "") then { 
							hostage addVest (vest _x);
							removeVest _x;
							removeAllWeapons _x;
							hostage addItemToVest "30Rnd_65x39_caseless_green";
							hostage addItemToVest "30Rnd_65x39_caseless_green";
							hostage addItemToVest "30Rnd_65x39_caseless_green";
						};
						hostage addMagazine "30Rnd_65x39_caseless_green";
						hostage addWeapon "arifle_Katiba_F";
						hostage forceWalk false;
					};
				};
			} forEach _deadL;
		};
		
		if(alive hostage) then {
			hostage setBehaviour (behaviour _caller);
			hostage setCombatMode "YELLOW";
			[hostage] join (group _caller);
		};
	};
};