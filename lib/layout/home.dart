// ignore_for_file: must_be_immutable
// ignore_for_file: invalid_required_positional_param, avoid_print

import 'package:aetodo/shared/cubit/cubit.dart';
import 'package:aetodo/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:aetodo/shared/components/components.dart';

class Home extends StatelessWidget {
  Home({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDBState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit app = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: app.isBody
                ? AppBar(
                    leading: IconButton(
                      onPressed: () {
                        app.bd(app.isBody = false);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 26,
                      ),
                    ),
                    backgroundColor: app.clrbg,
                    centerTitle: true,
                    title: Text(
                      app.titles[app.inx],
                      textAlign: TextAlign.center,
                    ),
                  )
                : AppBar(
                    leading: IconButton(
                      onPressed: () {
                        app.bd(app.isBody = true);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 23,
                      ),
                    ),
                    backgroundColor: app.clrbg,
                    centerTitle: true,
                    title: Text(
                      app.titles[3],
                      textAlign: TextAlign.center,
                    ),
                  ),
            floatingActionButton: app.isBody
                ? FloatingActionButton(
                    onPressed: () {
                      if (app.isShowBottomSheet) {
                        if (formKey.currentState!.validate()) {
                          app.insertDB(
                            titlecontroller.text,
                            datecontroller.text,
                            timecontroller.text,
                          );
                        }
                      } else {
                        scaffoldKey.currentState
                            ?.showBottomSheet(
                              (context) => Container(
                                color: Colors.blueGrey[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(13.7),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        child: Form(
                                          key: formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              tff(
                                                txt: "Title",
                                                ic: const Icon(
                                                    Icons.title_outlined),
                                                ctrl: titlecontroller,
                                                type: TextInputType.text,
                                                vld: (value) {
                                                  if (value!.isEmpty) {
                                                    return ("Enter Title");
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(
                                                height: 13,
                                                child: Container(
                                                  color: Colors.blueGrey[100],
                                                ),
                                              ),
                                              Container(
                                                color: Colors.blueGrey[100],
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: tff(
                                                          txt: "Date",
                                                          ic: const Icon(Icons
                                                              .date_range_outlined),
                                                          ctrl: datecontroller,
                                                          type: TextInputType
                                                              .datetime,
                                                          vld: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return ("Enter Date");
                                                            }
                                                            return null;
                                                          },
                                                          nbl: false,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 7,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(99),
                                                        color: app.clrbg,
                                                      ),
                                                      child: IconButton(
                                                        color: Colors.white,
                                                        onPressed: () {
                                                          showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime.now(),
                                                            lastDate:
                                                                DateTime.parse(
                                                                    '2099-12-31'),
                                                          ).then((value) {
                                                            datecontroller
                                                                    .text =
                                                                DateFormat
                                                                        .yMMMEd()
                                                                    .format(
                                                                        value!);
                                                          });
                                                        },
                                                        icon: const Icon(Icons
                                                            .date_range_outlined),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 13,
                                                child: Container(
                                                  color: Colors.blueGrey[100],
                                                ),
                                              ),
                                              Container(
                                                color: Colors.blueGrey[100],
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: tff(
                                                          txt: "Time",
                                                          ic: const Icon(Icons
                                                              .watch_later_outlined),
                                                          ctrl: timecontroller,
                                                          type: TextInputType
                                                              .datetime,
                                                          vld: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return ("Enter Time");
                                                            }
                                                            return null;
                                                          },
                                                          nbl: false,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 7,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(99),
                                                        color: app.clrbg,
                                                      ),
                                                      child: IconButton(
                                                        color: Colors.white,
                                                        onPressed: () {
                                                          showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                          ).then((value) {
                                                            timecontroller
                                                                    .text =
                                                                value!
                                                                    .format(
                                                                        context)
                                                                    .toString();
                                                            // print(value.format(context));
                                                          });
                                                        },
                                                        icon: const Icon(Icons
                                                            .watch_later_outlined),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      btn(
                                        fun: clr,
                                        txt: "Clear All",
                                        wd: 186.137,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .closed
                            .then((value) {
                          app.changeBtmBtn(
                            isShow: false,
                            btnIc: const Icon(Icons.add),
                          );
                        });
                        app.changeBtmBtn(
                          isShow: true,
                          btnIc: const Icon(Icons.save),
                        );
                      }
                    },
                    backgroundColor: app.clrbg,
                    child: app.fltBtn,
                  )
                : null,
            bottomNavigationBar: app.isBody
                ? BottomNavigationBar(
                    currentIndex: app.inx,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: app.clrbg,
                    fixedColor: Colors.white,
                    onTap: (index) {
                      app.bd(app.isBody = true);
                      app.changeInx(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.menu),
                        label: 'Tasks',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.done),
                        label: 'Done',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.archive_outlined),
                        label: 'Archive',
                      ),
                    ],
                  )
                : null,
            body: ConditionalBuilder(
              condition: app.isBody,
              builder: (context) => app.screens[app.inx],
              fallback: (context) => app.screens[3],
            ),
          );
        },
      ),
    );
  }

  void clr() {
    titlecontroller.clear();
    timecontroller.clear();
    datecontroller.clear();
  }
}
