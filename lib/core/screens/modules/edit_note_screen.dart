import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/controllers/note_cubit/note_cubit.dart';
import 'package:note_app/core/models/note_model.dart';
import '../../managers/app_strings.dart';

class EditNoteScreen extends StatelessWidget {
  EditNoteScreen(
      {Key? key, required this.note})
      : super(key: key);
  final Note? note;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteCubit.get(context);
        if(note != null){
          titleController.text = note!.title ?? '';
          contentController.text = note!.content ?? '';
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.brown.shade400,
            title: const Text(
              AppStrings.editNote,
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel_outlined)),
              IconButton(
                onPressed: () {
                  cubit.updateDatabase(
                    note: Note(
                      id: note!.id,
                      title: titleController.text,
                      content: contentController.text,
                    ),
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check_circle_outline),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  if(state is NoteUpdateDataLoadingState)
                    const LinearProgressIndicator(color: Colors.brown),

                  /*---------------------------  Title TextField  -------------------------------*/
                  TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: AppStrings.title,
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),

                  /*---------------------------  Content TextField  -------------------------------*/
                  TextField(
                    maxLines: 25,
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
