import 'package:flutter/material.dart';

import 'Database/coin_data_api.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;
  void initState() {
    // TODO: implement initState
    getValues();
  }

  void getValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto '),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
