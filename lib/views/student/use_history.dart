import 'package:flutter/material.dart';
import 'use_homepage.dart';
import 'use_status.dart';
import '../../widgets/ProfileScreen.dart';

class UseHistory extends StatelessWidget {
  const UseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'History',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  buildHistoryItem("Marvel", "18/10/2024", "19/10/2024",
                      "pending", Colors.grey),
                  buildHistoryItem("Marvel", "18/10/2024", "19/10/2024",
                      "approved", Colors.green),
                  buildHistoryItem("Marvel", "18/10/2024", "19/10/2024",
                      "rejected", Colors.red),
                  buildHistoryItem("Marvel", "18/10/2024", "19/10/2024",
                      "returned", Colors.purple),
                  buildHistoryItem("Marvel", "18/10/2024", "19/10/2024", "late",
                      Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Widget buildHistoryItem(String title, String borrowDate, String returnDate,
      String status, Color color) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(Icons.book, size: 40),
        title: Text(title),
        subtitle: Text("Borrow date: $borrowDate\nReturn date: $returnDate"),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.lightGreenAccent[700],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      showSelectedLabels: true,
      showUnselectedLabels: true,
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
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Status'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
