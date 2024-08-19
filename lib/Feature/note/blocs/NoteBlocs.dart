import 'package:aplikasi_catatan/Feature/note/state/NoteState.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

class NoteBloc extends Bloc<Event, NoteModel> {
  final String uid;
  final String noteId;
  TextEditingController titleController = TextEditingController();
  TextEditingController catatanController = TextEditingController();

  NoteBloc(this.uid, this.noteId, BuildContext context) : super(TextValue()) {
    // Handle Save event
    on<Save>((event, emit) async {
      await saveNoteData();
      emit(NoteSaveSuccess()); // Emit a success state
    });

    on<PengingatWaktu>((event,emit)async{
      pickDateTime(context, (selectedDateTime){
        final duration = selectedDateTime.difference(DateTime.now());
        Workmanager().registerOneOffTask(
          noteId,
          noteId,
          inputData: {'title': titleController.text},
          initialDelay: duration, // Delay pengingat sesuai kebutuhan
        );
      });
    });

    // Handle LoadNote event
    on<LoadNote>((event, emit) async {
      await loadNoteData();
      emit(TextUpdate(titleController.text,state.character)); // Pass updated text to state
    });

    // Handle DeleteNote event
    on<Hapus>((event, emit) async {
      await deleteNoteData();
      emit(NoteDeleteSuccess()); // Emit a success state
    });

    catatanController.addListener((){
      emit(TextUpdate(state.text, catatanController.text.characters.length));
    });

  }

  // Load note data using the unique ID
  Future<void> loadNoteData() async {
    final ref = FirebaseDatabase.instance.ref(uid).child("Catatan").child(noteId);
    final snapshot = await ref.get();
    if (snapshot.exists) {
      titleController.text = snapshot.child("title").value.toString();
      catatanController.text = snapshot.child("catatan").value.toString();
      emit(TextUpdate(titleController.text,catatanController.text.characters.length)); // Pass updated text to state
    }
  }

  // Save note data using the unique ID
  Future<void> saveNoteData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("$uid/Catatan/$noteId");

    await ref.update({
      "title": titleController.text,
      "catatan": catatanController.text,
      "tanggal": DateTime.now().toIso8601String(), // Use the current date
    });
  }

  // Delete note data using the unique ID
  Future<void> deleteNoteData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("$uid/Catatan/$noteId");
    await ref.remove();
  }

  @override
  Future<void> close() {
    // Cleanup controllers
    titleController.dispose();
    catatanController.dispose();
    return super.close();
  }
  Future<void> pickDateTime(BuildContext context, Function(DateTime) onDateTimePicked) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        onDateTimePicked(selectedDateTime);
      }
    }
  }
}
