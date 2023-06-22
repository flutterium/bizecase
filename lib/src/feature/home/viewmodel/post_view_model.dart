import 'package:bizecase/src/feature/home/model/post_model.dart';
import 'package:bizecase/src/feature/home/service/get_feed.dart';
import 'package:flutter/material.dart';

class PostViewModel extends ChangeNotifier {
  bool _loading = true;
  List<PostModel> _feed = [];

  bool get loading => _loading;

  List<PostModel> get feed => _feed;

  changeLoadingState(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> getFeed() async {
    changeLoadingState(true);
    _feed = await GetFeed().getFeed();

    changeLoadingState(false);

    notifyListeners();
  }
}
