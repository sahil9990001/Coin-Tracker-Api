import 'package:flutter/material.dart';

class CoinDrawer extends StatelessWidget {
  const CoinDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'OPTIONS',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(Icons.arrow_back_ios_outlined, size: 30),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/HOME.png',
                  height: 23,
                  width: 23,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'HOME',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/DEXS.png',
                  height: 23,
                  width: 23,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'FEEDBACK',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/FAQ.png',
                  height: 23,
                  width: 23,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'FAQ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/SUPPORT.png',
                  height: 23,
                  width: 23,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'SUPPORT',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/ABOUT.png',
                  height: 23,
                  width: 23,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'ABOUT US',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
