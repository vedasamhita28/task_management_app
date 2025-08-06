import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/constants/style.dart';
import 'package:task_management_app/homepage/provider/homepage_provider.dart';
import 'package:task_management_app/widgets/appbar_widget.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<UserListProvider>(context, listen: false)
          .fetchUsersListNew();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: "Nulinz Task Manager",
        backArraw: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "List of Employees and Their Tasks",
              style: Style.subHeadingStyle,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: Consumer<UserListProvider>(
              builder: (context, userListProvider, _) {
                final usersWithTasks = userListProvider.userWithTasksList;

                return ListView.builder(
                  itemCount: usersWithTasks.length,
                  itemBuilder: (context, index) {
                    final user = usersWithTasks[index].user;
                    final tasks = usersWithTasks[index].tasks;

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name ?? 'Unnamed User',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(user.email ?? 'No email'),
                            const Divider(),
                            tasks.isEmpty
                                ? Text("No tasks assigned.")
                                : ListView.builder(
                                    itemCount: tasks.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, taskIndex) {
                                      final task = tasks[taskIndex];
                                      return ListTile(
                                        title: Text(task['task'] ?? 'No Title'),
                                      );
                                    },
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
