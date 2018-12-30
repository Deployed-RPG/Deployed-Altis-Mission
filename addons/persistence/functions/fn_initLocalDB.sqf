#include "script_component.hpp"
/*
 * Author: xetra11
 *
 * This function will init the extDB3 local database
 *
 * Arguments:
 * 0: _dbName <STRING> - Name of Database config of extDB3 .ini file
 *
 * Example:
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

private _success = false;
_result = "extDB3" callExtension format["9:ADD_DATABASE:%1", _dbName];

if(!(_result isEqualTo "[1]")) then {
    ERROR("extDB3: error with database connection");
    _success = false;
} else {
    INFO("connection to database successful");
    _success = true;
};

private _protocolName = "coopr";
_result = "extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:%1:SQL:%2", _dbName, _protocolName];

if(!(_result isEqualTo "[1]")) then {
    ERROR("extDB3: error with database protocol connection");
    _success = false;
} else {
    INFO("connection to database with protocol successful");
    _success = true;
};

private _createUserTable = "CREATE TABLE users (
                               steam_id int NOT NULL,
                               characters_id int,
                               PRIMARY KEY (steam_id),
                               FOREIGN KEY (characters_id) REFERENCES characters(id));";

_result = "extDB3" callExtension format["1:%1:%2", _protocolName, _createUserTable];

if(!(_result isEqualTo "[1]")) then {
    ERROR("extDB3: error creating users table");
    _success = false;
} else {
    INFO("users table created successfully");
    _success = true;
};

private _createCharactersTable = "CREATE TABLE characters (
                                    id int NOT NULL,
                                    character_1 TEXT,
                                    character_2 TEXT,
                                    character_3 TEXT,
                                    PRIMARY KEY (id));";

_result = "extDB3" callExtension format["1:%1:%2", _protocolName, _createCharactersTable];

if(!(_result isEqualTo "[1]")) then {
    ERROR("extDB3: error creating characters table");
    _success = false;
} else {
    INFO("characters table created successfully");
    _success = true;
};

_success;
