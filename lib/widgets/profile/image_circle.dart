import 'dart:io';

import 'package:flutter/material.dart';

class ImageCircle extends StatelessWidget {
  final double radius;
  final File? file;
  final String? url;
  const ImageCircle({super.key, this.radius = 20, this.file, this.url});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (file != null)
          CircleAvatar(
            radius: radius,
            backgroundImage: FileImage(
              file!,
            ),
          )
        else if (url != null)
          CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage(url!),
          )
        else
          CircleAvatar(
            radius: radius,
            backgroundImage: const AssetImage(
              "images/avatar.png",
            ),
          ),
      ],
    );
  }
}
