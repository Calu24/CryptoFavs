import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:challenge_03/src/models/crypto_model.dart';


class CriptoServiceAPI{
  
  final String _url = 'https://api.cryptapi.io';


  Future<List<CriptoModel>> getCrypto(String crypto) async{
    
    final url  = '$_url/$crypto/info/';
    final resp = await http.get(Uri.parse(url));

    
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<CriptoModel> monedas = [];

    
    //if(decodedData == null) return [];

    if(decodedData['error'] != null) return [];


    final monedaTemp = CriptoModel.fromMap(decodedData);
      

    monedas.add(monedaTemp);

     
    return monedas;

  }
}