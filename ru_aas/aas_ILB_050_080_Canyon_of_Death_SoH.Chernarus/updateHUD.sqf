﻿#include "globalDefines.hpp"
array _teamColor =
	[ [1,1,1,1] ,
	  [1,0,0,1] ,     // red team
	  [0,0.7,1,1] ,     // blue team
	  [0,1,0,1] ];  // green team
	
array _teamBackColor =
	[ [1,1,1,0.6] ,
	  [0,0,0,0.2] ,     // red team
	  [0,0,0,0.2] ,     // blue team
	  [0,0,0,0.5] ];  // green team

int _mySide=0;
int _myTeamColIdx=1;
if( WEST_PLAYER ) then
	{
	_mySide = 1; 
	_myTeamColIdx = 2;
	};
updateTagsThreadRun = true;
array playerMarkers = [];
 _currentCutDisplay = uiNamespace getVariable "curdispHUD";
string _mColor="ColorBlue";
if( EAST_PLAYER ) then
	{
		 _mColor="ColorRed";
	};
	private "_val";
_var = 0; 
call {
    if (_var == 0) exitWith {_val = "0"};
    if (_var == 1) exitWith {_val = "1"};
    if (_var == 2) exitWith {_val = "2"};
    _val = "N/A";
};

	_map = _currentCutDisplay displayCtrl IDC_MAP;
	_mapBackground = _currentCutDisplay displayCtrl IDCMINIMAPBACK;
	if( hudDisplayLevel == HUD_LEVEL_FULL ) then
	{	
		pos _mapPos = ctrlPosition _map;
		_mapPos set[ 0, safeZoneW + safeZoneX - (MINIMAPWIDTH  + 0.01) ];
		_mapPos set[ 1, safeZoneH + safeZoneY - (MINIMAPHEIGHT + 0.01) ]; 		
		_map ctrlSetPosition _mapPos;
		_map ctrlShow true;
		ctrlMapAnimClear _map;
		_map ctrlMapAnimAdd[0, mapZoomLevel, getPos player];
		ctrlMapAnimCommit _map;			
		_map ctrlCommit 0;	//ARMA3
		pos _mbPos = ctrlPosition _mapBackground;
		_mbPos set[ 0, safeZoneW + safeZoneX - (MINIMAPWIDTH  + 0.0115) ];
		_mbPos set[ 1, safeZoneH + safeZoneY - (MINIMAPHEIGHT + 0.0115) ]; 				
		_mapBackground ctrlSetPosition _mbPos;		
		_mapBackground ctrlShow true;
		_mapBackground ctrlCommit 0; //ARMA3
	}
	else
	{
		_map ctrlShow false;		
		_mapBackground ctrlShow false;
	};
	array _capMessage = [ [[localize "STR_AAS_Dummy",localize "STR_AAS_Dummy"],[localize "STR_AAS_Recamping",localize "STR_AAS_Losing"],[localize "STR_AAS_Capturing",localize "STR_AAS_Enemy_recamping"],[localize "STR_AAS_Capturing",localize "STR_AAS_Dummy"]] ,
						[ [localize "STR_AAS_Dummy",localize "STR_AAS_Dummy"],[localize "STR_AAS_Capturing",localize "STR_AAS_Enemy_recamping"],[localize "STR_AAS_Recamping",localize "STR_AAS_Losing"],[localize "STR_AAS_Capturing",localize "STR_AAS_Dummy"]]   ]; 
	string _baseCapStr = "";
	array _baseCapColor = [ 0.5 , 0.5 , 0.5 , 1 ];
	bool _baseFound=false;
	float _capPercent=100;
		{
		string _thisBaseName = BASENAME(_x);
		if ( player distance (getMarkerPos _thisBaseName) < ((getMarkerSize _thisBaseName) select 0) and !_baseFound and BASECACHEA(_x,CAPLEVEL) < 100 ) then
			{
			_baseFound=true;
			int _diff = BASECACHEA(_x,NUMRED) - BASECACHEA(_x,NUMBLUE);
			if( WEST_PLAYER ) then { _diff = 0 - _diff; };
			int _capDir=0;
			if( _diff < 0 ) then { _capDir=1; };
			string _msg = ((_capMessage select _mySide) select BASEA(_x,TEAM)) select _capDir;
			if( _diff == 0 ) then { _msg = localize "STR_AAS_Capturing "; };
			_baseCapStr = format["%1%2 - %3 %4 (x%5)", round BASECACHEA(_x,CAPLEVEL), "%", _msg, base_names select _x, abs _diff];		
			_baseCapColor = _teamColor select BASEA(_x,TEAM);
			_capPercent=BASECACHEA(_x,CAPLEVEL);
			};
		} forEach curBaseList;
	control _backgroundControl = _currentCutDisplay displayCtrl IDCBASECAPBACKGROUND;
	control _control           = _currentCutDisplay displayCtrl IDCPROGRESSBAR;
	if( _baseFound) then
		{
		// inside a perimeter
		pos _position = ctrlPosition _backgroundControl;
		_position set[1, safeZoneY + BASECAPBACKGROUND_Y ];	
		_backgroundControl ctrlSetPosition _position;
		_backgroundControl ctrlShow true;
		pos _position = ctrlPosition _control;
		float _maxWidth = (ctrlPosition _backgroundControl select 2) - 0.02;				
		_position set[1, safeZoneY + PROGRESSBAR_Y ];
		_position set[2,_maxWidth * _capPercent / 100];
		_control ctrlSetPosition _position;
		_control ctrlSetText _baseCapStr;
		_control ctrlSetBackgroundColor _baseCapColor;		
		_control ctrlShow true;		
		}
	else
		{
		_backgroundControl ctrlShow false;
		_control ctrlShow false;
		};		
	_backgroundControl ctrlCommit 0;
	waitUntil { ctrlCommitted _backgroundControl };
	_control ctrlCommit 0;
	waitUntil { ctrlCommitted _control };		
	_displayGeneralInfo = true;
	if( hudDisplayLevel == HUD_LEVEL_MINIMAL ) then { _displayGeneralInfo = false; };
	_control = _currentCutDisplay displayCtrl IDCTIMERLABEL;
	_control ctrlSetText tleft;	
	_control ctrlShow _displayGeneralInfo;
	pos _controlPos = ctrlPosition _control;
	_controlPos set[ 0 , safeZoneW + safeZoneX - (1-TIMERLABEL_X) ];
	_controlPos set[ 1 , TIMERLABEL_Y - safeZoneY ];
	_control ctrlSetPosition _controlPos;
	_control ctrlCommit 0;
	waitUntil { ctrlCommitted _control };
	_playersStr=format["%1 - %2W v %3E (%4 tot)", SHORT_VERSION, playersNumber west,playersNumber east,(playersNumber west) + (playersNumber east)];
	_control = _currentCutDisplay displayCtrl IDCPLAYERSLABEL;
	_control ctrlSetText _playersStr;	
	_control ctrlShow _displayGeneralInfo;
	pos _controlPos = ctrlPosition _control;
	_controlPos set[ 0 , 0 + safeZoneX + PLAYERSLABEL_X ];
	_controlPos set[ 1 , PLAYERSLABEL_Y - safeZoneY ];
	_control ctrlSetPosition _controlPos;
	_control ctrlCommit 0;
	waitUntil { ctrlCommitted _control };
    _mygroup = groupID (group player);	
    string _myClassName = "Custom Gear";
	if( playerClass != LOADOUT_CUSTOM ) then { _myClassName = (RULES_classList select playerClass) select CL_NAME; };
	_control = _currentCutDisplay displayCtrl IDCPLAYERCLASSLABEL;    
	_control ctrlSetText format ["%1/%2",_myClassName,_mygroup] ;	
	_control ctrlShow _displayGeneralInfo;
	pos _controlPos = ctrlPosition _control;
	_controlPos set[ 0 , 0 + safeZoneX + PLAYERCLASSLABEL_X ];
	_controlPos set[ 1 , PLAYERCLASSLABEL_Y - safeZoneY ];
	_control ctrlSetPosition _controlPos;
	_control ctrlCommit 0;
	waitUntil { ctrlCommitted _control };
	bool _showPlayerMenu=false;
	string _mtext = "";
	string _cltext = "";
	string _riftext = "";
	string _topmsg = "";	
	if( showChooserTime > 0 ) then
		{
		_mtext = _mtext + localize "STR_AAS_CTRL+C";
{		
			string _thispclass = _x select CL_NAME;
			if( _myClassName == _thispclass ) then
				{
				_mtext = _mtext + format["<t size='0.9' color='#ff0099'>%1</t><br />",_thispclass];			
				}
			else
				{
				_mtext = _mtext + format["<t size='0.9'>%1</t><br />",_thispclass];
				};
			} forEach RULES_classList;
		_cltext = _cltext + localize "STR_AAS_CTRL+K";
		myRifles = (RULES_classList select playerClass) select CL_WESTRIFLES;
		if( EAST_PLAYER ) then { myRifles = (RULES_classList select playerClass) select CL_EASTRIFLES; };
		_riftext = _riftext + localize "STR_AAS_CTRL+D";
		int _selrifleidx=0;
	for "_selrifleidx" from 0 to ((count myRifles) - 1) do
			{
			//string _rifname = (myRifles select _selrifleidx) call getRifleName;
			string _rifname = (myRifles select _selrifleidx select 0) call getRifleName; //777
					
			if( _selrifleidx == myRifleIndex ) then
				{
				_riftext = _riftext + format["<t size='0.9' color='#ff0099'>%1</t><br/>",_rifname];			
				}
			else
				{
				_riftext = _riftext + format["<t size='0.9'>%1</t><br/>",_rifname];
				};
			};
		if( !classChangeLocked ) then
			{
			_topmsg=localize "STR_AAS_Choose_class_team";
			}
		else
			{
			_fcolor = "#ff2222";
			if( (round (time*2)) % 2 == 0 ) then { _fcolor = "#ffff22"; };
			
			_topmsg = format[localize "STR_AAS_Class_change_locked",_fcolor,round (lastClassChangeTime+RULES_classChangeDelay-time)];
			};		
		_showPlayerMenu=true;
		};	
	_control = _currentCutDisplay displayCtrl IDCPLAYERMENUL;	
	_control ctrlSetStructuredText (parseText _mtext);
	_control ctrlShow _showPlayerMenu;
	_control = _currentCutDisplay displayCtrl IDCPLAYERMENUR;	
	_control ctrlSetStructuredText (parseText _cltext);
	_control ctrlShow _showPlayerMenu;
	_control = _currentCutDisplay displayCtrl IDCPLAYERMENUT;	
	_control ctrlSetStructuredText (parseText format["<t color='#ffddff'>%1</t>",_topmsg]);
	_control ctrlShow _showPlayerMenu;
	_control = _currentCutDisplay displayCtrl IDCPLAYERMENUM;	
	_control ctrlSetStructuredText (parseText _riftext);
	_control ctrlShow _showPlayerMenu;
	_control = _currentCutDisplay displayCtrl IDCPLAYERMENUB;	
	_control ctrlSetStructuredText (parseText localize "STR_AAS_Shortcuts");
	_control ctrlShow _showPlayerMenu;
	_control = _currentCutDisplay displayCtrl IDCPLAYERMENUX;	
	_control ctrlShow _showPlayerMenu;
	_control = _currentCutDisplay displayCtrl IDCPLAYERNAMELABEL;
	_myHealth = round ((1 - damage player) * 100);
	//0770
	if (getFatigue player > 0.22) then { player setFatigue 0.22; };
	//
	
	_control ctrlSetText format[ "%1%2 %3", _myHealth,"%", player call getName];
	_control ctrlShow _displayGeneralInfo;
	pos _controlPos = ctrlPosition _control;
	_controlPos set[ 0 , 0 + safeZoneX + PLAYERNAMELABEL_X ];
	_controlPos set[ 1 , PLAYERNAMELABEL_Y - safeZoneY ];
	_control ctrlSetTextColor (_teamColor select _myTeamColIdx);
	_control ctrlSetPosition _controlPos;
	_control ctrlCommit 0;
	waitUntil { ctrlCommitted _control };
	_headingsArray = [ "N" , "NE", "E", "SE", "S" , "SW", "W", "NW" ];					   
	_quantisedDir = round ((getDir vehicle player)/44);
	if( _quantisedDir == 8 ) then { _quantisedDir = 0; };	
	_prefx="";
	if( getDir vehicle player < 100 ) then { _prefx = "0" };
	if( getDir vehicle player < 10 ) then { _prefx = "00" };	
	_heading = format["%1%2 %3",_prefx,floor (getDir vehicle player),(_headingsArray select _quantisedDir)];
	_control = _currentCutDisplay displayCtrl IDCHEADINGLABEL;
	_control ctrlSetText _heading;	
	_control ctrlShow _displayGeneralInfo;
	pos _controlPos = ctrlPosition _control;
	_controlPos set[ 0 , safeZoneW + safeZoneX - 0.27 ];
	_controlPos set[ 1 , HEADINGLABEL_Y - safeZoneY ];
	_control ctrlSetPosition _controlPos;	
	_control ctrlCommit 0;
	waitUntil { ctrlCommitted _control };
			if (GUI_DISPLAYED) then
		{
		call updateGUI;
	      }
		else
		{	
		call updateGUIremove;
	      };


	