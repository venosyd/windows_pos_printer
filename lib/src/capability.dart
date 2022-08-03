///
/// esc_pos_utils
/// Created by Andrey U.
///
/// Copyright (c) 2019-2020. All rights reserved.
/// See LICENSE for distribution and usage details.
///
// ignore_for_file: avoid_print
library windows_pos_printer.capability;

import 'dart:convert' show json;

import 'package:flutter/services.dart' show rootBundle;

///
final printProfiles = <Map>[];

///
var printCapabilities = {};

///
///
///
class CodePage {
  ///
  CodePage(this.id, this.name);

  ///
  int id;

  ///
  String name;
}

///
///
///
class CapabilityProfile {
  ///
  const CapabilityProfile._internal(this.name, this.codePages);

  ///
  final String name;

  ///
  final List<CodePage> codePages;

  /// [ensureProfileLoaded]
  /// this method will cache the profile json into data which will
  /// speed up the next loop and searching profile
  static Future ensureProfileLoaded({String? path}) async {
    /// check where this global capabilities is empty then load capabilities.json
    /// else do nothing
    if (printCapabilities.isEmpty == true) {
      final content = await rootBundle.loadString(
        path ?? 'packages/windows_pos_printer/assets/capabilities.json',
      );

      var _capabilities = json.decode(content);
      printCapabilities = Map.from(_capabilities);

      _capabilities['profiles'].forEach((k, v) {
        printProfiles.add({
          'key': k,
          'vendor': v['vendor'] is String ? v['vendor'] : '',
          'name': v['name'] is String ? v['name'] : '',
          'description': v['description'] is String ? v['description'] : '',
        });
      });

      /// assert that the capabilities will be not empty
      assert(printCapabilities.isNotEmpty);
    }
    //
    else {
      print("capabilities.length is already loaded");
    }
  }

  /// Public factory
  ///
  static Future<CapabilityProfile> load({String name = 'default'}) async {
    await ensureProfileLoaded();

    var profile = printCapabilities['profiles'][name];

    if (profile == null) {
      throw Exception("The CapabilityProfile '$name' does not exist");
    }

    final list = <CodePage>[];
    profile['codePages'].forEach((k, v) => list.add(CodePage(int.parse(k), v)));

    // Call the private constructor
    return CapabilityProfile._internal(name, list);
  }

  ///
  ///
  int getCodePageId(String? codePage) => codePages
      .firstWhere((cp) => cp.name == codePage,
          // ignore: unnecessary_cast
          orElse: (() => throw Exception(
                  "Code Page '$codePage' isn't defined for this profile"))
              as CodePage Function()?)
      .id;

  ///
  ///
  static Future<List<dynamic>> getAvailableProfiles() async {
    /// ensure the capabilities is not empty
    await ensureProfileLoaded();

    var _profiles = printCapabilities['profiles'];
    final res = [];

    _profiles.forEach((k, v) {
      res.add({
        'key': k,
        'vendor': v['vendor'] is String ? v['vendor'] : '',
        'name': v['name'] is String ? v['name'] : '',
        'description': v['description'] is String ? v['description'] : '',
      });
    });

    return res;
  }
}
