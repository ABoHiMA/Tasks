import 'package:aetodo/shared/cubit/cubit.dart';
import 'package:aetodo/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:aetodo/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Delete extends StatefulWidget {
  const Delete({super.key});

  @override
  State<Delete> createState() => _TasksState();
}

class _TasksState extends State<Delete> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).deletedTasks;
        return tasks.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: Colors.black26,
                      size: 69,
                    ),
                    Text(
                      "No Tasks in Trash",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) => dTsk(
                  tasks[index],
                  context,
                ),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 18.6,
                  ),
                  child: Container(
                    width: double.infinity,
                    color: Colors.blueGrey,
                  ),
                ),
                itemCount: tasks.length,
              );
      },
    );
  }
}
