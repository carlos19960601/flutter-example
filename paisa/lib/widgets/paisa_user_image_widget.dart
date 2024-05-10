import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/app_extensions.dart';

class PaisaUserImageWidget extends StatelessWidget {
  const PaisaUserImageWidget({
    super.key,
    required this.pickImage,
    required this.deleteImage,
    this.maxRadius,
    this.useDefault = false,
    this.imagePath = '',
  });

  final double? maxRadius;
  final VoidCallback pickImage;
  final VoidCallback deleteImage;
  final bool useDefault;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Builder(
        builder: (context) {
          if (imagePath.isEmpty) {
            return CircleAvatar(
              backgroundColor: context.primary,
              maxRadius: maxRadius,
              child: Icon(
                Icons.account_circle_outlined,
                color: context.onPrimary,
              ),
            );
          } else {
            if (useDefault) {
              return CircleAvatar(
                foregroundImage: FileImage(File(imagePath)),
                maxRadius: maxRadius,
              );
            }
            return Badge(
              alignment: AlignmentDirectional.bottomEnd,
              label: GestureDetector(
                onTap: deleteImage,
                child: Center(
                  child: Icon(
                    MdiIcons.delete,
                    size: 8,
                    color: context.primary,
                  ),
                ),
              ),
              child: CircleAvatar(
                foregroundImage: FileImage(File(imagePath)),
                maxRadius: maxRadius,
              ),
            );
          }
        },
      ),
    );
  }
}
