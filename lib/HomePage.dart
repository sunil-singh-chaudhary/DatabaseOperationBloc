import 'package:database_bloc/bloc/db_update_bloc.dart';
import 'package:database_bloc/bottomTextField.dart';
import 'package:database_bloc/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

// DbUpdateBloc _bloc = DbUpdateBloc(db_data);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LIST(),
      bottomNavigationBar: bottomTextField(),
    );
  }
}
