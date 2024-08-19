import 'package:aplikasi_catatan/Feature/Home/blocs/HomeBlocs.dart';
import 'package:aplikasi_catatan/Feature/Home/state/HomeState.dart';
import 'package:aplikasi_catatan/Feature/note/pages/NotePages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../note/pages/NoteAddPages.dart';

class HomePages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(context),
      child: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, ModelData>(
      builder: (context, state) {
        final filteredNotes = state.list.where((note) {
          return note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              note.catatan.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

        return PageView(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text("Notepad", style: TextStyle(color: Colors.black)),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: CupertinoSearchTextField(
                      controller: _searchController,
                      padding: EdgeInsets.all(15),
                      borderRadius: BorderRadius.circular(30),
                      placeholder: "Cari catatan",
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      child: filteredNotes.isNotEmpty
                          ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: filteredNotes.length,
                        itemBuilder: (ctx, item) {
                          final note = filteredNotes[item];
                          return Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                radius: 10,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NotePages(
                                        uid: state.uid!,
                                        noteId: note.id, // Pass the note ID here
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          note.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                                        child: Text(
                                          note.catatan,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10, top: 10),
                                        child: Text(
                                          note.tanggal,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                          : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/kosong.png", scale: 3),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Catatan kosong",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.green,
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteAddPages(uid: state.uid!, index: 0),
                    ),
                  );
                },
              ),
            ),
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text("Profil", style: TextStyle(color: Colors.black)),
              ),
              body: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: CircleAvatar(
                          child: Icon(Icons.person, size: 70),
                          radius: 50,
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          state.ussername!,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(LogoutEvent(context));
                      },
                      child: Text("Logout"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
