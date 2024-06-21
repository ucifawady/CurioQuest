import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cuiro_quest_app/layout/showall.dart';

import '../modules/CameraPage.dart';
import '../modules/EventsPage.dart';
import '../modules/MapPage.dart';
import '../modules/ReviewPage.dart';

class NmecHome extends StatefulWidget {
  @override
  State<NmecHome> createState() => _NmecHomeState();
}

class _NmecHomeState extends State<NmecHome> {
  final fb = FirebaseDatabase.instance;
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    NmecHomePage(),
    MapPage(),
    CameraPage(),
    ReviewPage(),
    EventsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        elevation: 0,
        title: Text(
          'NMEC',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: Colors.orange[500],
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.map_14),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.camera),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_border_outlined),
              label: 'Review',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_outlined),
              label: 'Events',
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange[500],
              ),
              child: Text(
                'Curio-Quest',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: Text('Museums'),
              onTap: () {
                Navigator.pushNamed(context, '/museums');
              },
            ),
            ListTile(
              title: Text('Share'),
              onTap: () {
                Navigator.pushNamed(context, '/share');
              },
            ),
            ListTile(
              title: Text('About us'),
              onTap: () {
                Navigator.pushNamed(context, '/about-us');
              },
            ),
            ListTile(
              title: Text('Log out'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NmecHomePage extends StatefulWidget {
  @override
  State<NmecHomePage> createState() => _NmecHomePageState();
}

class _NmecHomePageState extends State<NmecHomePage> {
  String search = '';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      search = _searchController.text;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "NMEC",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
            child: Text(
              "NMEC is the first museum in the Arab world focusing on the first civilization in the history.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search, color: Colors.black),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  onPressed: _clearSearch,
                  icon: Icon(Icons.clear, color: Colors.black),
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          _buildHorizontalList("Main Gallery", 'Main Gallery', search),
          _buildHorizontalList("Textile Gallery", 'TextTile Gallery', search),
          _buildHorizontalList("Royal Mummies Gallery", 'Royal Mummies Gallery', search),
        ],
      ),
    );
  }

  Widget _buildHorizontalList(String title, String db, String search) {
    final DatabaseReference ref = FirebaseDatabase.instance
        .refFromURL('https://cuiro-quest-msk-default-rtdb.firebaseio.com/')
        .child(db);

    return FutureBuilder<DatabaseEvent>(
      future: ref.once(),
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              SpinKitFadingCircle(
                color: Colors.orange[500],
                size: 50.0,
              ),
              SizedBox(height: 8)
            ],
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return Center(child: Text('No data available'));
        }

        List<dynamic> galleryItems = snapshot.data!.snapshot.value as List<dynamic>;

        // Filter items based on search query
        List<dynamic> filteredItems = galleryItems.where((item) {
          return item['Name'].toString().toLowerCase().contains(search.toLowerCase());
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ShowAllPage(db: db)));
                    },
                    label: Text(
                      'Show All',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    icon: Icon(Icons.add, size: 20, color: Colors.white),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 180,
              child: filteredItems.isEmpty
                  ? Center(
                child: Text(
                  'No item found',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
                  : CarouselSlider.builder(
                itemCount: filteredItems.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  var item = filteredItems[index];
                  if (item['ImageUrl'] == null) {
                    item['ImageUrl'] =
                    'https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg';
                  }

                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: EdgeInsets.all(0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.network(
                                    item['ImageUrl'],
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item['Name'] ?? 'Unnamed',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item['TextE'] ?? 'No description available',
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item['TextA'] ?? 'No description available',
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                item['ImageUrl'] ?? 'assets/images/NMEC.jpg',
                                height: 120,
                                width: 120,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              item['Name'] ?? 'Unnamed',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 260,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: search.isEmpty, // Enables infinite scroll only when there's no search
                  autoPlay: search.isEmpty, // Enables autoplay only when there's no search
                  autoPlayInterval: Duration(seconds: 3), // Sets the duration for each slide
                  viewportFraction: 0.4,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}