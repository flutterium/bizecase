import 'package:bizecase/src/data/constants/firestore_constants.dart';
import 'package:bizecase/src/feature/home/model/post_model.dart';
import 'package:bizecase/src/feature/home/service/get_feed_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetFeed extends IGetFeed {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<List<PostModel>> getFeed() async {
    QuerySnapshot snapshot = await firestore
        .collection(FirestoreConstants.posts)
        .orderBy('createdAt', descending: true)
        .get();
    List<PostModel>? feed;
    if (snapshot.docs.isNotEmpty) {
      feed = snapshot.docs.map((doc) => PostModel.fromDocument(doc)).toList();
    }
    return feed!;
  }
}
