import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChangeCupertinoTabBar with ChangeNotifier, DiagnosticableTreeMixin {
  bool _showCupertinoTabBar=true;

  bool get showCupertinoTabBar => _showCupertinoTabBar;

  void toggle() {
    _showCupertinoTabBar=!_showCupertinoTabBar;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('showCupertinoTabBar', showCupertinoTabBar?1:0));
  }
}
