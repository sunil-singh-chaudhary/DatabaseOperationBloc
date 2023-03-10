part of 'db_update_bloc.dart';

@immutable
abstract class DbUpdateState extends Equatable {
  const DbUpdateState();
}

class Initial extends DbUpdateState {
  @override
  List<Object?> get props => [];
}

class Loading extends DbUpdateState {
  @override
  List<Object?> get props => [];
}

class insertSuccess extends DbUpdateState {
  @override
  List<Object?> get props => [];
}

class FetchSuccess extends DbUpdateState {
  List<model> list;
  FetchSuccess(this.list);

  @override
  List<Object?> get props => [list];
}

class deletesuccess extends DbUpdateState {
  @override
  List<Object?> get props => [];
}

class Error extends DbUpdateState {
  String? msg;
  Error({this.msg});

  @override
  List<Object?> get props => [msg];
}
