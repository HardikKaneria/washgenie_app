import 'package:flutter/material.dart';
import 'package:washgenie_app/screens/models/user_data.dart';
import 'package:washgenie_app/screens/navbar.dart';
import 'screens/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserData>(
          create: (context) => UserData(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WashGenie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(), // First screen shown is SplashScreen
      // Add routes to navigate to other screens that contain your NavBar
      routes: {
        '/mainScreen': (context) => const MainScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Move the index to the state class

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigation or state updating logic can go here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Content for tab: $_selectedIndex'),
      ),
      bottomNavigationBar: NavBar(
        backgroundColor: const Color(0xFF203066),
        icons: [
          NavBarIcon(
              builder: (context) => Image.asset('assets/home_icon.png'),
              label: 'Home', onTap: () {  }),
          NavBarIcon(
              builder: (context) => Image.asset('assets/booking_icon.png'),
              label: 'Booking', onTap: () {  }),
          NavBarIcon(
              builder: (context) => Image.asset('assets/wallet_icon.png'),
              label: 'Wallet', onTap: () {  }),
          NavBarIcon(
              builder: (context) => Image.asset('assets/support_icon.png'),
              label: 'Support', onTap: () {  }),
        ],
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
