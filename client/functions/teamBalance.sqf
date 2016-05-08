// Teambalancer
_uid = getPlayerUID player;
_teamBal = ["A3W_teamBalance", 0] call getPublicVar;
if (playerSide in [BLUFOR,OPFOR] && _teamBal > 0) then{
	private ["_justPlayers", "_serverCount", "_sideCount"];
	_justPlayers = allPlayers - entities "HeadlessClient_F";
	_serverCount = count _justPlayers;
	_sideCount = playerSide countSide _justPlayers;
	if (_serverCount >= 10 && (_sideCount > (_teamBal/100) * _serverCount)) then{
		if !((getPlayerUID player) call isAdmin) then {
			if(!isNil "pvar_teamSwitchList")then{
				{ if (_x select 0 == _uid) exitWith {
					if(_x select 1 == playerSide)then{
						//If player is locked to the side that is unbalanced, move their lock to indie
						_x set [1, INDEPENDENT];
					};
				} } forEach pvar_teamSwitchList;
				publicVariable "pvar_teamSwitchList";
			};
			["TeamBalance",false,1] call BIS_fnc_endMission;
		} else {
			cutText ["You have used your admin to join a stacked team. Only do this for admin duties.", "PLAIN DOWN", 1];
		};
	};
};
