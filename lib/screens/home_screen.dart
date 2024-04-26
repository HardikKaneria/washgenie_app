// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MyCustomScreen(),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class MyCustomScreen extends StatelessWidget {
  const MyCustomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (kDebugMode) {
      print("Screen width: $screenWidth, Screen height: $screenHeight");
    } // Debug print
    return Scaffold(
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
        child: const Stack(
          children: <Widget>[
            HomeBodyHeader(userName: "Hardik Kaneria"),
            Positioned(
              top: 300, // Adjust the top value as needed for your design
              left: 0,
              right: 0,
              child: HomeBody(),
            ),
          ],
        ),
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
                                      const AccountScreen(
                                userName: 'Hardik Kaneria',
                                userPhone: '9825871942',
                                userBalance: 1500,
                              ),
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
                              text: userName ?? 'Customer',
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
                                screenSize.width * 0.05, // responsive font size
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Service: ',
                            style: TextStyle(
                              color: const Color(
                                  0xFFE9EEFF), // Consistent color for the word "Service"
                              fontSize: screenSize.width *
                                  0.035, // Responsive font size
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: serviceActive ? 'Active' : 'Inactive',
                                style: TextStyle(
                                  color: serviceActive
                                      ? const Color(0xFF77FFC3)
                                      : const Color(
                                          0xFFFF4949), // Dynamically changing color
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

class AccountScreen extends StatelessWidget {
  final String userName;
  final String userPhone;
  final double userBalance;

  const AccountScreen({
    super.key,
    required this.userName,
    required this.userPhone,
    required this.userBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: const Text('Account'),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF203066), Color(0xFFD1D8ED)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account',
                    style: TextStyle(
                      color: Color(0xFF15214B),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Rubik',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 37,
                        backgroundImage:
                            NetworkImage("https://via.placeholder.com/74x74"),
                        backgroundColor: Color(0xFF203066),
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
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '₹${userBalance.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Color(0xFF27684B),
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const MenuTile(icon: Icons.location_on, title: 'Address'),
            const MenuTile(icon: Icons.directions_car, title: 'Vehicles'),
            const MenuTile(icon: Icons.book, title: 'Bookings'),
            const MenuTile(
                icon: Icons.account_balance_wallet, title: 'My Wallet'),
            const MenuTile(icon: Icons.person, title: 'Profile'),
            const MenuTile(icon: Icons.exit_to_app, title: 'Log out'),
          ],
        ),
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Set the height of the menu tile
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
        onTap: () {
          if (kDebugMode) {
            print('$title tile tapped');
          }
        },
      ),
    );
  }
}
