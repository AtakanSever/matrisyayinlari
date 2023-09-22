import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonVeriCek extends StatefulWidget {
  const JsonVeriCek({super.key});

  @override
  State<JsonVeriCek> createState() => _JsonVeriCekState();
}

class _JsonVeriCekState extends State<JsonVeriCek> {
  List kitaplarJson = [];

  Future<void> readJsonKitaplar() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/data.json');
      final data = await json.decode(response);

      if (data != null && data.containsKey("kitaplar")) {
        final kitaplarList = data["kitaplar"];

        setState(() {
          kitaplarJson = kitaplarList;
          debugPrint('Number of items: ${kitaplarJson.length}');
        });
      } else {
        debugPrint('JSON format is not valid or "kitaplar" is missing.');
      }
    } catch (e) {
      debugPrint('Error while reading JSON: $e');
    }
  }

  @override
  void initState() {
    readJsonKitaplar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
