import "package:cripto_bazar/data/models.dart";
import "package:flutter/material.dart";

import "../data/constant/constans.dart";

// ignore: must_be_immutable
class CryptoList extends StatefulWidget {
  @override
  State<CryptoList> createState() => _CryptoListState();
  List<Crypto>? cryptoList;
  CryptoList({this.cryptoList});
}

class _CryptoListState extends State<CryptoList> {
  List<Crypto>? cryptoList;

  void initState() {
    super.initState();

    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: ListView.builder(
              itemCount: cryptoList!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    cryptoList![index].name!,
                    style: TextStyle(color: greenColor),
                  ),
                  subtitle: Text(
                    cryptoList![index].symbol!,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Text(
                    cryptoList![index].rank!.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  trailing: SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cryptoList![index].priceUsd!.toStringAsFixed(2),
                                style: TextStyle(color: Colors.white,fontSize: 15),
                              ),
                              Text(
                                cryptoList![index]
                                    .changePercent24Hr!
                                    .toStringAsFixed(2),
                                style: TextStyle(
                                  color: _getColor(
                                      cryptoList![index].changePercent24Hr!),
                                      fontSize: 13,
                                ),
                              ),
                            ]),
                        Icon(
                          Icons.trending_up,
                          color:
                              _getColor(cryptoList![index].changePercent24Hr!),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }

  Color _getColor(double changePercent24Hr) {
    if (changePercent24Hr >= 0) {
      return greenColor;
    } else {
      return redColor;
    }
  }
}
