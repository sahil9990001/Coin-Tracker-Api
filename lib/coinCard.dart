import 'dart:convert';

import 'package:cato1/Modals/api2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Modals/api3_modal.dart';
import 'Modals/api4_model.dart';

class CoinCard extends StatefulWidget {
  String websiteLink;
  String twitter;
  String discord;
  String telegram;
  String calculatingSupply;
  String marketAddress;
  String tokenAddress;
  String tokenDiscription;
  String tokenpair;
  String tokenname;
  String tokenLogo;
  CoinCard({
    this.discord,
    this.telegram,
    this.twitter,
    this.websiteLink,
    this.calculatingSupply,
    this.marketAddress,
    this.tokenAddress,
    this.tokenDiscription,
    this.tokenLogo,
    this.tokenpair,
    this.tokenname,
    Key key,
  }) : super(key: key);

  @override
  _CoinCardState createState() => _CoinCardState();
}

class _CoinCardState extends State<CoinCard> {
  static Future<Data1> getTokenData1(tokenAddress) async {
    Response response = await get(
        Uri.parse("https://api.solscan.io/token/meta?token=$tokenAddress"));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      final l = jsonDecode(jsonString)['data'];
      var json = Data1.fromJson(l);
      print(json);
      return json;
    } else {
      throw ("Can't fetch data");
    }
  }

  static Future<Data2> getVolumeData(marketAddress) async {
    Response response = await get(
        Uri.parse("https://api.dexlab.space/v1/volumes/$marketAddress"));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      final l = jsonDecode(jsonString)['data'];
      var json = Data2.fromJson(l);
      print(json);
      return json;
    } else {
      throw ("Can't fetch data");
    }
  }

  static Future<Data4> getSupplyData(tokenAddress) async {
    Response response = await get(
        Uri.parse("https://api.solscan.io/account?address=$tokenAddress"));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      final l = jsonDecode(jsonString)['data'];
      var json = Data4.fromJson(l);
      print(json);
      return json;
    } else {
      throw ("Can't fetch data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff36136b),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
                child: Text(
              'COIN CARD',
              style: TextStyle(fontSize: 25, color: Color(0xffffffff)),
            )),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    widget.tokenLogo,
                    height: 100,
                    width: 100,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tokenpair,
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 200,
                      child: Expanded(
                        child: Text(
                          widget.tokenname,
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: 10,
                      width: 200,
                      child: Expanded(
                        child: Text(
                          widget.tokenDiscription == null
                              ? 'No Discription'
                              : widget.tokenDiscription,
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Market Cup',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffffffff),
                    ),
                  ),
                  FutureBuilder<Data2>(
                    future: getVolumeData(widget.marketAddress),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.price.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Color(0xffffffff),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return Text(
                        'Loading.....',
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VOLUME',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffffffff),
                    ),
                  ),
                  FutureBuilder<Data2>(
                    future: getVolumeData(widget.marketAddress),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.summary.totalVolume.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Color(0xffffffff),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return Text(
                        'Loading.....',
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'LIQUIDITY',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffffffff),
                    ),
                  ),
                  Text(
                    'Liquidity',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffffffff),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'HOLDERS',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffffffff),
                    ),
                  ),
                  FutureBuilder<Data1>(
                    future: getTokenData1(widget.tokenAddress),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          (double.parse(snapshot.data.holder.toString()) *
                                  double.parse(widget.calculatingSupply))
                              .toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Color(0xffffffff),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return Text(
                        'Loading.....',
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SUPPLY',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffffffff),
                    ),
                  ),
                  FutureBuilder<Data4>(
                    future: getSupplyData(widget.tokenAddress),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.tokenInfo.supply.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Color(0xffffffff),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return Text(
                        'Loading.....',
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    launch(widget.websiteLink);
                    // print(widget.websiteLink);
                  },
                  child: Image.asset(
                    'assets/web.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  onTap: () {
                    launch(widget.twitter);
                  },
                  child: Image.asset(
                    'assets/twitter.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  onTap: () {
                    launch(widget.discord);
                  },
                  child: Image.asset(
                    'assets/discord.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  onTap: () {
                    launch(widget.telegram);
                  },
                  child: Image.asset(
                    'assets/telegram.png',
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 89,
              width: 293,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  fit: BoxFit
                      .cover, //I assumed you want to occupy the entire space of the card
                  image: AssetImage(
                    'assets/Rectangle.png',
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'TRADE NOW',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffffffff)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
