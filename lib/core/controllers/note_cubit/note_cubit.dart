import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/network/local/sql_database.dart';
import '../../models/note_model.dart';
import 'dart:developer';
part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitialState());

  static NoteCubit get(context) {
    return BlocProvider.of(context);
  }

  SqlDB sqlDB = SqlDB();

  /*--------------------------  Create Database -----------------------------*/
  initializeDB() {
    sqlDB.initDB().then((value) {
      emit(NoteCreateDatabaseSuccessState());
    }).catchError((error) {
      emit(NoteCreateDatabaseErrorState());
    });
  }

/*--------------------------  Insert Note -----------------------------*/
  insertToDatabase({required Note note}) {
    sqlDB.insertToDB(note: note).then((value) {
      log("row $value inserted successfully======");
      emit(NoteInsertDataSuccessState());
      readDatabase();
    }).catchError((error) {
      emit(NoteInsertDataErrorState());
    });
  }

  /*--------------------------  Update Note -----------------------------*/
  updateDatabase({required Note note}) {
    emit(NoteUpdateDataLoadingState());
    sqlDB.updateDB(note: note).then((value) {
      if (value! > 0) {
        emit(NoteUpdateDataSuccessState());
        log("updated successfully======");
        readDatabase();
      }
    }).catchError((error) {
      emit(NoteUpdateDataErrorState());
    });
  }

  /*--------------------------  Read all Notes -----------------------------*/
  List<Note> notes = [];

  readDatabase() {
    sqlDB.readDB().then((value) {
      notes = value; // add list in a list
      emit(NoteReadDataSuccessState());
    }).catchError((error) {
      emit(NoteReadDataErrorState());
    });
  }

  /*--------------------------  Search Note -----------------------------*/
  List<Note> notesSearch = [];

  searchInDatabase({required String text}) {
    sqlDB.searchInDB(where: "content LIKE '%$text%'").then((value) {
      log("length is ${value.length}");
      notesSearch = value; // add list in a list
      emit(NoteSearchDataSuccessState());
    }).catchError((error) {
      emit(NoteSearchDataErrorState());
    });
  }

  /*--------------------------  Delete Note -----------------------------*/
  deleteFromDatabase({required int id}) {
    sqlDB.deleteFromDB(id: id).then((value) {
      //check if value of response is not zero to avoid errors, that means the function completed normally.
      if (value! > 0) {
        emit(NoteDeleteDataSuccessState());
        log("row with id = $id deleted successfully======");
        // Delete the element from the list notes if it fulfills the condition.
        notes.removeWhere((element) => element.id == id);
      }
    }).catchError((error) {
      emit(NoteDeleteDataErrorState());
    });
  }

  /*--------------------------  Delete Database -----------------------------*/
  // database deleted but the structure is still exist
  deleteDatabase() {
    sqlDB.deleteMyDatabase().then((value) {
      log(" Database deleted successfully======");
      emit(NoteDeleteDatabaseSuccessState());
    }).catchError((error) {
      emit(NoteDeleteDatabaseErrorState());
    });
  }
}
