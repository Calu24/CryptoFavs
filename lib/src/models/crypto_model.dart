// To parse this JSON data, do
//
//     final criptoModel = criptoModelFromMap(jsonString);

import 'dart:convert';

class CriptoModel {
    CriptoModel({
        required this.coin,
        required this.logo,
        required this.ticker,
        required this.prices,
    });

    String coin;
    String logo;
    String ticker;
    Prices prices;

    factory CriptoModel.fromJson(String str) => CriptoModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CriptoModel.fromMap(Map<String, dynamic> json) => CriptoModel(
        coin: json["coin"],
        logo: json["logo"],
        ticker: json["ticker"],
        prices: Prices.fromMap(json["prices"]),
    );

    Map<String, dynamic> toMap() => {
        "coin": coin,
        "logo": logo,
        "ticker": ticker,
        "prices": prices.toMap(),
    };
}

class Prices {
    Prices({
        required this.usd,
        required this.eur,
    });

    String usd;
    String eur;

    factory Prices.fromJson(String str) => Prices.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Prices.fromMap(Map<String, dynamic> json) => Prices(
        usd: json["USD"],
        eur: json["EUR"],
    );

    Map<String, dynamic> toMap() => {
        "USD": usd,
        "EUR": eur,
    };
}
