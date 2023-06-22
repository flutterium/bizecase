import 'package:bizecase/src/feature/auth/model/user_model.dart';
import 'package:bizecase/src/feature/auth/service/sign_in.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class SignInViewModel extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  changeLoadingState(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext ctx}) async {
    try {
      changeLoadingState(true);

      String id = await SignInService().singIn(email, password);

      UserModel user = await SignInService().getUserInfoFromDB(id);

      if (ctx.mounted) SignInService().setUserInfo(user, ctx);

      changeLoadingState(false);
      if (ctx.mounted) ctx.go('/postView');
    } catch (exc) {
      changeLoadingState(false);
      debugPrint('Giriş esnasında bir hata oluştu: ${exc.toString()}');
    }
    notifyListeners();
  }
}
