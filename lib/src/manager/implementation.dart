///
///
// ignore_for_file: avoid_print

library windows_pos_printer.manager.impl;

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import '../capability.dart';
import '../enums.dart';
import '../extension.dart';
import '../generator.dart';
import '../model.dart';
import '../service.dart';
import 'abstract.dart';

/// USB Printer
class WindowsPOSManager extends PrinterManager {
  ///
  WindowsPOSManager(
    POSPrinter printer,
    int paperSizeWidthMM,
    int maxPerLine,
    CapabilityProfile profile, {
    int spaceBetweenRows = 5,
    int port = 9100,
  }) {
    super.printer = printer;
    super.address = printer.address;
    super.productId = printer.productId;
    super.deviceId = printer.deviceId;
    super.vendorId = printer.vendorId;
    super.paperSizeWidthMM = paperSizeWidthMM;
    super.maxPerLine = maxPerLine;
    super.profile = profile;
    super.spaceBetweenRows = spaceBetweenRows;
    super.port = port;
    
    generator = Generator(
      paperSizeWidthMM,
      maxPerLine,
      profile,
      spaceBetweenRows: spaceBetweenRows,
    );
  }

  ///
  Pointer<Utf16> pDocName = 'My Document'.toNativeUtf16();

  ///
  Pointer<Uint32>? dwBytesWritten = calloc<DWORD>();

  ///
  Pointer<Utf16> pDataType = 'RAW'.toNativeUtf16();

  /// [win32]
  Pointer<IntPtr>? phPrinter = calloc<HANDLE>();

  ///
  late Pointer<Utf16> szPrinterName;

  ///
  Pointer<DOC_INFO_1>? docInfo;

  ///
  late int hPrinter;

  ///
  int? dwCount;

  ///
  ///
  @override
  Future<ConnectionResponse> connect({
    Duration? timeout = const Duration(seconds: 5),
  }) async {
    try {
      docInfo = calloc<DOC_INFO_1>()
        ..ref.pDocName = pDocName
        ..ref.pOutputFile = nullptr
        ..ref.pDatatype = pDataType;
      szPrinterName = printer.name!.toNativeUtf16();

      final phPrinter = calloc<HANDLE>();
      if (OpenPrinter(szPrinterName, phPrinter, nullptr) == FALSE) {
        isConnected = false;
        printer.connected = false;
        return Future<ConnectionResponse>.value(
            ConnectionResponse.printerNotConnected);
      } else {
        hPrinter = phPrinter.value;
        isConnected = true;
        printer.connected = true;
        return Future<ConnectionResponse>.value(ConnectionResponse.success);
      }
    } catch (e) {
      isConnected = false;
      printer.connected = false;
      return Future<ConnectionResponse>.value(ConnectionResponse.timeout);
    }
  }

  ///
  /// [discover] let you explore all netWork printer in your network
  static Future<List<USBPrinter>> discover() async =>
      await USBService.findUSBPrinter();

  ///
  ///
  @override
  Future<ConnectionResponse> disconnect({Duration? timeout}) async {
    // Tidy up the printer handle.
    ClosePrinter(hPrinter);
    free(phPrinter!);
    free(pDocName);
    free(pDataType);
    free(dwBytesWritten!);
    free(docInfo!);
    free(szPrinterName);

    isConnected = false;
    printer.connected = false;
    if (timeout != null) {
      await Future.delayed(timeout, () => null);
    }

    return ConnectionResponse.success;
  }

  ///
  ///
  @override
  Future<ConnectionResponse> writeBytes(
    List<int> data, {
    bool isDisconnect = true,
  }) async {
    try {
      if (!isConnected) {
        await connect();
      }

      // Inform the spooler the document is beginning.
      final dwJob = StartDocPrinter(hPrinter, 1, docInfo!);
      if (dwJob == 0) {
        ClosePrinter(hPrinter);
        return ConnectionResponse.printInProgress;
      }
      // Start a page.
      if (StartPagePrinter(hPrinter) == 0) {
        EndDocPrinter(hPrinter);
        ClosePrinter(hPrinter);
        return ConnectionResponse.printerNotSelected;
      }

      // Send the data to the printer.
      final lpData = data.toUint8();
      dwCount = data.length;
      if (WritePrinter(hPrinter, lpData, dwCount!, dwBytesWritten!) == 0) {
        EndPagePrinter(hPrinter);
        EndDocPrinter(hPrinter);
        ClosePrinter(hPrinter);
        return ConnectionResponse.printerNotWritable;
      }

      // End the page.
      if (EndPagePrinter(hPrinter) == 0) {
        EndDocPrinter(hPrinter);
        ClosePrinter(hPrinter);
      }

      // Inform the spooler that the document is ending.
      if (EndDocPrinter(hPrinter) == 0) {
        ClosePrinter(hPrinter);
      }

      // Check to see if correct number of bytes were written.
      if (dwBytesWritten!.value != dwCount) {}

      if (isDisconnect) {
        // Tidy up the printer handle.
        ClosePrinter(hPrinter);
        // await disconnect();
      }
      return ConnectionResponse.success;
    }
    //
    catch (e) {
      return ConnectionResponse.unknown;
    }
  }
}
