import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class IotPdfScreen extends StatefulWidget {
  const IotPdfScreen({super.key});

  @override
  State<IotPdfScreen> createState() => _IotPdfScreenState();
}

class _IotPdfScreenState extends State<IotPdfScreen> {
  late PdfController pdfController;

  @override
  void initState() {
    super.initState();
    pdfController = PdfController(
      document: PdfDocument.openAsset('assets/pdf/iot.pdf'),
    );
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfView(
        controller: pdfController,
      ),
    );
  }
}

