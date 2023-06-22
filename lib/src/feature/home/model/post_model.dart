import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String desc, ppUrl, postedBy, imgUrl, createdAt;

  PostModel({
    required this.desc,
    required this.ppUrl,
    required this.postedBy,
    required this.imgUrl,
    required this.createdAt,
  });

  factory PostModel.fromDocument(DocumentSnapshot doc) {
    return PostModel(
      desc: doc['desc'],
      ppUrl: doc['ppUrl'],
      postedBy: doc['postedBy'],
      imgUrl: doc['imgUrl'],
      createdAt: doc['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'desc': desc,
      'ppUrl': ppUrl,
      'postedBy': postedBy,
      'imgUrl': imgUrl,
      'createdAt': createdAt,
    };
  }
}
