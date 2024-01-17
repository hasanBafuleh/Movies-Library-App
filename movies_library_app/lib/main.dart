// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    show();
    super.initState();
  }

  Widget buildActorRow(String name, String age, String country) {
    return Row(
      children: [
        Expanded(
          child: Text('Name: $name', style: TextStyle(fontSize: 16)),
        ),
        Expanded(
          child: Text('Age: $age', style: TextStyle(fontSize: 16)),
        ),
        Expanded(
          child: Text('Country: $country', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  void editMovie(int movieId) {
    // Implement edit logic here
  }

  void likeMovie(int movieId) {
    // Implement like logic here
  }

  var movies = [];
  show() async {
    var response = await http.get(Uri.parse("http://localhost:3000/movies"));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    setState(() {
      movies = jsonDecode(utf8.decode(response.bodyBytes));
    });
  }

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var releaseYearController = TextEditingController();
  var genreController = TextEditingController();
  var directorController = TextEditingController();

  var actor1NameController = TextEditingController();
  var actor1AgeController = TextEditingController();
  var actor1CountryController = TextEditingController();

  var actor2NameController = TextEditingController();
  var actor2AgeController = TextEditingController();
  var actor2CountryController = TextEditingController();

  var actor3NameController = TextEditingController();
  var actor3AgeController = TextEditingController();
  var actor3CountryController = TextEditingController();

  add() async {
    var response =
        await http.post(Uri.parse("http://localhost:3000/movies"), headers: {
      'content-type': 'application/json'
    }, body: {
      'titleController': titleController.value,
      'descriptionController': descriptionController.value,
      'releaseYearController': releaseYearController.value,
      'genreController': genreController.value,
      'directorController': directorController.value,
      'actor1NameController': actor1NameController.value,
      'actor1AgeController': actor1AgeController.value,
      'actor1CountryController': actor1CountryController.value,
      'actor2NameController': actor2NameController.value,
      'actor2AgeController': actor2AgeController.value,
      'actor2CountryController': actor2CountryController.value,
      'actor3NameController': actor3NameController.value,
      'actor3AgeController': actor3AgeController.value,
      'actor3CountryController': actor3CountryController.value,
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

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
        backgroundColor: Color.fromRGBO(110, 194, 177, 1),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(4, 66, 61, 0.843)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              // Handle search functionality
                            },
                            color: Color.fromRGBO(4, 66, 61, 0.843),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromRGBO(4, 66, 61, 0.843),
                      ),
                    ),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Add New Movie",
                            style: TextStyle(
                              color: Color.fromRGBO(4, 66, 61, 0.843),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: titleController,
                            decoration: InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.all(8.0),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.all(8.0),
                            ),
                            validator: (String? value) {
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: releaseYearController,
                            decoration: InputDecoration(
                              labelText: 'Release Year',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.all(8.0),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (String? value) {
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: genreController,
                            decoration: InputDecoration(
                              labelText: 'Genre',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.all(8.0),
                            ),
                            validator: (String? value) {
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: directorController,
                            decoration: InputDecoration(
                              labelText: 'Director',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.all(8.0),
                            ),
                            validator: (String? value) {
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Cast",
                            style: TextStyle(
                              color: Color.fromRGBO(4, 66, 61, 0.843),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: actor1NameController,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: actor1AgeController,
                                    decoration: InputDecoration(
                                      labelText: 'Age',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: actor1CountryController,
                                    decoration: InputDecoration(
                                      labelText: 'Country',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: actor2NameController,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: actor2AgeController,
                                    decoration: InputDecoration(
                                      labelText: 'Age',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: actor2CountryController,
                                    decoration: InputDecoration(
                                      labelText: 'Country',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: actor3NameController,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: actor3AgeController,
                                    decoration: InputDecoration(
                                      labelText: 'Age',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: actor3CountryController,
                                    decoration: InputDecoration(
                                      labelText: 'Country',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(4, 66, 61, 0.843),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.all(15),
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text('Add Movie'),
                                onPressed: () {
                                  show();
                                  for (var index = 0;
                                      index < movies.length;
                                      index++) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Movie Details'),
                                          content: Container(
                                            width: double.maxFinite,
                                            child: Card(
                                              margin: EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                  color: Color.fromRGBO(
                                                      4, 67, 62, 0.843),
                                                  width: 3,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      movies[index]['title'],
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      'Description: ${movies[index]['description']}',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      'Release Year: ${movies[index]['releaseYear']}',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      'Genre: ${movies[index]['genre']}',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      'Director: ${movies[index]['director']}',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      'Cast',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            4, 67, 62, 0.843),
                                                      ),
                                                    ),
                                                    buildActorRow(
                                                      movies[index]
                                                          ['actorName1'],
                                                      movies[index]
                                                          ['actorAge1'],
                                                      movies[index]
                                                          ['actorCountry1'],
                                                    ),
                                                    buildActorRow(
                                                      movies[index]
                                                          ['actorName2'],
                                                      movies[index]
                                                          ['actorAge2'],
                                                      movies[index]
                                                          ['actorCountry2'],
                                                    ),
                                                    buildActorRow(
                                                      movies[index]
                                                          ['actorName3'],
                                                      movies[index]
                                                          ['actorAge3'],
                                                      movies[index]
                                                          ['actorCountry3'],
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () =>
                                                              editMovie(
                                                                  movies[index]
                                                                      ['id']),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Color.fromRGBO(
                                                                    4,
                                                                    67,
                                                                    62,
                                                                    0.843),
                                                          ),
                                                          child: Text('Edit'),
                                                        ),
                                                        ElevatedButton.icon(
                                                          onPressed: () =>
                                                              likeMovie(
                                                                  movies[index]
                                                                      ['id']),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            shadowColor: Colors
                                                                .transparent,
                                                          ),
                                                          icon: Icon(
                                                              Icons.thumb_up),
                                                          label: Text(
                                                            movies[index]
                                                                    ['likes']
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Comments',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          // Add comment form and list here
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromRGBO(
                                                    4, 66, 61, 0.843),
                                                foregroundColor: Colors.white,
                                              ),
                                              child: Text('Close'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
