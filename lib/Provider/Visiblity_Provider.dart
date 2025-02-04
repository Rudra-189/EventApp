import 'package:flutter/cupertino.dart';

class visiblityProvider with ChangeNotifier{
  bool _isvisibel = true;
  bool get isvisibel => _isvisibel;

  void setvisibel(bool val){
    if(_isvisibel == true){
      _isvisibel = val;
    }else{
      _isvisibel = val;
    }
    notifyListeners();
  }
}