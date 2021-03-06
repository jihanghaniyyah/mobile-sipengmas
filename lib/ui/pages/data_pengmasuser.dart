import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:pengabdianmasyarakat/shared/theme.dart';
import 'package:pengabdianmasyarakat/ui/widgets/custom_app_bar.dart';
import 'package:pengabdianmasyarakat/ui/widgets/custom_card.dart';
import 'package:pengabdianmasyarakat/ui/widgets/custom_drawer.dart';

class PengmasUserPage extends StatefulWidget {
  const PengmasUserPage({Key? key}) : super(key: key);

  @override
  State<PengmasUserPage> createState() => _PengmasUserPageState();
}

class _PengmasUserPageState extends State<PengmasUserPage> {
  String searchString = "";
  TextEditingController searchController = TextEditingController();

  Future viewDataPengmasbyUser() async {
    var nomor = await SessionManager().get('nomor');

    var url = Uri.https(
        'project.mis.pens.ac.id',
        '/mis116/sipengmas/api/datapengmasuser.php/',
        {'function': 'showDataPengmasbyUser', 'nomor': nomor.toString()});

    var response = await http.get(url);
    var jsonData = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonData['data'] == null) {
        return [];
      } else {
        return jsonData["data"];
      }
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
                      'Data Pengmas Saya',
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
                      constraints:
                          const BoxConstraints(maxHeight: double.infinity),
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
                                hintText: "Masukkan Judul Pengmas",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          FutureBuilder<dynamic>(
                            future: viewDataPengmasbyUser(),
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
                                  constraints: const BoxConstraints(
                                      maxHeight: double.infinity),
                                  child: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (BuildContext context, index) {
                                      var isDataEmpty = snapshot.data == null;

                                      if (isDataEmpty) {
                                        return Container();
                                      } else {
                                        return snapshot.data[index]["JUDUL"]
                                                .contains(searchString)
                                            ? CustomBar(
                                                event:
                                                    '${snapshot.data[index]["JUDUL"]}',
                                                name:
                                                    '${snapshot.data[index]["KATEGORI"]}',
                                                major:
                                                    '${snapshot.data[index]["NAMA"]}',
                                                pusatriset:
                                                    '${snapshot.data[index]["NAMA_PEGAWAI"]}',
                                                onPressed: () {})
                                            : Container();
                                      }
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
