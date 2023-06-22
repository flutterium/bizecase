import 'package:flutter/material.dart';

class PostCircleAvatar extends StatelessWidget {
  final String imgUrl;
  const PostCircleAvatar({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      child: ClipOval(
        child: Image.network(
          imgUrl,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
