if (isServer) then {

	// All Players dead
	[] spawn {
		if(isMultiplayer) then {
			while{true} do {
				sleep 15;
				[] spawn chk_dead;
			};
		};
	};
	
	// Mission Start to Intro
	[] spawn {
		
		mohawk setVelocity [0,0,0];
		_light1 = "Chemlight_red" createVehicle getPos mohawk;
		_light1 attachTo [mohawk,[0,-1.4,-0.35]];
		mohawk setVelocity [0,0,0];
		_light2 = "Chemlight_red" createVehicle getPos mohawk;
		_light2 attachTo [mohawk,[0,2,-0.35]];
	
		if(!isNil {p1}) then { if(isPlayer p1) then { waitUntil{sleep 1; !isNil "p1_ready"}; }; };
		if(!isNil {p2}) then { if(isPlayer p2) then { waitUntil{sleep 1; !isNil "p2_ready"}; }; };
		if(!isNil {p3}) then { if(isPlayer p3) then { waitUntil{sleep 1; !isNil "p3_ready"}; }; };
		if(!isNil {p4}) then { if(isPlayer p4) then { waitUntil{sleep 1; !isNil "p4_ready"}; }; };
		
		_jumpPos = getMarkerPos "jumpOut";
		mohawk enableAI "MOVE";
		mohawk doMove _jumpPos;
		mohawk moveTo _jumpPos;
		
		intro_car enableAI "MOVE";
		
		waitUntil{sleep 1; (mohawk distance _jumpPos) < 1300};
		
		mohawk animateDoor ["CargoRamp_open",1,true];
		
		sleep 3.5;
		
		deleteVehicle _light1;
		deleteVehicle _light2;
		
		_light1 = "Chemlight_green" createVehicle getPos mohawk;
		_light1 attachTo [mohawk,[0,-1.4,-0.35]];
		_light2 = "Chemlight_green" createVehicle getPos mohawk;
		_light2 attachTo [mohawk,[0,2,-0.35]];
		
		sleep 5;
		
		mohawk lock false;
		{
			if(_x in mohawk) then {
				moveOut _x;
				
				if(local _x) then {
					_x setDir 10;
				} else {
					[[_x,10], "setDirMP", _x] spawn BIS_fnc_MP;
				};
				
				sleep 0.2;
			};
		}forEach units Deltaone;
		
		sleep 1;
		
		[flare_pos] spawn fireFlare;
		
		[] spawn {
			mohawk animateDoor ["CargoRamp_open",0];
			_endPos = getMarkerPos "mohawkEnd";
			mohawk move _endPos;
			mohawk doMove _endPos;
			
			waitUntil{sleep 5; unitReady mohawk};
			
			mohawk disableAI "MOVE";
			mohawk engineOn false;
			mohawk setPos getmarkerPos "tmp_mohawk";
			mohawk setVelocity [0,0,0];
		};
		
		sleep 3;
		
		deleteVehicle _light1;
		deleteVehicle _light2;	
		
		[[], "r3_openPara"] call BIS_fnc_MP;
		
		sleep 20;
		
		while { ({(_x distance fire1) < 25} count units Deltaone) != (count units Deltaone) } do {
			sleep 3;
		};
		
		sleep 4;
		
		deleteVehicle cheat_trigger;
		
		//fire intro on all clients
		[[[],"scripts\intro.sqf"],"BIS_fnc_execVM"] call BIS_fnc_MP;
		
		sleep 2;
		
		detach informant;
		informant setPos getMarkerPos "intro_pos";

		sleep 19;
		
		if(isDedicated) then {
		
			while{daytime > 19 OR daytime < 7} do {
				if(daytime > 19 && daytime < 5) then {
					skipTime 0.2;
				} else {
					skipTime 0.024;
				};
				sleep 0.08;
			};
			
			0 setFog 0;
			0 setOvercast 0.32;
			forceWeatherChange;
		} else {
			sleep 18;
		};

		fire1 inflame false;
		ammo1 setPos getMarkerPos "ammo1_pos";
		informant setPos getMarkerPos "informant_pos";
		informant setDir 350;
		[[informant,"HubStandingUC_move2"], "switchMoveMP"] call BIS_fnc_MP;
		
		// Create TALK TASK
		[] call createTalk_tasks;
	};
	
	// Mission after intro
	[] spawn {
		waitUntil{sleep 2; !isNil "introPlayed"};
		
		sleep 2;
		
		["regroupTask", "SUCCEEDED", true] call BIS_fnc_taskSetState;
		
		waitUntil{sleep 0.5; !isNil "infotalk"};
		
		// Informant Talking
		[[informant, "Good morning, sir, I hope you had a good night."], "sideChatMP"] call BIS_fnc_MP;
		[[informant, "informant_1"], "say3DMP"] call BIS_fnc_MP;
		sleep 2.5;
		[[informant, "Let's talk about your briefing: Today you have two main targets."], "sideChatMP"] call BIS_fnc_MP;
		[[informant, "informant_2"], "say3DMP"] call BIS_fnc_MP;	
		sleep 4.2;
		[[informant, "The first is Mustafa Karami, who is in possession of stolen high-risk documents. Selling these would be detrimental to national security."], "sideChatMP"] call BIS_fnc_MP;
		[[informant, "informant_3"], "say3DMP"] call BIS_fnc_MP;	
		sleep 8.3;
		[[informant, "The second of your targets is Yuri Orlov, a known rich arms dealer with contact to terror groups."], "sideChatMP"] call BIS_fnc_MP;
		[[informant, "informant_4"], "say3DMP"] call BIS_fnc_MP;	
		sleep 5.9;
		[[informant, "I updated your map and objective list, take a look at both if you need more details."], "sideChatMP"] call BIS_fnc_MP;
		[[informant, "informant_5"], "say3DMP"] call BIS_fnc_MP;
		sleep 4.9;
		[[informant, "Good luck and all the best!"], "sideChatMP"] call BIS_fnc_MP;
		[[informant, "informant_6"], "say3DMP"] call BIS_fnc_MP;
		sleep 3.5;
		
		//Sync Time to Clients/Server
		[[], "r3_syncTime"] call BIS_fnc_MP;
		
		[[informant,"HubStandingUC_move2"], "switchMoveMP"] call BIS_fnc_MP;
		
		// Create TARGET TASKS
		[] call createTarget_tasks;
		
		"pa1" setMarkerAlpha 0.7; 
		"pa2" setMarkerAlpha 0.7; 
		"pr_point" setMarkerAlpha 1; 
		"observe_marker" setMarkerAlpha 1; 
		"mine_field" setMarkerAlpha 0.9;
		"mine_radius" setMarkerAlpha 0.3;
		"ammo2_marker" setMarkerAlpha 0.9;
		
		["talkTask", "SUCCEEDED", true] call BIS_fnc_taskSetState;
		
		press_guard enableAI "MOVE";
		
		sleep 2;
		
		if(!isMultiplayer) then { saveGame };
		
		// Target1 found
		[] spawn {
			waitUntil{sleep 5; (Deltaone knowsAbout target1) > 1};
			["target1Task", [target1, true]] call BIS_fnc_taskSetDestination;
		};
		
		// Target 1 killed
		[] spawn {
			waitUntil{sleep 2; !alive target1};
			[] execVM "scripts\target1_killed.sqf";
		};

		// Target1 found
		[] spawn {
			waitUntil{sleep 5; (Deltaone knowsAbout target2) > 1};
			["target2Task", [target2, true]] call BIS_fnc_taskSetDestination;
		};
		
		// Target 2 killed
		[] spawn {
			waitUntil{sleep 2; !alive target2};	
			[] execVM "scripts\target2_killed.sqf";
		};
		
		// Start Target 2 at 7:09 am
		[] spawn {
			waitUntil{sleep 5; daytime > 7.12};
			
			sleep floor(random 60);
			
			target2 enableAI "MOVE";
			
			_t2pos = getMarkerPos "t2_move1";
			target2 doMove _t2pos;
			target2 moveTo _t2pos;
			
			waitUntil{sleep 1; !alive target2 OR unitReady target2};
						
			if(alive target2_driver && alive target2) then {
				target2 setSpeedMode "LIMITED";
				target2_boot limitSpeed 15;
				target2 doMove getMarkerPos "t2_move2";
				target2 moveTo getMarkerPos "t2_move2";
				
				_timeOut = time + 30;
				
				waitUntil{sleep 1; !alive target2 OR unitReady target2 OR time > _timeOut};
				
				if(alive target2 && !unitReady target2) then {
					target2_boot setPos getMarkerPos "t2_move2";
				};
				
				[] execVM "scripts\target2_arrived.sqf";
				
			} else {
				if(alive target2) then {
					target2 setSpeedMode "LIMITED";
					target2_boot limitSpeed 15;
					[] execVM "scripts\target2_escape.sqf";
				};
			};
		};
	};
};


