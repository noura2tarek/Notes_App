import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/controllers/note_cubit/note_cubit.dart';
import 'package:note_app/core/managers/app_strings.dart';
import 'package:note_app/core/models/note_model.dart';
import '../widgets/build_note_item.dart';
import 'add_note_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);


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
            title: const Text(
              AppStrings.notes,
              style: TextStyle(color: Colors.white),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => AddNoteScreen(),
              ));
            },
            elevation: 3.0,
            backgroundColor: Colors.brown.shade400,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FutureBuilder<List<Note>>(
              future: cubit.readDatabase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return buildNoteItem(
                          note: snapshot.data![index], context: context);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0,
                    ),
                    itemCount: snapshot.data!.length,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        );
      },
    );
  }
}
