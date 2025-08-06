import 'package:flutter/material.dart';
import 'package:task_management_app/constants/colors.dart';
import 'package:task_management_app/models/user_model.dart';

class UserListCard extends StatefulWidget {
  final UserModel user;
  List<Map<String, dynamic>> tasks;
  UserListCard({super.key, required this.user, required this.tasks});

  @override
  State<UserListCard> createState() => _UserListCardState();
}

class _UserListCardState extends State<UserListCard> {
  bool showCardDetails = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showCardDetails = !showCardDetails;
        });
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Colors.blue,
            width: 0.6,
          ),
        ),
        shadowColor: Colors.blue.withOpacity(0.1),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.name ?? 'Unnamed User',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(widget.user.email ?? 'No email'),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        showCardDetails = !showCardDetails;
                      });
                    },
                    icon: Icon(
                      showCardDetails
                          ? Icons.keyboard_arrow_up_outlined
                          : Icons.keyboard_arrow_down_outlined,
                    ),
                  ),
                ],
              ),
              if (showCardDetails) const Divider(),
              widget.tasks.isEmpty
                  ? Text("No tasks assigned.")
                  : showCardDetails
                      ? IgnorePointer(
                          child: ListView.builder(
                            itemCount: widget.tasks.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, taskIndex) {
                              final task = widget.tasks[taskIndex];
                              return ListTile(
                                title: Text(
                                    "${taskIndex + 1}. ${task['task']}" ??
                                        'No Title'),
                              );
                            },
                          ),
                        )
                      : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
