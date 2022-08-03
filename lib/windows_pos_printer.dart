///
///
library windows_pos_printer;

export 'src/capability.dart';
export 'src/enums.dart';
export 'src/stub.dart' if (dart.io.library) 'src/manager/implementation.dart';
export 'src/model.dart';
