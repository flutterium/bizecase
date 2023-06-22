import 'package:flutter/material.dart';

import '../model/user_model.dart';

abstract class ISignInService {
  Future<String> singIn(String email, String password);
  Future<UserModel> getUserInfoFromDB(String id);
  void setUserInfo(UserModel user, BuildContext ctx);
}
