import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/controllers/note_cubit/note_cubit.dart';
import 'package:note_app/core/models/note_model.dart';
import '../widgets/build_note_item.dart';

class SearchNoteScreen extends StatelessWidget {
  SearchNoteScreen({Key? key}) : super(key: key);
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteCubit.get(context);
        List<Note> list = cubit.notesSearch;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.brown.shade400,
            title: TextField(
              style: const TextStyle(color: Colors.white70),
              cursorColor: Colors.brown,
              keyboardType: TextInputType.text,
              controller: searchController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search your notes',
                hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 19.0,
                ),
              ),
              onChanged: (value) {
                cubit.searchInDatabase(
                  text: value,
                );
              },
              onSubmitted: (value) {
                cubit.searchInDatabase(
                  text: searchController.text,
                );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ConditionalBuilder(
              condition: list.isNotEmpty,
              builder: (BuildContext context) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return buildNoteItem(
                        note: list[index], context: context,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10.0,
                  ),
                  itemCount: list.length,
                );
              },
              fallback: (BuildContext context) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.brown,
                        size: 100.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "No matching notes",
                        style: TextStyle(
                            color: Colors.brown, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
