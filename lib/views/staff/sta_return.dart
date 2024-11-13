import 'package:flutter/material.dart';
import 'sta_history.dart';
import 'sta_dashboard.dart';
import 'sta_homepage.dart';
import '../../widgets/ProfileScreen.dart';
// สร้างคลาส ReturnAsset ที่เป็น StatefulWidget
class StaReturn extends StatefulWidget {
  const StaReturn({super.key});

  @override
  _StaReturnState createState() => _StaReturnState();
}

class _StaReturnState extends State<StaReturn> {
  // รายการคืนทรัพย์สิน
  List<Map<String, dynamic>> returnAssets = [
    {"title": "Marvel", "borrowDate": "18/10/2024", "returnDate": "19/10/2024"},
    {"title": "Batman", "borrowDate": "18/10/2024", "returnDate": "19/10/2024"},
    {"title": "Superman", "borrowDate": "18/10/2024", "returnDate": "19/10/2024"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar แสดงชื่อ "Return Asset"
      appBar: AppBar(
        title: Text("Return Asset"),
        centerTitle: true, // จัดกลางชื่อ
        backgroundColor: const Color.fromARGB(255, 239, 239, 239), // สีของ AppBar
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
              'RETURN ASSET',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // ขนาดและความหนาของข้อความ
            ),
            SizedBox(height: 16),
            Expanded(
              // ListView สำหรับแสดงรายการคืนทรัพย์สิน
              child: ListView.builder(
                itemCount: returnAssets.length,
                itemBuilder: (context, index) {
                  return _buildReturnAssetCard(
                    returnAssets[index]["title"],
                    returnAssets[index]["borrowDate"],
                    returnAssets[index]["returnDate"],
                    index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context), // สร้าง BottomNavigationBar
    );
  }

  // ฟังก์ชันสำหรับสร้างการ์ดคืนทรัพย์สิน
  Widget _buildReturnAssetCard(String title, String borrowDate, String returnDate, int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 12), // ช่องว่างด้านล่างการ์ด
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // มุมของการ์ด
      ),
      elevation: 4, // เพิ่มเงาให้กับการ์ด
      child: ListTile(
        leading: Icon(Icons.book, size: 40, color: const Color.fromARGB(255, 86, 86, 86)), // ไอคอนหนังสือ
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)), // ชื่อเรื่อง
        subtitle: Text("Borrow date: $borrowDate\nReturn date: $returnDate"), // วันที่ยืมและคืน
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // สีพื้นหลังของปุ่ม
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // มุมของปุ่ม
            ),
          ),
          onPressed: () {
            // ลบรายการเมื่อกดปุ่ม
            _returnAsset(index);
          },
          child: Text("Return", style: TextStyle(color: Colors.white)), // ข้อความในปุ่ม
        ),
      ),
    );
  }

  // ฟังก์ชันสำหรับลบรายการคืนทรัพย์สิน
  void _returnAsset(int index) {
    setState(() {
      returnAssets.removeAt(index); // ลบรายการออกจาก List
    });
  }

  // ฟังก์ชันสำหรับสร้าง BottomNavigationBar
  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.lightGreenAccent[700], // สีพื้นหลัง
      selectedItemColor:  Colors.black, // สีของรายการที่เลือก
      unselectedItemColor:  Colors.black54, // สีของรายการที่ไม่เลือก
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
