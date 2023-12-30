import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/controllers/note_cubit/note_cubit.dart';
import 'package:note_app/core/managers/app_strings.dart';
import 'package:note_app/core/models/note_model.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.brown.shade400,
            title: const Text(
              AppStrings.addNote,
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                  )),
              IconButton(
                onPressed: () {
                  cubit.insertToDatabase(
                    note: Note(
                      title: titleController.text,
                      content: contentController.text,
                    ),
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  /*---------------------------  Title TextField  -------------------------------*/
                  TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: AppStrings.title,
                      hintStyle: TextStyle(fontSize: 18.0),
                      border: InputBorder.none,
                    ),
                  ),

                  /*---------------------------  Content TextField  -------------------------------*/
                  TextField(
                    maxLines: 20,
                    keyboardType: TextInputType.text,
                    controller: contentController,
                    decoration: const InputDecoration(
                      hintText: AppStrings.note,
                      border: InputBorder.none,
                      filled: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
