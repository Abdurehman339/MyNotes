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
        title: const Text('Your Notes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(newNoteRoute);
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<MenuItem>(
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
              return const [
                PopupMenuItem<MenuItem>(
                  value: MenuItem.logout,
                  child: Text('Log out'),
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
                    return const Text("Hello");
                  }
                default:
                  return const CircularProgressIndicator();
              }
            },
          );
        })),
      ),
    );
  }
}
