import 'package:bizecase/src/feature/home/model/post_model.dart';

abstract class IGetFeed {
  Future<List<PostModel>> getFeed();
}