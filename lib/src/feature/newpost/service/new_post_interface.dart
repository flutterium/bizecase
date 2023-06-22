import 'dart:io';

import 'package:bizecase/src/feature/auth/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class INewPostService {
  Future pickImage(ImageSource source);
  Future storeImage(File img, String id, BuildContext ctx);
  Future savePost(UserModel userModel, String desc, String url);
}