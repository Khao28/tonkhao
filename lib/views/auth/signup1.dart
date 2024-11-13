import 'package:flutter/material.dart';
import 'signup2.dart';

class SignUp1 extends StatelessWidget {
  const SignUp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // ปรับขนาดคอลัมน์ให้เท่าที่จำเป็น
          children: [
            const SizedBox(height: 20), // เพิ่มช่องว่างจาก AppBar
            Image.asset('assets/images/Logo.png', width: 100, height: 100), // โลโก้
            const SizedBox(height: 20), // ลดช่องว่างระหว่างโลโก้และข้อความ
            const Text(
              "Let's Create",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5), // ลดระยะห่างระหว่างหัวข้อและข้อความอธิบาย
            const Text('Provide us a bit about you'),
            const SizedBox(height: 20), // ลดช่องว่างระหว่างข้อความกับฟอร์มกรอกข้อมูล
            // ช่องกรอกชื่อ
            TextField(
              decoration: InputDecoration(
                labelText: 'First name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // ปรับโค้งมากขึ้น
                ),
              ),
            ),
            const SizedBox(height: 20), // ลดช่องว่างระหว่างช่องกรอกข้อมูล
            // ช่องกรอกนามสกุล
            TextField(
              decoration: InputDecoration(
                labelText: 'Last name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // ปรับโค้งมากขึ้น
                ),
              ),
            ),
            const SizedBox(height: 20), // ลดช่องว่างระหว่างฟอร์มกรอกข้อมูลกับปุ่ม
            // ปุ่ม Continue
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp2()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 140, 204, 68), // สีปุ่ม
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50), // เพิ่มขนาดปุ่ม
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
