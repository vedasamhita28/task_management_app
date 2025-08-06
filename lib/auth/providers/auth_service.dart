
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<void> createUser({
  required String name,
  required String userId,
  required String email,
  required bool isTLuser
}) async {
  firestore.collection('users').add({
    'name': name,
    'email': email,
    'userId': userId,
    'isTLuser': isTLuser
  });
}

Future<void> createTask(
    {required String name,
    required String task,
    required String email,
    required String assignedBy}) async {
  firestore.collection('employee_task').add(
      {'name': name, 'email': email, 'task': task, 'assignedby': assignedBy});
}

