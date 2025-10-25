import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_project/core/error/exception_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/utils/enums.dart';

class ShareFiles {
  Future<void> sharePdf(Uint8List uint8list, String fileName, Size size,
      {ShareType shareType = ShareType.image}) async {
    final tempDir = await getTemporaryDirectory();
    var path =
        '${tempDir.path}/$fileName.${shareType == ShareType.image ? 'png' : 'pdf'}';
    File file = await File(path).create();
    file.writeAsBytesSync(uint8list);

    try {
      final params = ShareParams(
          text: fileName,
          sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height),
          files: [XFile(file.path)]);

      // Share the pdf file
      await SharePlus.instance.share(params);
    } catch (e) {
      ExceptionHandler().handleException(e);
    }
  }
}
