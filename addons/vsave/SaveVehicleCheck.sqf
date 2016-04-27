//@file Version: 1.0
//@file Name: SaveWeaponCheck.sqf
//@file Author: Gigatek
//@file Created: 06/11/2015

private "_veh";
_veh = cursorTarget;

alive _veh &&
{player distance _veh <= (sizeOf typeOf _veh / 2) max 2} &&
{{_veh isKindOf _x} count ["C_Kart_01_F", "Quadbike_01_base_F", "Hatchback_01_base_F", "SUV_01_base_F", "Offroad_01_base_F", "Van_01_base_F", "MRAP_01_base_F", "MRAP_02_base_F", "MRAP_03_base_F", "Truck_01_base_F", "Truck_02_base_F", "Truck_03_base_F", "Wheeled_APC_F", "Tank_F", "Rubber_duck_base_F", "SDV_01_base_F", "Boat_Civil_01_base_F", "Boat_Armed_01_base_F", "B_Heli_Light_01_F", "B_Heli_Light_01_armed_F", "C_Heli_Light_01_civil_F", "O_Heli_Light_02_unarmed_F", "I_Heli_light_03_unarmed_F", "B_Heli_Transport_01_F", "B_Heli_Transport_01_camo_F", "O_Heli_Light_02_F", "I_Heli_light_03_F", "B_Heli_Attack_01_F", "O_Heli_Attack_02_F", "O_Heli_Light_02_v2_F", "O_Heli_Attack_02_black_F", "I_Heli_Transport_02_F", "Heli_Transport_04_base_F", "B_Heli_Transport_03_unarmed_F", "B_Heli_Transport_03_F", "Plane", "UGV_01_base_F"] > 0 && !(_veh getVariable ["R3F_LOG_disabled", true]) && locked _veh != 2 && _veh getVariable ["ownerUID",""] != getPlayerUID player && vehicle player == player}
