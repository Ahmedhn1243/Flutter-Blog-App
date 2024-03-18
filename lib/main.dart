import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Pages/LoadingPage.dart';
import 'Pages/WelcomePage.dart';
import 'Pages/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  Widget page = LoadingPage();
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    try {
      String token = await storage.read(key: "token");
      if (token != null) {
        setState(() {
          page = HomePage();
        });
      } else {
        setState(() {
          page = WelcomePage();
        });
      }
    } catch (e) {
      print("Error occurred: $e");
      setState(() {
        page = WelcomePage(); // Navigate to welcome page in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return page;
  }
}


