import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tonkhao/views/approver/len_homepage.dart';
import 'package:tonkhao/views/approver/len_homepage.dart';
import 'package:tonkhao/lenhome.dart';

void main() {
  runApp(LenHomepage());
}

class LenHomepage extends StatelessWidget {
  const LenHomepage({super.key});

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

  // List of book data
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
        "status": "available",
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
        "status": "available",
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
                  'Menu for Lender',
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

                // Assign icons based on the category
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
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/marvel.jpg"), // Placeholder image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              book["title"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Category: ${book['category']}"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Status: ${book['status']}",
                              style: TextStyle(
                                color: book['status'] == "available"
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
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
        backgroundColor: Colors.lightGreenAccent[700],
        selectedItemColor: Colors.black45,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: "Status"),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
