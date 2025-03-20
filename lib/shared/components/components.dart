// ignore_for_file: invalid_required_positional_param

import 'package:aetodo/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

double sz = 36.0;

Widget btn({
  required Function() fun,
  required String txt,
  double rd = 13,
  double pd = 13.7,
  double ht = 39,
  double wd = double.infinity,
  Color clr = Colors.blueGrey,
  bool up = true,
}) =>
    Padding(
      padding: EdgeInsets.all(pd),
      child: Container(
        width: wd,
        height: ht,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(rd),
          color: clr,
        ),
        child: MaterialButton(
          onPressed: fun,
          child: Text(
            up ? txt.toUpperCase() : txt,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

Widget tff({
  required String txt,
  required Icon ic,
  required TextEditingController ctrl,
  required TextInputType type,
  required String? Function(String?) vld,
  final Function()? tb,
  final Function(String)? smt,
  final Function(String)? chg,
  bool nbl = true,
}) {
  return TextFormField(
    enabled: nbl,
    controller: ctrl,
    decoration: InputDecoration(
      labelText: txt,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      border: const OutlineInputBorder(),
      prefixIcon: ic,
    ),
    validator: vld,
    onFieldSubmitted: smt,
    onChanged: chg,
    keyboardType: type,
    onTap: tb,
  );
}

Widget tsk(
  Map model,
  context,
  @required Icon rFunIcon,
  @required String rFunText,
  @required Icon lFunIcon,
  @required String lFunText,
  @required String dltText,
) =>
    Dismissible(
      key: Key("${model['id']}"),
      background: Padding(
        padding: const EdgeInsets.all(18.6),
        child: Container(
          color: Colors.red,
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 6,
          right: 3,
          left: 3,
          bottom: 1.2,
        ),
        child: Card(
          shape: Border.all(
            color: AppCubit.get(context).clrbg,
          ),
          color: const Color.fromARGB(137, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.all(13.7),
            child: Column(
              children: [
                Text(
                  "${model["title"]}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).uptadeDB(
                          rFunText,
                          model["id"],
                        );
                      },
                      icon: rFunIcon,
                    ),
                    Column(
                      children: [
                        Text(
                          "${model["time"]}",
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "${model["date"]}",
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).uptadeDB(
                          lFunText,
                          model["id"],
                        );
                      },
                      icon: lFunIcon,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).uptadeDB(
          "Deleted",
          model["id"],
        );
        const snackBar = SnackBar(
          content: Center(child: Text('Task is moved to Trash...!')),
          duration: Duration(
            seconds: 3,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );

Widget dTsk(
  Map model,
  context,
) =>
    Padding(
      padding: const EdgeInsets.only(
        top: 6,
        right: 3,
        left: 3,
        bottom: 1.2,
      ),
      child: Card(
        shape: Border.all(
          color: AppCubit.get(context).clrbg,
        ),
        color: const Color.fromARGB(137, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(13.7),
          child: Column(
            children: [
              Text(
                "${model["title"]}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            // title: const Text('Confirmation'),
                            content: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  size: 36,
                                  color: Colors.blueGrey,
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                                Text(
                                  'Are you sure you want to permanently delete the task?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  AppCubit.get(context).deleteDB(model['id']);
                                  const snackBar = SnackBar(
                                    content: Center(
                                        child:
                                            Text('Task is moved to Trash...!')),
                                    duration: Duration(
                                      seconds: 3,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red,
                      size: sz,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "${model["time"]}",
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "${model["date"]}",
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      AppCubit.get(context).uptadeDB(
                        "New",
                        model["id"],
                      );
                    },
                    icon: Icon(
                      Icons.restart_alt_rounded,
                      color: Colors.black38,
                      size: sz,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

