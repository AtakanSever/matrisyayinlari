import 'package:flutter/material.dart';
import 'package:matris_yayinlari/context_mediaquery.dart';
import 'package:matris_yayinlari/test_page/konular_page.dart';
import 'package:matris_yayinlari/test_page/test_sorulari_page.dart';

import '../constants/app_constants.dart';

class KonuTestleriSayfasi extends StatefulWidget {
  final List<dynamic> testler;
  final List<dynamic> konular;

  const KonuTestleriSayfasi({
    required this.konular,
    required this.testler,
    super.key,
  });

  @override
  State<KonuTestleriSayfasi> createState() => _KonuTestleriSayfasiState();
}

class _KonuTestleriSayfasiState extends State<KonuTestleriSayfasi> {
  List<dynamic> filteredTestler = [];
  final TextEditingController _filterController = TextEditingController();

  @override
  void initState() {
    filteredTestler = widget.testler;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              child: Column(
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
                    height: context.dynamicHeight(0.650),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              transitionDuration: const Duration(
                                                  milliseconds: 200),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  animationTime,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                              pageBuilder: (context, animation,
                                                  animationTime) {
                                                return KonularSayfasi(
                                                  konular: widget.konular,
                                                );
                                              }));
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      size: 45,
                                      color: Colors.deepPurple,
                                    ))),
                            Expanded(
                                flex: 4,
                                child: TextField(
                                  controller: _filterController,
                                  onChanged: (value) {
                                    setState(() {
                                      filteredTestler =
                                          widget.testler.where((test) {
                                        return test['title']
                                            .toLowerCase()
                                            .contains(value.toLowerCase());
                                      }).toList();
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Aramaya Başla',
                                      hintStyle:
                                          TextStyle(color: Colors.grey.shade400),
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        size: 36,
                                        color: Colors.grey,
                                      )),
                                )),
                          ],
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: filteredTestler.length,
                            itemBuilder: (context, index) {
                              final test = filteredTestler[index];
                              final sorular = test['sorular'];
                              return ListTile(
                                trailing: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 18,
                                  color: Colors.deepPurple.shade200,
                                ),
                                title: Text(
                                  test['title'],
                                  style: Sabitler.listStyle,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TestSorulariSayfasi(
                                        sorular: sorular,
                                        test: test,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
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
                  SizedBox(height: context.dynamicHeight(0.018)),
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
            ),
          ),
        ),
      ),
    );
  }
}
