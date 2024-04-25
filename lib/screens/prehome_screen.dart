import 'package:flutter/material.dart';
import 'sign_in.dart'; // Replace 'sign_in.dart' with the actual path to your sign-in screen file

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        // ignore: deprecated_member_use
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      home: const Scaffold(
        body: PreStart(),
      ),
    );
  }
}

class PreStart extends StatelessWidget {
  const PreStart({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          color: Color(0xFFE9EEFF),
          image: DecorationImage(
            image: AssetImage(
              'assets/bg-prehome.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: screenHeight / 2 - screenHeight / 4,
                      child: Image.asset(
                        'assets/pre-home_img.png', // Replace 'your_image.png' with the actual image path
                        fit: BoxFit
                            .contain, // Adjust the fit property according to your image size
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                            height:
                                150), // Adjust the height based on your image size
                        Text(
                          'Welcome to WashGenie!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF1C3AA4),
                            fontSize: screenWidth * 0.064,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Discover the future of car care with our waterless wash service. Get a pristine vehicle anytime, anywhere, and help us keep the planet green.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF203066),
                            fontSize: screenWidth * 0.0427,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 16,
              right: 16,
              child: Container(
                height: screenHeight * 0.0616,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(1.00, 0.00),
                    end: Alignment(-1, 0),
                    colors: [Color(0xFF1C3AA4), Color(0xFF203066)],
                  ),
                  borderRadius: BorderRadius.circular(screenHeight * 0.0086),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const SignInScreen()), // Replace SignInScreen with the actual name of your sign-in screen widget
                    );
                  },
                  child: Center(
                    child: Text(
                      'Let\'s start',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFE8EDFF),
                        fontSize: screenWidth * 0.0373,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
