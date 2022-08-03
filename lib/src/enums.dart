///
///
library drago_pos_printer.enums.connection_response;

///
enum PosAlign { left, center, right }

///
enum PosCutMode { full, partial }

///
enum PosFontType { fontA, fontB }

///
enum PosDrawer { pin2, pin5 }

/// Choose image printing function
/// bitImageRaster: GS v 0 (obsolete)
/// graphics: GS ( L
enum PosImageFn { bitImageRaster, graphics }

///
///
///
class PosTextSize {
  ///
  static const size1 = 1;

  ///
  static const size2 = 2;

  ///
  static const size3 = 3;

  ///
  static const size4 = 4;

  ///
  static const size5 = 5;

  ///
  static const size6 = 6;

  ///
  static const size7 = 7;

  ///
  static const size8 = 8;

  ///
  static int decSize(int height, int width) => 16 * (width - 1) + (height - 1);
}

///
///
///
class PaperSizeWidth {
  ///
  static int mm58 = 384;

  ///
  static const mm80Old = 500;

  ///
  static const mm80 = 570;
}

///
///
///
class PaperSizeMaxPerLine {
  ///
  static int mm58 = 32;

  ///
  static const mm80Old = 42;

  ///
  static const mm80 = 48;
}

///
///
///
class PosBeepDuration {
  ///
  const PosBeepDuration._internal(this.value);

  ///
  final int value;

  ///
  static const beep50ms = PosBeepDuration._internal(1);

  ///
  static const beep100ms = PosBeepDuration._internal(2);

  ///
  static const beep150ms = PosBeepDuration._internal(3);

  ///
  static const beep200ms = PosBeepDuration._internal(4);

  ///
  static const beep250ms = PosBeepDuration._internal(5);

  ///
  static const beep300ms = PosBeepDuration._internal(6);

  ///
  static const beep350ms = PosBeepDuration._internal(7);

  ///
  static const beep400ms = PosBeepDuration._internal(8);

  ///
  static const beep450ms = PosBeepDuration._internal(9);
}

///
///
///
class ConnectionResponse {
  ///
  const ConnectionResponse._internal(this.value);

  ///
  final int value;

  ///
  static const success = ConnectionResponse._internal(1);

  ///
  static const timeout = ConnectionResponse._internal(2);

  ///
  static const printerNotSelected = ConnectionResponse._internal(3);

  ///
  static const ticketEmpty = ConnectionResponse._internal(4);

  ///
  static const printInProgress = ConnectionResponse._internal(5);

  ///
  static const scanInProgress = ConnectionResponse._internal(6);

  ///
  static const printerNotConnected = ConnectionResponse._internal(7);

  ///
  static const unknown = ConnectionResponse._internal(8);

  ///
  static const unsupport = ConnectionResponse._internal(9);

  ///
  static const printerNotWritable = ConnectionResponse._internal(10);

  ///
  ///
  String get msg {
    if (value == ConnectionResponse.success.value) {
      return 'Success';
    }
    //
    else if (value == ConnectionResponse.timeout.value) {
      return 'Error. Printer connection timeout';
    }
    //
    else if (value == ConnectionResponse.printerNotSelected.value) {
      return 'Error. Printer not selected';
    }
    //
    else if (value == ConnectionResponse.printerNotConnected.value) {
      return 'Error. Printer not connected';
    }
    //
    else if (value == ConnectionResponse.ticketEmpty.value) {
      return 'Error. Ticket is empty';
    }
    //
    else if (value == ConnectionResponse.printInProgress.value) {
      return 'Error. Another print in progress';
    }
    //
    else if (value == ConnectionResponse.scanInProgress.value) {
      return 'Error. Printer scanning in progress';
    }
    //
    else if (value == ConnectionResponse.unknown.value) {
      return 'Unknown error';
    }
    //
    else if (value == ConnectionResponse.unsupport.value) {
      return 'Unsupport platform';
    }
    //
    else if (value == ConnectionResponse.printerNotWritable.value) {
      return 'Printer not writable';
    }
    //
    else {
      return 'Unknown error';
    }
  }
}
