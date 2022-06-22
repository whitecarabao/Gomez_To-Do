import 'package:simple_moment/simple_moment.dart';

class Note {
  late String note;
  late DateTime chrono;

  bool done = false;

  Note({
    this.note = '',
    DateTime? chrono,
  }) {
    chrono == null ? this.chrono = DateTime.now() : this.chrono = chrono;
  }

  Note.fromJson(Map<String, dynamic> json) {
    note = json['note'] ?? '';
    chrono = json['chrono'] ?? DateTime.now();
    done = json['done'] ?? false;
  }

  String get parseDate {
    return Moment.fromDateTime(chrono).format('hh:mm a MMMM dd, yyyy');
  }

  updateNote(String injection) {
    note = injection;
    chrono = DateTime.now();
  }

  clearNote() {
    note = "";
    chrono = DateTime.now();
  }

  changeStat() {
    done = !done;
  }

  Map<String, dynamic> get json => {
        'note': note,
        'chrono': chrono,
        'done': done,
      };
  Map<String, dynamic> toJson() {
    return json;
  }
}
