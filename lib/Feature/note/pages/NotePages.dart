import 'package:aplikasi_catatan/Feature/note/blocs/NoteBlocs.dart';
import 'package:aplikasi_catatan/Feature/note/state/NoteState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotePages extends StatelessWidget {
  final String uid;
  final String noteId;

  NotePages({required this.uid, required this.noteId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteBloc(uid, noteId, context),
      child: NoteDesign(),
    );
  }
}

class NoteDesign extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoteDesignState();
}

class _NoteDesignState extends State<NoteDesign> {
  @override
  void initState() {
    super.initState();
    // Dispatch LoadNote event when the widget is first built
    context.read<NoteBloc>().add(LoadNote(
      context.read<NoteBloc>().uid,  // Access the uid from NoteBloc
      context.read<NoteBloc>().noteId,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteBloc, NoteModel>(
      listener: (context, state) {
        if (state is NoteSaveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Catatan berhasil disimpan!')),
          );
        }
      },
      child: BlocBuilder<NoteBloc, NoteModel>(
        builder: (context, state) {
          final noteBloc = context.read<NoteBloc>();

          // Handle the TextUpdate state
          if (state is TextUpdate) {
            noteBloc.titleController.text = state.text;
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text("Catatan", style: TextStyle(color: Colors.black)),
              actions: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: () {
                    context.read<NoteBloc>().add(Hapus());
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.timer_outlined, color: Colors.black),
                  onPressed: () {
                    context.read<NoteBloc>().add(PengingatWaktu(context));
                  },
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    TextField(
                      controller: noteBloc.titleController,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: "Judul",
                        border: InputBorder.none,
                      ),
                    ),
                    Row(
                      children: [
                        Text("13 Agustus 2024", style: TextStyle(color: Colors.black54)),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text("|", style: TextStyle(color: Colors.black54)),
                        ),
                        Text("${state.character} karakter", style: TextStyle(color: Colors.black54)),

                      ],
                    ),
                    TextField(
                      controller: noteBloc.catatanController,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Mulai mengetik",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(Icons.save),
              onPressed: () {
                context.read<NoteBloc>().add(Save());
              },
            ),
          );
        },
      ),
    );
  }
}
