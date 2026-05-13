import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 20),
          const Text("Tugas Latihan Responsi", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await StorageService().logout();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginPage()), (r) => false);
            },
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}