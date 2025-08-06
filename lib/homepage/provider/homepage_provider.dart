import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:task_management_app/auth/providers/auth_service.dart';
import 'package:task_management_app/models/employee_task_model.dart';
import 'package:task_management_app/models/user_model.dart';
import 'package:task_management_app/models/user_task_model.dart';
import 'package:task_management_app/widgets/snack_bar.dart';
import 'package:http/http.dart' as http;

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class UserListProvider with ChangeNotifier {
  final box = GetStorage();
  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  List<EmployeeTaskModel> _tasks = [];
  List<EmployeeTaskModel> get tasks => _tasks;

  List<UserWithTasks> _userWithTasksList = [];
  List<UserWithTasks> get userWithTasksList => _userWithTasksList;

  Future<void> fetchUsersList() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where("isTLuser", isNotEqualTo: true)
          .get();

      _users = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        print("User Data is here ==== ${data.toString()}");
        return UserModel.fromJson(data ?? {});
      }).toList();
      notifyListeners(); 
    } catch (error) {
      print("Error fetching users: $error");
    }
  }

  Future<void> fetchUsersListNew() async {
    try {
      final usersSnapshot = await firestore
          .collection('users')
          .where("isTLuser", isNotEqualTo: true)
          .get();

      List<UserWithTasks> tempList = [];

      for (var doc in usersSnapshot.docs) {
        final userData = doc.data() as Map<String, dynamic>?;
        if (userData == null) continue;

        UserModel user = UserModel.fromJson(userData);
        String? email = user.email;

        if (email != null && email.isNotEmpty) {
          final tasksSnapshot = await firestore
              .collection('employee_task')
              .where('email', isEqualTo: email)
              .get();

          List<Map<String, dynamic>> tasks = tasksSnapshot.docs.map((taskDoc) {
            return taskDoc.data() as Map<String, dynamic>;
          }).toList();

          tempList.add(UserWithTasks(user: user, tasks: tasks));
        }
      }

      _userWithTasksList = tempList;
      notifyListeners();
    } catch (error) {
      print("Error fetching users and their tasks: $error");
    }
  }

  Future<void> fetchTaskList(String empEmail) async {
    if (empEmail.isEmpty) {
      print("fetchTaskList: Provided email is empty.");
      return;
    }

    try {
      print("Fetching tasks for employee: $empEmail");

      final querySnapshot = await firestore
          .collection('employee_task')
          .where('email', isEqualTo: empEmail)
          .get();

      final tasks = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        print("Fetched Task Data: $data");
        return EmployeeTaskModel.fromJson(data);
      }).toList();

      _tasks = tasks;
      notifyListeners(); 
    } catch (e, stackTrace) {
      print("fetchTaskList: Error occurred - $e");
      print("Stack trace: $stackTrace");
    }
  }


  Future<void> addUser(UserModel newUser) async {
    try {
      await firestore.collection('users').add(newUser.toJson());
      
      await fetchUsersList();
    } catch (error) {
      print("Error adding user: $error");
      
    }
  }

  // Example method to reload the user list
  Future<void> reloadUsersList() async {
    await fetchUsersListNew();
  }

  Future<void> createTaskByTL(BuildContext context, String name, String email,
      String task, String assignedBy,String fcmToken) async {
    try {
      await createTask(
        name: name,
        email: email,
        task: task,
        assignedBy: assignedBy,
      );
      await fetchUsersListNew();
      await sendTaskNotification(fcmToken,task,assignedBy);
      context.pop();
    } on FirebaseAuthException {
      // TODO
      CustomSnackbar.show(
          context: context,
          message: "Could n't add Task, Please check with your admin",
          type: SnackbarType.error);
    }
  }

  Future<void> sendTaskNotification(String fcmtoken, String task, String assignedBy) async {
    final serverKey =
        box.read('server-key'); // Replace with your real Firebase server key!

    final response = await http.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/task-management-app-c3f75/messages:send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode({
        "message": {
          "token": fcmtoken,
          "notification": {
            "title": "$assignedBy assigned you an Task",
            "body": task
          },
          "data": {"story_id": "story_12345"}
        }
      }),
    );

    if (response.statusCode == 200) {
      print(' Notification sent successfully');
    } else {
      print(' Failed to send notification: ${response.body}');
    }
  }
}
