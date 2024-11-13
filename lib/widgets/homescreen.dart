// import 'package:flutter/material.dart';
// import 'package:the_book_coner/fantasy_page.dart';
// import 'package:the_book_coner/manga_pages.dart';
// import 'comics_page.dart'; // Import the ComicsPage here

// class HomeScreen extends StatelessWidget {
//   final ScrollController _scrollController = ScrollController();

//   HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels ==
//           _scrollController.position.maxScrollExtent) {
//         print("Reached the bottom of the grid");
//       }
//     });

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Row(
//             children: [
//               Icon(Icons.search, color: Colors.grey),
//               SizedBox(width: 8),
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search',
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 16),
//             Container(
//               height: 150,
//               color: Colors.white,
//               child: Center(child: Text("Image Carousel")),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Categories',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CategoryButton(
//                     icon: Icons.star_outlined,
//                     label: 'Comics',
//                     onTap: () {
//                       // Navigate to ComicsPage when the Comics button is pressed
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => ComicsPage()),
//                       );
//                     }),
//                 CategoryButton(
//                     icon: Icons.fire_extinguisher_outlined, label: 'Manga',
//                     onTap: () {
//                       // Navigate to ComicsPage when the Comics button is pressed
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => MangaPages()),
//                       );
//                     }),
//                 CategoryButton(icon: Icons.castle_rounded, label: 'Fantasy',
//                 onTap: () {
//                       // Navigate to ComicsPage when the Comics button is pressed
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => FantasyPage()),
//                       );
//                     }),
//               ],
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: GridView.builder(
//                 controller: _scrollController,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 8,
//                   crossAxisSpacing: 8,
//                   childAspectRatio: 0.7,
//                 ),
//                 itemCount: 20,
//                 itemBuilder: (context, index) {
//                   return ComicCard();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.greenAccent,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black54,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
//           BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Status'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }

// class CategoryButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback? onTap;

//   CategoryButton({required this.icon, required this.label, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         IconButton(
//           icon: Icon(icon),
//           iconSize: 48,
//           color: Colors.black,
//           onPressed: onTap, // Trigger onTap if provided
//         ),
//         Text(label, style: TextStyle(fontSize: 12)),
//       ],
//     );
//   }
// }

// class ComicCard extends StatelessWidget {
//   void _showRentalDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           backgroundColor: Colors.grey[200],
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Image(image: AssetImage('assets/images/marvel.jpg')),
//                 SizedBox(height: 8),
//                 Text('Marvel',
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 Text('available', style: TextStyle(color: Colors.grey)),
//                 SizedBox(height: 16),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text('Details',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 ),
//                 SizedBox(height: 8),
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child:
//                       Text('Description', style: TextStyle(color: Colors.grey)),
//                 ),
//                 SizedBox(height: 24),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8)),
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text('Cancel'),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.greenAccent,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8)),
//                       ),
//                       onPressed: () {},
//                       child: Text('Rental'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _showRentalDialog(context),
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/marvel.jpg'),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Marvel',
//                       style:
//                           TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//                   Text('Category: Comics',
//                       style: TextStyle(fontSize: 12, color: Colors.grey[600])),
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: Chip(
//                       label: Text('Rental'),
//                       backgroundColor: Colors.black,
//                       labelStyle: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
