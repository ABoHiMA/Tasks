import 'package:aetodo/shared/cubit/cubit.dart';
import 'package:aetodo/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:aetodo/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Archive extends StatefulWidget {
  const Archive({super.key});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivedTasks;
        return tasks.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.archive_outlined,
                      color: Colors.black26,
                      size: 69,
                    ),
                    Text(
                      "No Archived Tasks",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: Colors.black26,
                      ),
                      textAlign: TextAlign.center,
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
                    Icons.task_outlined,
                    color: Colors.blueGrey,
                    size: sz,
                  ),
                  "New",
                  "Archived",
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
