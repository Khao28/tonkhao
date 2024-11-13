import 'package:flutter/material.dart';
import 'sta_history.dart';
import 'sta_return.dart';
import 'sta_homepage.dart';
import '../../widgets/ProfileScreen.dart';
// สร้างคลาส Dashboardstaff ที่เป็น StatelessWidget
class StaDashboard extends StatelessWidget {
  const StaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar แสดงชื่อ "Dashboard"
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true, // จัดกลางชื่อ
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField สำหรับค้นหา
            TextField(
              decoration: InputDecoration(
                hintText: 'Search', // ข้อความที่จะแสดงในช่องค้นหา
                prefixIcon: Icon(Icons.search), // ไอคอนค้นหาที่อยู่ด้านหน้า
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // มุมของกรอบช่องค้นหา
                  borderSide: BorderSide(color: Colors.grey.shade400), // ขอบสีเทา
                ),
                filled: true,
                fillColor: Colors.grey.shade200, // สีพื้นหลังของช่องค้นหา
              ),
            ),
            SizedBox(height: 16), // ช่องว่างระหว่างช่องค้นหาและข้อความ
            Text(
              'DASHBOARD',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // ขนาดและความหนาของข้อความ
            ),
            SizedBox(height: 16),
            _buildTotalBookAssetSection(), // เรียกใช้ฟังก์ชันเพื่อสร้างส่วนแสดงจำนวนหนังสือ
            SizedBox(height: 16),
            _buildOutstandingDelayStatus(), // เรียกใช้ฟังก์ชันเพื่อแสดงสถานะการชำระเงิน
            SizedBox(height: 16),
            _buildTodayAssets(), // เรียกใช้ฟังก์ชันเพื่อแสดงสินทรัพย์ในวันนี้
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context), // สร้าง BottomNavigationBar
    );
  }

  // ฟังก์ชันสำหรับสร้างส่วนแสดงจำนวนหนังสือทั้งหมด
  Widget _buildTotalBookAssetSection() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          color: Colors.lightGreenAccent, // สีพื้นหลัง
          child: Text(
            "Total book asset",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // ขนาดและความหนาของข้อความ
          ),
        ),
        // แสดงการ์ดสำหรับหมวดหมู่หนังสือ
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryCard("Comics", "102 books", Icons.auto_stories, Colors.black), // การ์ดสำหรับ Comics
            _buildCategoryCard("Manga", "96 books", Icons.lightbulb_outline, Colors.black), // การ์ดสำหรับ Manga
            _buildCategoryCard("Fantasy", "26 books", Icons.pets, Colors.black), // การ์ดสำหรับ Fantasy
          ],
        ),
      ],
    );
  }

  // ฟังก์ชันสำหรับสร้างการ์ดหมวดหมู่
  Widget _buildCategoryCard(String title, String subtitle, IconData icon, Color iconColor) {
    return Card(
      elevation: 4, // เพิ่มเงาให้กับการ์ด
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // มุมของการ์ด
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // ระยะห่างภายในการ์ด
        child: Column(
          children: [
            Icon(icon, size: 48, color: iconColor), // ไอคอนของหมวดหมู่
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)), // ชื่อหมวดหมู่
            Text(subtitle), // จำนวนหนังสือในหมวดหมู่
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันสำหรับสร้างส่วนแสดงสถานะการชำระเงิน
  Widget _buildOutstandingDelayStatus() {
    return Column(
      children: [
        Text(
          'Outstanding Delay Status',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // ขนาดและความหนาของข้อความ
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatusCard("114 PCS", "13 members", "On Time", Icons.event_available, Colors.green), // การ์ดสถานะ On Time
            _buildStatusCard("10 PCS", "8 members", "Disables", Icons.warning, Colors.red), // การ์ดสถานะ Disables
            _buildStatusCard("15 PCS", "16 members", "30 Days Late", Icons.event_busy, Colors.orange), // การ์ดสถานะ 30 Days Late
          ],
        ),
      ],
    );
  }

  // ฟังก์ชันสำหรับสร้างการ์ดสถานะ
  Widget _buildStatusCard(String title, String subtitle, String status, IconData icon, Color iconColor) {
    return Card(
      elevation: 4, // เพิ่มเงาให้กับการ์ด
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // มุมของการ์ด
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // ระยะห่างภายในการ์ด
        child: Column(
          children: [
            Icon(icon, size: 40, color: iconColor), // ไอคอนของสถานะ
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)), // จำนวน
            Text(subtitle), // จำนวนสมาชิก
            Text(status), // สถานะ
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันสำหรับสร้างส่วนแสดงสินทรัพย์ในวันนี้
  Widget _buildTodayAssets() {
    return Column(
      children: [
        Text(
          'Today Assets',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // ขนาดและความหนาของข้อความ
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildAssetStatusCard("Available Assets (Today)", Colors.lightGreenAccent), // การ์ดสำหรับสินทรัพย์ที่มีอยู่
            _buildAssetStatusCard("Disabled Assets (Today)", Colors.lightBlueAccent), // การ์ดสำหรับสินทรัพย์ที่ไม่สามารถใช้งานได้
          ],
        ),
      ],
    );
  }

  // ฟังก์ชันสำหรับสร้างการ์ดสถานะสินทรัพย์
  Widget _buildAssetStatusCard(String title, Color color) {
    return Container(
      width: 150, // ความกว้างของการ์ด
      height: 100, // ความสูงของการ์ด
      decoration: BoxDecoration(
        color: color, // สีพื้นหลังของการ์ด
        borderRadius: BorderRadius.circular(10), // มุมของการ์ด
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // เงาของการ์ด
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // เงาด้านล่าง
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center, // จัดข้อความกลาง
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // ความหนาของข้อความ
        ),
      ),
    );
  }

  // ฟังก์ชันสำหรับสร้าง BottomNavigationBar
  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.lightGreenAccent[700], // สีพื้นหลัง
      selectedItemColor: Colors.black, // สีของรายการที่เลือก
      unselectedItemColor: Colors.black54, // สีของรายการที่ไม่เลือก
      showSelectedLabels: true, // แสดงป้ายกำกับสำหรับรายการที่เลือก
      showUnselectedLabels: true, // แสดงป้ายกำกับสำหรับรายการที่ไม่เลือก
      onTap: (index) {
        if (index == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => StaHomepage()),
            (route) => false,
          );
        } else if (index == 1) {
          // Navigate to ProfileScreen when profile button is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StaHistory()),
          );
        } else if (index == 2) {
          // Navigate to ProfileScreen when profile button is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StaReturn()),
          );
        } else if (index == 3) {
          // Navigate to ProfileScreen when profile button is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StaDashboard()),
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
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), // รายการ Home
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'), // รายการ History
        BottomNavigationBarItem(icon: Icon(Icons.repeat), label: 'Return'), // รายการ Return
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'), // รายการ Dashboard
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'), // รายการ Profile
      ],
      type: BottomNavigationBarType.fixed, // กำหนดประเภทของ BottomNavigationBar
    );
  }
}
