import 'package:flutter/material.dart';
import 'package:matris_yayinlari/test_page/soru_goster_page.dart';

class TestSorulariSayfasi extends StatefulWidget {
  final List<dynamic> sorular;
  final dynamic test;

  const TestSorulariSayfasi(
      {super.key, required this.sorular, required this.test});

  @override
  State<TestSorulariSayfasi> createState() => _TestSorulariSayfasiState();
}

class _TestSorulariSayfasiState extends State<TestSorulariSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.test['title']),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: widget.sorular.length,
                  itemBuilder: (context, index) {
                    final soru = widget.sorular[index];
                    return ListTile(
                      trailing: const Icon(
                        Icons.not_started,
                        color: Colors.deepPurple,
                        size: 30,
                      ),
                      title: Text(
                        soru['title'],
                        style: const TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SoruDetaySayfasi(
                              soru: soru,
                              sorular: widget.sorular,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
