import 'dart:math';
import 'package:flutter/material.dart';
import '../../widgets/login_screen.dart'; // เข้าหน้า LoginScreen

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  List<int> otpCode = [0, 0, 0, 0]; // รหัส OTP เริ่มต้น

  // ฟังก์ชันสุ่มรหัส OTP
  void generateRandomOTP() {
    setState(() {
      otpCode = List<int>.generate(
          4, (index) => Random().nextInt(10)); // สุ่มตัวเลข 0-9 จำนวน 4 ตัว
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // รูปภาพโลโก้
            Image.asset(
              'assets/images/Logo.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Let\'s Create',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              'Provide us a bit about you',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: otpCode.map((digit) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$digit',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // ปุ่มส่ง OTP ใหม่
            TextButton(
              onPressed: generateRandomOTP,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Resend OTP',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // ปุ่มสร้างบัญชี
            ElevatedButton(
              onPressed: () {
                // นำทางไปยังหน้า LoginScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 140, 204, 68),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                'Create my Account',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
