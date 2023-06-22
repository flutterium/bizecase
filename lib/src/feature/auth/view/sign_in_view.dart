import 'package:bizecase/src/feature/auth/viewmodel/sign_in_view_model.dart';
import 'package:bizecase/src/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInViewModel = Provider.of<SignInViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail_rounded),
                  border: OutlineInputBorder(),
                  hintText: 'Eposta',
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password_rounded),
                  border: OutlineInputBorder(),
                  hintText: 'Şifre',
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              BaseButton(
                loading: signInViewModel.loading,
                title: 'Giriş yap',
                onPress: () {
                  signInViewModel.signIn(
                      ctx: context,
                      email: emailController.text,
                      password: passwordController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
