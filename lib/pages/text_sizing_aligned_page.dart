import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

class TextSizingAlignedPage extends StatelessWidget {
  TextSizingAlignedPage({super.key});

  final ExportDelegate exportDelegate = ExportDelegate(
    ttfFonts: {'Ubuntu': 'fonts/Ubuntu/Ubuntu-Regular.ttf'},
    options: ExportOptions(
      pageFormatOptions: const PageFormatOptions(
        pageFormat: PageFormat.custom,
        width: 21.0 * PdfPageFormat.cm,
        height: 29.7 * PdfPageFormat.cm,
        marginTop: 2 * PdfPageFormat.cm,
        marginBottom: 2 * PdfPageFormat.cm,
        marginLeft: 2 * PdfPageFormat.cm,
        marginRight: 2 * PdfPageFormat.cm,
      ),
      textFieldOptions: const TextFieldOptions.individual(interactive: false),
      checkboxOptions: CheckboxOptions.uniform(interactive: false),
    ),
  );

  final bodyText16 = const TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: Colors.black,
    height:
        1.12, // close - would be perfect around 1.125 - but that's being rounded to 1.13
    letterSpacing: 0.0025, // perfect match
    wordSpacing: 1.5, // perfect match
    textBaseline: TextBaseline.alphabetic,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed('/container-sizing-aligned'),
                child: const Text('page 2'),
              ),
              ElevatedButton(onPressed: save, child: const Text('Save')),
            ],
          ),
          Expanded(
            child: InteractiveViewer(
              constrained: false,
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.all(0.0),
                padding: const EdgeInsets.all(2.45 * PdfPageFormat.cm),
                child: ExportFrame(
                  exportDelegate: exportDelegate,
                  frameId: 'someFrameId', // identifies the frame
                  child: Container(
                    decoration: const BoxDecoration(border: null),
                    width: 21.0 * PdfPageFormat.cm,
                    height: 29.7 * PdfPageFormat.cm + 2 * PdfPageFormat.cm,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          child: Text(
                            "Lorem ipsum, uti salvus iungo pareo principium infra. Illa curso, voro malum acer hoc tutamen rogo. Comperio levus, donum pyus. Quero, explicatus. Traho monitio, cado rideo ictus. Dolor libere, agere moti. Rutum ascit, nimis senis profero, cessi. Pre meminisse quin. Causa, decor puchre sepe feteo dimidium profari. Emerio promissio urbis tunc prae. Pergo, velut lebes nota. Hi quin illi secus.",
                            style: bodyText16,
                          ),
                        ),
                        Container(
                          width: 400.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("100 - 100", style: bodyText16),
                          ),
                        ),
                        Container(
                          width: 400.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("200 - 200", style: bodyText16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  save() async {
    final pdf = await exportDelegate.exportToPdfDocument('someFrameId');
    saveFile(pdf, 'output');
  }

  Future<void> saveFile(document, String name) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File('${dir.path}/$name.pdf');

    await file.writeAsBytes(await document.save());
    debugPrint('Saved exported PDF at: ${file.path}');
  }
}
