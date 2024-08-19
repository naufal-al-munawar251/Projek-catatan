import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/NoteAddBlocs.dart';
import '../state/NoteAddState.dart';

class NoteAddPages extends StatefulWidget {
  final String uid;
  final int index;

  NoteAddPages({required this.uid, required this.index});

  @override
  State<StatefulWidget> createState() => NoteAddDesign(uid: uid, index: index);
}

class NoteAddDesign extends State<NoteAddPages> {
  final String uid;
  final int index;

  NoteAddDesign({required this.uid, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteAddBloc(uid),
      child: BlocListener<NoteAddBloc, NoteAddModel>(
        listener: (context, state) {
          if (state is NoteAddSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.text)),
            );
          }
        },
        child: BlocBuilder<NoteAddBloc, NoteAddModel>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text("Catatan", style: TextStyle(color: Colors.black)),
              ),
              body: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      TextField(
                        controller: context.read<NoteAddBloc>().titleController,
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                          Text("50 karakter", style: TextStyle(color: Colors.black54)),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text("|", style: TextStyle(color: Colors.black54)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(Icons.timer_outlined, size: 15, color: Colors.black54),
                          ),
                          Text("50 karakter", style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                      TextField(
                        controller: context.read<NoteAddBloc>().catatanController,
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
                  context.read<NoteAddBloc>().add(Save());
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
