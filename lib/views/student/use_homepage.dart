import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/ProfileScreen.dart';
import 'use_history.dart';
import 'use_status.dart';
void main() {
  runApp(UseHomepage());
}

class UseHomepage extends StatelessWidget {
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

  final List<String> categories = ["Comics", "Manga", "Fantasy"];

  final Map<String, List<Map<String, dynamic>>> bookData = {
    "Comics": [
      {
        "title": "Garfield Vol. 3 (KaBOOM!)",
        "category": "Comics",
        "status": "available",
        "description":
            "After a sequence of bad luck, Garfield assumes he's dreaming and confronts his rival Buster the bulldog."
      },
      {
        "title": "Batman: The Killing Joke",
        "category": "Comics",
        "status": "available",
        "description":
            "An intense showdown between Batman and the Joker unfolds in this iconic graphic novel."
      },
      {
        "title": "Spider-Man: Into the Spider-Verse",
        "category": "Comics",
        "status": "out of stock",
        "description":
            "Follow Miles Morales as he learns to become the Spider-Man of his universe."
      },
    ],
    "Manga": [
      {
        "title": "Naruto",
        "category": "Manga",
        "status": "available",
        "description":
            "Join Naruto Uzumaki on his journey to become the strongest ninja in his village."
      },
      {
        "title": "One Piece",
        "category": "Manga",
        "status": "available",
        "description":
            "Follow Monkey D. Luffy and his crew as they search for the ultimate treasure, the One Piece."
      },
      {
        "title": "Attack on Titan",
        "category": "Manga",
        "status": "out of stock",
        "description":
            "Humanity fights for survival against giant humanoid creatures known as Titans."
      },
    ],
    "Fantasy": [
      {
        "title": "Harry Potter and the Sorcerer's Stone",
        "category": "Fantasy",
        "status": "available",
        "description":
            "Harry Potter discovers he's a wizard and begins his journey at Hogwarts School of Witchcraft and Wizardry."
      },
      {
        "title": "The Lord of the Rings",
        "category": "Fantasy",
        "status": "out of stock",
        "description":
            "An epic adventure to destroy the One Ring and defeat the dark lord Sauron."
      },
      {
        "title": "The Hobbit",
        "category": "Fantasy",
        "status": "available",
        "description":
            "Bilbo Baggins joins a quest to reclaim the lost Dwarf Kingdom of Erebor from the dragon Smaug."
      },
    ],
  };

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showRentalDialog(
      BuildContext context, String title, String status, String description) {
    DateTime startDate = DateTime.now();
    DateTime endDate = startDate.add(Duration(days: 1));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(image: AssetImage('assets/images/marvel.jpg')),
                SizedBox(height: 8),
                Text(title,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(status, style: TextStyle(color: Colors.grey)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Details',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      Text(description, style: TextStyle(color: Colors.grey)),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Start Date:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      '${startDate.day}/${startDate.month}/${startDate.year}',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('End Date:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      '${endDate.day}/${endDate.month}/${endDate.year}',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: status == 'available'
                            ? Colors.lightGreenAccent[400]
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: status == 'available'
                          ? () {
                              // Handle rental logic here
                              Navigator.of(context).pop();
                            }
                          : null,
                      child: Text(
                        'Rental',
                        style: TextStyle(color: Colors.black),
                      ),
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
                  'Categories',
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
                    bool isAvailable = book["status"] == "available";
                    
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/marvel.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isAvailable
                                        ? Colors.green[100]
                                        : Colors.red[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    book["status"].toUpperCase(),
                                    style: TextStyle(
                                      color: isAvailable
                                          ? Colors.green[800]
                                          : Colors.red[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              book["title"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Category: ${book['category']}",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isAvailable
                                        ? Colors.lightGreenAccent[400]
                                        : Colors.grey[400],
                                    minimumSize: Size(double.infinity, 36),
                                  ),
                                  onPressed: isAvailable
                                      ? () {
                                          _showRentalDialog(
                                            context,
                                            book["title"],
                                            book["status"],
                                            book["description"],
                                          );
                                        }
                                      : null,
                                  child: Text(
                                    "Rental",
                                    style: TextStyle(
                                      color: isAvailable
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
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
        backgroundColor: Colors.lightGreenAccent[700],
        selectedItemColor: Colors.black45,unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: "Status"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}