import 'package:flutter/material.dart';

class CategoryScrollView extends StatefulWidget {
  @override
  _CategoryScrollViewState createState() => _CategoryScrollViewState();
}

class _CategoryScrollViewState extends State<CategoryScrollView> {
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Comics',
      'icon': '🏛️',
      'items': ['Marvel', 'DC', 'Image', 'Dark Horse']
    },
    {
      'name': 'Manga',
      'icon': '📖',
      'items': ['Naruto', 'One Piece', 'Attack on Titan', 'Bleach']
    },
    {
      'name': 'Fantasy',
      'icon': '🧙‍♂️',
      'items': [
        'Harry Potter',
        'Lord of the Rings',
        'Eragon',
        'Game of Thrones'
      ]
    },
  ];

  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Column(
        children: [
          // ListView สำหรับเลื่อนหมวดหมู่
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: selectedCategoryIndex == index
                              ? Colors.blue
                              : Colors.grey.shade300,
                          child: Text(
                            categories[index]['icon'],
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          categories[index]['name'],
                          style: TextStyle(
                            color: selectedCategoryIndex == index
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // GridView ที่จะแสดงข้อมูลตามหมวดหมู่ที่เลือก
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: categories[selectedCategoryIndex]['items'].length,
              itemBuilder: (context, index) {
                final item = categories[selectedCategoryIndex]['items'][index];
                return Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        color: Colors.blue.shade100,
                        child: Center(
                          child: Text(
                            item,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              item,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Category: ${categories[selectedCategoryIndex]['name']}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {}, child: Text('Edit')),
                                OutlinedButton(
                                    onPressed: () {}, child: Text('Rental')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
