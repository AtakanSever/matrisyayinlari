import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matris_yayinlari/constants/app_constants.dart';
import 'package:matris_yayinlari/context_mediaquery.dart';
import 'package:matris_yayinlari/qr_page/qr_page.dart';
import 'package:matris_yayinlari/test_page/konular_page.dart';
import 'package:matris_yayinlari/test_page/test_sorulari_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> kitaplarJson = [];
  List<Map<String, dynamic>> filteredKitaplarJson = [];
  final _controller = TextEditingController();
  final _controllerKod = TextEditingController();

  Future<void> readJsonKitaplar() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/data.json');
      final data = await json.decode(response);

      if (data != null && data.containsKey("kitaplar")) {
        final kitaplarList = data["kitaplar"] as List<dynamic>;

        setState(() {
          kitaplarJson = kitaplarList.map((kitap) {
            final kitapAdi = kitap["kitapAdi"].toString();
            final konular = kitap["content"] as List<dynamic>;
            return {
              "kitapAdi": kitapAdi,
              "konular": konular,
            };
          }).toList();
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
    _controller.addListener(() {
      filtreliKitaplar(_controller.text);
    });
    super.initState();
  }

  void filtreliKitaplar(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredKitaplarJson = List.from(kitaplarJson);
      } else {
        filteredKitaplarJson = kitaplarJson.where((kitap) {
          final kitapAdi = kitap['kitapAdi'].toString().toLowerCase();
          return kitapAdi.contains(searchText.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.amber, Colors.white],
              stops: [0.3, 0.7],
            ),
          ),
          child: SafeArea(
              child: Center(
            child: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: context.dynamicHeight(0.01),
                          left: context.dynamicWidth(0.014)),
                      child: Image.asset(
                        'images/matris.png',
                        height: context.dynamicHeight(0.165),
                        width: context.dynamicWidth(0.400),
                      ),
                    ),
                    SizedBox(height: context.dynamicHeight(0.030)),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: context.dynamicWidth(0.036)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 6.0,
                            )
                          ]),
                      height: context.dynamicHeight(0.4),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: TextField(
                                    onChanged: filtreliKitaplar,
                                    decoration: InputDecoration(
                                        hintText: 'Aramaya Başla',
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400),
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          size: 36,
                                          color: Colors.deepPurple,
                                        )),
                                  )),
                            ],
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemCount: _controller.text.isEmpty
                                  ? kitaplarJson.length
                                  : filteredKitaplarJson.length,
                              itemBuilder: (context, index) {
                                final kitap = _controller.text.isEmpty
                                    ? kitaplarJson[index]
                                    : filteredKitaplarJson[index];
                                final kitapAdi = kitap["kitapAdi"].toString();
                                final konular =
                                    kitap['konular'] as List<dynamic>;
                                return ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 18,
                                    color: Colors.deepPurple.shade200,
                                  ),
                                  title: Text(
                                    kitapAdi,
                                    style: Sabitler.listStyle,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          transitionDuration:
                                              const Duration(milliseconds: 300),
                                          transitionsBuilder: (context,
                                              animation, animationTime, child) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                          pageBuilder: (context, animation,
                                              animationTime) {
                                            return KonularSayfasi(
                                              konular: konular,
                                            );
                                          }),
                                    );
                                  },
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                  height: context.dynamicHeight(0.016),
                                  thickness: 0.6,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: context.dynamicHeight(0.046),
                      thickness: 1.4,
                      indent: 20.0,
                      endIndent: 20.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: context.dynamicWidth(0.460),
                              child: TextField(
                                controller: _controllerKod,
                                maxLength: 7,
                                keyboardType: TextInputType.number,
                                style: Sabitler.textFieldStyle,
                                decoration: InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    labelText: 'Test Kodu Yaz',
                                    labelStyle: TextStyle(
                                        color: Colors.green.shade300,
                                        fontSize: 13),
                                    prefixIcon: const Icon(
                                      Icons.password_outlined,
                                      size: 26,
                                      color: Colors.deepPurple,
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: context.dynamicWidth(0.03),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                testKoduBul(_controllerKod.text);
                              },
                              style: Sabitler.kodButonStyle,
                              child: const Text(
                                'Teste Git',
                                style: Sabitler.kodButonTextStyle,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: context.dynamicHeight(0.030)),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const QRPage())));
                          },
                          style: Sabitler.qrbutonStyle,
                          child: const Text(
                            'QR OKUT',
                            style: Sabitler.butonTextStyle,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: context.dynamicHeight(0.054),
                      thickness: 1.4,
                      indent: 90.0,
                      endIndent: 90.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Sabitler.svr,
                          style: Sabitler.svrStyle,
                        ),
                        Text(
                          Sabitler.soft,
                          style: Sabitler.softStyle,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  void testKoduBul(String text) {
    bool testKoduBulundu = false;

    for (int i = 0; i < kitaplarJson.length; i++) {
      for (int j = 0; j < kitaplarJson[i]['konular'].length; j++) {
        for (int k = 0;
            k < kitaplarJson[i]['konular'][j]['konular'].length;
            k++) {
          dynamic test = kitaplarJson[i]['konular'][j]['konular'][k];
          if (test['code'] == text) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TestSorulariSayfasi(
                  sorular: test['sorular'],
                  test: test,
                ),
              ),
            );
            testKoduBulundu = true;
            break;
          }
        }
        if (testKoduBulundu) {
          break;
        }
      }
      if (testKoduBulundu) {
        break;
      }
    }

    if (!testKoduBulundu) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Hata'),
            content: const Text('Girilen test kodu bulunamadı.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }
}
