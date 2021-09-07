import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'Modals/cota_APi.dart';
import 'coin_card_tile.dart';
import 'coin_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COIN API',
      debugShowCheckedModeBanner: false,
      home: ScreenList(),
    );
  }
}

class ScreenList extends StatefulWidget {
  @override
  _ScreenListState createState() => _ScreenListState();
}

class _ScreenListState extends State<ScreenList> {
  Future<dynamic> json;
  List<Welcome> listData = [];
  var loading = false;
  final TextEditingController _filter = new TextEditingController();

  String _searchText = "";
  List filteredNames = []; // names filtered by search text
  Icon _searchIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget _text = new Text(
    'COIN ANALYTICS',
    style: TextStyle(
        fontSize: 20, color: Color(0xffffffff), fontWeight: FontWeight.w400),
  );

  _ScreenListState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = listData;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  Future<Null> getData() async {
    setState(() {
      loading = true;
    });
    Response response = await get(Uri.parse(
        "https://raw.githubusercontent.com/SOL-CAT/catodata/master/catoapidata.json"));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      final l = jsonDecode(jsonString);
      setState(() {
        for (Map i in l) {
          listData.add(Welcome.fromJson(i));
        }
        // print(listData);
        loading = false;
      });
    } else {
      throw ("Can't fetch data");
    }
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._text = Container(
          // color: Colors.amber,
          width: 250,
          height: 40,
          child: new TextField(
            style: TextStyle(color: Colors.white),
            controller: _filter,
            decoration: new InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: new Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: 'Search...'),
          ),
        );
      } else {
        this._searchIcon = new Icon(
          Icons.search,
          color: Colors.white,
        );
        this._text = new Text(
          'COIN ANALYTICS',
          style: TextStyle(
              fontSize: 20,
              color: Color(0xffffffff),
              fontWeight: FontWeight.w400),
        );
        filteredNames = listData;
        _filter.clear();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xff36136b),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Image.asset('assets/drawer_icon.png'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text(
            'COIN TRACKER',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xffffffff)),
          ),
        ),
      ),
      drawer: CoinDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
                top: 30,
                bottom: 500.0,
                left: 10.0,
                right: 16.0,
                child: Center(child: Image.asset('assets/TOPBanner.png'))),
            Positioned(
                top: 30,
                bottom: 500.0,
                left: 0.0,
                right: 100.0,
                child: Center(child: Image.asset('assets/CATODEX.png'))),
            Positioned(
                top: 30,
                bottom: 500.0,
                left: 200.0,
                right: 0.0,
                child: Center(child: Image.asset('assets/Logo.png'))),
            Positioned(
                top: 126,
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Image.asset(
                  'assets/GlassBg.png',
                  fit: BoxFit.fill,
                )),
            Positioned(
                top: 200,
                bottom: 10.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 30.0, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _text,
                              GestureDetector(
                                  onTap: _searchPressed, child: _searchIcon)
                            ],
                          ),
                        ),
                        Container(
                          height: 400,
                          child: buildList(),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  ListView buildList() {
    if (_searchText.isNotEmpty) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .tokenPair
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    } else {
      filteredNames = listData;
    }

    return ListView.builder(
        itemCount: filteredNames.length,
        itemBuilder: (context, i) {
          final ndata = filteredNames[i];
          print(ndata);
          String marketAddress = ndata.marketAddress;
          return CoinCardTile(
              websiteLink: ndata.wesbite,
              twitter: ndata.twitter,
              discord: ndata.discord,
              telegram: ndata.telegram,
              calculatingSupply: ndata.circulatingSupply,
              tokenAddress: ndata.tokenAddress,
              marketAddress: marketAddress,
              tokenpair: ndata.tokenPair,
              tokenLogo: ndata.tokenLogo,
              tokenname: ndata.tokenName,
              tokenDiscription: ndata.tokenDescription);
        });
  }
}
