# windows_pos_printer

This plugin allow developer to print to esc printer via USB on Windows.

## Example

```
_scan() async {
    setState(() {
      _isLoading = true;
      _printers = [];
    });

    var printers = await WindowsPOSManager.discover();

    setState(() {
      _isLoading = false;
      _printers = printers;
    });
  }

  _connect(USBPrinter printer) async {
    var paperSize = PaperSizeWidth.mm80;
    var profile = await CapabilityProfile.load();
    var manager = WindowsPOSManager(printer, paperSize, profile);

    await manager.connect();

    setState(() {
      _manager = manager;
      printer.connected = true;
    });
  }

  _startPrinter() async {
    if (_data.isEmpty) {
      final content = Demo.getShortReceiptContent();

      var bytes = await WebcontentConverter.contentToImage(
        content: content,
        executablePath: WebViewHelper.executablePath(),
      );

      var service = ESCPrinterService(bytes);
      var data = await service.getBytes();
      
      if (mounted) setState(() => _data = data);
    }

    if (_manager != null) {
      print("isConnected ${_manager.isConnected}");
      _manager.writeBytes(_data, isDisconnect: false);
    }
  }
```

## Getting Started
```
  flutter pub add windows_pos_printer
```

Thank to :
- [drago_pos_printer](https://pub.dev/packages/drago_pos_printer)
- [esc_pos_utils](https://pub.dev/packages/esc_pos_utils)
- [printing](https://pub.dev/packages/printing)