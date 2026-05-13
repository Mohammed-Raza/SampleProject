import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import '../../providers/media_provider.dart';

class LongLivedIsolation extends StatefulWidget {
  const LongLivedIsolation({super.key});

  @override
  State<LongLivedIsolation> createState() => _LongLivedIsolationState();
}

class _LongLivedIsolationState extends State<LongLivedIsolation> {
  final receivePort = ReceivePort();

  @override
  void initState() {
    context.read<MediaProvider>()
      ..longLivedImages.clear()
      ..longLivedLoader = false
      ..clearImages = false;
    super.initState();
  }

  @override
  void dispose() {
    receivePort.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MediaProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              spacing: 10,
              children: [
                RichText(
                    text: TextSpan(style: context.labelLarge, children: [
                  TextSpan(text: context.l10n.longLivedIntroPrefix),
                  TextSpan(
                      text: context.l10n.longLivedIntroHighlight,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  TextSpan(text: context.l10n.longLivedIntroSuffix)
                ])),
                Text(context.l10n.longLivedImageGenerationDescription,
                    style: context.titleMedium?.apply(fontWeightDelta: -1)),
                provider.longLivedImages.isNotEmpty
                    ? const _BuildStreamBuilder()
                    : InkWell(
                        onTap: () => provider.longLivedIsolate(receivePort),
                        child: Column(
                          children: [
                            const Icon(Icons.add_a_photo_outlined, size: 70),
                            const SizedBox(height: 6),
                            Text(context.l10n.tapToTakeImage,
                                style: context.labelLarge)
                          ],
                        )),
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: provider.longLivedImages.isNotEmpty &&
                          provider.longLivedImages.length == 50,
                      child: FilledButton.icon(
                          onPressed: provider.deleteLongLivedImage,
                          style: FilledButton.styleFrom(
                              minimumSize: const Size(280, 45),
                              backgroundColor: Colors.red),
                          icon: const Icon(Icons.delete_outline),
                          label: Text(context.l10n.deleteAllImages)),
                    ),
                  ],
                ),
                const Gap(10)
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BuildStreamBuilder extends StatefulWidget {
  const _BuildStreamBuilder();

  @override
  State<_BuildStreamBuilder> createState() => _BuildStreamBuilderState();
}

class _BuildStreamBuilderState extends State<_BuildStreamBuilder> {
  StreamSubscription? _subscription;

  List<String> images = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuildContext());
  }

  void afterBuildContext() {
    final provider = context.read<MediaProvider>();
    _subscription = provider.streamController.stream.listen((image) {
      if (!mounted) return;
      setState(() {
        images = List<String>.from(image);
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MediaProvider>(builder: (context, provider, child) {
      return Wrap(
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ...List.generate(images.length, (index) {
            final imagePath = images[index];
            return InkWell(
              onTap: () => onImageClick(context, imagePath),
              child: Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(width: 1, color: Colors.black12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.file(File(imagePath),
                      height: 45, width: 45, fit: BoxFit.fill),
                ),
              ),
            );
          }),
          // if (provider.longLivedLoader) circularIndicator,
        ],
      );
    });
  }

  void onImageClick(BuildContext context, String imageUrl) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              insetPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: context.height * 0.6,
                  width: double.infinity,
                  child: InteractiveViewer(
                    maxScale: 3,
                    minScale: 0.4,
                    child: Image.file(
                      File(imageUrl),
                      gaplessPlayback: true,
                      fit: BoxFit.fill,
                      errorBuilder: (context, url, error) =>
                          Center(child: Text(context.l10n.unableToLoadImage)),
                    ),
                  ),
                ),
              ),
            ));
  }

  get circularIndicator => Transform.scale(
      scale: 0.3, child: const CircularProgressIndicator.adaptive());
}
