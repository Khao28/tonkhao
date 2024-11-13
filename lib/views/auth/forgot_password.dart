import 'package:flutter/material.dart';
import '../../widgets/login_screen.dart';
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/Logo.png', width: 100, height: 100),
            const SizedBox(height: 20),
            const Text(
              'Forgot Password?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter your email account to reset password',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // กดปุ่ม Continue ให้แสดง dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildCheckEmailDialog(context);
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  // สร้าง Dialog แจ้งให้ตรวจสอบอีเมล
  Widget _buildCheckEmailDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.email, size: 50, color: Colors.black),
          const SizedBox(height: 10),
          const Text(
            'Check your email',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'We have sent password recovery instructions to your email',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // ใช้ pushAndRemoveUntil เพื่อกลับไปหน้า LoginScreen
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false, // ปิด stack ทั้งหมด
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightGreen,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: const Text('Back to Login'),
          ),
        ],
      ),
    );
  }
}
