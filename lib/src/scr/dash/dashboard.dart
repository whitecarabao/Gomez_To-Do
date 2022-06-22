import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gomez_todo/src/ctrl/note_ctrl.dart';
import 'package:gomez_todo/src/scr/auth/auth_ctrl.dart';
//import note_model.dart
import 'package:gomez_todo/src/note_model.dart';

class DashScreen extends StatefulWidget {
  final AuthCtrl authCtrl;
  const DashScreen(
    this.authCtrl, {
    Key? key,
  }) : super(key: key);

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  late NoteCtrl _noteCtrl;
  final ScrollController _scroll = ScrollController();

  AuthCtrl get _authCtrl => widget.authCtrl;
  List<Note> _notes = [
    Note(
      note: 'Kill the zombies',
      chrono: DateTime.now(),
    ),
  ];
  Note tempNote = Note();

  @override
  void initState() {
    _noteCtrl = NoteCtrl(_authCtrl.currUsr!.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Hello! There are ' +
              _noteCtrl.countNotes().toString() +
              ' notes in storage'),
          backgroundColor: const Color(0xFF2C2C2C),
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  //open add dialog that shows a text field and save and cancel button
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                              title: const Text('Add a note'),
                              content: TextField(
                                onChanged: (injection) {
                                  tempNote.clearNote();
                                  tempNote.note = injection;
                                },
                              ),
                              actions: [
                                FlatButton(
                                  child: const Text('Cancel'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                FlatButton(
                                    child: const Text('Save'),
                                    onPressed: () {
                                      _notes.add(
                                        Note(
                                          note: tempNote.note.toString(),
                                          chrono: DateTime.now(),
                                        ),
                                      );
                                      _noteCtrl.addNote(tempNote);

                                      Navigator.pop(context);
                                      //tempNote.clearNote();
                                      setState(() {});
                                    })
                              ]));
                })
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scroll.animateTo(0.0,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        },
        child: const Icon(Icons.keyboard_arrow_up),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  child: Center(
                      child: Column(
                children: [
                  for (Note note in _noteCtrl.notes)
                    ListTile(
                      title: Column(children: [
                        if (note.done)
                          Text(
                            note.note.toString(),
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          )
                        else
                          Text(note.note.toString())
                      ]),
                      subtitle: Text(note.parseDate),
                      onTap: () {
                        //call changeStat()
                        //note.changeStat();
                        _noteCtrl.toggleNote(note);
                        _noteCtrl.saveData();
                        setState(() {});
                      },
                      onLongPress: () {
                        //open edit dialog that shows a text field and save and cancel button
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: const Text('Edit a note'),
                                    content: TextField(
                                      onChanged: (injection) {
                                        note.updateNote(injection);
                                      },
                                    ),
                                    actions: [
                                      FlatButton(
                                        child: const Text('Cancel'),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      FlatButton(
                                          child: const Text('Save'),
                                          onPressed: () {
                                            _noteCtrl.updateNote(note);
                                            setState(() {});
                                            Navigator.pop(context);
                                          })
                                    ]));
                      },
                      trailing: Column(children: [
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _noteCtrl.deleteNote(note);
                              _noteCtrl.saveData();
                              setState(() {});
                            }),
                      ]),
                    ),
                ],
              )))
            ],
          ),
        ),
      ),
    );
  }
}
