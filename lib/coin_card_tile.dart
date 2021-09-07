import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Modals/api2.dart';
import 'coinCard.dart';

class CoinCardTile extends StatefulWidget {
  String websiteLink;
  String twitter;
  String discord;
  String telegram;
  String calculatingSupply;
  String tokenAddress;
  String marketAddress;
  String tokenDiscription;
  String tokenpair;
  String tokenname;
  String tokenLogo;
  CoinCardTile({
    this.discord,
    this.telegram,
    this.twitter,
    this.websiteLink,
    this.calculatingSupply,
    this.tokenAddress,
    this.marketAddress,
    this.tokenDiscription,
    this.tokenLogo,
    this.tokenpair,
    this.tokenname,
    Key key,
  }) : super(key: key);

  @override
  _CoinCardTileState createState() => _CoinCardTileState();
}

class _CoinCardTileState extends State<CoinCardTile> {
  // setUpTimedFetch() {
  //   Timer.periodic(Duration(milliseconds: 10000), (timer) {
  //     print(widget.tokenAddress);
  //     json = ApiServices.getData1(widget.tokenAddress);
  //   });
  // }

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CoinCard(
                    twitter: widget.twitter,
                    websiteLink: widget.websiteLink,
                    telegram: widget.telegram,
                    discord: widget.discord,
                    calculatingSupply: widget.calculatingSupply,
                    marketAddress: widget.marketAddress,
                    tokenAddress: widget.tokenAddress,
                    tokenDiscription: widget.tokenDiscription,
                    tokenpair: widget.tokenpair,
                    tokenLogo: widget.tokenLogo,
                    tokenname: widget.tokenname)),
          );
        },
        child: Container(
            height: 89,
            width: 293,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/BG-Banner.png',
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Image.network(
                      widget.tokenLogo,
                      height: 70,
                      width: 70,
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tokenpair,
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.tokenname,
                      style: TextStyle(
                          fontSize: 10,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // FutureBuilder<Data2>(
                //   future: getVolumeData(widget.marketAddress),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       return Padding(
                //         padding: const EdgeInsets.all(25.0),
                //         child: Text(
                //           snapshot.data.price.toString(),
                //           style: TextStyle(
                //               fontSize: 10,
                //               color: Color(0xffffffff),
                //               fontWeight: FontWeight.bold),
                //         ),
                //       );
                //     } else if (snapshot.hasError) {
                //       return Text('${snapshot.error}');
                //     }

                //     // By default, show a loading spinner.
                //     return Text(
                //       'Loading.....',
                //       style: TextStyle(color: Colors.white),
                //     );
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    '0.09',
                    style: TextStyle(
                        fontSize: 10,
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
