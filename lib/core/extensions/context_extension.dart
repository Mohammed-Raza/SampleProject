import 'package:flutter/cupertino.dart';

extension ContextExtensions on BuildContext {
  /// MediaQuery extensions
  Size get size => MediaQuery.of(this).size;
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  double get topPadding => MediaQuery.paddingOf(this).top;
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;
}
