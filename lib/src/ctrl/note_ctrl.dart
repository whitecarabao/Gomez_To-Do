//import material
import 'package:flutter/material.dart';

//import hive_flutter
import 'package:hive_flutter/hive_flutter.dart';

import '../note_model.dart';

class NoteCtrl with ChangeNotifier {
  final Box noteStash = Hive.box('notes');
  late String currUsr;
  List<Note> notes = [];

  NoteCtrl(this.currUsr) {
    List notesList = noteStash.get(currUsr, defaultValue: []);
    for (var noteIter in notesList) {
      print(noteIter.toString());
      notes.add(Note.fromJson(Map<String, dynamic>.from(noteIter)));
    }
    notifyListeners();
  }

  toggleNote(Note note) {
    note.changeStat();
    saveData();
    notifyListeners();
  }

  countNotes() {
    return notes.length;
  }

  saveData() {
    List<Map<String, dynamic>> notesList = [];
    for (Note noteIter in notes) {
      print("Saving note: ${noteIter.note}");
      notesList.add(noteIter.toJson());
    }
    noteStash.put(currUsr, notesList);
    notifyListeners();
  }

  addNote(Note noteInjection) {
    notes.add(noteInjection);
    saveData();
  }

  updateNote(Note noteInjection) {
    for (Note noteIter in notes) {
      if (noteIter.note == noteInjection.note) {
        noteIter.updateNote(noteInjection.note);
        saveData();
        break;
      }
    }
    notifyListeners();
  }

  deleteNote(Note noteInjection) {
    notes.remove(noteInjection);
    saveData();
  }
}
