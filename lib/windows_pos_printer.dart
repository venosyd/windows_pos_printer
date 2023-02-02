///
///
library windows_pos_printer;

export 'src/capability.dart';
export 'src/enums.dart';
export 'src/stub.dart' if (dart.library.io) 'src/manager/implementation.dart';
export 'src/model.dart';
