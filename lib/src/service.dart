///
///
library windows_pos_printer.service;

import 'package:printing/printing.dart';

import 'model.dart';

///
///
///
class USBService {
  ///
  static Future<List<USBPrinter>> findUSBPrinter() async {
    var devices = <USBPrinter>[];

    var results = await Printing.listPrinters();

    devices = [
      ...results
          .where((entry) => entry.isAvailable)
          .toList()
          .map(
            (e) => USBPrinter(
              name: e.name,
              address: e.url,
              connected: e.isAvailable,
            ),
          )
          .toList()
    ];

    return devices;
  }
}
