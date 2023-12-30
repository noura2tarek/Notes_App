part of 'note_cubit.dart';

@immutable
abstract class NoteState {}

class NoteInitialState extends NoteState {}
class NoteCreateDatabaseSuccessState extends NoteState {}
class NoteCreateDatabaseErrorState extends NoteState {}
//insert
class NoteInsertDataSuccessState extends NoteState {}
class NoteInsertDataErrorState extends NoteState {}
//update
class NoteUpdateDataLoadingState extends NoteState {}
class NoteUpdateDataSuccessState extends NoteState {}
class NoteUpdateDataErrorState extends NoteState {}
//select
class NoteReadDataSuccessState extends NoteState {}
class NoteReadDataErrorState extends NoteState {}
//search data
class NoteSearchDataSuccessState extends NoteState {}
class NoteSearchDataErrorState extends NoteState {}
//delete
class NoteDeleteDataSuccessState extends NoteState {}
class NoteDeleteDataErrorState extends NoteState {}
//delete database
class NoteDeleteDatabaseSuccessState extends NoteState {}
class NoteDeleteDatabaseErrorState extends NoteState {}

