import 'package:flutter/material.dart';
class GrecormHome extends StatelessWidget {
  const GrecormHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.orange[500],
          elevation: 0,
          title: Text(
            'GRM',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Greco-Roman Museum",
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
                  "Museum's collection is the product of donations from wealthy Alexandrians as well as of excavations led by successive directors of the institution.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 280,),
              Center(
                child: Text(
                    "COMMING SOON",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.orange[600],)),
              )
            ],
          ),

        )
    );
  }
}