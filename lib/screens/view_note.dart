import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/utils/widgets.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final DocumentReference ref;

  ViewNote(this.data, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  String title;
  String description;
  int color;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdited = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    title = 'Edit Note';
    titleController.text = widget.data['title'];
    descriptionController.text = widget.data['description'];
    color = widget.data['color'];
    return SafeArea(
      child: WillPopScope(
          onWillPop: () async {
            isEdited ? showDiscardDialog(context) : moveToLastScreen();
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                title,
                style: Theme.of(context).textTheme.headline5,
              ),
              backgroundColor: colors[color],
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () {
                    isEdited ? showDiscardDialog(context) : moveToLastScreen();
                  }),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.save,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    titleController.text.length == 0
                        ? showEmptyTitleDialog(context)
                        : save();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: () {
                    showDeleteDialog(context);
                  },
                )
              ],
            ),
            body: Container(
              color: colors[color],
              child: Column(
                children: <Widget>[
                  PriorityPicker(
                    selectedIndex: 3 - widget.data['priority'],
                    onTap: (index) {
                      isEdited = true;
                      widget.data['priority'] = 3 - index;
                    },
                  ),
                  ColorPicker(
                    selectedIndex: color,
                    onTap: (index) {
                      setState(() {
                        color = index;
                      });
                      isEdited = true;
                      widget.data['color'] = index;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      controller: titleController,
                      maxLength: 255,
                      style: Theme.of(context).textTheme.bodyText2,
                      onChanged: (value) {
                        updateTitle();
                      },
                      decoration: InputDecoration.collapsed(
                        hintText: 'Title',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        maxLength: 255,
                        controller: descriptionController,
                        style: Theme.of(context).textTheme.bodyText1,
                        onChanged: (value) {
                          updateDescription();
                        },
                        decoration: InputDecoration.collapsed(
                          hintText: 'Description',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void showDiscardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Discard Changes?",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          content: Text("Are you sure you want to discard changes?",
              style: Theme.of(context).textTheme.bodyText1),
          actions: <Widget>[
            TextButton(
              child: Text("No",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
                moveToLastScreen();
              },
            ),
          ],
        );
      },
    );
  }

  void showEmptyTitleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Title is empty!",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          content: Text('The title of the note cannot be empty.',
              style: Theme.of(context).textTheme.bodyText1),
          actions: <Widget>[
            TextButton(
              child: Text("Okay",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Delete Note?",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          content: Text("Are you sure you want to delete this note?",
              style: Theme.of(context).textTheme.bodyText1),
          actions: <Widget>[
            TextButton(
              child: Text("No",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
                delete();
              },
            ),
          ],
        );
      },
    );
  }



  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    isEdited = true;
    widget.data['title'] = titleController.text;
  }

  void updateDescription() {
    isEdited = true;
    widget.data['description'] = descriptionController.text;
  }

  void delete() async {
    // delete from db
    await widget.ref.delete();
    Navigator.pop(context);
  }

  void save() async {

      await widget.ref.update(
        {
          'title': titleController.text,
          'description': descriptionController.text,
          'color': color,
          'priority': widget.data['priority'],
          'created': DateTime.now(),
        },
      );
      Navigator.of(context).pop();
  }

}