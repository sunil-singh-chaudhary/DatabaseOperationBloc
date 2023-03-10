import 'package:database_bloc/bloc/db_update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// final DatabaseHelper db = DatabaseHelper();

class LIST extends StatefulWidget {
  const LIST({super.key});

  @override
  State<LIST> createState() => _LISTState();
}

class _LISTState extends State<LIST> {
  @override
  void initState() {
    context.read<DbUpdateBloc>().add(ShowDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<DbUpdateBloc, DbUpdateState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchSuccess) {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(state.list[index].name!),
                  leading: const Icon(Icons.circle),
                  trailing: IconButton(
                      onPressed: () {
                        context.read<DbUpdateBloc>().add(DeleteDataEvent(
                            state.list[index].name!)); //Delete from db
                      },
                      icon: const Icon(Icons.delete)),
                );
              },
            );
          } else if (state is Error) {
            return Center(child: Text(state.msg!));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
