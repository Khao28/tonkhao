import 'package:flutter/material.dart';
import '../../widgets/ProfileScreen.dart';
import 'sta_dashboard.dart';
import 'sta_return.dart';
import 'sta_homepage.dart';
// สร้างคลาส HistoryStaff ที่เป็น StatelessWidget
class StaHistory extends StatelessWidget {
  const StaHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar แสดงชื่อ "History"
      appBar: AppBar(
        title: Text("History"),
        centerTitle: true, // จัดกลางชื่อ
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // สีของ AppBar
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
              'History',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // ขนาดและความหนาของข้อความ
            ),
            SizedBox(height: 16),
            Expanded(
              // ListView สำหรับแสดงประวัติ
              child: ListView(
                children: [
                  // เรียกใช้ฟังก์ชันเพื่อสร้างการ์ดประวัติ
                  _buildHistoryCard("Marvel", "18/10/2024", "19/10/2024", "Pending", Colors.grey),
                  _buildHistoryCard("Marvel", "18/10/2024", "19/10/2024", "Approved", Colors.green),
                  _buildHistoryCard("Marvel", "18/10/2024", "19/10/2024", "Rejected", Colors.red),
                  _buildHistoryCard("Marvel", "18/10/2024", "19/10/2024", "Returned", Colors.purple),
                  _buildHistoryCard("Marvel", "18/10/2024", "19/10/2024", "Late", Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context), // สร้าง BottomNavigationBar
    );
  }

  // ฟังก์ชันสำหรับสร้างการ์ดประวัติ
  Widget _buildHistoryCard(String title, String borrowDate, String returnDate, String status, Color color) {
    return Card(
      margin: EdgeInsets.only(bottom: 12), // ช่องว่างด้านล่างการ์ด
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // มุมของการ์ด
      ),
      elevation: 4, // เพิ่มเงาให้กับการ์ด
      child: ListTile(
        leading: Icon(Icons.book, size: 40, color: const Color.fromARGB(255, 100, 100, 100)), // ไอคอนหนังสือ
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)), // ชื่อเรื่อง
        subtitle: Text("Borrow date: $borrowDate\nReturn date: $returnDate"), // วันที่ยืมและคืน
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // ขอบเขตของป้ายกำกับสถานะ
          decoration: BoxDecoration(
            color: color.withOpacity(0.2), // สีพื้นหลังของป้ายกำกับสถานะ
            borderRadius: BorderRadius.circular(8), // มุมของป้ายกำกับ
          ),
          child: Text(
            status, // แสดงสถานะ
            style: TextStyle(color: color, fontWeight: FontWeight.bold), // สีและความหนาของข้อความ
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันสำหรับสร้าง BottomNavigationBar
  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.lightGreenAccent[700], // สีพื้นหลัง
      selectedItemColor:  Colors.black, // สีของรายการที่เลือก
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
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(
            icon: Icon(Icons.repeat), label: 'Return'),
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      type: BottomNavigationBarType.fixed, // กำหนดประเภทของ BottomNavigationBar
    );
  }
}
