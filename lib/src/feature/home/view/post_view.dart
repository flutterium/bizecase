import 'package:bizecase/src/feature/home/viewmodel/post_view_model.dart';
import 'package:bizecase/src/widgets/app_bar.dart';
import 'package:bizecase/src/widgets/post/post_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  void initState() {
    Provider.of<PostViewModel>(context, listen: false).getFeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Gönderiler',
      ),
      body: SafeArea(
        child: Consumer<PostViewModel>(
          builder: (context, postViewModel, _) {
            return !postViewModel.loading
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: postViewModel.feed.length,
                    itemBuilder: (context, index) {
                      return PostCard(post: postViewModel.feed[index]);
                    })
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.go('/newPost');
        },
      ),
    );
  }
}
