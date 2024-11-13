import 'package:flutter/material.dart';
import 'len_request.dart';
import 'len_dashboard.dart';
import '../../widgets/ProfileScreen.dart';
import 'len_homepage.dart';

// สร้าง Stateless Widget ชื่อ Historylender
class LenHistory extends StatelessWidget {
  const LenHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // ใช้ Scaffold เพื่อสร้างโครงสร้างพื้นฐานของหน้าจอ
    return Scaffold(
      // AppBar แสดงชื่อ History
      appBar: AppBar(
        title: Text("History"),
        centerTitle: true, // จัดกลางชื่อ
      ),

      // ส่วนของเนื้อหาหลักในหน้า History
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
            SizedBox(height: 16), // ระยะห่างแนวตั้งระหว่าง TextField กับข้อความ 'History'

            // ข้อความหัวข้อ 'History'
            Text(
              'History',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // ขนาดและน้ำหนักตัวอักษร
            ),
            SizedBox(height: 16), // ระยะห่างแนวตั้งระหว่างข้อความหัวข้อและรายการ History

            // ListView แสดงรายการ History แต่ละรายการ
            Expanded(
              child: ListView(
                children: [
                  // การ์ดของรายการยืมในสถานะต่างๆ
                  _buildHistoryCard("Marvel", "Borrow date: 18/10/2024", "Return date: 19/10/2024", "Pending"),
                  _buildHistoryCard("Marvel", "Borrow date: 18/10/2024", "Return date: 19/10/2024", "Approved"),
                  _buildHistoryCard("Marvel", "Borrow date: 18/10/2024", "Return date: 19/10/2024", "Rejected"),
                  _buildHistoryCard("Marvel", "Borrow date: 18/10/2024", "Return date: 19/10/2024", "Returned"),
                  _buildHistoryCard("Marvel", "Borrow date: 18/10/2024", "Return date: 19/10/2024", "Late"),
                ],
              ),
            ),
          ],
        ),
      ),

      // BottomNavigationBar แถบเมนูที่ด้านล่างของหน้าจอ
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  // ฟังก์ชันที่สร้างการ์ดแต่ละรายการใน History
  Widget _buildHistoryCard(String title, String borrowDate, String returnDate, String status) {
    // กำหนดสีของสถานะ
    Color statusColor;
    switch (status) {
      case "Approved":
        statusColor = const Color.fromARGB(255, 63, 255, 69);
        break;
      case "Rejected":
        statusColor = const Color.fromARGB(255, 255, 83, 70);
        break;
      case "Returned":
        statusColor = const Color.fromARGB(255, 89, 178, 251);
        break;
      case "Late":
        statusColor = const Color.fromARGB(255, 255, 179, 65);
        break;
      default:
        statusColor = Colors.grey;
    }

    // การ์ดของรายการ History
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8), // ระยะห่างแนวตั้งระหว่างการ์ดแต่ละอัน
      elevation: 4, // ความลึกของเงา
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // มุมโค้ง
      ),
      child: ListTile(
        leading: Icon(Icons.book, size: 40), // ไอคอนหนังสือทางด้านซ้าย
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)), // ชื่อหนังสือ
        subtitle: Text("$borrowDate\n$returnDate", style: TextStyle(color: Colors.grey)), // ข้อมูลวันยืมและวันคืน
        trailing: Chip(
          label: Text(status, style: TextStyle(color: Colors.white)), // สถานะ
          backgroundColor: statusColor, // สีของสถานะตามที่กำหนดไว้
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
