import 'package:challenge_03/src/provider/crypto_fav.dart';
import 'package:challenge_03/src/provider/quantity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> _cryptosAvailables = [
    'Bitcoin',
    'Ethereum',
    'Litecoin',
    'Tron'
  ];
  List<String> _visibleCryptos = [];
  double _cryptoQuantity = 0.0;

  @override
  void initState() {
    _visibleCryptos = _cryptosAvailables;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(1, 20, 53, 1),
        centerTitle: true,
        title: const Text('CryptoFavs'),
      ),
      body: Stack(
        children: [
          _searchBody(),
        ],
      ),
    );
  }

  Padding _searchBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Filter',
            ),
            onChanged: (value) {
              _visibleCryptos = _cryptosAvailables
                  .where((crypto) => crypto.contains(value))
                  .toList();
              setState(() {});
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_visibleCryptos[index]),
                  onTap: () => _showCrypto(context, _visibleCryptos[index]),
                );
              },
              itemCount: _visibleCryptos.length,
            ),
          ),
        ],
      ),
    );
  }

  void _showCrypto(BuildContext context, String selected) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            title: Text(
              selected,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              _input(),
              const SizedBox(
                height: 30.0,
              )
            ]),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0))),
                  onPressed: () {
                    context.read<SetQuantity>().quantity.add(_cryptoQuantity);
                    context.read<CryptoFav>().name = selected;
                    Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
                  },
                  child: const Text('Save')),
            ],
          );
        });
  }

  Widget _input() {
    return TextField(
      keyboardType: TextInputType.number,
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Quantity',
        helperStyle: TextStyle(backgroundColor: Colors.grey[200]),
      ),
      onChanged: (valor) {
        setState(() {
          _cryptoQuantity = valor == '' ? 0 : double.parse(valor);
        });
      },
    );
  }
}
