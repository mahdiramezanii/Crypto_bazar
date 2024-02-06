import "package:cripto_bazar/data/constant/constans.dart";
import "package:cripto_bazar/data/models.dart";
import "package:cripto_bazar/screan/crypto_list.dart";
import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import 'package:dio/dio.dart';

class HomeScrean extends StatefulWidget {
  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/images/logo.png"),
            ),
            Text(
              "کریپتو بازار",
              style: TextStyle(
                  fontFamily: "mr", fontSize: 22, color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            SpinKitWave(
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  void _getData() async {
    var response = await Dio().get("https://api.coincap.io/v2/assets");
    print(response.data);

    List<Crypto> cryptoList = response.data["data"]
        .map((MapJson) => Crypto.FromJson(MapJson))
        .toList()
        .cast<Crypto>();

    Navigator.of(context).push(
      MaterialPageRoute(builder: ((BuildContext context) => CryptoList(cryptoList: cryptoList,))),
    );
  }
}
