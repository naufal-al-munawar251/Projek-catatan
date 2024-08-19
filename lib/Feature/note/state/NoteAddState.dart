// Model classes
abstract class NoteAddModel {
  final String text;
  NoteAddModel(this.text);
}

class TextAddValue extends NoteAddModel {
  TextAddValue() : super("");
}

class TextAddUpdate extends NoteAddModel {
  TextAddUpdate(String text) : super(text);
}

// New state to represent successful save
class NoteAddSuccess extends NoteAddModel {
  NoteAddSuccess() : super("Note added successfully!");
}

// Event classes
abstract class EventAdd {}

class Save extends EventAdd {}
