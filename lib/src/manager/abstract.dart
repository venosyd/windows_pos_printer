///
///
library windows_pos_printer.manager.abstract;

import '../capability.dart';
import '../enums.dart';
import '../generator.dart';
import '../model.dart';

///
///
///
abstract class PrinterManager {
  ///
  int paperSizeWidthMM = 0;

  ///
  int maxPerLine = 0;

  ///
  Generator? generator;

  ///
  CapabilityProfile? profile;

  ///
  bool isConnected = false;

  ///
  String? address;

  ///
  int? vendorId;

  ///
  int? productId;

  ///
  int? deviceId;

  ///
  int port = 9100;

  ///
  int spaceBetweenRows = 5;

  ///
  late POSPrinter printer;

  ///
  ///
  Future<ConnectionResponse> connect({Duration? timeout});

  ///
  ///
  Future<ConnectionResponse> writeBytes(
    List<int> data, {
    bool isDisconnect = true,
  });

  ///
  ///
  Future<ConnectionResponse> disconnect({Duration? timeout});
}
