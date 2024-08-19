import 'dart:async';

import 'package:aplikasi_catatan/Config/FirebaseLogout.dart';
import 'package:aplikasi_catatan/Feature/Home/model/ModelData.dart';
import 'package:aplikasi_catatan/Feature/Home/state/HomeState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomeBloc extends Bloc<HomeEvent, ModelData> {
  List<Note> notesList = [];
  final FirebaseLogout firebaseLogout;
  StreamSubscription? _notesSubscription;

  HomeBloc(BuildContext context)
      : firebaseLogout = FirebaseLogout(),
        super(ModelIntial()) {
    on<OnHomeEvent>((event, emit) {
      editDatabase(event.index, context);
    });

    on<LogoutEvent>((event, emit) {
      firebaseLogout.Logout(event.context);
    });

    checkLogin(context);
  }

  void checkLogin(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        final ref = FirebaseDatabase.instance.ref();
        final snapshot = await ref.child(user.uid).get();
        if (snapshot.exists) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(
              message: "Selamat datang ${snapshot.child("Nama").value}",
            ),
          );
          emit(ModelUpdate([], snapshot.child("Nama").value.toString(), user.email!, user.uid, state.index));
        } else {
          print('No data available.');
        }

        initializeDatabase();
      }
    });
  }

  void initializeDatabase() {
    final notesRef = FirebaseDatabase.instance.ref(state.uid).child("Catatan");

    _notesSubscription?.cancel();

    _notesSubscription = notesRef.onChildAdded.listen((event) {
      notesList.add(Note(
        id: event.snapshot.key ?? '', // Store the Push ID
        title: event.snapshot.child("title").value.toString(),
        catatan: event.snapshot.child("catatan").value.toString(),
        tanggal: event.snapshot.child("tanggal").value.toString(),
      ));
      _emitUpdatedState();
    });

    notesRef.onChildChanged.listen((event) {
      final index = notesList.indexWhere((note) => note.id == event.snapshot.key);
      if (index != -1) {
        notesList[index] = Note(
          id: event.snapshot.key ?? '',
          title: event.snapshot.child("title").value.toString(),
          catatan: event.snapshot.child("catatan").value.toString(),
          tanggal: event.snapshot.child("tanggal").value.toString(),
        );
        _emitUpdatedState();
      }
    });

    notesRef.onChildRemoved.listen((event) {
      notesList.removeWhere((note) => note.id == event.snapshot.key);
      _emitUpdatedState();
    });
  }

  void editDatabase(int index, BuildContext context) {
    final noteToEdit = notesList[index];
    final noteRef = FirebaseDatabase.instance.ref(state.uid).child("Catatan").child(noteToEdit.id);

    // Perform the update based on the note ID
    noteRef.update({
      "title": noteToEdit.title, // Update with new values
      "catatan": noteToEdit.catatan,
      "tanggal": DateTime.now().toIso8601String(), // Update the date if necessary
    }).then((_) {
      _emitUpdatedState(); // Emit the updated state after successful update
    }).catchError((error) {
      print('Update failed: $error');
    });
  }

  void _emitUpdatedState() {
    emit(ModelUpdate(notesList, state.ussername!, state.email!, state.uid!, state.index));
  }

  @override
  Future<void> close() {
    _notesSubscription?.cancel();
    return super.close();
  }
}
