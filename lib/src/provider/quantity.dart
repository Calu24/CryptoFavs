import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class SetQuantity with ChangeNotifier, DiagnosticableTreeMixin  {

  List<double> _quantity = [];

  List<double> get quantity {
    return _quantity;
  }


  set quantity(List<double> cryptoQuantity){
    _quantity = cryptoQuantity;

    notifyListeners();
  }

  void remove(int index){
    _quantity.removeAt(index);

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty('quantity', quantity));
  }
}


