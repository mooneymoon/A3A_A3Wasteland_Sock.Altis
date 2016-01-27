//@file Version: 1.0
//@file Name: RespawnRemove.sqf
//@file Author: AgentRev, Gigatek
//@file Created: 26/01/2016

private "_veh";
_veh = param [0, objNull, [objNull]];

if (!isNil "A3W_respawningVehicles") then
{
	_rspnSettings = _veh getVariable "vehicleRespawn_settingsArray";

	if (!isNil "_rspnSettings") then
	{
		A3W_respawningVehicles deleteAt (A3W_respawningVehicles find _rspnSettings);
		_veh setVariable ["vehicleRespawn_settingsArray", nil];
	};
};