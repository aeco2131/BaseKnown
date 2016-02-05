if(isServer) then {
	if(alive target1) then {
		target1 setBehaviour "SAFE";
		target1 forceWalk true;
		
		target1 move getMarkerPos "entrance";
		target1 doMove getMarkerPos "entrance";
		target1 moveTo getMarkerPos "entrance";
		
		waitUntil{sleep 1; !alive target1 OR unitReady target1};
		
		if(alive target1) then {
			target1 disableAI "MOVE";
			target1 setPosATL [6063.5,5629.23,0.00142288];
			target1 setDir 201;
			intel attachTo [tisch2,[0,0,0.41]];
			
			target1onTable = true;
			
			if(target2onTable) then {
				[[5], "r3_clientHint"] call BIS_fnc_MP;	
			};
		};	
	};
};