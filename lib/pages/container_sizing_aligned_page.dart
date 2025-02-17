import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ContainerSizingAlignedPage extends StatelessWidget {
  ContainerSizingAlignedPage({super.key});

  final ExportDelegate exportDelegate = ExportDelegate(
    ttfFonts: {'Ubuntu': 'fonts/Ubuntu/Ubuntu-Regular.ttf'},
    options: ExportOptions(
        pageFormatOptions: const PageFormatOptions(
          pageFormat: PageFormat.custom,
          width: 595,
          height: 842,
          marginTop: 0,
          marginBottom: 0,
          marginLeft: 0,
          marginRight: 0,
        ),
        textFieldOptions: const TextFieldOptions.individual(interactive: true),
        checkboxOptions: CheckboxOptions.uniform(interactive: false)),
  );

  final bodyText16 = const TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: Colors.black,
    height:
        1.13, // close - would be perfect around 1.125 - but that's being rounded to 1.13
    letterSpacing: 0.02, // perfect match
    wordSpacing: 1.25, // perfect match
    textBaseline: TextBaseline.alphabetic,
  );

  static const double perfectScale = 1.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/text-sizing-aligned'),
                child: const Text('page 1'),
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
                padding: const EdgeInsets.all(0.0),
                child: ExportFrame(
                  exportDelegate: exportDelegate,
                  frameId: 'someFrameId', // identifies the frame
                  child: Container(
                    width: 595,
                    height: 842,
                    child: Column(
                      children: [
                        Container(
                          width: 400.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("200 - 200",
                                style: bodyText16,
                                textScaler:
                                    const TextScaler.linear(perfectScale)),
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
                            child: Text("100 - 100",
                                style: bodyText16,
                                textScaler:
                                    const TextScaler.linear(perfectScale)),
                          ),
                        ),
                        Container(
                          width: 400.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("50 - 50",
                                style: bodyText16,
                                textScaler:
                                    const TextScaler.linear(perfectScale)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          child: Text(
                              "Lorem ipsum, uti salvus iungo pareo principium infra. Illa curso, voro malum acer hoc tutamen rogo. Comperio levus, donum pyus. Quero, explicatus. Traho monitio, cado rideo ictus. Dolor libere, agere moti. Rutum ascit, nimis senis profero, cessi. Pre meminisse quin. Causa, decor puchre sepe feteo dimidium profari. Emerio promissio urbis tunc prae. Pergo, velut lebes nota. Hi quin illi secus.",
                              style: bodyText16,
                              textScaler:
                                  const TextScaler.linear(perfectScale)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          child: Text(
                            "Lorem ipsum, uti salvus iungo pareo principium infra. Illa curso, voro malum acer hoc tutamen rogo. Comperio levus, donum pyus. Quero, explicatus. Traho monitio, cado rideo ictus. Dolor libere, agere moti. Rutum ascit, nimis senis profero, cessi. Pre meminisse quin. Causa, decor puchre sepe feteo dimidium profari. Emerio promissio urbis tunc prae. Pergo, velut lebes nota. Hi quin illi secus.",
                            style: bodyText16,
                            textScaler: const TextScaler.linear(perfectScale),
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
