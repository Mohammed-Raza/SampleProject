import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

mixin ImageMixin {
  /// Add Watermark to Image
  static Future<File> addWatermarkToImage(
      {required File originalImage, required String waterMarkText}) async {
    try {
      final image = img.decodeImage(originalImage.readAsBytesSync())!;

      img.drawString(image, waterMarkText,
          font: img.arial48,
          x: 100,
          y: 100,
          color: img.ColorRgb8(255, 172, 28));
      final tempDir = await getTemporaryDirectory();

      var file =
          File('${tempDir.path}/${DateTime.now().microsecondsSinceEpoch}.jpg')
            ..writeAsBytesSync(img.encodeJpg(image));

      final compressedFile = await compressImage(file);

      return compressedFile;
    } catch (e) {
      return originalImage;
    }
  }

  /// Method used to Compress Image
  static Future<File> compressImage(File file) async {
    try {
      // Read bytes
      final bytes = file.readAsBytesSync();

      // Decode image
      final image = img.decodeImage(bytes)!;

      // Resize / compress
      final resized = img.copyResize(image, width: 800);

      // Save new file
      final newPath =
          '${file.parent.path}/compressed_${file.uri.pathSegments.last}';
      File(newPath).writeAsBytesSync(img.encodeJpg(resized, quality: 80));
      return File(newPath);
    } catch (e) {
      return file;
    }
  }
}
