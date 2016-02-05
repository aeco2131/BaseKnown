_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit forceAddUniform "U_I_G_resistanceLeader_F";
_unit addVest "V_PlateCarrier1_blk";
_unit addItemToVest "SmokeShell";
for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
_unit addHeadgear "H_HelmetB";
_unit addGoggles "G_mas_wpn_mask_b";

_unit addWeapon "arifle_MXC_Black_F";
_unit addPrimaryWeaponItem "acc_flashlight";
_unit addPrimaryWeaponItem "optic_ACO_grn_smg";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addWeapon "Binocular";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

_unit setFace "AfricanHead_03";
_unit setSpeaker "Male03ENG";
[_unit,"TFAegis"] call bis_fnc_setUnitInsignia;

_unit enableGunLights "forceOn";
