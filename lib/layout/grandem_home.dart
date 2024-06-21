import 'package:flutter/material.dart';
class GrandemHome extends StatelessWidget {
  const GrandemHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.orange[500],
          elevation: 0,
          title: Text(
            'GEM',
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
                  "The Grand Egyptian Museum",
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
                  "The building design is the second largest architectural competition in history.",
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