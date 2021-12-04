import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
import 'src/provider/crypto_fav.dart';
import 'src/routes/routes.dart';
import 'package:challenge_03/src/provider/quantity.dart';
 
void main() => runApp(const AppState());
 
class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SetQuantity()),
        ChangeNotifierProvider(create: (_) => CryptoFav())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: getAplicationRoutes(),
    );
  }
}