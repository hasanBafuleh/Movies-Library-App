// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(4, 66, 61, 0.843),
          title: Text(
            'Movies Library',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromRGBO(109, 193, 176, 0.843),
        body: Align(
          alignment: Alignment.topCenter,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(40),
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to our 'Movie Library' application!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Explore, search, and manage an extensive collection of movies. Add your favorite films, update details, and even delete entries. Your personalized movie database is just a click away!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
