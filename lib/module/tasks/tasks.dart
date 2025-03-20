import 'package:aetodo/shared/cubit/cubit.dart';
import 'package:aetodo/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:aetodo/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return tasks.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.menu_outlined,
                      color: Colors.black26,
                      size: 69,
                    ),
                    Text(
                      "No Tasks Yet...!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: Colors.black26,
                      ),
                    ),
                    Text(
                      "Click + To Add New Task",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 29,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) => tsk(
                  tasks[index],
                  context,
                  Icon(
                    Icons.check_box_outlined,
                    color: Colors.green,
                    size: sz,
                  ),
                  "Done",
                  Icon(
                    Icons.archive_outlined,
                    color: Colors.black38,
                    size: sz,
                  ),
                  'Archived',
                  "New",
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
