import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool visibleBackButton;
  const BaseAppBar(
      {super.key, required this.title, this.visibleBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: visibleBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                context.go('/postView');
              },
            )
          : const SizedBox(),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
