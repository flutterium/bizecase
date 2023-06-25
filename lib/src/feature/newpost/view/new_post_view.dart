import 'dart:io';

import 'package:bizecase/src/feature/newpost/viewmodel/new_post_view_model.dart';
import 'package:bizecase/src/widgets/app_bar.dart';
import 'package:bizecase/src/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({super.key});

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  TextEditingController descController = TextEditingController();
  File? image;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NewPostViewModel>(context, listen: false).disposeImage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newPostViewModel = Provider.of<NewPostViewModel>(context);
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Yeni Gönderi',
        visibleBackButton: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
                height: 240,
                child: newPostViewModel.imageFile == null
                    ? Center(
                        child: TextButton(
                            onPressed: () => openBottomSheet(fromCamera: () {
                                  context.pop();
                                  newPostViewModel
                                      .pickImage(ImageSource.camera);
                                }, fromGallery: () {
                                  context.pop();
                                  newPostViewModel
                                      .pickImage(ImageSource.gallery);
                                }),
                            child: const Text(
                              'Resim yüklemek için dokunun',
                              style: TextStyle(fontSize: 20),
                            )),
                      )
                    : Image.file(
                        newPostViewModel.imageFile!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    maxLines: 5,
                    controller: descController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Açıklamanızı yazınız',
                    ),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  BaseButton(
                    loading: newPostViewModel.loading,
                    title: 'Gönder',
                    onPress: () async {
                      if (newPostViewModel.imageFile != null) {
                        await newPostViewModel
                            .savePost(desc: descController.text, ctx: context)
                            .then((value) => context.go('/postView'));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openBottomSheet(
      {required void Function() fromCamera,
      required void Function() fromGallery}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                        onPressed: fromGallery,
                        icon: const Icon(
                          Icons.photo_album,
                          size: 64,
                        )),
                    const Text(
                      'Galeri',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                        onPressed: fromCamera,
                        icon: const Icon(
                          Icons.camera_alt_rounded,
                          size: 64,
                        )),
                    const Text(
                      'Kamera',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
