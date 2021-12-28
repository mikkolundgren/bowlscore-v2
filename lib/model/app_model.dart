import 'package:flutter/foundation.dart';

abstract class AppModel extends ChangeNotifier {
  void setBowler(String bowler);
  String get bowler;
}

class AppModelImplementation extends AppModel {
  String _bowler = '';

  @override
  String get bowler => _bowler;

  @override
  void setBowler(String bowler) {
    _bowler = bowler;
    if (kDebugMode) {
      print('bowler: $_bowler');
    }
    notifyListeners();
  }
}
