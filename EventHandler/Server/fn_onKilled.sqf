#include "..\constants.hpp"

params ["_victim", "_killer", "_instigator", "_useEffects"];
LSTART("ON KILL");

private _lastDamageSource = _victim getVariable ["ace_medical_lastDamageSource", objNull];
FLOG("instigator: %1", _instigator);
FLOG("instigator is null: %1", isNull _instigator);
FLOG("lastDmgSrc: %1", _lastDamageSource);
FLOG("killer: %1", _killer);
FLOG("victim: %1", _victim);

// if entity died of later causes than the shot itself
if(isNull _instigator) then {
    _killer = _lastDamageSource;
};

if(isPlayer _victim) then {
    if(_victim isEqualTo _killer) then {
        SLOG("player killed himself");
    } else {
     // check for PvP
     // add X11_fnc_playerKilledPlayer;
    };
    LEND("ON KILL");
} else {
    if (isPlayer _killer) then {
        [_victim] remoteExec ["X11_fnc_playerKilledNpc", _killer];
    };
    LEND("ON KILL");
}
