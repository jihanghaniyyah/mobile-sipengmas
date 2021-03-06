import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pengabdianmasyarakat/shared/theme.dart';
import 'package:pengabdianmasyarakat/ui/widgets/custom_app_bar.dart';
import 'package:pengabdianmasyarakat/ui/widgets/custom_card.dart';
import 'package:pengabdianmasyarakat/ui/widgets/custom_drawer.dart';

class PenawaranJudulPage extends StatefulWidget {
  const PenawaranJudulPage({Key? key}) : super(key: key);

  @override
  State<PenawaranJudulPage> createState() => _PenawaranJudulPageState();
}

class _PenawaranJudulPageState extends State<PenawaranJudulPage> {
  String searchString = "";
  TextEditingController searchController = TextEditingController();

  Future viewDataPenawaranJudul() async {
    var url = Uri.https('project.mis.pens.ac.id',
        '/mis116/sipengmas/api/penawaranjudul.php/', {'function': 'showJudul'});
    var response = await http.get(url);
    var jsonData = convert.jsonDecode(response.body);
    print(jsonData['data']);
    if (response.statusCode == 200) {
      return jsonData['data'];
    } else {
      print('Gagal');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(13, 13, 0, 13),
                    child: Text(
                      'Penawaran Judul Kegiatan Pengabdian Masyarakat',
                      textAlign: TextAlign.start,
                      style: purpleTextStyle.copyWith(
                        fontFamily: 'Poppins',
                        fontWeight: semibold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Container(
                      width: double.infinity,
                      height: 885,
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  searchString = value;
                                });
                              },
                              controller: searchController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: "Masukkan Judul Penawaran",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          FutureBuilder<dynamic>(
                            future: viewDataPenawaranJudul(),
                            builder: (context, snapshot) {
                              if (snapshot.error != null) {
                                return Text(
                                  "${snapshot.error}",
                                  style: const TextStyle(fontSize: 20),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: const CircularProgressIndicator());
                              } else {
                                return Container(
                                  child: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return snapshot.data[index]
                                                  ["JUDUL_PENAWARAN"]
                                              .contains(searchString)
                                          ? CustomBar(
                                              event:
                                                  '${snapshot.data[index]["JUDUL_PENAWARAN"]}',
                                              name:
                                                  '${snapshot.data[index]["KATEGORI"]}',
                                              major:
                                                  '${snapshot.data[index]["KETENTUAN"]}',
                                              pusatriset:
                                                  '${snapshot.data[index]["STATUS"]}',
                                              // date: '${snapshot.data[index]["TAHUN_PELAKSANAAN"]}',
                                              onPressed: () {})
                                          : Container();
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                  //   child: Text(
                  //     'Showing 1 to 10 of 6 entries',
                  //     style: TextStyle(
                  //       fontFamily: 'Poppins',
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
