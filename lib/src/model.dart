///
///
library windows_pos_printer.model;

///
///
///
class POSPrinter {
  ///
  POSPrinter({
    this.id,
    this.name,
    this.address,
    this.deviceId,
    this.vendorId,
    this.productId,
    this.connected = false,
    this.type = 0,
  });

  ///
  String? id;

  ///
  String? name;

  ///
  String? address;

  ///
  int? deviceId;

  ///
  int? vendorId;

  ///
  int? productId;

  ///
  bool connected;

  ///
  int type;

  ///
  factory POSPrinter.instance() => POSPrinter();
}

///
///
///
class USBPrinter extends POSPrinter {
  ///
  USBPrinter({
    String? id,
    String? name,
    String? address,
    int? deviceId,
    int? vendorId,
    int? productId,
    bool connected = false,
    int type = 0,
  }) {
    this.id = id;
    this.name = name;
    this.address = address;
    this.deviceId = deviceId;
    this.vendorId = vendorId;
    this.productId = productId;
    this.connected = connected;
    this.type = type;
  }
}
