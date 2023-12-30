import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/controllers/note_cubit/note_cubit.dart';
import 'package:note_app/core/screens/modules/search_note_screen.dart';
import '../widgets/build_note_item.dart';
import 'add_note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  //String date = DateTime.now().toString();
  //String date2 = DateFormat.yMMMd().format(date!);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.brown.shade400,
            title: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchNoteScreen(),
                  )),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.brown.withOpacity(0.4),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.menu),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      "Search your notes",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 19.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => AddNoteScreen(),
              ));
            },
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ConditionalBuilder(
              condition: cubit.notes.isNotEmpty,
              builder: (context) {
                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return buildNoteItem(
                        note: cubit.notes[index], context: context);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10.0,
                  ),
                  itemCount: cubit.notes.length,
                );
              },
              fallback: (context) {
                return const Center(
                    child: Icon(
                  Icons.menu,
                  size: 50.0,
                ));
              },
            ),
          ),
        );
      },
    );
  }
}
