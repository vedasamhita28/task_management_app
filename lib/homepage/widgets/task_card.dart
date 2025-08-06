import 'package:flutter/material.dart';
import 'package:task_management_app/constants/colors.dart';
import 'package:task_management_app/models/employee_task_model.dart';

class TaskListCard extends StatelessWidget {
  final EmployeeTaskModel empTasks;
  int index;
  TaskListCard({super.key, required this.empTasks, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Colors.blue, // Primary blue border
              width: 1.5,
            ),
          ),
          shadowColor: Colors.blue.withOpacity(0.1),
          color: Colors.white,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Task Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Circular number badge
                    Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "$index",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        empTasks.task ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),

                    // Optional icon
                    // const Icon(
                    //   Icons.check_circle_outline,
                    //   color: Colors.blue,
                    //   size: 20,
                    // ),
                  ],
                ),

                const SizedBox(height: 12),

                // Assigned by
                Text(
                  "Assigned by ${empTasks.email ?? 'Unknown'}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
