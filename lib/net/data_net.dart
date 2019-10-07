import 'dart:convert';

import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_registered.dart';
import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:flutter/cupertino.dart';

class Data {
  static init() {
    Bmob.initMasterKey(
        '8b1b6ee760674b2ad3a2c7f05b6372fe ',
        'a636919da63834314a8f2b6dfb6de4a4 ',
        'ab64d54a41bded475fd1d810cb41ac60 ');
  }

  static login(BuildContext context, String username, String password) {
    BmobUser bmobUserRegister = BmobUser();
    bmobUserRegister.username = username;
    bmobUserRegister.password = password;
    bmobUserRegister.login().then((BmobUser bmobUser) {
      showSuccess(context, bmobUser.getObjectId() + "\n" + bmobUser.username);
    }).catchError((e) {
      showError(context, BmobError.convert(e).error);
    });
  }

  static register(
      BuildContext context, String email, String username, String password) {
    BmobUser bmobUserRegister = BmobUser();
    bmobUserRegister.username = username;
    bmobUserRegister.email = email;
    bmobUserRegister.password = password;
    bmobUserRegister.register().then((BmobRegistered data) {
      showSuccess(context, data.objectId);
    }).catchError((e) {
      showError(context, BmobError.convert(e).error);
    });
  }

  static set(BuildContext context, String key, String value) {
    MapObject mapObject = MapObject();
    Map<String, dynamic> map = Map<String, dynamic>();
    map['key'] = key;
    map['value'] = value;
    mapObject.setParams(map);
    mapObject.setObjectId(key);
    mapObject.save().then((BmobSaved bmobSaved) {
      String message =
          "创建一条数据成功：${bmobSaved.objectId} - ${bmobSaved.createdAt}";
      showSuccess(context, message);
    }).catchError((e) {
      showError(context, BmobError.convert(e).error);
    });
  }

  static Map<String, dynamic> get(BuildContext context, String key) {
    if (key != null) {
      BmobQuery<MapObject> bmobQuery = BmobQuery();
      bmobQuery.addWhereEqualTo("key", key);
      bmobQuery.queryObject(key).then((data) {
        return jsonDecode(data);
      }).catchError((e) {
        showError(context, BmobError.convert(e).error);
      });
    } else {
      showError(context, "请先新增一条数据");
    }
  }
}

class MapObject extends BmobObject {
  Map<String, dynamic> _map;

  void setParams(Map<String, dynamic> map) {
    _map = map;
  }

  @override
  Map<String, dynamic> getParams() {
    return _map;
  }
}
