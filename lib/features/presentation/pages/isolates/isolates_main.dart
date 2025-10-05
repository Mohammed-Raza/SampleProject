import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/features/presentation/providers/media_provider.dart';
import 'package:sample_project/features/presentation/widgets/common_widgets.dart';

import 'long_lived_isolates.dart';

class IsolatesMainScreen extends StatefulWidget {
  const IsolatesMainScreen({super.key});

  @override
  State<IsolatesMainScreen> createState() => _IsolatesMainScreenState();
}

class _IsolatesMainScreenState extends State<IsolatesMainScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    context.read<MediaProvider>().processedImage = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isolation')),
      body: Column(
        children: [
          TabBar(
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              padding: const EdgeInsets.symmetric(vertical: 10),
              labelPadding: const EdgeInsets.symmetric(vertical: 10),
              controller: tabController,
              tabs: [
                Text('Short-Lived', style: context.titleMedium),
                Text('Long-Lived', style: context.titleMedium)
              ]),
          Expanded(
              child: TabBarView(controller: tabController, children: const [
            ShortLivedIsolation(),
            LongLivedIsolation()
          ]))
        ],
      ),
    );
  }
}

class ShortLivedIsolation extends StatefulWidget {
  const ShortLivedIsolation({super.key});

  @override
  State<ShortLivedIsolation> createState() => _ShortLivedIsolationState();
}

class _ShortLivedIsolationState extends State<ShortLivedIsolation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MediaProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            RichText(
                text: TextSpan(style: context.labelLarge, children: const [
              TextSpan(text: 'Here '),
              TextSpan(
                  text: 'Isolate.run / compute ',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text:
                      'method is used. This method spawns an isolate, passes a callback to the spawned'
                      ' isolate to start some computation, returns a value from the computation, and '
                      'then shuts the isolate down when the computation is complete.')
            ])),
            Text(
                'Here after capturing the image it will be compressed with compute method',
                style: context.titleMedium?.apply(fontWeightDelta: -1)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  provider.shortLivedLoader
                      ? const CircularIndicator()
                      : (provider.processedImage != null
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  border: Border.all(color: Colors.black26)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                    File(provider.processedImage!),
                                    height: context.height * 0.45,
                                    width: context.width,
                                    fit: BoxFit.fill),
                              ),
                            )
                          : InkWell(
                              onTap: provider.onClickOfCamera,
                              child: Column(
                                children: [
                                  const Icon(Icons.add_a_photo_outlined,
                                      size: 70),
                                  const SizedBox(height: 6),
                                  Text('Tap to take image',
                                      style: context.labelLarge)
                                ],
                              ))),
                  Visibility(
                    visible: provider.processedImage != null,
                    child: ElevatedButton(
                        onPressed: provider.deleteProcessedImage,
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(context.width, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Colors.red),
                        child: const Text('Delete Image',
                            style: TextStyle(color: Colors.white))),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
