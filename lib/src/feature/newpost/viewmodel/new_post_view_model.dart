import 'dart:io';
import 'package:bizecase/src/data/notifier/user_provider.dart';
import 'package:bizecase/src/feature/auth/model/user_model.dart';
import 'package:bizecase/src/feature/newpost/service/new_post_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewPostViewModel extends ChangeNotifier {
  bool _loading = false;
  File? _imageFile;
  UserModel? _user;

  bool get loading => _loading;
  File? get imageFile => _imageFile;

  changeLoadingState(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future pickImage(ImageSource source) async {
    _imageFile = await NewPostService().pickImage(source);
    notifyListeners();
  }

  Future storeImage({required BuildContext ctx}) async {
    changeLoadingState(true);
    _user = _user = Provider.of<UserProvider>(ctx, listen: false).user;
    String imgUrl =
        await NewPostService().storeImage(_imageFile!, _user!.id, ctx);
    return imgUrl;
  }

  Future savePost({required String desc, required BuildContext ctx}) async {
    String imgUrl = await storeImage(ctx: ctx);
    NewPostService().savePost(_user!, desc, imgUrl);
    changeLoadingState(false);
  }

  disposeImage() {
    _imageFile = null;
    notifyListeners();
  }
}
