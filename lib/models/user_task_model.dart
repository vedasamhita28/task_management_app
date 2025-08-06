import 'package:task_management_app/models/user_model.dart';

class UserWithTasks {
  final UserModel user;
  final List<Map<String, dynamic>> tasks;
  DateTime? taskStartTaskDate;
  DateTime? taskEndTaskDate;
  

  UserWithTasks({required this.user, required this.tasks, this.taskStartTaskDate, this.taskEndTaskDate});
}
