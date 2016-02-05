if (isServer) then {

	// STARTUP TASKS
	[
		west,
		"missionTask",
		["<img image='images\header.jpg' width='355' height='90'/><br/><br/>Main mission (sorted below)", "Main mission:", ""],
		nil,
		"CREATED",-1,false
	] call BIS_fnc_taskCreate;
	
	waitUntil{["missionTask"] call BIS_fnc_taskExists };

	[
		west,
		["regroupTask","missionTask"],
		["<img image='images\camptask.jpg' width='355' height='355'/><br/><br/>Sgt.Ramsey prepared a camp, regroup there and stay the night.", "Regroup and stay", "REGROUP"],
		getMarkerPos "camp_marker",
		"ASSIGNED",20,false
	] call BIS_fnc_taskCreate;

	// TALK TASK
	createTalk_tasks = {	
		[
			west,
			["talkTask","missionTask"],
			["<img image='images\talktask.jpg' width='355' height='355'/><br/><br/>Talk with Sgt.Ramsey to get your briefing.", "Get your briefing", "TALK"],
			[informant, true],
			"ASSIGNED",19,false
		] call BIS_fnc_taskCreate;
		
		waitUntil{["talkTask"] call BIS_fnc_taskExists};
	};

	// MAIN TARGETS
	createTarget_tasks = {
		[
			west,
			["target1Task","missionTask"],
			["<img image='images\target1.jpg' width='355' height='355'/><br/><br/>Locate and eliminate Mustafa Karami, he's currently waiting for Yuri Orlov on negotiation point.", "Mustafa Karami", "ELIMINATE"],
			nil,
			"CREATED",15,false
		] call BIS_fnc_taskCreate;
		
		waitUntil{["target1Task"] call BIS_fnc_taskExists };
		
		[
			west,
			["target2Task","missionTask"],
			["<img image='images\target2.jpg' width='355' height='355'/><br/><br/>Eliminate Yuri Orlov. He left Altis 1 hour ago and will land on Kamino-Bay around 7:10 am.<br/><br/>You can capture Yuri on the way to destination, or wait until the negotiation have begun, to get both targets.", "Yuri Orlov", "ELIMINATE"],
			nil,
			"CREATED",17,false
		] call BIS_fnc_taskCreate;

		waitUntil{["target2Task"] call BIS_fnc_taskExists};
	};

	// INTEL TASK
	createIntel_task = {
		[
			west,
			["intelTask","missionTask"],
			["<img image='images\inteltask.jpg' width='355' height='355'/><br/><br/>Karami is down ! hurry up and secure the intel.<br/><br/>You can also browse Karamis corpse, maybe you can find something.", "Secure intel", "SECURE"],
			[intel, true],
			"ASSIGNED",14,true
		] call BIS_fnc_taskCreate;
		
		waitUntil{["intelTask"] call BIS_fnc_taskExists};
	};
	
	// MONEY TASK
	createMoney_task = {
		[
			west,
			["moneyTask","missionTask"],
			["<img image='images\moneytask.jpg' width='355' height='355'/><br/><br/>Yuri Orlov eliminated, now find and secure Yuris money.<br/><br/>You can also browse Yuris corpse, maybe you can find something.", "Secure the money", "SECURE"],
			[money, true],
			"ASSIGNED",16,true
		] call BIS_fnc_taskCreate;
		
		waitUntil{["moneyTask"] call BIS_fnc_taskExists};
	};
	
	// EXTRACTION TASK
	createExtraction_task = {
		if !(["extractionTask"] call BIS_fnc_taskExists) then {
			[
				west,
				["extractionTask","missionTask"],
				["<img image='images\extraction.jpg' width='355' height='355'/><br/><br/>Good job, all objectives done !, throw GREEN-SMOKE and we will get you out.<br/><br/>Pay attention to a free landing position without trees, rocks and buildings.", "Extraction", "GET IN"],
				nil,
				"CREATED",10,true
			] call BIS_fnc_taskCreate;
			
			waitUntil{["extractionTask"] call BIS_fnc_taskExists};
			
			[[], "r3_chkGreenSmoke"] call BIS_fnc_MP;
		};
	};
	
	// OPTIONAL TASKS
	createOptional_tasks = {
		[
			west,
			"optionalTask",
			["<img image='images\header.jpg' width='355' height='90'/><br/><br/>Optional missions (sorted below)", "Optional:", ""],
			nil,
			"CREATED",-1,false
		] call BIS_fnc_taskCreate;
		
		waitUntil{["optionalTask"] call BIS_fnc_taskExists};
	};
	
	// HOSTAGE TASK
	createHostage_tasks = {
	
		if!(["hostageTask"] call BIS_fnc_taskExists) then {
		
			if!(["optionalTask"] call BIS_fnc_taskExists) then {
				[] call createOptional_tasks;
			};
			
			"hostage_marker" setMarkerAlpha 0.9;
			
			[
				west,
				["hostageTask","optionalTask"],
				["<img image='images\hostagetask.jpg' width='355' height='355'/><br/><br/>You found information about a hostage near you. Rescue or leave it, your choice.<br/><br/>The task is complete soon as the hostage sitting in extraction chopper.", "Rescue the hostage", "RESCUE"],
				getMarkerPos "hostage_marker",
				"CREATED",-1,true
			] call BIS_fnc_taskCreate;
			
			waitUntil{["hostageTask"] call BIS_fnc_taskExists};
			
			waitUntil{sleep 2; !alive hostage};
			
			["hostageTask", "FAILED", true] call BIS_fnc_taskSetState;
		};
	};
	
	// AMMO TASK
	createAmmo_tasks = {	
	
		if!(["ammoTask"] call BIS_fnc_taskExists) then {
		
			if!(["optionalTask"] call BIS_fnc_taskExists) then {
				[] call createOptional_tasks;
			};
			
			"arsenal_marker" setMarkerAlpha 0.9;
			
			[
				west,
				["ammoTask","optionalTask"],
				["<img image='images\ammotask.jpg' width='355' height='355'/><br/><br/>You found information about Yuris hidden arsenal. Your choice to destroy it.", "Destroy arsenal", "DESTROY"],
				getMarkerPos "arsenal_marker",
				"CREATED",-1,true
			] call BIS_fnc_taskCreate;
			
			waitUntil{["ammoTask"] call BIS_fnc_taskExists};
			
			waitUntil{sleep 2; (ammo1destroyed && ammo2destroyed && ammo3destroyed)};
			
			["ammoTask", "SUCCEEDED", true] call BIS_fnc_taskSetState;
		};
	};
};




