// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_key_in_widget_constructors, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List to hold widgets for movie details
  List<Widget> moviesDetailsWidgets = [];

  int? movieId;
  @override
  void initState() {
    super.initState();

    titleController = TextEditingController();
    descriptionController = TextEditingController();
    releaseYearController = TextEditingController();
    genreController = TextEditingController();
    directorController = TextEditingController();

    actor1NameController = TextEditingController();
    actor1AgeController = TextEditingController();
    actor1CountryController = TextEditingController();

    actor2NameController = TextEditingController();
    actor2AgeController = TextEditingController();
    actor2CountryController = TextEditingController();

    actor3NameController = TextEditingController();
    actor3AgeController = TextEditingController();
    actor3CountryController = TextEditingController();

    searchController = TextEditingController();
    addMovieBtnController = TextEditingController();

    show();
  }

  // Method to build a row for actor details
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

// Function to handle movie editing
  void editMovie(int movieId) async {
    // Scroll to the top
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeInOut,
      duration: Duration(seconds: 1),
    );
    // Fetch movie details from the server
    final response =
        await http.get(Uri.parse("http://localhost:3000/movies/$movieId"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> movieDetails = json.decode(response.body);

      // Set controller values with movie details
      titleController.text = movieDetails['title'];
      descriptionController.text = movieDetails['description'];
      releaseYearController.text = movieDetails['releaseYear'];
      genreController.text = movieDetails['genre'];
      directorController.text = movieDetails['director'];
      actor1NameController.text = movieDetails['actorName1'];
      actor1AgeController.text = movieDetails['actorAge1'];
      actor1CountryController.text = movieDetails['actorCountry1'];
      actor2NameController.text = movieDetails['actorName2'];
      actor2AgeController.text = movieDetails['actorAge2'];
      actor2CountryController.text = movieDetails['actorCountry2'];
      actor3NameController.text = movieDetails['actorName3'];
      actor3AgeController.text = movieDetails['actorAge3'];
      actor3CountryController.text = movieDetails['actorCountry3'];

      // Update the form button to indicate editing mode
      setState(() {
        this.movieId = movieId;
        isEditMode = true;
      });

      // Remove listener for Add Movie button
      addMovieBtnController.removeListener(add);

      // Add listener for Update Movie button
      addMovieBtnController.addListener(() => updateMovie(movieId));
    }
  }

// Function to handle movie update
  void updateMovie(int? movieId) async {
    if (movieId == null) {
      print('Movie ID is null');
      return;
    }

    // Fetch the latest movie data from the server
    await show();

    // Find the movie details map in the list
    int index = movies.indexWhere((movie) => movie['id'] == movieId);

    if (index != -1) {
      // Update the values in the movies list
      movies[index]['title'] = titleController.text;
      movies[index]['description'] = descriptionController.text;
      movies[index]['releaseYear'] = releaseYearController.text;
      movies[index]['genre'] = genreController.text;
      movies[index]['director'] = directorController.text;
      movies[index]['actorName1'] = actor1NameController.text;
      movies[index]['actorAge1'] = actor1AgeController.text;
      movies[index]['actorCountry1'] = actor1CountryController.text;
      movies[index]['actorName2'] = actor2NameController.text;
      movies[index]['actorAge2'] = actor2AgeController.text;
      movies[index]['actorCountry2'] = actor2CountryController.text;
      movies[index]['actorName3'] = actor3NameController.text;
      movies[index]['actorAge3'] = actor3AgeController.text;
      movies[index]['actorCountry3'] = actor3CountryController.text;

      // Update the movie on the server
      await http.put(
        Uri.parse("http://localhost:3000/movies/$movieId"),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(movies[index]),
      );

      // Rebuild the UI with the updated movie details
      setState(() {
        moviesDetailsWidgets[index] = buildMovieDetails(context, index);
        isEditMode = false;
      });

      // Add listener for Add Movie button
      addMovieBtnController.addListener(add);

      // Remove listener for Update Movie button
      addMovieBtnController.removeListener(() => updateMovie(movieId));

      // Reset the form after updating
      resetForm();

      // Refresh the UI after updating
      await show();
    } else {
      print('Movie with id $movieId not found.');
    }
  }

  void resetForm() {
    titleController.clear();
    descriptionController.clear();
    releaseYearController.clear();
    genreController.clear();
    directorController.clear();
    actor1NameController.clear();
    actor1AgeController.clear();
    actor1CountryController.clear();
    actor2NameController.clear();
    actor2AgeController.clear();
    actor2CountryController.clear();
    actor3NameController.clear();
    actor3AgeController.clear();
    actor3CountryController.clear();
  }

  // Method to handle liking a movie
  void likeMovie(int movieId) async {
    print("Like button clicked for movieId: $movieId");

    await http.post(
      Uri.parse("http://localhost:3000/movies/$movieId/like"),
    );

    // Refresh the UI to show updated likes
    show();
  }

  // List to hold movie data
  List movies = [];

  // Controllers for text fields
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

  var searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  TextEditingController addMovieBtnController = TextEditingController();

  bool isEditMode = false;

  void searchMovies() {
    String searchTerm = searchController.text.toLowerCase();

    List filteredMovies = movies.where((movie) {
      String title = movie['title'].toLowerCase();
      return title.contains(searchTerm);
    }).toList();

    setState(() {
      moviesDetailsWidgets = filteredMovies.map((movie) {
        return buildMovieDetails(context, movies.indexOf(movie));
      }).toList();
    });
  }

  void deleteMovie(int movieId) async {
    // Implement logic to delete the movie from the database and update UI
    await http.delete(Uri.parse("http://localhost:3000/movies/$movieId"));
    show(); // Refresh the movie list after deletion
  }

  // Method to fetch movie data from the server
  show() async {
    var response = await http.get(Uri.parse("http://localhost:3000/movies"));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    setState(() {
      movies = jsonDecode(utf8.decode(response.bodyBytes));
      // Clear the existing widgets
      moviesDetailsWidgets.clear();

      // Populate the list with movie details widgets
      for (int i = 0; i < movies.length; i++) {
        moviesDetailsWidgets.add(buildMovieDetails(context, i));
      }

      // Reverse the list to display the latest movies first
      moviesDetailsWidgets = moviesDetailsWidgets.reversed.toList();
    });
  }

  // Method to add a new movie
  add() async {
    if (titleController.text == "" || descriptionController.text == "") return;

    var response = await http.post(
      Uri.parse("http://localhost:3000/movies"),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({
        'title': titleController.text,
        'description': descriptionController.text,
        'releaseYear': releaseYearController.text,
        'genre': genreController.text,
        'director': directorController.text,
        'actorName1': actor1NameController.text,
        'actorAge1': actor1AgeController.text,
        'actorCountry1': actor1CountryController.text,
        'actorName2': actor2NameController.text,
        'actorAge2': actor2AgeController.text,
        'actorCountry2': actor2CountryController.text,
        'actorName3': actor3NameController.text,
        'actorAge3': actor3AgeController.text,
        'actorCountry3': actor3CountryController.text,
      }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Clear the form and refresh the UI to show the new movie
    resetForm();
    show();
  }

  // Method to build the details widget for a movie
  Widget buildMovieDetails(BuildContext context, int index) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          width: double.maxFinite,
          child: Card(
            color: Color.fromRGBO(255, 255, 255, 1),
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Color.fromRGBO(4, 67, 62, 0.843),
                width: 3,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movies[index]['title'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Description: ${movies[index]['description']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Release Year: ${movies[index]['releaseYear']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Genre: ${movies[index]['genre']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Director: ${movies[index]['director']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Cast',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(4, 67, 62, 0.843),
                          ),
                        ),
                        buildActorRow(
                          movies[index]['actorName1'],
                          movies[index]['actorAge1'],
                          movies[index]['actorCountry1'],
                        ),
                        buildActorRow(
                          movies[index]['actorName2'],
                          movies[index]['actorAge2'],
                          movies[index]['actorCountry2'],
                        ),
                        buildActorRow(
                          movies[index]['actorName3'],
                          movies[index]['actorAge3'],
                          movies[index]['actorCountry3'],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () => editMovie(movies[index]['id']),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Color.fromRGBO(4, 67, 62, 0.843),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => likeMovie(movies[index]['id']),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Color.fromRGBO(4, 67, 62, 0.843),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: Icon(Icons.thumb_up),
                              label: Text(
                                movies[index]['likes'].toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Comments',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              // Add comment form and list here
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => deleteMovie(movies[index]['id']),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
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
        body: ListView(controller: _scrollController, children: [
          Center(
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
                        controller: searchController,
                        style: TextStyle(),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(4, 66, 61, 0.843),
                              width: 3,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(4, 66, 61, 0.843),
                              width: 3,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              // Handle search functionality
                              searchMovies();
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
                        width: 3,
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
                                child: Text(
                                  isEditMode ? 'Update Movie' : 'Add Movie',
                                ),
                                onPressed: () {
                                  // Display movie details for each movie
                                  isEditMode ? updateMovie(movieId) : add();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: moviesDetailsWidgets,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
