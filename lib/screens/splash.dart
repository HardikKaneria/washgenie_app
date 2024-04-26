import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'prehome_screen.dart';
import 'models/user_data.dart'; // Adjust the import path as per your project structure

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider<UserData>(
//           create: (context) => UserData(),
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WashGenie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to HomeScreen after 5 seconds
    Future.delayed(Duration.zero, () {
      Provider.of<UserData>(context, listen: false).loadUserData().then((_) {
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Property1Variant4(), // Your custom splash screen layout
    );
  }
}

class Property1Variant4 extends StatelessWidget {
  const Property1Variant4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.01, 1.00),
              end: Alignment(0.01, -1),
              colors: [Color(0xFF15214B), Color(0xFF1C3AA4)],
            ),
          ),
          child: Stack(
            children: [
              Opacity(
                opacity: 0.50,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
                    // Ensure the blur effect is contained within the child
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6533,
                        height: MediaQuery.of(context).size.width * 0.6533,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF77FFC3),
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
                  child: SvgPicture.asset(
                    "assets/logo.svg", // Update the path if your file structure is different
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
