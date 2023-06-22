import 'dart:io';

import 'package:bizecase/src/data/constants/firestore_constants.dart';
import 'package:bizecase/src/feature/auth/model/user_model.dart';
import 'package:bizecase/src/feature/home/model/post_model.dart';
import 'package:bizecase/src/feature/newpost/service/new_post_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ntp/ntp.dart';

class NewPostService extends INewPostService {
  final FirebaseStorage storage = FirebaseStorage.instance;
  DateTime? _time;

  @override
  Future pickImage(ImageSource source) async {
    File? imageFile;
    XFile? pickedFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    return imageFile;
  }

  @override
  Future storeImage(File img, String id, BuildContext ctx) async {
    String downloadUrl;
    _time = await NTP.now();

    String createdAt = _time.toString();
    try {
      TaskSnapshot snapshot =
          await storage.ref().child('posts/$id/$createdAt').putFile(img);
      if (snapshot.state == TaskState.success) {
        downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return 'Failed';
    }
  }

  @override
  Future savePost(UserModel userModel, String desc, String url) async {
    _time = await NTP.now();
    PostModel newPost = PostModel(
        createdAt: _time.toString(),
        desc: desc,
        imgUrl: url,
        postedBy: userModel.fullName(),
        ppUrl: userModel.ppUrl);
    await FirebaseFirestore.instance
        .collection(FirestoreConstants.posts)
        .add(newPost.toJson());
  }
}
