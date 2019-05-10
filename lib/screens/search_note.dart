import 'package:flutter/material.dart';
import 'package:notes_app/modal_class/notes.dart';

class NotesSearch extends SearchDelegate<Note> {
  final List<Note> notes;
  List<Note> filteredNotes = [];
  NotesSearch({this.notes});

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
        hintColor: Colors.black,
        primaryColor: Colors.white,
        textTheme: TextTheme(
          title: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ));
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query == '') {
      return Container(
        color: Colors.white,
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.search,
                size: 50,
                color: Colors.black,
              ),
            ),
            Text(
              'Enter a note to search.',
              style: TextStyle(color: Colors.black),
            )
          ],
        )),
      );
    } else {
      filteredNotes = [];
      getFilteredList(notes);
      if (filteredNotes.length == 0) {
        return Container(
          color: Colors.white,
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.sentiment_dissatisfied,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              Text(
                'No results found',
                style: TextStyle(color: Colors.black),
              )
            ],
          )),
        );
      } else {
        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: filteredNotes.length == null ? 0 : filteredNotes.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  Icons.note,
                  color: Colors.black,
                ),
                title: Text(
                  filteredNotes[index].title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
                subtitle: Text(
                  filteredNotes[index].description,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
                onTap: () {
                  close(context, filteredNotes[index]);
                },
              );
            },
          ),
        );
      }
    }
  }

  List<Note> getFilteredList(List<Note> note) {
    for (int i = 0; i < note.length; i++) {
      if (note[i].title.toLowerCase().contains(query) ||
          note[i].description.toLowerCase().contains(query)) {
        filteredNotes.add(note[i]);
      }
    }
    return filteredNotes;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == '') {
      return Container(
        color: Colors.white,
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.search,
                size: 50,
                color: Colors.black,
              ),
            ),
            Text(
              'Enter a note to search.',
              style: TextStyle(color: Colors.black),
            )
          ],
        )),
      );
    } else {
      filteredNotes = [];
      getFilteredList(notes);
      if (filteredNotes.length == 0) {
        return Container(
          color: Colors.white,
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.sentiment_dissatisfied,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              Text(
                'No results found',
                style: TextStyle(color: Colors.black),
              )
            ],
          )),
        );
      } else {
        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: filteredNotes.length == null ? 0 : filteredNotes.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  Icons.note,
                  color: Colors.black,
                ),
                title: Text(
                  filteredNotes[index].title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
                subtitle: Text(
                  filteredNotes[index].description,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
                onTap: () {
                  close(context, filteredNotes[index]);
                },
              );
            },
          ),
        );
      }
    }
  }
}
