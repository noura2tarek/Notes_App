import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/network/local/sql_database.dart';
import '../../models/note_model.dart';

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
      print("row $value inserted successfully======");
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
      print("updated successfully======");
      emit(NoteUpdateDataSuccessState());
      readDatabase();
    }).catchError((error) {
      emit(NoteUpdateDataErrorState());
    });
  }

  /*--------------------------  Read all Notes -----------------------------*/
  List<Note> notes = [];

  readDatabase() {
    sqlDB.readDB().then((value) {
      emit(NoteReadDataSuccessState());
    }).catchError((error) {
      emit(NoteReadDataErrorState());
    });
  }

  /*--------------------------  Delete Note -----------------------------*/
  deleteFromDatabase({required int id}) {
    sqlDB.deleteFromDB(id: id).then((value) {
      print("row  with id = $id deleted successfully======");
      emit(NoteDeleteDataSuccessState());
      readDatabase();
    }).catchError((error) {
      emit(NoteDeleteDataErrorState());
    });
  }

  /*--------------------------  Delete Database -----------------------------*/
  // database deleted but the structure is still exist
  deleteDatabase() {
    sqlDB.deleteMyDatabase().then((value) {
      print(" Database deleted successfully======");
      emit(NoteDeleteDatabaseSuccessState());
    }).catchError((error) {
      emit(NoteDeleteDatabaseErrorState());
    });
  }
}
