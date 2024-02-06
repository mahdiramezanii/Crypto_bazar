import "package:cripto_bazar/data/models.dart";
import "package:dio/dio.dart";
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
  bool is_loading = false;

  void initState() {
    super.initState();

    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "کریپتو بازار",
          style: TextStyle(
            color: greenColor,
            fontFamily: "mr",
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  onChanged: (value) async {
                    SerachData(value);
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: greenColor,
                      hintText: "نام ارز مورد نظر خود را وارد کنید",
                      hintStyle: TextStyle(
                          color: Colors.black, fontFamily: "mr", fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                      )),
                  style: TextStyle(
                      color: Color.fromARGB(255, 26, 25, 25), fontFamily: "mr"),
                ),
              ),
            ),
            Visibility(
              visible: is_loading,
                child: Text(
              "... در حال بروز رسانی داده ها",
              style: TextStyle(color: Colors.green, fontFamily: "mr"),
            )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RefreshIndicator(
                  onRefresh: () async {
                    var data = await _getData();

                    setState(() {
                      cryptoList = data;
                    });
                  },
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
                                        cryptoList![index]
                                            .priceUsd!
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      Text(
                                        cryptoList![index]
                                            .changePercent24Hr!
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                          color: _getColor(cryptoList![index]
                                              .changePercent24Hr!),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ]),
                                Icon(
                                  Icons.trending_up,
                                  color: _getColor(
                                      cryptoList![index].changePercent24Hr!),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(double changePercent24Hr) {
    if (changePercent24Hr >= 0) {
      return greenColor;
    } else {
      return redColor;
    }
  }

  Future<List<Crypto>> _getData() async {
    var response = await Dio().get("https://api.coincap.io/v2/assets");
    print(response.data);

    List<Crypto> cryptoList = response.data["data"]
        .map((MapJson) => Crypto.FromJson(MapJson))
        .toList()
        .cast<Crypto>();

    return cryptoList;
  }

  Future<void> SerachData(String value) async {
    if (value.isEmpty) {

      setState(() {
        is_loading=true;
      });
      var result = await _getData();

      setState(() {
        cryptoList = result;
        is_loading=false;
      });
      return;
    }

    var my_list = cryptoList;

    var new_list = my_list!.where((element) {
      return element.name!.toLowerCase().contains(value.toLowerCase());
    }).toList();

    setState(() {
      cryptoList = new_list;
    });
  }
}
