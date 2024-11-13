import 'package:flutter/material.dart';
import '../../widgets/ProfileScreen.dart';
import 'use_homepage.dart';
import 'use_history.dart';

// สร้างคลาส StatusPage ที่เป็น StatelessWidget
class UseStatus extends StatelessWidget {
  const UseStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar แสดงชื่อ "Status Page"
      appBar: AppBar(
        title: Text("Status Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ข้อความหัวเรื่อง "Request Status"
            Text(
              'Request Status',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // ขนาดและความหนาของข้อความ
            ),
            SizedBox(height: 16), // ช่องว่างระหว่างหัวเรื่องและรายการ
            Expanded(
              // ListView สำหรับแสดงรายการสถานะ
              child: ListView(
                children: [
                  // เรียกใช้ฟังก์ชันเพื่อสร้างรายการสถานะ
                  buildStatusItem("Marvel", "18/10/2024", "19/10/2024", "pending", Colors.grey),
                  buildStatusItem("Marvel", "18/10/2024", "19/10/2024", "approved", Colors.green),
                  buildStatusItem("Marvel", "18/10/2024", "19/10/2024", "rejected", Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context), // สร้าง BottomNavigationBar
    );
  }

  // ฟังก์ชันสำหรับสร้างรายการสถานะ
  Widget buildStatusItem(String title, String borrowDate, String returnDate, String status, Color color) {
    return Card(
      margin: EdgeInsets.only(bottom: 12), // ช่องว่างด้านล่างการ์ด
      child: ListTile(
        leading: Icon(Icons.book, size: 40), // ไอคอนหนังสือที่อยู่ด้านซ้าย
        title: Text(title), // ชื่อเรื่อง
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
  Widget buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.lightGreenAccent[700], // สีพื้นหลังของแท็บบาร์
      selectedItemColor: Colors.black, // สีของไอคอนที่เลือก
      unselectedItemColor: Colors.black54, // สีของไอคอนที่ไม่ได้เลือก
      showSelectedLabels: true, // แสดง label ของไอคอนที่เลือก
      showUnselectedLabels: true,
       // แสดง label ของไอคอนที่ไม่ได้เลือก
       onTap: (index) {
        if (index == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UseHomepage()),
            (route) => false,
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UseHistory()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UseStatus()),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), // รายการ Home
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'), // รายการ History
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Status'), // รายการ Status
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'), // รายการ Profile
      ],
      type: BottomNavigationBarType.fixed, // เพื่อให้ไอคอนและ label ไม่ขยับไปมา
    );
  }
}
