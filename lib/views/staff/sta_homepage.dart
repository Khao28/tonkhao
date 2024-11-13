import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_book_coner/ProfileScreen.dart';
import 'package:the_book_coner/sta_dashboard.dart';
import 'package:the_book_coner/sta_history.dart';
import 'package:the_book_coner/sta_return.dart';
import 'dart:io';
import '../../widgets/custom_bottom_navigation_bar.dart';

void main() {
  runApp(StaHomepage());
}

class StaHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookRentalApp(),
    );
  }
}

class BookRentalApp extends StatefulWidget {
  @override
  _BookRentalAppState createState() => _BookRentalAppState();
}

class _BookRentalAppState extends State<BookRentalApp> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // List of categories
  final List<String> categories = ["Comics", "Manga", "Fantasy"];

  // Updated book data with new status options
  final Map<String, List<Map<String, dynamic>>> bookData = {
    "Comics": [
      {
        "title": "Marvel",
        "category": "Comics",
        "status": "available",
        "introduction": ""
      },
    ],
    "Manga": [
      {
        "title": "Naruto",
        "category": "Manga",
        "status": "out of stock",
        "introduction": ""
      },
    ],
    "Fantasy": [
      {
        "title": "Harry Potter",
        "category": "Fantasy",
        "status": "available",
        "introduction": ""
      },
    ],
  };

  // Status options
  final List<String> statusOptions = ['available', 'out of stock'];

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return Colors.green;
      case 'out of stock':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void showAddBookDialog() async {
    String newCategory = categories[_currentIndex];
    String newStatus = statusOptions[0]; // Default to 'available'
    String newTitle = '';
    String newIntroduction = '';
    File? imageFile;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add New Book',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    final pickedFile =
                        await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      imageFile = File(pickedFile.path);
                    }
                    setState(() {});
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      image: imageFile != null
                          ? DecorationImage(
                              image: FileImage(imageFile!), fit: BoxFit.cover)
                          : null,
                    ),
                    child: imageFile == null
                        ? Icon(Icons.add_a_photo, color: Colors.grey)
                        : null,
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: newCategory,
                  items: categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category,
                                style: TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) newCategory = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Categories',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  dropdownColor: Colors.black,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Book Name',
                      hintStyle: TextStyle(color: Colors.white)),
                  onChanged: (value) => newTitle = value,
                  style: TextStyle(color: Colors.white),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Introduction about Book',
                      hintStyle: TextStyle(color: Colors.white)),
                  onChanged: (value) => newIntroduction = value,
                  style: TextStyle(color: Colors.white),
                ),
                DropdownButtonFormField<String>(
                  value: newStatus,
                  items: statusOptions
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status,
                                style: TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) newStatus = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Status',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  dropdownColor: Colors.black,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cancel', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreenAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        if (newTitle.isNotEmpty) {
                          setState(() {
                            bookData[newCategory]!.add({
                              "title": newTitle,
                              "category": newCategory,
                              "status": newStatus,
                              "introduction": newIntroduction,
                            });
                          });
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text('Add', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showEditDialog(Map<String, dynamic> book) {
    String newCategory = book['category'];
    String newStatus = book['status'];
    String newTitle = book['title'];
    String newIntroduction = book['introduction'];
    File? imageFile;
    final ImagePicker _picker = ImagePicker();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.lightGreenAccent,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Edit Book',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    final pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      imageFile = File(pickedFile.path);
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      image: imageFile != null
                          ? DecorationImage(
                              image: FileImage(imageFile!), fit: BoxFit.cover)
                          : null,
                    ),
                    child: imageFile == null
                        ? Icon(Icons.add_a_photo, color: Colors.grey)
                        : null,
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: newCategory,
                  items: categories
                      .map((category) =>
                          DropdownMenuItem(value: category, child: Text(category)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) newCategory = value;
                  },
                  decoration: InputDecoration(labelText: 'Categories'),
                ),
                TextFormField(
                  initialValue: newTitle,
                  decoration: InputDecoration(hintText: 'Book Name'),
                  onChanged: (value) => newTitle = value,
                ),
                TextFormField(
                  initialValue: newIntroduction,
                  decoration: InputDecoration(hintText: 'Introduction about Book'),
                  onChanged: (value) => newIntroduction = value,
                ),
                DropdownButtonFormField<String>(
                  value: newStatus,
                  items: statusOptions
                      .map((status) =>
                          DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) newStatus = value;
                  },
                  decoration: InputDecoration(labelText: 'Status'),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cancel', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        setState(() {
                          book['title'] = newTitle;
                          book['category'] = newCategory;
                          book['introduction'] = newIntroduction;
                          book['status'] = newStatus;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('Save', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Menu for staff',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...categories.asMap().entries.map((entry) {
                int idx = entry.key;
                String category = entry.value;
                IconData icon;

                switch (category) {
                  case "Comics":
                    icon = Icons.festival_rounded;
                    break;
                  case "Manga":
                    icon = Icons.cyclone;
                    break;
                  case "Fantasy":
                    icon = Icons.spa;
                    break;
                  default:
                    icon = Icons.category;
                }

                return GestureDetector(
                  onTap: () {
                    _pageController.jumpToPage(idx);
                    setState(() {
                      _currentIndex = idx;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _currentIndex == idx
                              ? Colors.lightGreenAccent[700]
                              : Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          color: _currentIndex == idx
                              ? Colors.black
                              : Colors.lightGreenAccent[700],
                        ),
                      ),
                      Text(
                        category,
                        style: TextStyle(
                          color: _currentIndex == idx
                              ? Colors.lightGreenAccent[700]
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              IconButton(
                icon: Icon(Icons.add, color: Colors.lightGreenAccent[700]),
                onPressed: showAddBookDialog,
                tooltip: "Add Book",
                color: Colors.black,
              ),
            ],
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: onPageChanged,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String category = categories[index];
                return GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: bookData[category]?.length ?? 0,
                  itemBuilder: (context, bookIndex) {
                    var book = bookData[category]![bookIndex];
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/marvel.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Status badge
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: getStatusColor(book["status"]),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      book["status"],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book["title"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Category: ${book['category']}",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    showEditDialog(book);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.edit, size: 16),
                                      SizedBox(width: 4),
                                      Text("Edit"),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightGreenAccent[700],
                                    foregroundColor: Colors.white,
                                    minimumSize: Size(double.infinity, 36),
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => StaHomepage()),
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StaHistory()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StaReturn()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StaDashboard()),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          }
        },
        backgroundColor: Colors.lightGreenAccent[700],
        selectedItemColor: Colors.black45,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.repeat), label: "Return"),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}