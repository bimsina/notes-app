import 'package:flutter/material.dart';

class NoteAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        title: Text('About MyNotes'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(50),
            child: Text('MyNotes is a dark version of NoteKeeper app created by Bimsina (https://github.com/bimsina/notes-app)',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 14,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'App Name',
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 14,
              ),
            ),
            trailing: Text(
              'MyNotes',
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 14,
              ),
            ),
          ),
          
          ListTile(
            title: Text(
              'Version',
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 14,
              ),
            ),
            trailing: Text(
              '1.0.0',
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 14,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Developer',
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 14,
              ),
            ),
            trailing: Text(
              'beodroid@gmail.com',
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 14,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'License',
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 14,
              ),
            ),
            trailing: Text(
              'MIT',
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
