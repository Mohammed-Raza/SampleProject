import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  final Color? color;

  const CircularIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
          scale: 0.6,
          child: CircularProgressIndicator.adaptive(
              backgroundColor: color ?? Colors.black)),
    );
  }
}

class BuildCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  final Widget? errorWidget;
  final double? height, width;
  const BuildCachedNetworkImage(
      {super.key,
      required this.imageUrl,
      this.borderRadius = 10,
      this.errorWidget,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: InteractiveViewer(
        maxScale: 3,
        minScale: 0.5,
        child: CachedNetworkImage(
            height: height,
            width: width,
            filterQuality: FilterQuality.high,
            imageUrl: imageUrl,
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                FittedBox(
                  child: Transform.scale(
                    scale: 0.3,
                    child: CircularProgressIndicator.adaptive(
                        strokeWidth: 2, value: downloadProgress.progress),
                  ),
                ),
            errorWidget: (context, url, error) =>
                errorWidget ??
                const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error),
                      Text('Unable to load image')
                    ])),
      ),
    );
  }
}

class CommonDivider extends StatelessWidget {
  const CommonDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(thickness: 0.8);
  }
}
