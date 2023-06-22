import 'package:bizecase/src/feature/auth/view/sign_in_view.dart';
import 'package:bizecase/src/feature/home/view/post_view.dart';
import 'package:bizecase/src/feature/newpost/view/new_post_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SignInView();
        },
      ),
      GoRoute(
        path: '/postView',
        builder: (BuildContext context, GoRouterState state) {
          return const PostView();
        },
      ),
      GoRoute(
        path: '/newPost',
        builder: (BuildContext context, GoRouterState state) {
          return const NewPostView();
        },
      ),
    ],
  );
}
