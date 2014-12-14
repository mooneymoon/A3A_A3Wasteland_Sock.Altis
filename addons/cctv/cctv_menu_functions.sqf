#include "constants.h"
#include "macro.h"
#include "defines.h"

if (not(undefined(cctv_menu_functions_defined))) exitWith {};

diag_log format["Loading cctv menu functions ..."];

cctv_menu_result_camera_name = 0;
cctv_menu_result_ac = 1;
cctv_menu_result_ac_type = 0;
cctv_menu_result_ac_value = 1;

cctv_menu_dialog = { _this spawn {
  disableSerialization;

  ARGVX3(0,_player,objNull);
  ARGVX3(1,_camera_name,"");

  if (not(createDialog "cctv_menu")) exitWith {
    player groupChat format["ERROR: Could not create CCTV menu dialog"];
  };

  private["_list"];
  _list = [_camera_name] call cctv_menu_setup;

  private["_my_index"];
  _my_index = 0;

  {if(true)then {
    private["_data", "_title", "_value"];
    _data = _x;
    _title = _data select 0;
    _value = _data select 1;

    private["_index"];
    _index = _list lbAdd _title;

    lbSetData [(ctrlIDC _list),_index,_value];
    lbSetValue [(ctrlIDC _list),_index,_value];
  };} forEach
  [
   [format["Player (%1)", (name _player)], str(["player", getPlayerUID _player])],
   [format["Group (%1)", str(group _player)], str(["group", getPlayerUID _player])],
   [format["Team (%1)", str(side _player)], str(["side", str(side _player)])]
  ];

  _list lbSetCurSel 0;
  cctv_menu_result = nil;

  //Ok button
  buttonSetAction [
  cctv_menu_button_ok_idc,
  (
    '  private["_access_control", "_name"];' +
    '  _name  = ctrlText cctv_menu_camera_name_field_idc;' +
    '  _access_control  = call compile (lbData [cctv_menu_access_control_field_idc,lbCurSel cctv_menu_access_control_field_idc]);' +
    '  cctv_menu_result = [_name,_access_control];' +
    'closedialog 0;'
  )];

};};


cctv_menu_combo_focus = {
  ARGVX3(0,_control,controlNull);
  _control ctrlSetBackgroundColor [0.1,0.1,0.1,1];
};

cctv_menu_combo_blur = {
  ARGVX3(0,_control,controlNull);
  _control ctrlSetBackgroundColor [1,1,1,0.08];
};

cctv_menu_setup = {
  disableSerialization;
  ARGVX3(0,_camera_name,"");

  private["_display"];
  _display = uiNamespace getVariable "CCTV_MENU";

  _cctv_menu_header = _display displayCtrl cctv_menu_header_idc;
  _cctv_menu_background = _display displayCtrl cctv_menu_background_idc;
  _cctv_menu_camera_name_label = _display displayCtrl cctv_menu_camera_name_label_idc;
  _cctv_menu_camera_name_field = _display displayCtrl cctv_menu_camera_name_field_idc;
  _cctv_menu_access_control_label = _display displayCtrl cctv_menu_access_control_label_idc;
  _cctv_menu_access_control_field = _display displayCtrl cctv_menu_access_control_field_idc;
  _cctv_menu_button_ok = _display displayCtrl cctv_menu_button_ok_idc;
  _cctv_menu_button_cancel = _display displayCtrl cctv_menu_button_cancel_idc;


  _cctv_menu_access_control_field ctrlAddEventHandler ["SetFocus","(_this) call cctv_menu_combo_focus"];
  _cctv_menu_access_control_field ctrlAddEventHandler ["KillFocus","(_this) call cctv_menu_combo_blur"];

  private["_x","_y","_ysep","_sep","_cctv_title","_w","_h"];
  _x = 0.14;
  _y = 0.14;
  _w = 0.40;
  _h = 0.30;
  _ysep = 0.006;
  _sep = 0.01;
  _cctv_title = "CCTV MENU";

  private["_button_font_height","_font_family"];
  _button_font_height = MENU_TITLE_FONT_HEIGHT;
  _font_family = "PuristaMedium";

  //cctv header
  private["_chx","_chy","_chw","_bhh"];
  _chx = _x;
  _chy = _y;
  _chw = _w;
  _chh = 0.045;

  _cctv_menu_header ctrlSetPosition [_chx,_chy,_chw,_chh];
  _cctv_menu_header ctrlSetFontHeight _button_font_height;
  _cctv_menu_header ctrlSetText _cctv_title;
  _cctv_menu_header ctrlSetFont _font_family;
  _cctv_menu_header ctrlCommit 0;

  //cctv close button
  private["_ccx","_ccy","_ccw","_cch"];
  _ccw = 0.14;
  _cch = _chh;
  _ccx = _chx + _chw - _ccw;
  _ccy = _chy + _h - _cch;

  _cctv_menu_button_cancel ctrlSetText "Cancel";
  _cctv_menu_button_cancel ctrlSetPosition [_ccx,_ccy,_ccw,_cch];
  buttonSetAction [(ctrlIDC _cctv_menu_button_cancel),"closeDialog 0"];
  _cctv_menu_button_cancel ctrlCommit 0;

  //cctv ok button
  private["_cox","_coy" ,"_cow","_coh"];
  _cow = 0.11 ;
  _coh = _cch;
  _cox = _ccx - _cow - _ysep *2;
  _coy = _ccy;


  _cctv_menu_button_ok ctrlSetText "Ok";
  _cctv_menu_button_ok ctrlSetPosition [_cox,_coy,_cow,_coh];
  _cctv_menu_button_ok ctrlCommit 0;

  //cctv background
  private["_cbx","_cby","_cbw","_cbh"];
  _cbx = _chx;
  _cby = _chy + _chh + _ysep;
  _cbw = _w;
  _cbh = (_ccy ) - (_chy ) - _cch - _ysep - _ysep;

  _cctv_menu_background ctrlSetPosition [_cbx,_cby,_cbw,_cbh];
  _cctv_menu_background ctrlSetBackgroundColor [0,0,0,0.65];
  _cctv_menu_background ctrlCommit 0;




  //cctv camera name label
  private["_cnlx","_cnly","_cnlw","_cnlh"];
  _cnlx = _cbx + _sep * 2;
  _cnly = _cby + _sep * 2;
  _cnlw = (_cbw - _sep *6) / 2;
  _cnlh = 0.04;

  _cctv_menu_camera_name_label ctrlSetText "Camera name: ";
  _cctv_menu_camera_name_label ctrlSetPosition [_cnlx,_cnly,_cnlw,_cnlh];
  _cctv_menu_camera_name_label ctrlSetFontHeight _button_font_height - 0.003;
  _cctv_menu_camera_name_label ctrlCommit 0;

  //cctv camera name field
  private["_cnfx","_cnfy","_cnfw","_cnfh"];
  _cnfx = _cnlx + _cnlw + _sep * 2 ;
  _cnfy = _cnly;
  _cnfw = _cnlw;
  _cnfh = _cnlh;

  _cctv_menu_camera_name_field ctrlSetText _camera_name;
  _cctv_menu_camera_name_field ctrlSetFontHeight _button_font_height - 0.003;;
  _cctv_menu_camera_name_field ctrlSetFont _font_family;
  _cctv_menu_camera_name_field ctrlSetPosition [_cnfx,_cnfy,_cnfw,_cnfh];
  _cctv_menu_camera_name_field ctrlSetBackgroundColor [1,1,1,0.08];
  _cctv_menu_camera_name_field ctrlCommit 0;


  //cctv access control label
  private["_calx","_caly","_calw","_calh"];
  _calx = _cnlx;
  _caly = _cnly + _cnlh + _ysep * 2;
  _calw = _cnlw;
  _calh = _cnlh;

  _cctv_menu_access_control_label ctrlSetText "Accessible by: ";
  _cctv_menu_access_control_label ctrlSetPosition [_calx,_caly,_calw,_calh];
  _cctv_menu_access_control_label ctrlSetFontHeight _button_font_height - 0.003;
  _cctv_menu_access_control_label ctrlCommit 0;

  //cctv access control field
  private["_cafx","_cafy","_cafw","_cafh"];
  _cafx = _calx + _calw + _sep * 2 ;
  _cafy = _caly;
  _cafw = _calw;
  _cafh = _calh;

  _cctv_menu_access_control_field ctrlSetFontHeight _button_font_height - 0.003;;
  _cctv_menu_access_control_field ctrlSetFont _font_family;
  _cctv_menu_access_control_field ctrlSetPosition [_cafx,_cafy,_cafw,_cafh];
  _cctv_menu_access_control_field ctrlSetBackgroundColor [1,1,1,0.08];
  _cctv_menu_access_control_field ctrlCommit 0;


  _cctv_menu_access_control_field
};

cctv_menu_functions_defined = true;

diag_log format["Loading cctv menu functions complete"];