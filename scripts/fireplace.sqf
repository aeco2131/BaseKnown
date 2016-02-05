if (isDedicated) exitWith {};
waitUntil {!isNull player};

_fplace = _this select 0;
_fsmoke = objNull;
_fly = objNull;
_fplace inflame true;
_smokeRestart = true;
_light = objNull;

_fly = "#particlesource" createVehicleLocal (getPosATL _fplace);
_fly setParticleParams[["\A3\animals_f\fly.p3d",1,0,1,0],"","spaceObject",1,4,[0,0,0],[0,0,0.5],0,1.30,1,0,[1.2,1.2,1.2,0],[[1,1,1,1],[1,1,1,1]],[1.5,0.5],0.01,0.08,"","",""];
_fly setParticleRandom[3,[0.8,0.8,0.5],[0,0,0],1,0.2,[0,0,0,0.1],0.01,0.03,10];
_fly setDropInterval 0.5;


while {alive _fplace} do {

	if(rain > 0.3) then {_fplace inflame false;};
	
	if(inflamed _fplace && _smokeRestart) then {

		_light = "#lightpoint" createVehicleLocal getPos _fplace; 
		_light setLightBrightness 0.18; 
		_light setLightAmbient [0.85,0.27,0]; 
		_light setLightColor [0.99,0.52,0.25]; 
		_light attachTo [_fplace,[0,0,0.6]];
		
		_fsmoke = "#particlesource" createVehicleLocal (getPosATL _fplace);
		_fsmoke setParticleParams
		/*Sprite*/		[["\A3\data_f\ParticleEffects\Universal\Universal_02",8,0,40,1],"",// File,Ntieth,Index,Count,Loop(Bool)
		/*Type*/			"Billboard",
		/*TimmerPer*/		1,
		/*Lifetime*/		8,
		/*Position*/		[0, 0, 2],
		/*MoveVelocity*/	[0, 0, 2.5],
		/*Simulation*/		1, 0.05, 0.04, 0.05,//rotationVel,weight,volume,rubbing
		/*Scale*/		[0.6, 17],
		/*Color*/		[[0.1,0.1,0.1,0.04],[0.2,0.2,0.2,0.05],[0.3,0.3,0.3,0.02],[0.3,0.3,0.3,0.03],[0.4,0.4,0.4,0.01]],
		/*AnimSpeed*/		[0.4, 0.3, 0.25],
		/*randDirPeriod*/	0.4,
		/*randDirIntesity*/	0.3,
		/*onTimerScript*/	"",
		/*DestroyScript*/	"",
		/*Follow*/		"",
		/*Angle*/              0,
		/*onSurface*/          true,
		/*bounceOnSurface*/    0.5,
		/*emissiveColor*/      [[0.6,0.6,0.6,0.02]]];

		_fsmoke setParticleRandom
		/*LifeTime*/		[9,
		/*Position*/		[0, 0, 2],
		/*MoveVelocity*/	[0, 0, 2.6],
		/*rotationVel*/		1,
		/*Scale*/		0.01,
		/*Color*/		[0.2,0.2,0.2,0.02],
		/*randDirPeriod*/	0.4,
		/*randDirIntesity*/	0.3,
		/*Angle*/		1];

		_fsmoke setDropInterval 0.08;
		_smokeRestart = false;
	};
	if(!inflamed _fplace && !_smokeRestart) then {
		deleteVehicle _fsmoke;
		if(!isNull _light) then { deleteVehicle _light};
		_smokeRestart = true;
	};
	sleep 5;
};



