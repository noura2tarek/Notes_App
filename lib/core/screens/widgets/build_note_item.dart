import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/core/controllers/note_cubit/note_cubit.dart';
import 'package:note_app/core/network/local/sql_database.dart';
import '../../models/note_model.dart';
import '../modules/edit_note_screen.dart';

SqlDB sqlDB = SqlDB();


Widget buildNoteItem({required Note note, required BuildContext context}) {
  return Card(
    elevation: 3.0,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: const RoundedRectangleBorder(
       borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    child: ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditNoteScreen(
            note: note,
          ),
        ),
      ),

      title: Text(
        "${note.title}",
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        "${note.content}",
        style: const TextStyle(fontSize: 20.0, color: Colors.black54),
      ),
      trailing: IconButton(
        onPressed: () async {
          NoteCubit.get(context).deleteFromDatabase(id: note.id!);
        },
        icon: const Icon(
          Icons.delete_outlined,
          color: Colors.redAccent,
        ),
      ),
    ),
  );
}

