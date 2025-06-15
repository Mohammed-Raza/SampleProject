import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PageErrorWidget extends StatelessWidget {
  final String errorImage;
  final String errorText;
  final Function()? retry;
  const PageErrorWidget(
      {super.key,
      required this.errorText,
      required this.errorImage,
      this.retry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset(errorImage)),
          RichText(
            text: TextSpan(
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.teal),
                children: [TextSpan(text: errorText)]),
          ),
          Gap(8),
          ElevatedButton.icon(
              onPressed: retry,
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Theme.of(context).primaryColor),
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text('Retry', style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }
}
