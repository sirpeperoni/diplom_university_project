import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/api_client/image_downloader.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({super.key, required this.imagePath, this.height, this.width, this.fit});
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit; 
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
                    imageUrl: ImageDownloader.imageUrl(imagePath),
                    width: width,
                    height: height,
                    fit: fit,
                    progressIndicatorBuilder: (context, url, downloadProgress) => 
                      Center(
                        child: SizedBox(
                          width: 25, height: 25,
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress, 
                            strokeWidth: 2.0),
                        )
                      ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  );
  }
}