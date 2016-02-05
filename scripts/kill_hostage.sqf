if(isServer) then {
	
	_msg = parseText "<t color='#ff6c00' size='1.1' shadow='1' shadowColor='#000000' align='center'>Hostage guardian alerted ! Hurry up !</t>";
	[[_msg], "hintMP"] call BIS_fnc_MP;
	
	sleep 10 + floor(random 15);
	
	if(alive hostage) then {
	
		_shooter = objNull;
		_distance = 30;
		
		_killers = [hkiller1, hkiller2, hkiller3];
		
		{
			if(alive _x) then {
				if((_x distance hostage) < _distance) then {
					_shooter = _x;
					_distance = (_x distance hostage);
				};
			};
		}forEach _killers;
		
		if(!isNull _shooter) then {
			_shooter reveal hostage;
			_shooter enableAI "MOVE";
			sleep 0.5;
			_shooter doWatch hostage;
			_shooter doTarget hostage;
			sleep 2;
			
			if(alive _shooter) then {
				[[hostage, "AinjPpneMstpSnonWrflDnon"], "switchMoveMP"] call BIS_fnc_MP;
				sleep 0.1;
				_shooter doFire hostage;
				_shooter fireAtTarget [hostage];
				
				[] spawn createHostage_tasks;
			};
		};
	};
};