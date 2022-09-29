class CoinData {
  CoinData({
    required this.name,
    required this.imageurl,
    required this.price,
  });
  final String name;
  final String imageurl;
  final double price;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'imageurl': imageurl,
        'price': price,
      };
}
