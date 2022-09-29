import 'package:flutter/material.dart';
import 'package:bip39/bip39.dart' as bip39;

// abstract class WalletAddressServivce {
//   String generateMenomonic();
// }

class WalletAddress  {
  String generateMenomonic() {
    return bip39.generateMnemonic();
  }
}
