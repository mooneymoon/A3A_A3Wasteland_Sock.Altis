//@file Version: 1.0
//@file Name: SaveWeaponCheck.sqf
//@file Author: Gigatek
//@file Created: 06/11/2015

private "_veh";
_veh = cursorTarget;

alive _veh &&
{player distance _veh <= (sizeOf typeOf _veh / 2) max 2} &&
{{_veh isKindOf _x} count ["B_static_AT_F", "O_static_AT_F", "I_static_AT_F", "B_static_AA_F", "O_static_AA_F", "I_static_AA_F", "B_HMG_01_F", "O_HMG_01_F", "I_HMG_01_F", "B_HMG_01_high_F", "O_HMG_01_high_F", "I_HMG_01_high_F", "B_GMG_01_F", "O_GMG_01_F", "I_GMG_01_F", "B_GMG_01_high_F", "O_GMG_01_high_F", "I_GMG_01_high_F", "B_Mortar_01_F", "O_Mortar_01_F", "I_Mortar_01_F"] > 0 && !(_veh getVariable ["R3F_LOG_disabled", true]) && _veh getVariable ["ownerUID",""] != getPlayerUID player && vehicle player == player}
