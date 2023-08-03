import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class percobaan4 extends StatefulWidget {
  const percobaan4({Key? key}) : super(key: key);

  @override
  State<percobaan4> createState() => _percobaan4State();
}

class _percobaan4State extends State<percobaan4> {

  final picker = ImagePicker();
  final pdf = pw.Document();
  List<File> image = [];
  var pageformat = "A4";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          image.length == 0
              ? Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*Image(
                      image: AssetImage(
                        'assets/images/r5.png',
                      ),
                      height: 200,
                    ),*/
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Pilih Gambar dari Kamera atau dari galeri',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
              : PdfPreview(
            maxPageWidth: 1000,
            // useActions: false,
            // canChangePageFormat: true,
            canChangeOrientation: true,
            // pageFormats:pageformat,
            canDebug: false,

            build: (format) => generateDocument(
              format,
              image.length,
              image,
            ),
          ),
          Align(
            alignment: Alignment(-0.5, 0.8),
            child: FloatingActionButton(
              elevation: 0.0,
              child: new Icon(
                Icons.image,
              ),
              //backgroundColor: Colors.indigo[900],
              backgroundColor: Colors.blue,
              onPressed: getImageFromGallery,
            ),
          ),
          Align(
            alignment: Alignment(0.5, 0.8),
            child: FloatingActionButton(
              elevation: 0.0,
              child: new Icon(
                Icons.camera,
              ),
              //backgroundColor: Colors.indigo[900],
              backgroundColor: Colors.blue,
              onPressed: getImageFromcamera,
            ),
          ),
        ],
      ),
    );
  }

  getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image.add(File(pickedFile.path));

      } else {
        print('No image selected');
      }
    });
  }

  getImageFromcamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image.add(File(pickedFile.path));
      } else {
        print('No image selected');
      }
    });
  }

  Future<Uint8List> generateDocument(
      PdfPageFormat format, imagelenght, image) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    for (var im in image) {
      final showimage = pw.MemoryImage(im.readAsBytesSync());

      doc.addPage(
        pw.Page(
          pageTheme: pw.PageTheme(
            pageFormat: format.copyWith(
              marginBottom: 0,
              marginLeft: 0,
              marginRight: 0,
              marginTop: 0,
            ),
            orientation: pw.PageOrientation.portrait,
            // buildBackground: (context) =>
            //     pw.Image(showimage, fit: pw.BoxFit.contain),
            theme: pw.ThemeData.withFont(
              base: font1,
              bold: font2,
            ),
          ),
          build: (context) {
            return pw.Center(
              child: pw.Image(showimage, fit: pw.BoxFit.contain),
            );
          },
        ),
      );
    }
    return await doc.save();
  }


  }

