import 'package:aplikasi_catatan/Feature/note/state/NoteAddState.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteAddBloc extends Bloc<EventAdd, NoteAddModel> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();
  final String uid;

  NoteAddBloc(this.uid) : super(TextAddValue()) {
    // Emit initial state
    emit(TextAddUpdate(uid));

    // Handle save event
    on<Save>((event, emit) async {
      await databaseNote();
      emit(NoteAddSuccess()); // Emit success state after saving
    });
  }

  Future<void> databaseNote() async {
    // Reference to the notes list in the database, using push() to create a unique ID
    DatabaseReference ref = FirebaseDatabase.instance.ref("$uid/Catatan").push();

    // Set data to Firebase
    await ref.set({
      "title": titleController.text,
      "catatan": catatanController.text,
      "tanggal": DateTime.now().toIso8601String(), // Use current date
    });
  }

  @override
  Future<void> close() {
    // Cleanup controllers
    titleController.dispose();
    catatanController.dispose();
    return super.close();
  }
}
