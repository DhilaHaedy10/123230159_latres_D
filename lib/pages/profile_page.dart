import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = "";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Fungsi untuk mengambil data username dari Shared Preferences
  void _loadUsername() async {
    String? user = await StorageService().getUser();
    setState(() {
      _username = user ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 15),
          
          // Menampilkan nama user yang sedang login
          Text(
            _username, 
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          
          const Text("Latihan Responsi Gais", style: TextStyle(color: Colors.grey)),
          const Text("Bismillah Lancar", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 30),
          
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () async {
              await StorageService().logout();
              if (!mounted) return;
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (_) => LoginPage()), 
                (route) => false,
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}