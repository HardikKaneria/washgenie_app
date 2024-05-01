import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:washgenie_app/screens/navbar.dart';
import 'package:washgenie_app/screens/prehome_screen.dart';
import 'package:washgenie_app/screens/profile_screen.dart';
// import 'models/user_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyCustomScreen(),
    );
  }
}

class MyCustomScreen extends StatefulWidget {
  const MyCustomScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyCustomScreenState createState() => _MyCustomScreenState();
}

class _MyCustomScreenState extends State<MyCustomScreen> {
  int _selectedIndex = 0; // Initialize selected index
  String? userName;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Here, you would also handle navigation or page updating
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Unknown User';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (kDebugMode) {
      print("Screen width: $screenWidth, Screen height: $screenHeight");
    } // Debug print

    return Scaffold(
      backgroundColor: const Color(0xFF15214B),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.01, 1.00),
            end: Alignment(0.01, -1.00),
            colors: [Color(0xFF15214B), Color(0xFF1C3AA4)],
          ),
        ),
        child: Stack(
          children: <Widget>[
            HomeBodyHeader(userName: userName),
            Positioned(
              top: screenHeight * 0.3, // Use a fraction of screen height
              left: 0,
              right: 0,
              child: const HomeBody(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(
        backgroundColor: const Color(0xFF203066),
        icons: [
          NavBarIcon(
              builder: (context) => Image.asset('assets/home_icon.png'),
              label: 'Home'),
          NavBarIcon(
              builder: (context) => Image.asset('assets/booking_icon.png'),
              label: 'Booking'),
          NavBarIcon(
              builder: (context) => Image.asset('assets/wallet_icon.png'),
              label: 'Wallet'),
          NavBarIcon(
              builder: (context) => Image.asset('assets/support_icon.png'),
              label: 'Support'),
        ],
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}

class HomeBodyHeader extends StatelessWidget {
  final String? userName; // Accept a userName as an optional parameter

  const HomeBodyHeader({super.key, this.userName}); // Adjusted for null-safety

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight * 0.35, // Height of the container adjusted here
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/header_background.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: screenWidth,
          height: screenHeight * 0.35, // Adjusted to be responsive
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.01, 1.00),
              end: Alignment(0.01, -1),
              colors: [Color(0x001C3AA4), Color(0xFF1C3AA4)],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const AccountScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(-1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.easeInOut;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return Stack(
                                  children: [
                                    Positioned.fill(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 50 * secondaryAnimation.value,
                                          sigmaY: 50 * secondaryAnimation.value,
                                        ),
                                        child: Container(
                                            color: Colors.black.withOpacity(
                                                0.5 *
                                                    secondaryAnimation.value)),
                                      ),
                                    ),
                                    SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: 53,
                          height: 53,
                          decoration: const ShapeDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/default_user_image.png"),
                              fit: BoxFit.fill,
                            ),
                            shape: CircleBorder(
                              side: BorderSide(
                                  width: 2, color: Color(0xFF77FFC3)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 13),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Welcome,\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: userName,
                              style: const TextStyle(
                                color: Color(0xFFE8EDFF),
                                fontSize: 16,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications,
                        color: Color(0xFF77FFC3)),
                    onPressed: () {
                      if (kDebugMode) {
                        print("Notifications pressed");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool serviceActive = false; // Initial switch state

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check, color: Color(0xFF77FFC3));
        }
        return const Icon(Icons.close, color: Colors.white);
      },
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: screenSize.width, // use full screen width
            height: screenSize.height * 0.6, // relative height
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.04,
                vertical: screenSize.height * 0.02),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1C3AA4), Color(0xFF15214B)],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Washing Service',
                          style: TextStyle(
                            color: const Color(0xFF77FFC3),
                            fontSize:
                                screenSize.width * 0.06, // responsive font size
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Service : ',
                            style: TextStyle(
                              color: const Color(
                                  0xFFE9EEFF), // Consistent color for the word "Service"
                              fontSize: screenSize.width *
                                  0.04, // Responsive font size
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: serviceActive ? 'Active' : 'Inactive',
                                style: TextStyle(
                                  color: serviceActive
                                      ? const Color(0xFF59D6A0)
                                      : const Color(
                                          0xFFFF5448), // Dynamically changing color
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: serviceActive,
                      onChanged: (bool value) {
                        setState(() {
                          serviceActive = value;
                        });
                      },
                      thumbIcon: thumbIcon, // Custom property for thumb icon
                      thumbColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return const Color(0xFF203066); // On state
                          }
                          return const Color(0xFFFF4949); // Off state
                        },
                      ),
                      trackColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return const Color(0xFF77FFC3); // On state
                          }
                          return const Color(0xFFFFD4D4); // Off state
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.02), // responsive space
                GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      print('Banner tapped');
                    }
                  },
                  child: Container(
                    width: screenSize.width,
                    height: screenSize.height / 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                          "assets/booking_banner.png", // Update with your asset's path
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        width: 0.50,
                        color: const Color(0xFF77FFC3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(
                              0, 4), // Shadow direction: bottom right
                        )
                      ],
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Get Your Car Clean in\nEvery Morning',
                          style: TextStyle(
                            color: Color(0xFF77FFC3),
                            fontSize: 20,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Text(
                          'Book Now.....',
                          style: TextStyle(
                            color: Color(0xFF77FFC3),
                            fontSize: 20,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: screenSize.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (kDebugMode) {
                              print('Address clicked');
                            }
                          },
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(10),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF77FFC3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: const Icon(Icons.location_on,
                                      color: Color(0xFF203066)),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Address',
                                  style: TextStyle(
                                    color: Color(0xFFE8EDFF),
                                    fontSize: 12,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (kDebugMode) {
                              print('Vehicles clicked');
                            }
                          },
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(10),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF77FFC3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: const Icon(Icons.directions_car,
                                      color: Color(0xFF203066)),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Vehicles',
                                  style: TextStyle(
                                    color: Color(0xFFE8EDFF),
                                    fontSize: 12,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (kDebugMode) {
                              print('Get Report clicked');
                            }
                          },
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(10),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF77FFC3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: const Icon(Icons.insert_chart_outlined,
                                      color: Color(0xFF203066)),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Get Report',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFE8EDFF),
                                    fontSize: 12,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (kDebugMode) {
                              print('Booking History clicked');
                            }
                          },
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(10),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF77FFC3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: const Icon(Icons.history,
                                      color: Color(0xFF203066)),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Booking\nHistory',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFE8EDFF),
                                    fontSize: 12,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late String userName;
  late String userPhone;
  late double userBalance;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Unknown User';
      userPhone = prefs.getString('userPhone') ?? 'No Phone';
      userBalance = prefs.getDouble('userBalance') ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height, // Full screen height
        color: const Color(0xFFE9EEFF),
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerSection(context),
              const SizedBox(height: 20),
              menuSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, -3.50),
          end: Alignment(0, 2),
          colors: [Color(0xFF203066), Color(0xFFD1D8ED)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                icon: const Icon(Icons.arrow_back, color: Color(0xFF15214B)),
                onPressed: () => Navigator.pop(context),
              ),
              const Center(
                child: Text(
                  'Account',
                  style: TextStyle(
                    color: Color(0xFF15214B),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Rubik',
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          const SizedBox(height: 32),
          userInfoSection(),
        ],
      ),
    );
  }

  Widget userInfoSection() {
    return Row(
      children: [
        Container(
          width: 53,
          height: 53,
          decoration: const ShapeDecoration(
            image: DecorationImage(
              image: AssetImage("assets/default_user_image.png"),
              fit: BoxFit.fill,
            ),
            shape: CircleBorder(
              side: BorderSide(width: 2, color: Color(0xFF203066)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  color: Color(0xFF203066),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Rubik',
                ),
              ),
              Text(
                userPhone,
                style: const TextStyle(
                  color: Color(0xFF1C3AA4),
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '₹${userBalance.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Color(0xFF28684C),
                  fontSize: 14,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Widget menuSection(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  return Container(
    height: screenSize.height,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment(0.00, 2.00),
        end: Alignment(0, 3),
        colors: [Color(0xFFD1D8ED), Color(0xFF203066)],
      ),
    ),
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    child: Column(
      children: [
        MenuTile(
          icon: Icons.location_on,
          title: 'Address',
          onTap: () => handleMenuTap(context, 'Address'),
        ),
        MenuTile(
          icon: Icons.directions_car,
          title: 'Vehicles',
          onTap: () => handleMenuTap(context, 'Vehicles'),
        ),
        MenuTile(
          icon: Icons.book,
          title: 'Bookings',
          onTap: () => handleMenuTap(context, 'Bookings'),
        ),
        MenuTile(
          icon: Icons.account_balance_wallet,
          title: 'My Wallet',
          onTap: () => handleMenuTap(context, 'My Wallet'),
        ),
        MenuTile(
          icon: Icons.person,
          title: 'Profile',
          onTap: () => handleMenuTap(context, 'Profile'),
        ),
        MenuTile(
          icon: Icons.exit_to_app,
          title: 'Log out',
          onTap: () => handleMenuTap(context, 'Log out'),
        ),
      ],
    ),
  );
}

void handleMenuTap(BuildContext context, String menuItem) {
  if (kDebugMode) {
    print('$menuItem tapped');
  }
  // Here you can add navigation or other logic based on the tapped menu item
  switch (menuItem) {
    case 'Address':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AddressScreen()));
      break;
    case 'Vehicles':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const VehiclesScreen()));
      break;
    case 'Bookings':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const BookingsScreen()));
      break;
    case 'My Wallet':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const WalletScreen()));
      break;
    case 'Profile':
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      break;
    case 'Log out':
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      break;
    default:
      if (kDebugMode) {
        print('Unknown menu item');
      }
  }
}

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFF2E75E8)),
          title: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF231F20),
              fontSize: 18,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// Placeholder for other screens
class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Address')),
      body: const Center(child: Text('Address Screen')),
    );
  }
}

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vehicles')),
      body: const Center(child: Text('Vehicles Screen')),
    );
  }
}

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookings')),
      body: const Center(child: Text('Bookings Screen')),
    );
  }
}

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Wallet')),
      body: const Center(child: Text('Wallet Screen')),
    );
  }
}
