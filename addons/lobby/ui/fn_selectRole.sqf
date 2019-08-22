#include "script_component.hpp"
/*
 * Author: xetra11
 *
 * Handles the event of the selection of the role combo box in the creation screen
 *
 * Arguments:
 * 0: _loginDialog <CONTROL> - the login dialog
 * 1: _rolesHash <CBA_HASH> - the roles hash
 *
 * Public: No
 *
 * Scope: LBSelChanged Event
 */

params ["_ctrl", "_index"];

detach COOPR_LOBBY_AGENT;
COOPR_LOBBY_AGENT setDir 0;
hideObject COOPR_LOBBY_PROP_STRETCHER;
hideObject COOPR_LOBBY_PROP_BODYBAG;
COOPR_LOBBY_AGENT hideObject false;

private _loginDialog = findDisplay GUI_ID_LOGIN_DIALOG;
private _rolesHash = [COOPR_CHARACTER_ROLES, []] call CBA_fnc_hashCreate;

private _picture = _loginDialog displayCtrl GUI_ID_LOGIN_CHARACTER_CREATION_ROLE_PICTURE;
private _roleName = _ctrl lbText _index;
private _roleId = [_rolesHash, _roleName] call CBA_fnc_hashGet;
private _roleImage = [_roleId] call coopr_fnc_getImageForRole;
private _loadOut = _roleId call coopr_fnc_getLoadoutForRole;

COOPR_LOBBY_AGENT setUnitLoadout _loadOut;
[_roleId] spawn { [_this select 0] call coopr_fnc_playAnimationForRole; };

_picture ctrlSetText _roleImage;