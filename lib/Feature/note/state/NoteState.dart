import 'package:flutter/cupertino.dart';

abstract class NoteModel {
  final String text;
  final int character;
  NoteModel(this.text,this.character);
}

class TextValue extends NoteModel {
  TextValue() : super("",0);
}

class TextUpdate extends NoteModel {
  TextUpdate(String text, int character) : super(text,character);
}

class NoteSaveSuccess extends NoteModel {
  NoteSaveSuccess() : super("",0); // This can be extended to include success messages or details if needed
}

abstract class Event {}

class Save extends Event {}
class Hapus extends Event{}
class PengingatWaktu extends Event{
  final BuildContext context;
  PengingatWaktu(this.context);
}

class LoadNote extends Event {
  final String uid;
  final String noteId;

  LoadNote(this.uid, this.noteId);
}
class DeleteNote extends Event {}
class NoteDeleteSuccess extends NoteModel {
  NoteDeleteSuccess() : super("",0); // Ensure this also extends NoteModel
}