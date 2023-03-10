import 'package:database_bloc/bottomTextField.dart';
import 'package:database_bloc/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

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
      appBar: AppBar(title: const Center(child: Text('Database With Bloc'))),
      body: const LIST(),
      bottomNavigationBar: const bottomTextField(),
    );
  }
}
