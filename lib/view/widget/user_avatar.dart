import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

/// 利用 [CachedNetworkImage] 自 Google 快取頭像，並於發生錯誤時顯示預設人形頭像
class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.photoUrl});

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: photoUrl,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) {
        if (kDebugMode) {
          print(error);
        }
        return const Icon(Icons.person);
      },
    );
  }
}
