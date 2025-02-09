import 'package:flutter/material.dart';
import 'package:learnify/components/custom_text.dart';
import 'package:learnify/controllers/auth_controller.dart';
import 'package:learnify/screens/auth/signin_screen.dart';
import 'package:learnify/utils/custom_navigator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const RalewayText(
          text: "Profile",
          color: Colors.white,
          fWaight: FontWeight.bold,
          fontSize: 26,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    Image.asset('assets/icon/profileImage.png').image,
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: RalewayText(
                text: "Hello Buddy",
                color: Colors.black,
                fWaight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            _buildMenuItem(
              context,
              icon: Icons.help_outline_outlined,
              title: 'FAQ',
              onTap: () {},
            ),
            const SizedBox(height: 10),
            _buildMenuItem(
              context,
              icon: Icons.info_outline,
              title: 'About Us',
              onTap: () {},
            ),
            const SizedBox(height: 10),
            _buildMenuItem(
              context,
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {},
            ),
            const SizedBox(height: 10),
            _buildMenuItem(
              context,
              icon: Icons.logout_outlined,
              title: 'Log Out',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: const RalewayText(
                        text: 'Confirm Log Out',
                        color: Colors.black,
                        fontSize: 20,
                        fWaight: FontWeight.bold,
                      ),
                      content: const Text(
                        'Are you sure you want to log out?',
                        style: TextStyle(color: Colors.black),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.red),
                              ),
                              child: const Text('Cancel',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.teal),
                              ),
                              child: const Text('Log Out',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.of(context).pop();
                                AuthController().signOutUser(context);
                                CustomNavigator.replasement(context, const SignInPage());
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade100,
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.black),
          title: RalewayText(
            text: title,
            color: Colors.black,
            fontSize: 18,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.black,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
