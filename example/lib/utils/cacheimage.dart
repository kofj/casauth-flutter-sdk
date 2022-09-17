import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget cachedImage(String url) {
  return CachedNetworkImage(
    imageUrl: url,
    progressIndicatorBuilder: (context, url, progress) =>
        CircularProgressIndicator(
      value: progress.progress,
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
