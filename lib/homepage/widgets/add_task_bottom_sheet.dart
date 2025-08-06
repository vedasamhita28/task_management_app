import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/homepage/provider/homepage_provider.dart';
import 'package:task_management_app/models/user_model.dart';
import 'package:task_management_app/widgets/primary_button.dart';
import 'package:task_management_app/widgets/text_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final List<UserModel> userList;
  const AddTaskBottomSheet({super.key, required this.userList});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final box = GetStorage();
  UserModel? _selectedUser;
  TextEditingController taskController = TextEditingController();

  Widget build(BuildContext context) {
    final userListProvider =
        Provider.of<UserListProvider>(context, listen: true);
    userListProvider.reloadUsersList();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          // Add padding at the bottom equal to the keyboard height
          // This is crucial for the content to scroll above the keyboard
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select an Employee:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<UserModel>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Employee Name',
              ),
              value: _selectedUser,
              items: widget.userList.map((user) {
                return DropdownMenuItem<UserModel>(
                  value: user,
                  child: Text(user.name ?? 'No Name'),
                );
              }).toList(),
              onChanged: (UserModel? newUser) {
                setState(() {
                  _selectedUser = newUser;
                  print('Selected Employee Email: ${_selectedUser?.email}');
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Task Details:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            PrimaryTextField(
                hintText: "Do 's and Don't do",
                controller: taskController,
                isRequried: true),
            SizedBox(height: 16),
            PrimaryButton(
              width: double.infinity,
              text: 'Submit',
              onPressed: () async {
                await userListProvider.createTaskByTL(
                    context,
                    _selectedUser!.name!,
                    _selectedUser!.email!,
                    taskController.text.trim(),
                    box.read("TLemailID"),
                    _selectedUser!.fcmtoken!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
