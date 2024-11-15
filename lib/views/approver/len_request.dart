import 'package:flutter/material.dart';
import '../../widgets/ProfileScreen.dart';
import 'len_dashboard.dart';
import 'len_history.dart';
import 'len_homepage.dart';

// Create Stateful Widget named LenRequest
class LenRequest extends StatefulWidget {
  const LenRequest({super.key});

  @override
  _LenRequestState createState() => _LenRequestState();
}

class _LenRequestState extends State<LenRequest> {
  // Define a list of statuses
  final List<String> statuses = ["Pending", "Approved", "Rejected"];
  // A map to hold the background color for each status
  final Map<String, Color> statusColors = {
    "Approved": Color.fromARGB(255, 59, 222, 65),
    "Rejected": Color.fromARGB(255, 233, 101, 92),
    "Pending": Color.fromARGB(255, 235, 169, 69),
  };

  // Map to keep track of selected status for each book
  Map<String, String> selectedStatuses = {
    "Marvel": "Pending",
    "Spider-Man": "Approved",
    "Batman": "Rejected",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Status"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Request Status',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildStatusCard("Marvel"),
                  _buildStatusCard("Spider-Man"),
                  _buildStatusCard("Batman"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  // Build the status card with a dropdown
  Widget _buildStatusCard(String title) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(Icons.book, size: 40),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Select Status", style: TextStyle(color: Colors.grey)),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: statusColors[selectedStatuses[
                title]], // Set background color based on selected status
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton<String>(
            value: selectedStatuses[title],
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.white),
            dropdownColor: Colors.grey[800],
            underline: SizedBox(),
            items: statuses.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedStatuses[title] = newValue!;
              });
            },
          ),
        ),
      ),
    );
  }

  // Function to build the BottomNavigationBar
  Widget _buildBottomNavBar(BuildContext context) {
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
            MaterialPageRoute(builder: (context) => LenHomepage()),
            (route) => false,
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LenHistory()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LenRequest()),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LenDashboard()),
          );
        } else if (index == 4) {
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
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
