///
///
library windows_pos_printer.manager.stub;

import 'capability.dart';
import 'enums.dart';
import 'manager/abstract.dart';
import 'model.dart';

///
///
///
class WindowsPOSManager extends PrinterManager {
  ///
  WindowsPOSManager(
    POSPrinter printer,
    int paperSizeWidthMM,
    int maxPerLine,
    CapabilityProfile profile, {
    int spaceBetweenRows = 5,
    int port = 9100,
  });

  ///
  /// [discover] let you explore all netWork printer in your network
  static Future<List<USBPrinter>> discover() async => [];

  @override
  Future<ConnectionResponse> connect({Duration? timeout}) {
    throw UnimplementedError();
  }

  @override
  Future<ConnectionResponse> disconnect({Duration? timeout}) {
    throw UnimplementedError();
  }

  @override
  Future<ConnectionResponse> writeBytes(List<int> data,
      {bool isDisconnect = true}) {
    throw UnimplementedError();
  }
}
