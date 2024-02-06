class Crypto {
  String? id;
  int? rank;
  String? symbol;
  String? name;
  double? volumeUsd24Hr;
  double? priceUsd;
  double? changePercent24Hr;

  Crypto({
    this.id,
    this.rank,
    this.symbol,
    this.name,
    this.volumeUsd24Hr,
    this.priceUsd,
    this.changePercent24Hr,
  });

  factory Crypto.FromJson(Map<String, dynamic> MapJson) {
    return Crypto(
        id: MapJson["id"],
        rank: int.parse(MapJson["rank"]),
        symbol: MapJson["symbol"],
        name: MapJson["name"],
        volumeUsd24Hr: double.parse(MapJson["volumeUsd24Hr"]),
        priceUsd: double.parse(MapJson["priceUsd"]),
        changePercent24Hr: double.parse(MapJson["priceUsd"]));
  }
}
