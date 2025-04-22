import 'package:flutter/material.dart';
import 'hide_message_screen.dart';
import 'reveal_message_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  Widget buildFeatureBox({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.deepPurple.shade100,
              child: Icon(icon, size: 30, color: Colors.deepPurple),
            ),
            const SizedBox(height: 12),
            Text(label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Welcome to Hide N Seek!',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This app lets you hide secret messages inside image metadata (EXIF) '
                      'and retrieve them later.\n\n'
                      'Use \"Hide Message\" to select an image and embed your secret.\n'
                      'Use \"Reveal Message\" to read the secret from any image.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              buildFeatureBox(
                icon: Icons.lock,
                label: 'Hide Message',
                onTap: () => navigateTo(context, const HideMessageScreen()),
              ),
              const SizedBox(height: 32),
              buildFeatureBox(
                icon: Icons.visibility,
                label: 'Reveal Message',
                onTap: () => navigateTo(context, const RevealMessageScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
