_truck = vehicle player;
_arty = nearestObject [_truck, "StaticCannon"];

//
//_arty attachTo [_truck, [0,-7,-1.3]];

_pos = _truck modelToWorld [0,-7,-1.3];
_arty setPos _pos;
_arty setDir ((getDir _truck)+180);

[_arty, _truck, false] call BIS_fnc_attachToRelative;

//



vehicle player vehicleChat "Arty attached";
attached = 1;
act2 = 0;
while {Alive _truck or (attached == 1)} do{
    if ((act2 == 0) && driver _truck == player) then {
        detachActionId = _truck addAction ["Detach arty","=BTC=Arty\detachArty.sqf"];
		act2 = 1;
    }
        else {
            if (!(driver _truck == player)) then {
                _truck removeAction detachActionId;
				act2 = 0;
	        };
        };
     sleep 0.1;
};
if(true) exitWith {}; 