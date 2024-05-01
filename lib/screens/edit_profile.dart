import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import 'dart:math' as math; // Import for using min function
import 'navbar.dart'; // Ensure this is correctly pointed to your navbar widget
import 'profile_screen.dart'; // Adjust the import path to your actual ProfileScreen

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Uint8List? _imageBytes;

  int _selectedIndex = 0; // For bottom navigation

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _nameController.text = prefs.getString('userName') ?? '';
    _phoneController.text = prefs.getString('userPhone') ?? '';
    _emailController.text = prefs.getString('userEmail') ?? '';
    String? base64Image = prefs.getString('userImage');
    if (base64Image != null) {
      setState(() {
        _imageBytes = base64Decode(base64Image);
      });
    }
  }

  Future<void> _updateUserData() async {
    final prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setString('userName', _nameController.text) &&
        await prefs.setString('userPhone', _phoneController.text) &&
        await prefs.setString('userEmail', _emailController.text);
    if (_imageBytes != null) {
      String base64Image = base64Encode(_imageBytes!);
      success = success && await prefs.setString('userImage', base64Image);
    }

    if (success) {
      await prefs.setBool('profileUpdated', true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ProfileScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update user data!')));
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      img.Image? originalImage = img.decodeImage(bytes);
      if (originalImage != null) {
        int cropSize = math.min(originalImage.width, originalImage.height);
        img.Image croppedImage = img.copyCrop(originalImage,
            x: 0, y: 0, width: cropSize, height: cropSize);
        img.Image resizedImage =
            img.copyResize(croppedImage, width: 146, height: 146);
        setState(() {
          _imageBytes = Uint8List.fromList(img.encodeJpg(resizedImage));
        });
        // Log message when new image is stored
        print('New image stored in SharedPreferences');
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFF203066),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF77FFC3)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFF77FFC3)),
            onPressed: () => print('Notifications Pressed'),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.01, 1.00),
            end: Alignment(0.01, -1.00),
            colors: [Color(0xFF15214B), Color(0xFF1C3AA4)],
          ),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: const Color(0xFF77FFC3),
                child: Stack(
                  children: [
                    if (_imageBytes != null)
                      ClipOval(
                        child: Image.memory(_imageBytes!, fit: BoxFit.cover),
                      ),
                    if (_imageBytes == null)
                      Image.asset(
                        'assets/default_user_image.png',
                        fit: BoxFit.cover,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
                child: Text('Change Profile Picture',
                    style: TextStyle(color: Color(0xFFE8EDFF), fontSize: 12))),
            const SizedBox(height: 30),
            _buildTextField(_nameController, 'Full Name'),
            const SizedBox(height: 20), // Increased the gap here
            _buildTextField(_phoneController, 'Phone Number'),
            const SizedBox(height: 20), // Increased the gap here
            _buildTextField(_emailController, 'Email ID'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  _updateUserData, // This triggers data update and navigation
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF77FFC3),
                  foregroundColor: const Color(0xFF203066),
                  minimumSize: const Size(double.infinity, 50)),
              child: const Text(
                'Update your Profile',
                style: TextStyle(
                  color: Color(0xFF203066),
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
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
      ), // Your custom NavBar
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF77FFC3)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF77FFC3)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
