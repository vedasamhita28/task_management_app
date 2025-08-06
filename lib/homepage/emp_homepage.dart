import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/constants/style.dart';
import 'package:task_management_app/constants/utils.dart';
import 'package:task_management_app/homepage/provider/homepage_provider.dart';
import 'package:task_management_app/homepage/widgets/task_card.dart';
import 'package:task_management_app/widgets/appbar_widget.dart';

class EmployeeHomepage extends StatefulWidget {
  const EmployeeHomepage({super.key});

  @override
  State<EmployeeHomepage> createState() => _EmployeeHomepageState();
}

class _EmployeeHomepageState extends State<EmployeeHomepage> {
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
    // Fetch the initial list when the widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<UserListProvider>(context, listen: false)
          .fetchTaskList(box.read('employeeEmailId'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: "Nulinz Task Manager"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Text(
                    "List of Tasks",
                    style: Style.subHeadingStyle,
                    textAlign: TextAlign.left,
                  ),
                  gapH20,
                  Divider(
                    thickness: 1,
                  ),
                  gapH8,
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await Provider.of<UserListProvider>(context,
                                listen: false)
                            .fetchTaskList(box.read('employeeEmailId'));
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Consumer<UserListProvider>(
                          builder: (context, userListProvider, _) {
                            if (userListProvider.tasks.isNotEmpty) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: userListProvider.tasks.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: TaskListCard(
                                      empTasks: userListProvider.tasks[index],
                                      index: index + 1,
                                    ),
                                  );
                                },
                              );
                            } else {
                              return SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Image.asset('assets/images/no_task_state.png'),
                                        Text(
                                          "You have no task for today enjoy your today",
                                          style: Style.subHeadingStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
