import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  getPrice() async {
    try {
      String temp;
      String url = 'https://api.coingecko.com/api/v3/coins';
      var response = await http.get(Uri.parse(url));
      var json = jsonDecode(response.body);
      print(json.length);
      for (int i = 0; i < json.length; i++) {
        print(json[i]['name'] +
            '  ' +
            json[i]['symbol'] +
            '  ' +
            json[i]['market_data']['current_price']['usd'].toString()
            + '  ' + json[i]['symbol']);
      }
      //temp = json.toString();

      //var value = json['market_data']['current_price']['usd'].toString();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  getPrice();
                },
                child: Text('Pressed')),
          ],
        ),
      ),
    );
  }
}
