import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/Utilities/dialogs/logout_dialog.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/services/auth/auth_service.dart';
import 'package:my_notes/enum/menu_items.dart';
import 'package:my_notes/services/auth/bloc/auth_bloc.dart';
import 'package:my_notes/services/auth/bloc/auth_event.dart';
import 'package:my_notes/services/cloud/cloud_note.dart';
import 'package:my_notes/services/cloud/firebase_cloud_storage.dart';
import 'package:my_notes/view/notes_view/note_list_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Notes",
          style: TextStyle(color: Colors.white),
        ),
        titleSpacing: 20.0,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: const Color.fromRGBO(136, 171, 142, 100.0),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(newNoteRoute);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          PopupMenuButton<MenuItem>(
            color: const Color.fromRGBO(242, 241, 235, 20.0),
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
            onSelected: (value) async {
              switch (value) {
                case MenuItem.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    if (context.mounted) {
                      context.read<AuthBloc>().add(const AuthEventLogginOut());
                    }
                  }
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<MenuItem>(
                  value: MenuItem.logout,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Logout',
                    ),
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: _notesService.deleteUnneccesaryNotes(),
        builder: (((context, snapshot) {
          return StreamBuilder(
            stream: _notesService.allNotes(ownerUserId: userId),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    final allNotes = snapshot.data as Iterable<CloudNote>;
                    return NotesListView(
                      notes: allNotes.where((element) => element.text != ''),
                      onDeleteNote: (note) async {
                        await _notesService.deleteNote(
                            documentId: note.documentId);
                      },
                      onTap: (note) {
                        Navigator.of(context).pushNamed(
                          newNoteRoute,
                          arguments: note,
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                default:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(175, 200, 173, 100.0),
                    ),
                  );
              }
            },
          );
        })),
      ),
    );
  }
}
