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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 125, vertical: 15),
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