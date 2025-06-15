import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Container mainDecorations() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withValues(alpha: 0.4),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(2, 3), // changes position of shadow
              ),
            ]),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: this);
  }
}
