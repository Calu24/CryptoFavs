import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class CryptoFav with ChangeNotifier, DiagnosticableTreeMixin {

  String _cryptoName = '';
  final List<String> _cryptoNameList = [];
  String _actualCurrency = 'USD';

  set name(String cryptoName){
    switch (cryptoName) {
      case 'Bitcoin':
        _cryptoName = 'btc';
        break;
      case 'Ethereum':
        _cryptoName = 'eth';
        break;
      case 'Litecoin':
        _cryptoName = 'ltc';
        break;
      case 'Tron':
        _cryptoName = 'trx';
        break;
    }
    _cryptoNameList.add(_cryptoName);

    notifyListeners();
  }

  void remove(int index){
    _cryptoNameList.removeAt(index);

    notifyListeners();
  }

  List<String> get list {
    return _cryptoNameList;
  }


  set changeCurrency(String currency){
    currency == 'USD' ? _actualCurrency  = 'EUR' : _actualCurrency  = 'USD';

    notifyListeners();
  }

  String get currency{
    return _actualCurrency;
  }


  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty('list', list));
    properties.add(StringProperty('currency', currency));
  }
  
}