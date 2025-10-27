import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:sample_project/core/utils/enums.dart';
import '../../../../core/environments/environment.dart';
import '../../components/share_files.dart';

@immutable
class PdfCreator {
  final List<String> tableHeaderList;
  final List<List<String>>? tableData;
  final String fileName;
  final Size size;
  final List<String> capturedImages;
  const PdfCreator(this.tableHeaderList, this.tableData, this.size,
      {this.fileName = 'groceries', this.capturedImages = const []});

  void buildPdf() async {
    final doc = pw.Document();

    var logo = await getPdfImage(doc);

    var imagesList = [];
    if (capturedImages.isNotEmpty) {
      for (var imagePath in (capturedImages)) {
        var imageFile = File(imagePath);
        final Uint8List imageBytes = await imageFile.readAsBytes();
        final image = pw.MemoryImage(imageBytes);
        imagesList.add(image);
      }
    }

    doc.addPage(pw.MultiPage(
        pageFormat: _pdfPaddings,
        build: (context) => [
              buildPdfHeader(logo),
              buildTableView(tableHeaderList, tableData),
              if (imagesList.isNotEmpty) _imagesView(imagesList)
            ]));

    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$fileName.pdf');
    await file.writeAsBytes(await doc.save());
    Uint8List data = await doc.save();
    ShareFiles().sharePdf(data, fileName, size, shareType: ShareType.pdf);
  }

  pw.Widget buildTableView(
      List<String> headersList, List<List<dynamic>>? tableData) {
    var tableBorder = const pw.BorderSide(color: PdfColors.grey200);
    return pw.TableHelper.fromTextArray(
        headers: headersList,
        cellAlignments: {
          0: pw.Alignment.center,
          1: pw.Alignment.center,
          2: pw.Alignment.center,
          3: pw.Alignment.center,
          4: pw.Alignment.center,
          5: pw.Alignment.center
        },
        headerDecoration: pw.BoxDecoration(
            color: PdfColor.fromHex('#F5F6FA'),
            border: pw.Border(bottom: tableBorder, top: tableBorder)),
        border: pw.TableBorder(
            horizontalInside: tableBorder,
            verticalInside: tableBorder,
            bottom: tableBorder,
            left: tableBorder,
            right: tableBorder),
        headerStyle: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
        cellHeight: 30,
        cellPadding: const pw.EdgeInsets.symmetric(vertical: 10),
        data: tableData ?? []);
  }

  pw.Widget _imagesView(List<dynamic> imagesList) {
    return pw.Wrap(
        direction: pw.Axis.horizontal,
        spacing: 10,
        runSpacing: 10,
        children: List.generate(
            imagesList.length,
            (index) => pw.Container(
                  height: 250,
                  margin: const pw.EdgeInsets.only(top: 15),
                  decoration: pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.circular(15),
                      border: pw.Border.all(color: PdfColors.green800)),
                  child: pw.ClipRRect(
                      horizontalRadius: 15,
                      verticalRadius: 15,
                      child: pw.Image(imagesList[index])),
                )));
  }

  pw.Widget buildPdfHeader(pw.ImageProvider image) {
    return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 10),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(child: pw.Image(image, height: 100, width: 100)),
              pw.SizedBox(height: 10),
              pw.Divider(thickness: 1, color: PdfColors.grey400),
              pw.SizedBox(height: 10)
            ]));
  }

  Future<pw.ImageProvider> getPdfImage(pw.Document doc) async {
    final data = (await rootBundle.load(Environment().configuration.logoPath))
        .buffer
        .asUint8List();
    return pw.MemoryImage(data);
  }

  PdfPageFormat get _pdfPaddings => PdfPageFormat.letter.copyWith(
      marginTop: 0.8 * PdfPageFormat.cm,
      marginBottom: 1.5 * PdfPageFormat.cm,
      marginLeft: 1.5 * PdfPageFormat.cm,
      marginRight: 1.5 * PdfPageFormat.cm);
}
