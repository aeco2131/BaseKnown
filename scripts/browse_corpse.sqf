if(!isNull player) then {

	_target = _this select 0;
	_aid = _this select 2;
	
	if(!isNull _target) then {
	
		_dir = getDir player;
		player playMove "AinvPknlMstpSrasWrflDnon_Putdown_AmovPknlMstpSrasWrflDnon";
		sleep 2;
		player setDir _dir;
		player playMoveNow "AinvPknlMstpSrasWrflDnon_Putdown_AmovPknlMstpSrasWrflDnon";
		sleep 2;
		
		if(_target == target1 && isNil "target1browsed") then {
		
			target1browsed = true;
			publicVariable "target1browsed";
			
			if(!isNil {_aid}) then { target1 removeAction _aid };
			
			[[3], "r3_clientHint"] call BIS_fnc_MP;
			
			sleep 4;
			
			[[], "createHostage_tasks", false] call BIS_fnc_MP;
		};
		
		if(_target == target2 && isNil "target2browsed") then {
		
			target2browsed = true;
			publicVariable "target2browsed";
			
			if(!isNil {_aid}) then { target2 removeAction _aid };
			
			[[4], "r3_clientHint"] call BIS_fnc_MP;	
			
			sleep 4;
			
			[[], "createAmmo_tasks", false] call BIS_fnc_MP;
		};	
	};
};