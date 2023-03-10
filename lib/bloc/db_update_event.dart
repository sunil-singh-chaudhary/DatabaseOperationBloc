part of 'db_update_bloc.dart';

@immutable
abstract class DbUpdateEvent extends Equatable {
  const DbUpdateEvent();
}

class AddDataEvent extends DbUpdateEvent {
  final model newData;

  const AddDataEvent(this.newData);

  @override
  List<Object?> get props => [newData];
}

class DeleteDataEvent extends DbUpdateEvent {
  final String name;

  const DeleteDataEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class ShowDataEvent extends DbUpdateEvent {
  @override
  List<Object?> get props => [];
}
