import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washgenie_app/screens/models/user_data.dart'; // Adjust the import path to your UserData model
import 'package:washgenie_app/screens/navbar.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  int _selectedIndex = 0; // Initialize selected index
  String? userName;
  @override
  void initState() {
    super.initState();
    // Load user data when the profile screen is initialized
    Provider.of<UserData>(context, listen: false).loadUserData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Here, you would also handle navigation or page updating
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: const Color(0xFF203066),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF77FFC3)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.01, 1.00),
            end: Alignment(0.01, -1.00),
            colors: [Color(0xFF15214B), Color(0xFF1C3AA4)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF77FFC3), width: 4),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: userData.userProfileImage != null
                        ? MemoryImage(userData.userProfileImage!)
                            as ImageProvider<Object>
                        : const AssetImage('assets/default_user_image.png')
                            as ImageProvider<Object>,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            _buildDetailItem('Name:', userData.userName ?? ''),
            _buildDetailItem('Phone:', userData.userPhone ?? ''),
            _buildDetailItem('Email:', userData.userEmail ?? ''),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF77FFC3),
                  foregroundColor: const Color(0xFF203066),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text(
                  'Edit Your Profile',
                  style: TextStyle(
                    color: Color(0xFF203066),
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
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
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 20)),
          const SizedBox(width: 20),
          Expanded(
              child: Text(value,
                  style:
                      const TextStyle(color: Color(0xFF77FFC3), fontSize: 20))),
        ],
      ),
    );
  }
}
