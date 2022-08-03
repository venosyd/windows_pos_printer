///
///
library windows_pos_printer.manager.stub;

import 'package:windows_pos_printer/src/manager/abstract.dart';

import 'enums.dart';

///
///
///
class WindowsPOSManager extends PrinterManager {
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
