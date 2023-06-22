import 'package:bizecase/src/core/navigation/routes.dart';
import 'package:bizecase/src/data/notifier/user_provider.dart';
import 'package:bizecase/src/feature/auth/viewmodel/sign_in_view_model.dart';
import 'package:bizecase/src/feature/home/viewmodel/post_view_model.dart';
import 'package:bizecase/src/feature/newpost/viewmodel/new_post_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<SignInViewModel>(
          create: (_) => SignInViewModel(),
        ),
        ChangeNotifierProvider<PostViewModel>(
          create: (_) => PostViewModel(),
        ),
        ChangeNotifierProvider<NewPostViewModel>(
          create: (_) => NewPostViewModel(),
        ),
      ],
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Bize Case',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
            useMaterial3: true,
          ),
          routerConfig: Routes.router),
    );
  }
}
