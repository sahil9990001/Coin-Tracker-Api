import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    this.tokenName,
    this.tokenPair,
    this.tokenDescription,
    this.marketAddress,
    this.tokenAddress,
    this.tokenLogo,
    this.wesbite,
    this.twitter,
    this.discord,
    this.telegram,
    this.circulatingSupply,
  });

  String tokenName;
  String tokenPair;
  String tokenDescription;
  String marketAddress;
  String tokenAddress;
  String tokenLogo;
  String wesbite;
  String twitter;
  String discord;
  String telegram;
  String circulatingSupply;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        tokenName: json["token_name"],
        tokenPair: json["token_pair"],
        tokenDescription: json["token_description"] == null
            ? null
            : json["token_description"],
        marketAddress: json["market_address"],
        tokenAddress: json["token_address"],
        tokenLogo: json["token_logo"],
        wesbite: json["wesbite"],
        twitter: json["twitter"],
        discord: json["discord"],
        telegram: json["telegram"],
        circulatingSupply: json["circulating_supply"],
      );

  Map<String, dynamic> toJson() => {
        "token_name": tokenName,
        "token_pair": tokenPair,
        "token_description": tokenDescription == null ? null : tokenDescription,
        "market_address": marketAddress,
        "token_address": tokenAddress,
        "token_logo": tokenLogo,
        "wesbite": wesbite,
        "twitter": twitter,
        "discord": discord,
        "telegram": telegram,
        "circulating_supply": circulatingSupply,
      };
}
