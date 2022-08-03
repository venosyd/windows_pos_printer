///
///
// ignore_for_file: avoid_print
library windows_pos_printer.extension;

import 'dart:ffi';
import 'package:ffi/ffi.dart';

///
/// extension for converting list<int> to Unit8 to work with win32
///
extension IntParsing on List<int> {
  ///
  ///
  Pointer<Uint8> toUint8() {
    final result = calloc<Uint8>(length);

    final nativeString = result.asTypedList(length);
    nativeString.setAll(0, this);

    return result;
  }

  ///
  ///
  List<List<int>> chunkBy(num value) {
    final size = length;

    var result = <List<int>>[];
    var max = size ~/ value;
    var check = size % (value as int);

    if (check > 0) {
      max += 1;
    }

    if (size <= value) {
      result = [this];
    }
    //
    else {
      for (var i = 0; i < max; i++) {
        var startIndex = value * i;
        var endIndex = value * (i + 1);

        if (endIndex > size) {
          endIndex = size;
        }

        var sub = sublist(startIndex, endIndex);
        result.add(sub);
      }
    }

    return result;
  }
}
