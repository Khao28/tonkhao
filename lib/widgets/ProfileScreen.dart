import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = 'Mariah J.'; // ตัวแปรเก็บชื่อผู้ใช้เริ่มต้น

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),

          // กล่องด้านบนที่มีไอคอนกลับและไอคอนแก้ไข
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color.fromARGB(255, 98, 255, 46), Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          // เปิดหน้าต่างแก้ไขเมื่อกดไอคอนดินสอ
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditProfileDialog(
                                currentUsername: _username,
                                onUsernameChanged: (newUsername) {
                                  setState(() {
                                    _username = newUsername; // อัปเดตชื่อผู้ใช้
                                  });
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // ชื่อและที่อยู่
          Text(
            _username,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Aaron Larson 123 Center Ln., Apartment\n34 Plymouth, MN 55441',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 116, 115, 115),
              fontSize: 16,
            ),
          ),
          const Spacer(),
          // ปุ่ม Logout
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: ElevatedButton(
              onPressed: () {
                // แสดง Alert Dialog เมื่อกดปุ่ม Logout
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LogoutDialog();
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfileDialog extends StatefulWidget {
  final String currentUsername; 
  final ValueChanged<String> onUsernameChanged;

  const EditProfileDialog({
    required this.currentUsername,
    required this.onUsernameChanged,
  });

  @override
  _EditProfileDialogState createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late String _username;
  bool _isPasswordVisible = false; // ตัวแปรควบคุมการแสดงรหัสผ่าน
  // ignore: unused_field
  String _password = ''; // ตัวแปรเก็บรหัสผ่านที่ป้อน
  String? _imagePath; // ตัวแปรเก็บเส้นทางของภาพ
  bool _isPasswordValid = false; // ตัวแปรเพื่อตรวจสอบความถูกต้องของรหัสผ่าน

  // ฟังก์ชันเพื่อเลือกภาพจากแกลเลอรี
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path; // อัปเดตเส้นทางภาพ
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _username = widget.currentUsername; // กำหนดชื่อผู้ใช้เริ่มต้น
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.black,
                  backgroundImage:
                      _imagePath != null ? FileImage(File(_imagePath!)) : null,
                  child: _imagePath == null
                      ? const Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(2.5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 98, 255, 46),
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 10),
            const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 20),
            // ช่องกรอก Username
            TextField(
              controller: TextEditingController(text: _username),
              onChanged: (value) {
                _username = value; // อัปเดตชื่อผู้ใช้
              },
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // ช่องกรอกรหัสผ่าน
            TextField(
              obscureText: !_isPasswordVisible,
              onChanged: (value) {
                _password = value; // อัปเดตรหัสผ่าน
                setState(() {
                  // ตรวจสอบความถูกต้องของรหัสผ่าน
                  _isPasswordValid = (value == '1111' || value == '2222' || value == '3333');
                });
              },
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible; // สลับสถานะการแสดงรหัสผ่าน
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_isPasswordValid) {
                  widget.onUsernameChanged(_username); // ส่งชื่อผู้ใช้ที่อัปเดตกลับไปยัง ProfileScreen
                  Navigator.pop(context); // ปิด Dialog
                } else {
                  // แสดง SnackBar หากรหัสผ่านไม่ถูกต้อง
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incorrect password!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 173, 255, 47),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.logout, size: 50, color: Colors.black),
            const SizedBox(height: 20),
            const Text(
              'Are you sure you want to log out?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // ปิด Dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                ); // กลับไปที่หน้า LoginScreen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 173, 255, 47),
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Back to Login',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            IconButton(
              onPressed: () {
                Navigator.pop(context); // ปิด Dialog
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}