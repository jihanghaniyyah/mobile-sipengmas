import 'package:flutter/material.dart';
import 'package:pengabdianmasyarakat/ui/pages/dashboard_page.dart';
import 'package:pengabdianmasyarakat/ui/pages/data_mandiri.dart';
import 'package:pengabdianmasyarakat/ui/pages/data_programstudidetail.dart';
import 'package:pengabdianmasyarakat/ui/pages/data_researchcenter.dart';
import 'package:pengabdianmasyarakat/ui/pages/data_researchgroup.dart';
import 'package:pengabdianmasyarakat/ui/pages/data_penawaranjudul.dart';
import 'package:pengabdianmasyarakat/ui/pages/data_pengmasuser.dart';
import 'package:pengabdianmasyarakat/ui/pages/login_page.dart';
import 'package:pengabdianmasyarakat/ui/pages/read_data_researchcenter.dart';
import 'package:pengabdianmasyarakat/ui/pages/read_data_researchgroup.dart';
import 'package:pengabdianmasyarakat/ui/pages/read_data_penawaranjudul.dart';
import 'package:pengabdianmasyarakat/ui/pages/register_page.dart';
import 'package:pengabdianmasyarakat/ui/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
      routes: {
        '/splash': (context) => SplashScreenPage(),
        '/log-in': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/dashboard': (context) => DashboardPage(),
        '/d-progstud': (context) => ProgramStudiDetailPage(),
        '/d-rc': (context) => ResearchCenterPage(),
        '/d-rg': (context) => ResearchGroupPage(),
        '/d-md' :(context) => MandiriPage(),
        '/d-pj': (context) => PenawaranJudulPage(),
        '/d-du': (context) => PengmasUserPage(),
        // '/rd-progstud': (context) => ReadDataProgramStudiPage(),
        '/rd-rc': (context) => ReadDataResearchCenterPage(),
        '/rd-rg': (context) => ReadDataResearchGroupPage(),
        '/rd-pj': (context) => ReadDataPenawaranJudulPage(),
      },
    );
  }
}
