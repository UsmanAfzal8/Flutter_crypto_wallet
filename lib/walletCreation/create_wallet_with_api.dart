import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WallletWithApi {
  static String myWalletId = '';
  static String url = 'https://apirone.com/api/v2/wallets';
  List<String> units = ['btc', 'doge', 'bch', 'ltc'];

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
  };
  Future<Map<String, dynamic>> createWallet() async {
    final Map<String, dynamic> encryptedAddMap = {};
    String? endpointUrl = dotenv.env['ENDPOINT_URL'];
    for (String un in units) {
      Map<String, dynamic> body = {
        'type': 'saving',
        'currency': un,
        'callback': {
          'url': 'ENDPOINT_URL notifications-wallet.php',
        }
      };
      try {
        print('Enter ho giya');
        await http
            .post(Uri.parse(url),
                headers: requestHeaders, body: jsonEncode(body))
            .then((http.Response value) async {
          if (value.statusCode == 200) {
            var body = jsonDecode(value.body);
            print('hh');
            print(body);
            String walletId = body['wallet'];
            String transferKey = body['transfer_key'];
            String encryptedWalletId = (walletId);
            String encryptedTrxKey = (transferKey);

            try {
              http.Response? addressResponse = await http
                  .post(
                Uri.parse('$url/$walletId/addresses'),
                headers: requestHeaders,
              )
                  .then((http.Response value) {
                if (value.statusCode == 200) {
                  var body = jsonDecode(value.body);
                  String address = body['address'];
                  String encryptedAddress = (address);

                  Map<String, dynamic> encryptedWalletData = {
                    '${un}_transfer_key': encryptedTrxKey,
                    '${un}_wallet': encryptedWalletId,
                    '${un}_address': encryptedAddress,
                  };
                  encryptedAddMap.addAll(encryptedWalletData);
                } else {
                  print('error');
                }
              }).timeout(
                const Duration(seconds: 60),
              );
              return addressResponse;
            } catch (e) {
              print(e);
            }
          }
        }).timeout(
          const Duration(seconds: 60),
        );
      } catch (e) {
        print(e);
      }
    }

    return encryptedAddMap;
  }
}
