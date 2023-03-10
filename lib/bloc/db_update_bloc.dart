import 'package:bloc/bloc.dart';
import 'package:database_bloc/DatabaseHelper.dart';
import 'package:database_bloc/model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'db_update_event.dart';
part 'db_update_state.dart';

DatabaseHelper dbhelper = DatabaseHelper();

class DbUpdateBloc extends Bloc<DbUpdateEvent, DbUpdateState> {
  DbUpdateBloc() : super(Initial()) {
    on<AddDataEvent>((event, emit) async {
      print('bloc insert start');
      try {
        emit(Loading());
        await dbhelper.insertNote(event
            .newData); //pass data using event from main to here thorugh event class
        emit(insertSuccess());
        List<model> lst = await dbhelper.getNoteList();
        emit(FetchSuccess(lst));
      } catch (e) {
        Error(msg: e.toString());
      }
    });

    on<DeleteDataEvent>((event, emit) async {
      try {
        emit(Loading());
        await dbhelper.deleteTable(event
            .name); //pass data using event from main to here thorugh event class
        emit(deletesuccess());
        List<model> lst = await dbhelper.getNoteList();
        emit(FetchSuccess(lst));
      } catch (e) {
        emit(Error(msg: e.toString()));
      }
    });

    on<ShowDataEvent>((event, emit) async {
      print('bloc ShowDataEvent start');
      try {
        emit(Loading());
        List<model> lst = await dbhelper.getNoteList();
        emit(FetchSuccess(lst));
      } catch (e) {
        emit(Error(msg: e.toString()));
      }
    });
  }
}
