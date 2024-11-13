import 'package:flutter/material.dart';
import 'len_request.dart';
import '../../widgets/ProfileScreen.dart';
import 'len_history.dart';
import 'len_homepage.dart';

// สร้าง Stateless Widget ชื่อ Dashboardlender
class LenDashboard extends StatelessWidget {
  const LenDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // ใช้ Scaffold เพื่อสร้างโครงสร้างพื้นฐานของหน้าจอ
    return Scaffold(
      // AppBar แสดงชื่อ Dashboard
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true, // จัดกลางชื่อ
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // ตั้งค่าระยะห่างรอบๆ เนื้อหา
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // จัดตำแหน่งให้เริ่มจากซ้าย
          children: [
            // ช่องค้นหา
            TextField(
              decoration: InputDecoration(
                hintText: 'Search', // ข้อความตัวอย่างในช่องค้นหา
                prefixIcon: Icon(Icons.search), // ไอคอนค้นหาทางด้านซ้าย
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // มุมของขอบโค้ง
                  borderSide: BorderSide(color: Colors.grey.shade400), // ขอบสีเทา
                ),
                filled: true,
                fillColor: Colors.grey.shade200, // พื้นหลังของช่องค้นหา
              ),
            ),
            SizedBox(height: 16), // ระยะห่างแนวตั้งระหว่าง TextField กับข้อความ 'DASHBOARD'

            // ข้อความหัวข้อ 'DASHBOARD'
            Text(
              'DASHBOARD',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // ขนาดและน้ำหนักตัวอักษร
            ),
            SizedBox(height: 16), // ระยะห่างแนวตั้งระหว่างข้อความหัวข้อและกล่อง 'Book Assets'

            // กล่อง 'Book Assets'
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // ระยะห่างในกล่อง
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent, // พื้นหลังสีเขียวอ่อน
                borderRadius: BorderRadius.circular(10), // มุมโค้ง
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // เงาของกล่อง
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // การเบี่ยงเบนของเงา
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Book Assets",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // ขนาดและน้ำหนักตัวอักษร
                ),
              ),
            ),
            SizedBox(height: 16), // ระยะห่างแนวตั้งระหว่าง 'Book Assets' และแถวของสถานะ

            // แถวแสดงสถานะต่างๆ (Approve, Disapprove, Pending)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // กระจายตำแหน่งในแถวให้เท่ากัน
              children: [
                // การ์ดสถานะ Approve
                _buildStatusCard("Approve", "569", Colors.green, Icons.check_circle),
                // การ์ดสถานะ Disapprove
                _buildStatusCard("Disapprove", "125", Colors.red, Icons.cancel),
                // การ์ดสถานะ Pending
                _buildStatusCard("Pending", "348", Colors.orange, Icons.access_time),
              ],
            ),
            SizedBox(height: 16), // ระยะห่างแนวตั้งระหว่างแถวสถานะและกล่อง 'Total rental'

            // กล่อง 'Total rental' ที่พื้นหลังสีดำและมีข้อความสีขาว
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black, // พื้นหลังสีดำ
                  borderRadius: BorderRadius.circular(10), // มุมโค้ง
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // เงาของกล่อง
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // การเบี่ยงเบนของเงา
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Total rental",
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold), // ตัวอักษรสีขาว ขนาด 24 และหนา
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // BottomNavigationBar แถบเมนูที่ด้านล่างของหน้าจอ
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  // ฟังก์ชันที่สร้างการ์ดสถานะแต่ละอัน
  Widget _buildStatusCard(String title, String count, Color color, IconData icon) {
    return Card(
      elevation: 4, // ความลึกของเงา
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // มุมโค้ง
      ),
      child: Container(
        padding: EdgeInsets.all(16), // ระยะห่างภายในการ์ด
        child: Column(
          mainAxisSize: MainAxisSize.min, // ขนาดของการ์ดตามเนื้อหา
          children: [
            Icon(icon, size: 40, color: color), // ไอคอนของสถานะ
            SizedBox(height: 8), // ระยะห่างระหว่างไอคอนและข้อความ
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)), // ชื่อสถานะ
            SizedBox(height: 4), // ระยะห่างระหว่างชื่อสถานะและจำนวน
            Text(count), // จำนวนสถานะ
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันที่สร้าง BottomNavigationBar ด้านล่าง
  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.lightGreenAccent[700], // สีพื้นหลังของแถบเมนู
      selectedItemColor: Colors.black, // สีของไอคอนที่ถูกเลือก
      unselectedItemColor: Colors.black54, // สีของไอคอนที่ไม่ได้ถูกเลือก
      showSelectedLabels: true, // แสดงชื่อเมนูของไอคอนที่ถูกเลือก
      showUnselectedLabels: true, // แสดงชื่อเมนูของไอคอนที่ไม่ได้ถูกเลือก
      onTap: (index) {
        if (index == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LenHomepage()),
            (route) => false,
          );
        } else if (index == 1) {
          // Navigate to ProfileScreen when profile button is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LenHistory()),
          );
        } else if (index == 2) {
          // Navigate to ProfileScreen when profile button is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LenRequest()),
          );
        } else if (index == 3) {
          // Navigate to ProfileScreen when profile button is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LenDashboard()),
          );
        } else if (index == 4) {
          // Navigate to ProfileScreen when profile button is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Request'),
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      type: BottomNavigationBarType.fixed, // กำหนดให้แสดงเมนูทั้งหมดโดยไม่เปลี่ยนตำแหน่ง
    );
  }
}
