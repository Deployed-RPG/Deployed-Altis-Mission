#include "..\constants.hpp"

private _commander = GLOB(DPL_NPC_COMMANDER);

_commander setBehaviour "CARELESS";
[_commander, "AidlPercMstpSnonWnonDnon_G02", "ASIS"] call BIS_fnc_ambientAnim;
_commander addAction [localize "str.dpl.reputation.action.commander", {call X11_fnc_deliverAfterActionReport},[],1.5,true,true,"","true",3];
