import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Database/coin_data_api.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:web3dart/web3dart.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';

import 'walletCreation/create_wallet_with_api.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;
  String seedcheck =
      'swear mind differ battle dolphin stay soldier filter fiber detail uncle decrease';
  List<String> units = ['btc', 'doge', 'bch', 'ltc'];
  List<String> wallets = [];
  List<String> transferKey = [];
  List<String> address = [];
  void initState() {
    // TODO: implement initState
    getValues();
  }

  ethWallet() async {
    Map<String, dynamic> temp = await WallletWithApi().createETherumWallet();
    print(temp);
  }

  createWallet() async {
    final Map<String, dynamic> wallet = await WallletWithApi().createWallet();
    print(wallet);
    wallets.add(wallet['btc_wallet']);
    wallets.add(wallet['doge_wallet']);
    wallets.add(wallet['bch_wallet']);
    wallets.add(wallet['ltc_wallet']);
    print(wallets.length);
    for (int i = 0; i < 4; i++) {
      //print(units[i] + ': ' + wallets[i]);
    }
    // for (int i = 0; i < 4; i++) {
    //   print(units[i] + ': ' + wallets[i]);
    // }
    final Map<String, dynamic> balance =
        await WallletWithApi().getWalletBalance(wallets);
    print(balance);
    wallets.clear();
  }

  void getValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");

    setState(() {});
  }

  walletAddress() async {
    String temp = bip39.generateMnemonic();
    final seed = bip39.mnemonicToSeed(temp);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.extractAddress();

    if (kDebugMode) {
      print('Seed:   $temp');
      print('Private key : $privateKey');
      print('address: $address');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto '),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                walletAddress();
              },
              child: Text('press')),
          ElevatedButton(
              onPressed: () {
                createWallet();
              },
              child: Text('apirone')),
          ElevatedButton(
              onPressed: () {
                ethWallet();
              },
              child: Text('Eth wallet')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text('Bitcoin'),
              Text(bitcoin.toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text('Etherum'),
              Text(ethereum.toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text('tether'),
              Text(tether.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
