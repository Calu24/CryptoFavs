import 'package:challenge_03/src/models/crypto_model.dart';
import 'package:challenge_03/src/provider/crypto_fav.dart';
import 'package:challenge_03/src/provider/quantity.dart';
import 'package:challenge_03/src/service/crypt_api.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:challenge_03/src/pages/search.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final cryptoAPI = CriptoServiceAPI();

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                context.read<CryptoFav>().changeCurrency =
                    context.read<CryptoFav>().currency;
                setState(() {});
              },
              child: Text(context.watch<CryptoFav>().currency,
                  style: GoogleFonts.nunito(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
          const SizedBox(
            width: 10.0,
          )
        ],
        backgroundColor: const Color.fromRGBO(1, 20, 53, 1),
        elevation: 10.0,
        centerTitle: true,
        title: Text(
          'CryptoFavs',
          style:
              GoogleFonts.nunito(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        itemCount: context.watch<CryptoFav>().list.length,
        separatorBuilder: (_, __) => const Divider(
          color: Colors.black,
          height: 2,
        ),
        itemBuilder: (_, int index) {
          if (context.watch<CryptoFav>().list.isEmpty) {
            return Container();
          }

          return _listTileFutureBuilder(context, cryptoAPI,
              context.watch<CryptoFav>().list[index], index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(1, 20, 53, 1),
        onPressed: () {
          Navigator.push(context, _transicionAnimada());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _listTileFutureBuilder(BuildContext context, CriptoServiceAPI cryptos,
      String cryptoName, int index) {
    return FutureBuilder(
      future: cryptos.getCrypto(cryptoName),
      builder: (context, AsyncSnapshot<List<CriptoModel>> snapshot) {
        if (snapshot.hasData) {
          final cryptoCurrency = snapshot.data;

          double switchedCryptoCurrency =
              context.watch<CryptoFav>().currency == 'USD'
                  ? double.parse(cryptoCurrency![0].prices.usd)
                  : double.parse(cryptoCurrency![0].prices.eur);

          var result = switchedCryptoCurrency *
              context.watch<SetQuantity>().quantity[index];

          return ListTile(
            leading: Text(
              cryptoCurrency[0].ticker.toUpperCase(),
              style: GoogleFonts.nunito(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            title: Text(
              '\$$result ${context.watch<CryptoFav>().currency}',
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(Icons.circle_outlined, color: Colors.red[300]),
              onPressed: () {
                setState(() {
                  context.read<SetQuantity>().remove(index);
                  context.read<CryptoFav>().remove(index);
                });
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Route _transicionAnimada() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          const SearchPage(),
      transitionDuration: const Duration(milliseconds: 1000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation =
            CurvedAnimation(parent: animation, curve: Curves.ease);

        return SlideTransition(
          child: child,
          position:
              Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
                  .animate(curvedAnimation),
        );
      },
    );
  }
}
