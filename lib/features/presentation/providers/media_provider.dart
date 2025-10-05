import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_project/core/error/exception_handler.dart';
import 'package:sample_project/core/mixins/image_mixin.dart';

class MediaProvider extends ChangeNotifier {
  StreamController<List<String>> streamController =
      StreamController.broadcast();

  String? processedImage;

  List<String> longLivedImages = [];

  bool shortLivedLoader = false, longLivedLoader = false, clearImages = false;

  final ExceptionHandler _exceptionHandler = ExceptionHandler();

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();

  /// Method is to capture picture / upload from gallery
  Future<void> onClickOfCamera({bool isCamera = true}) async {
    try {
      shortLivedLoader = true;
      notifyListeners();

      final XFile? capturedImage = await _picker.pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);

      if (capturedImage != null) {
        processedImage = await compute(processImage, capturedImage.path);
      }

      shortLivedLoader = false;
      notifyListeners();
    } catch (e) {
      shortLivedLoader = false;
      notifyListeners();
      _exceptionHandler.handleExceptionWithToastNotifier(e);
    }
  }

  void deleteProcessedImage() {
    processedImage = null;
    notifyListeners();
  }

  void deleteLongLivedImage() {
    longLivedImages.clear();
    notifyListeners();
  }

  Future<void> longLivedIsolate(ReceivePort receivePort) async {
    try {
      longLivedLoader = true;
      notifyListeners();

      final XFile? capturedImage =
          await _picker.pickImage(source: ImageSource.camera);

      if (capturedImage == null) {
        longLivedLoader = false;
        notifyListeners();
        return;
      }

      // Create a fresh receivePort for this run
      final rootToken = RootIsolateToken.instance!;

      await Isolate.spawn(
        isolateImageCompress,
        ImageIsolateData(
            token: rootToken,
            imagePath: capturedImage.path,
            answerPort: receivePort.sendPort),
      );

      await for (final res in receivePort) {
        if (res is Map<String, dynamic>) {
          longLivedLoader = true;
          notifyListeners();
          longLivedImages.add(res["path"]);
          streamController.sink.add(longLivedImages);

          if (res["isDone"] == true) {
            // Wait a tiny moment to let final UI updates propagate
            await Future.delayed(const Duration(milliseconds: 100));

            receivePort.close();
            longLivedLoader = false;
            clearImages = true;
            notifyListeners();

            await streamController.sink.close();
            break;
          }
        }
      }
    } catch (e, s) {
      _exceptionHandler.handleExceptionWithToastNotifier(e);
      longLivedLoader = false;
      notifyListeners();
      streamController.sink.addError(e, s);
    }
  }
}

Future<String> processImage(String imagePath) async {
  final file = File(imagePath);

  final compressedImage = await ImageMixin.compressImage(file);

  return compressedImage.path;
}

void isolateImageCompress(ImageIsolateData isolateData) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.token);

  for (var i = 0; i < 50; i++) {
    await Future.delayed(const Duration(milliseconds: 300));
    var compressedImage = await ImageMixin.addWatermarkToImage(
        originalImage: File(isolateData.imagePath),
        waterMarkText: 'Index : $i');

    var compressedPath = compressedImage.path;

    isolateData.answerPort.send({"path": compressedPath, "isDone": i == 50});
  }
}

class ImageIsolateData {
  final RootIsolateToken token;
  final String imagePath;
  final SendPort answerPort;

  ImageIsolateData(
      {required this.token, required this.imagePath, required this.answerPort});
}
