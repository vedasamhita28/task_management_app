import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management_app/models/employee_task_model.dart';

class TaskService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'employee_task';

  // CREATE - Add new task
  static Future<String> createTask({
    required String name,
    required String task,
    required String email,
    required String assignedBy,
  }) async {
    final docRef = await _firestore.collection(_collection).add({
      'name': name,
      'email': email,
      'task': task,
      'assignedby': assignedBy,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  // READ - Get all tasks
  static Stream<List<EmployeeTaskModel>> getAllTasks() {
    return _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EmployeeTaskModel.fromJson(doc.data(), docId: doc.id))
            .toList());
  }

  // READ - Get tasks by user email
  static Stream<List<EmployeeTaskModel>> getTasksByEmail(String email) {
    return _firestore
        .collection(_collection)
        .where('email', isEqualTo: email)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EmployeeTaskModel.fromJson(doc.data(), docId: doc.id))
            .toList());
  }

  // READ - Get single task by ID
  static Future<EmployeeTaskModel?> getTaskById(String taskId) async {
    final doc = await _firestore.collection(_collection).doc(taskId).get();
    if (doc.exists) {
      return EmployeeTaskModel.fromJson(doc.data()!, docId: doc.id);
    }
    return null;
  }

  // UPDATE - Update existing task
  static Future<void> updateTask({
    required String taskId,
    required String task,
    String? name,
    String? email,
  }) async {
    final updateData = <String, dynamic>{
      'task': task,
      'updatedAt': FieldValue.serverTimestamp(),
    };
    
    if (name != null) updateData['name'] = name;
    if (email != null) updateData['email'] = email;
    
    await _firestore.collection(_collection).doc(taskId).update(updateData);
  }

  // DELETE - Remove task
  static Future<void> deleteTask(String taskId) async {
    await _firestore.collection(_collection).doc(taskId).delete();
  }

  // BULK DELETE - Remove multiple tasks
  static Future<void> deleteTasksByEmail(String email) async {
    final batch = _firestore.batch();
    final querySnapshot = await _firestore
        .collection(_collection)
        .where('email', isEqualTo: email)
        .get();
    
    for (final doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }
    
    await batch.commit();
  }
}