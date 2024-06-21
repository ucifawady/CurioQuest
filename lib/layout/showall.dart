import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShowAllPage extends StatefulWidget {
  final String db;

  ShowAllPage({required this.db});

  @override
  State<ShowAllPage> createState() => _ShowAllPageState();
}

class _ShowAllPageState extends State<ShowAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Show All'),
      ),
      body: FutureBuilder<DatabaseEvent>(
        future: FirebaseDatabase.instance
            .refFromURL('https://cuiro-quest-msk-default-rtdb.firebaseio.com/')
            .child(widget.db) // Use the db parameter here
            .once(),
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.snapshot.value == null ||
              (snapshot.data!.snapshot.value as List).isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<dynamic> data = snapshot.data!.snapshot.value as List<dynamic>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                Map<dynamic, dynamic> itemData = data[index] as Map<dynamic, dynamic>;
                return ReviewItem(
                  title: itemData["Name"] ?? 'Unnamed',
                  image: itemData["ImageUrl"] ?? 'https://cdn.britannica.com/51/194651-050-747F0C18/Interior-National-Gallery-of-Art-Washington-DC.jpg',
                  descriptionEn: itemData["TextE"] ?? '',
                  descriptionAr: itemData["TextA"] ?? '',
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String title;
  final String descriptionEn;
  final String descriptionAr;
  final String image;

  ReviewItem({
    required this.title,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    descriptionEn,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    descriptionAr,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}