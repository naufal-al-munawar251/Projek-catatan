import 'dart:convert';

class Note {
  final String id;
  final String title;
  final String catatan;
  final String tanggal;

  Note({
    required this.id,
    required this.title,
    required this.catatan,
    required this.tanggal,
  });

  factory Note.fromMap(Map<String, dynamic> map, String id) { // ID is passed separately
    return Note(
      id: id, // Set the ID
      title: map['title'],
      catatan: map['catatan'],
      tanggal: map['tanggal'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'catatan': catatan,
      'tanggal': tanggal,
    };
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source, String id) => Note.fromMap(json.decode(source), id);
}
