import 'package:flutter/material.dart';

class Sabitler {
  static const Color matrisRenk = Color.fromARGB(255, 185, 174, 80);
  static const String matrisText = '   MATRİS\nYAYINLARI';
  static const String qrText = 'QR OKUT';
  static const TextStyle matrisStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: matrisRenk);
  static const TextStyle listStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.black);

  static const Color backgroundColor = Color.fromRGBO(1, 110, 190, 223);
  static final ButtonStyle qrbutonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(160, 70),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: const Color.fromARGB(255, 56, 210, 140));
  static final ButtonStyle kodButonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(80, 58),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: const Color.fromARGB(255, 56, 210, 140));
  static const TextStyle kodButonTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  static const TextStyle butonTextStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white);
  static const String svr = 'Svr ';
  static const String soft = 'Soft';
  static const TextStyle svrStyle = TextStyle(
      color: Colors.deepPurple,
      fontSize: 20,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.italic);
  static const TextStyle softStyle = TextStyle(
      color: Colors.deepPurple,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal);
  static const TextStyle textFieldStyle =
      TextStyle(color: Colors.deepPurple, fontSize: 16);
}
