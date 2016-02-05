if(!isNull player) then {

	_unit = _this select 0;

	if(local _unit) then {
	
		{
			_unit removeWeaponGlobal _x;
		}forEach weapons _unit;

		{_unit removeMagazineGlobal _x;} foreach (magazines _unit);
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeGoggles _unit;
		removeHeadGear _unit;
		{
			_unit unassignItem _x;
			_unit removeItem _x;
		} foreach (assignedItems _unit);

		switch(_unit) do {
			// TEAM-LEADER
			case p1: {
				_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
				_unit addItemToUniform "FirstAidKit";
				for "_i" from 1 to 3 do {_unit addItemToUniform "30Rnd_65x39_caseless_mag";};
				_unit addVest "V_PlateCarrier2_rgr";
				for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
				_unit addItemToVest "SmokeShell";
				for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
				for "_i" from 1 to 3 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
				_unit addBackpack "B_Parachute";
				_unit addHeadgear "H_HelmetSpecB_paint2";
				_unit addGoggles "G_Bandanna_oli";
				
				_unit addMagazine "30Rnd_65x39_caseless_mag";
				_unit addWeapon "arifle_MX_F";
				_unit addPrimaryWeaponItem "acc_flashlight";
				_unit addPrimaryWeaponItem "optic_Arco";
				_unit addPrimaryWeaponItem "bipod_01_F_snd";
				_unit addWeapon "hgun_Pistol_heavy_01_F";
				_unit addHandgunItem "optic_MRD";
				_unit addWeapon "Binocular";

				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
			};
			// MEDIC
			case p2: {
				_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
				_unit addItemToUniform "FirstAidKit";
				
				_unit addVest "V_PlateCarrier1_rgr";
				for "_i" from 1 to 6 do {_unit addItemToVest "FirstAidKit";};
				_unit addItemToVest "SmokeShell";
				for "_i" from 1 to 2 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
				
				_unit addBackpack "B_Parachute";
				_unit addHeadgear "H_HelmetB_snakeskin";
				_unit addGoggles "G_mas_wpn_gog_md";
				
				if(332350 in (getDLCs 1)) then {
					for "_i" from 1 to 2 do {_unit addItemToUniform "20Rnd_762x51_Mag";};
					for "_i" from 1 to 3 do {_unit addItemToVest "20Rnd_762x51_Mag";};
					_unit addMagazine "20Rnd_762x51_Mag";
					_unit addWeapon "srifle_DMR_03_F";
					_unit addPrimaryWeaponItem "optic_Hamr";
					_unit addPrimaryWeaponItem "acc_flashlight";
					_unit addPrimaryWeaponItem "bipod_01_F_blk";
				} else {
					for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_65x39_caseless_mag";};
					for "_i" from 1 to 3 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
					_unit addMagazine "30Rnd_65x39_caseless_mag";
					_unit addWeapon "arifle_MXC_F";
					_unit addPrimaryWeaponItem "acc_flashlight";
					_unit addPrimaryWeaponItem "optic_Hamr";
				};
				_unit addWeapon "hgun_Pistol_heavy_01_F";
				_unit addHandgunItem "optic_MRD";
				_unit addWeapon "Binocular";

				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
			};
			// SNIPER
			case p3: {
				if(332350 in (getDLCs 1)) then {
					_unit forceAddUniform "U_B_FullGhillie_lsh";
				} else {
					_unit forceAddUniform "U_B_GhillieSuit";
				};
				_unit addItemToUniform "FirstAidKit";
				
				for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
				_unit addVest "V_PlateCarrier1_rgr";
				for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
				_unit addItemToVest "SmokeShell";
				for "_i" from 1 to 2 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
				_unit addBackpack "B_Parachute";
				_unit addGoggles "G_Bandanna_tan";
				
				if(332350 in (getDLCs 1)) then {
					for "_i" from 1 to 4 do {_unit addItemToUniform "10Rnd_338_Mag";};
					for "_i" from 1 to 6 do {_unit addItemToVest "10Rnd_338_Mag";};
					_unit addMagazine "10Rnd_338_Mag";
					_unit addWeapon "srifle_DMR_02_sniper_F";
					_unit addPrimaryWeaponItem "acc_flashlight";
					_unit addPrimaryWeaponItem "optic_AMS_snd";
					_unit addPrimaryWeaponItem "bipod_01_F_snd";				
				} else {
					for "_i" from 1 to 4 do {_unit addItemToUniform "20Rnd_762x51_Mag";};
					for "_i" from 1 to 5 do {_unit addItemToVest "20Rnd_762x51_Mag";};
					_unit addMagazine "20Rnd_762x51_Mag";
					_unit addWeapon "srifle_EBR_F";
					_unit addPrimaryWeaponItem "acc_flashlight";
					_unit addPrimaryWeaponItem "optic_DMS";
					_unit addPrimaryWeaponItem "bipod_01_F_snd";
				};

				_unit addWeapon "hgun_Pistol_heavy_01_F";
				_unit addHandgunItem "optic_MRD";
				_unit addWeapon "Rangefinder";

				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
			};
			// AMMO-GUY
			case p4: {
				_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
				for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
				_unit addVest "V_I_G_resistanceLeader_F";
				for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
				_unit addItemToVest "SmokeShell";
				_unit addItemToVest "200Rnd_65x39_cased_Box";
				_unit addBackpack "B_Parachute";
				_unit addHeadgear "H_HelmetSpecB";
				_unit addGoggles "G_Combat";
				
				_unit addMagazine "200Rnd_65x39_cased_Box";
				_unit addWeapon "LMG_Mk200_F";
				_unit addPrimaryWeaponItem "acc_flashlight";
				_unit addPrimaryWeaponItem "optic_Holosight";
				_unit addPrimaryWeaponItem "bipod_01_F_blk";
				_unit addWeapon "hgun_Pistol_heavy_01_F";
				_unit addHandgunItem "optic_MRD";
				_unit addWeapon "Binocular";

				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
			};
		};
	};
};



			