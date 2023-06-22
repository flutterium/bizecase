import 'package:bizecase/src/data/constants/firestore_constants.dart';
import 'package:bizecase/src/data/notifier/user_provider.dart';
import 'package:bizecase/src/feature/auth/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:bizecase/src/feature/auth/service/sign_in_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInService implements ISignInService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<String> singIn(String email, String password) async {
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      debugPrint('DEBUG PRINT RESULT : $result');

      return result.user!.uid;
    } on auth.FirebaseAuthException catch (exception, s) {
      debugPrint('$exception$s');
      debugPrint('EXCEPTION CODE ${exception.code}');
      switch ((exception).code) {
        case 'invalid-email':
          return 'Email address is malformed.';
        case 'wrong-password':
          return 'Wrong password.';
        case 'user-not-found':
          return 'No user corresponding to the given email address.';
        case 'user-disabled':
          return 'This user has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts to sign in as this user.';
      }
      return 'Unexpected firebase error, Please try again.';
    } catch (e, s) {
      debugPrint('$e$s');
      return 'Login failed, Please try again.';
    }
  }

  @override
  Future<UserModel> getUserInfoFromDB(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestore.collection(FirestoreConstants.users).doc(id).get();
    UserModel? user;
    if (documentSnapshot.exists) {
      user = UserModel.fromDocument(documentSnapshot);
    }
    return user!;
  }

  @override
  void setUserInfo(UserModel user, BuildContext ctx) {
    ctx.read<UserProvider>().setUser(user);
  }
}
