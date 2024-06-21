import 'package:cuiro_quest_app/shared/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cuiro_quest_app/layout/egyptm_home.dart';
import 'package:cuiro_quest_app/layout/grecorm_home.dart';
import '../shared/cashhelper.dart';
import 'NMEC_HOME.dart';
import 'grandem_home.dart';
import '../models/login_screen.dart'; // Ensure this import is correct

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onTap: () async {
                // Clear saved data
                await CasheHelper.removeData(key: 'uId');
                await FirebaseAuth.instance.signOut();

                // Navigate to login screen and remove all previous routes
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ImportScreen2()), // Ensure correct login screen
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: Text(
          'Curio Quest',
          style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Museums',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange[500],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  MuseumCard(
                    image: 'assets/images/NMEC.jpg',
                    name: 'National Museum of Egyptian Civilization',
                    description:
                    """This museum presents the Egyptian civilization from prehistoric times to the present day. is a large museum (490,000 square metres) located in Old Cairo, a district of Cairo, Egypt. Partially opened in 2017, the museum was officially inaugurated on 3 April 2021 by President Abdel Fattah El-Sisi. The museum displays a collection of 50,000 artifacts, presenting the Egyptian civilization from prehistoric times to the present day.""",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NmecHome()));
                    },
                  ),
                  SizedBox(width: 16.0),
                  MuseumCard(
                    image: 'assets/images/grand_museum.webp',
                    name: 'The Grand Egyptian Museum',
                    description: """The building design was decided by an architectural competition[8] announced on 7 January 2002. The organisers received 1,557 entries from 82 countries, making it the second largest architectural competition in history. In the second stage of the competition, 20 entries submitted additional information on their designs.""",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GrandemHome()));
                    },
                  ),
                  SizedBox(width: 16.0),
                  MuseumCard(
                    image: 'assets/images/Egyptian_museum.JPG',
                    name: 'The Egyptian Museum',
                    description: """The Egyptian Museum of Antiquities contains many important pieces of ancient Egyptian history. It houses the world's largest collection of Pharaonic antiquities. The Egyptian government established the museum built in 1835 near the Ezbekieh Garden and later moved to the Cairo Citadel.""",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EgyptmHome()));
                    },
                  ),
                  SizedBox(width: 16.0),
                  MuseumCard(
                    image: 'assets/images/greek_museum.JPG',
                    name: 'Greco-Roman Museum',
                    description: """Museum's collection is the product of donations from wealthy Alexandrians as well as of excavations led by successive directors of the institution, both within the town and in its environs. Certain other objects have come from the Organization of Antiquities at Cairo (particularly those of the Pharaonic period) and from various digs undertaken at the beginning of the century in Fayoum and at Benhasa.""",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GrecormHome()));
                    },
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

class MuseumCard extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final VoidCallback onPressed;

  const MuseumCard({
    Key? key,
    required this.image,
    required this.name,
    required this.description,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      borderRadius: BorderRadius.circular(15.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          width: 300.0,
          height: double.infinity, // Set a fixed height for the Card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect( //7waf Elsora
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: Image.asset(
                  image,
                  height: 200.0, // Increase the height of the image
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
