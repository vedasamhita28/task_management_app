import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/constants/style.dart';
import 'package:task_management_app/constants/utils.dart';
import 'package:task_management_app/homepage/provider/homepage_provider.dart';
import 'package:task_management_app/homepage/widgets/add_task_bottom_sheet.dart';
import 'package:task_management_app/homepage/widgets/user_card.dart';
import 'package:task_management_app/widgets/appbar_widget.dart';
import 'package:task_management_app/widgets/server_key.dart';

class TeamLeadHomepage extends StatefulWidget {
  const TeamLeadHomepage({super.key});

  @override
  State<TeamLeadHomepage> createState() => _TeamLeadHomepageState();
}

class _TeamLeadHomepageState extends State<TeamLeadHomepage> {
  @override
  void initState() {
    super.initState();
    // Fetch the initial list when the widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserListProvider>(context, listen: false).fetchUsersListNew();
      Provider.of<UserListProvider>(context, listen: false).fetchUsersList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            isScrollControlled: false,
            useSafeArea: true,
            enableDrag: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (context) => Consumer<UserListProvider>(
              builder: (context, userListProvider, _) {
                return AddTaskBottomSheet(userList: userListProvider.users);
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppbarWidget(title: "Nulinz Task Manager"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "List of Employees and Their Tasks",
              style: Style.subHeadingStyle,
              textAlign: TextAlign.left,
            ),
            Divider(
              thickness: 1,
            ),
            gapH8,
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<UserListProvider>(context, listen: false)
                      .reloadUsersList();
                },
                child: Consumer<UserListProvider>(
                  builder: (context, userListProvider, _) {
                    final usersWithTasks = userListProvider.userWithTasksList;
                    return ListView.builder(
                      itemCount: usersWithTasks.length,
                      itemBuilder: (context, index) {
                        final user = usersWithTasks[index].user;
                        final tasks = usersWithTasks[index].tasks;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: UserListCard(
                            user: user,
                            tasks: tasks,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
