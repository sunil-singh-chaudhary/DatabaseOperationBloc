import 'package:database_bloc/bloc/db_update_bloc.dart';
import 'package:database_bloc/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class bottomTextField extends StatefulWidget {
  const bottomTextField({super.key});

  @override
  State<bottomTextField> createState() => _bottomTextFieldState();
}

class _bottomTextFieldState extends State<bottomTextField> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: 60,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    fillColor: Colors.white38,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)))),
              ),
            ),
            SizedBox(
              height: 40,
              width: 60,
              child: BlocBuilder<DbUpdateBloc, DbUpdateState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      if (state is Loading) {
                        const Center(child: CircularProgressIndicator());
                      }
                      if (state is insertSuccess) {
                        const Text('Inserted');
                      }
                      if (state is Error) {
                        Text(state.msg!);
                      }

                      //insert into dB
                      context.read<DbUpdateBloc>().add(AddDataEvent(
                          model(name: controller.text, uniqueID: 1)));
                      FocusManager.instance.primaryFocus?.unfocus();
                      controller.clear();
                    },
                    icon: const Icon(Icons.send),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
