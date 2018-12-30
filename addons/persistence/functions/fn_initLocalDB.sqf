#include "script_component.hpp"
/*
 * Author: xetra11
 *
 * This function will init the extDB3 local database
 *
 * Arguments:
 * 0: _dbName <STRING> - Name of Database config of extDB3 .ini file
 *
 * [Database] <- this
 * IP = 127.0.0.1
 * Port = 3306
 * Username = coopr
 * Password = coopr
 * Database = coopr_local
 *
 * Return Value:
 * success <BOOLEAN>
 *
 * Example:
 * "Database" call coopr_fnc_allVariablesToHash
 *
 * Public: No
 *
 * Scope: Server
 */

params[["_dbName", ""]];

if(_dbName isEqualTo "") then { ERROR("_dbName was empty string") };

_result = "extDB3" callExtension format["9:ADD_DATABASE:%1", _dbName];

if(!(_result isEqualTo "[1]")) exitWith {
    ERROR("extDB3: error with database connection");
    false;
} else {
    INFO("connection to database successful");
};

private _protocolName = "coopr";
_result = "extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:%1:SQL:%2", _dbName, _protocolName];

if(!(_result isEqualTo "[1]")) exitWith {
    ERROR("extDB3: error with database protocol connection");
    false;
} else {
    INFO("connection to database with protocol successful");
};
true;
