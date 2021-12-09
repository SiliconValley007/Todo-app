import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/blocs/task_bloc/task_bloc.dart';
import 'package:todo_app/constants/remove_focus.dart';
import 'package:todo_app/constants/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TaskBloc _taskBloc;
  final RemoveFocus _removeFocus = RemoveFocus();

  @override
  void initState() {
    _taskBloc = BlocProvider.of<TaskBloc>(context);
    _taskBloc.add(LoadTasks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _removeFocus.removeFocus(context),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Body(taskBloc: _taskBloc),
          floatingActionButton: FloatingActionButton(
            backgroundColor:
                Theme.of(context).floatingActionButtonTheme.backgroundColor,
            onPressed: () => Navigator.of(context).pushNamed('/add-task'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.add,
                color: Theme.of(context).scaffoldBackgroundColor),
          ),
        ),
      );
}

class Body extends StatelessWidget {
  final TaskBloc taskBloc;
  final TextEditingController searchController = TextEditingController();
  Body({Key? key, required this.taskBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (searchController.text.replaceAll(' ', '').isNotEmpty) {
          searchController.clear();
          FocusScope.of(context).requestFocus(FocusNode());
          taskBloc.add(LoadTasks());
          return false;
        } else {
          return false;
        }
      },
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 22.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(50.0),
              ),
              height: MediaQuery.of(context).size.height * 0.06,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          taskBloc.add(SearchTask(query: value));
                        } else if (value.isEmpty) {
                          taskBloc.add(LoadTasks());
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).bottomAppBarColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/settings'),
                    icon: Icon(Icons.settings,
                        color: Theme.of(context).iconTheme.color),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            Expanded(
              child: BlocBuilder(
                bloc: taskBloc,
                builder: (BuildContext context, TaskState state) {
                  if (state is TaskLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TaskLoaded) {
                    if (state.tasks.isEmpty) {
                      return Center(
                        child: Lottie.asset('assets/lottie/writing-blue.json'),
                      );
                    } else {
                      return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return TaskCard(
                                onTap: () => Navigator.of(context)
                                        .pushNamed('/add-task',
                                            arguments: state.tasks[index])
                                        .then((value) {
                                      searchController.clear();
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    }),
                                title: state.tasks[index].title,
                                content: state.tasks[index].content);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox();
                          },
                          itemCount: state.tasks.length);
                    }
                  } else {
                    return const Center(child: Text('Error'));
                  }
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
