if(!isNull player) then {

	1001 cutText ["", "BLACK OUT", 2];
	
	sleep 2;
	1001 cutText ["", "BLACK FADED", 0];
	
	{
		if(local _x) then {
			_x setPos getMarkerPos "intro_pos";
			if(!isPlayer _x) then { _x disableAI "MOVE" };
		};
	}forEach units group player;
	
	enableSentences false;
	showCinemaBorder true;

	playMusic "MisIntro";
	0 fadeMusic 1;
	
	_cam = "camera" camCreate [(getMarkerPos "camPos1" select 0), (getMarkerPos "camPos1" select 1), 2]; 
	_cam camSetTarget fire1;
	camUseNVG false;
	_cam cameraEffect ["internal", "BACK"]; 
	_cam camCommit 0;
	_cam camSetFov 0.9;
	
	sleep 3;
	
	_light = "#lightpoint" createVehicleLocal [(getMarkerPos "lightPos" select 0), (getMarkerPos "lightPos" select 1), 160];
	_light setLightBrightness 45;
	_light setLightAmbient [0,0.06,0.13]; 
	_light setLightColor [0,0.06,0.13]; 
	
	1001 cutFadeOut 4;
	
	sleep 11;
	
	_cam camSetPos [(getMarkerPos "camPos1" select 0), (getMarkerPos "camPos1" select 1), 25]; 
	_cam camSetFov 0.6;
	_cam camCommit 20;
	
	sleep 5;

	["<img image='images\music.paa' shadow='0' size='8'/>", 0.75, 0.45, 5, 2, 0, 1002] spawn BIS_fnc_dynamicText;
	
	[] spawn r3_skipTime;

	sleep 14;
	
	_cam camSetTarget [(getMarkerPos "camPos2" select 0), (getMarkerPos "camPos2" select 1), 330]; 
	_cam camSetFov 1;
	_cam camCommit 11;
	
	sleep 5;
	
	["<img image='images\main_logo.paa' shadow='0' size='11'/>", 0, 0.2, 15, 2, 0, 1003] spawn BIS_fnc_dynamicText;
	
	waitUntil{sleep 2; daytime < 19 && daytime >= 5};
	
	deleteVehicle _light;
	
	waitUntil{sleep 2; daytime < 19 && daytime >= 7};
	
	1100 cutText ["", "BLACK OUT", 3];
	
	sleep 3;
	
	1100 cutText ["", "BLACK FADED", 0];
	
	{
		if(local _x) then {
			_marker = format ["%1_pos",_x];
			_x setPos getMarkerPos _marker;
			[[_x,""], "switchMoveMP"] call BIS_fnc_MP;
			[_x] spawn r3_addBackpack;
			if(!isPlayer _x) then { _x enableAI "MOVE"; commandStop _x };
		};
	}forEach units group player;
	
	if(!isNil {p1}) then { if(local p1) then { p1 setDir ([p1,informant] call BIS_fnc_dirTo) }; };
	if(!isNil {p2}) then { if(local p2) then { p2 setDir ([p2,informant] call BIS_fnc_dirTo) }; };
	if(!isNil {p3}) then { if(local p3) then { p3 setDir ([p3,informant] call BIS_fnc_dirTo) }; };
	if(!isNil {p4}) then { if(local p4) then { p4 setDir ([p4,informant] call BIS_fnc_dirTo) }; };
	
	[true] call r3_weatherChange;
	
	if(isNil {introPlayed}) then {
		introPlayed = true;
		publicVariable "introPlayed";
	};
	
	_cam cameraEffect ["terminate","back"]; 
	camDestroy _cam;
	
	1100 cutFadeOut 3;

	enableSentences true;
};
