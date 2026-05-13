import 'package:flutter/material.dart';
import '../shared.dart';
import '../services/storage_service.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final String myNIM = "123230159"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Icon(Icons.shopping_bag_outlined, size: 80, color: AppTheme.primary),
              const SizedBox(height: 10),
              Text("Toko Awikwak", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.primary)),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: AppTheme.cardDeco, // Memanggil dari shared.dart
                child: Column(
                  children: [
                    TextField(controller: userCtrl, decoration: const InputDecoration(labelText: 'Username', prefixIcon: Icon(Icons.person))),
                    const SizedBox(height: 15),
                    TextField(controller: passCtrl, decoration: const InputDecoration(labelText: 'Password (NIM)', prefixIcon: Icon(Icons.lock)), obscureText: true),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity, height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        onPressed: () async {
                          if (passCtrl.text == myNIM) {
                            await StorageService().saveUser(userCtrl.text);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password harus NIM!'), backgroundColor: Colors.red));
                          }
                        },
                        child: const Text("LOGIN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}