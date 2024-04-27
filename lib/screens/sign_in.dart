import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import
import 'package:washgenie_app/screens/splash.dart';
import 'home_screen.dart';
// ignore: unused_import
import 'models/user_data.dart';

void main() {
  runApp(const SignInScreen());
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: const LogIn(),
          ),
        ),
      ),
    );
  }
}

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _userPhoneController = TextEditingController();
  bool _isuserPhoneValid = false;
  bool _attemptedValidation = false;

  // Define method to store phone number
  Future<void> storePhoneNumber(String phoneNumber) async {
    // Implement your logic to store the phone number, for example, using SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userPhone', phoneNumber);
  }

  // Define method to retrieve stored phone number
  Future<String> getStoredPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userPhone') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight,
      padding: EdgeInsets.only(
        top: screenHeight * 0.23,
        bottom: screenHeight * 0.23,
        left: screenWidth * 0.05,
        right: screenWidth * 0.05,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF15214B), Color(0xFF1C3AA4)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/Logo1.png',
            width: screenWidth * 0.5,
            height: screenHeight * 0.1,
            fit: BoxFit.contain,
          ),
          SizedBox(height: screenHeight * 0.05),
          const Text(
            'Welcome to WashGenie!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF77FFC3),
              fontSize: 24,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          const Text(
            'Access your WashGenie account and continue your eco-friendly car care journey.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFE8EDFF),
              fontSize: 16,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
          SizedBox(
            width: screenWidth * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _userPhoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(
                      color: _attemptedValidation && !_isuserPhoneValid
                          ? const Color(0xFFFF4949)
                          : const Color(0xFF77FFC3),
                      fontSize: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _attemptedValidation && !_isuserPhoneValid
                            ? const Color(0xFFFF4949)
                            : const Color(0xFF77FFC3),
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(11.25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _attemptedValidation && !_isuserPhoneValid
                            ? const Color(0xFFFF4949)
                            : const Color(0xFF77FFC3),
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(11.25),
                    ),
                  ),
                  style: const TextStyle(
                    color: Color(0xFF77FFC3),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isuserPhoneValid = value.length == 10;
                    });
                  },
                ),
                SizedBox(height: screenHeight * 0.05),
                MaterialButton(
                  color: const Color(0xFF77FFC3),
                  minWidth: double.infinity,
                  height: screenHeight * 0.07,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF203066),
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () async {
                    final userPhone = _userPhoneController.text;
                    if (kDebugMode) {
                      print('User phone number: $userPhone');
                    } // Debug print to check user phone number

                    // Attempt to store the phone number
                    await storePhoneNumber(userPhone);
                    if (kDebugMode) {
                      print('Phone number stored in SharedPreferences');
                    }

                    setState(() {
                      _attemptedValidation = true;
                    });

                    // Check if phone number is stored in SharedPreferences
                    final storedPhoneNumber = await getStoredPhoneNumber();
                    if (storedPhoneNumber.isNotEmpty) {
                      if (kDebugMode) {
                        print('Phone number stored: $storedPhoneNumber');
                      }
                    } else {
                      if (kDebugMode) {
                        print('Phone number not stored');
                      }
                    }

                    if (userPhone.length == 10) {
                      // Implement your login logic here using userPhone
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return const MainContainer();
                        },
                      );
                    } else {
                      // Optionally handle incorrect phone number entry
                      if (kDebugMode) {
                        print('Please enter a valid 10-digit phone number.');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  final TextEditingController _otpController = TextEditingController();
  String _otp = '';
  bool _isOTPValid = false;
  Future<bool> validateOTP(String otp) async {
    // Assume this method checks the OTP validity and returns true if valid, otherwise false.
    // This could involve a network request or a local check depending on your implementation.
    return otp == "123456"; // Example condition
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingWidth = screenWidth > 360 ? (screenWidth - 328) / 2 : 16;

    return DraggableScrollableSheet(
      expand: false,
      maxChildSize:
          0.5, // Limits the draggable sheet to 50% of the screen height
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF15214B), Color(0xFF1C3AA4)],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome, {{First_Name}}!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF77FFC3),
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Enter your 6 digit OTP number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFE8EDFF),
                      fontSize: 16,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Enter OTP',
                      hintStyle: const TextStyle(color: Colors.white54),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: _isOTPValid
                                ? const Color(0xFF77FFC3)
                                : Colors.red),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _otp = value;
                      });
                    },
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_otp.length == 6) {
                        // Implement your OTP validation logic here
                        if (kDebugMode) {
                          print('OTP entered: $_otp');
                        }
                        // Call a function to verify the OTP here, for now, assume it's valid
                        setState(() {
                          _isOTPValid = true; // Update OTP validation state
                        });
                        if (_isOTPValid) {
                          // Navigate to the HomeScreen if the OTP is valid
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MyCustomScreen()), // Ensure HomeScreen is a valid widget
                          );
                        }
                      } else {
                        // Optionally handle incorrect OTP entry
                        if (kDebugMode) {
                          print('Please enter a valid 6-digit OTP.');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF77FFC3),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Submit OTP',
                      style: TextStyle(
                        color: Color(0xFF203066),
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
