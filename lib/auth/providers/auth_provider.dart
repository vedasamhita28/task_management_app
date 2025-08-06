import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:task_management_app/auth/providers/auth_service.dart';
import 'package:task_management_app/widgets/snack_bar.dart';

class AuthProvider with ChangeNotifier {
  final box = GetStorage();

  Future<void> createUserwithEmailAndPassword(BuildContext context, String name,
      String email, String password, bool isTLuser) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await createUser(
        name: name,
        email: email,
        userId: userCredential.user!.uid,
        isTLuser: isTLuser,
      );
      context.pop();
    } on FirebaseAuthException catch (e) {
      // TODO
      CustomSnackbar.show(
          context: context, message: e.code, type: SnackbarType.error);
    }
  }

  Future<void> loginUserwithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
    bool isTLuser,
  ) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("OOOOOOOOOOOOOO");
      print(userCredential.user);

      if (userCredential.user != null) {
        final user = userCredential.user;
        var querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('userId', isEqualTo: user!.uid)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          if (isTLuser) {
            if (querySnapshot.docs.first.get('isTLuser') == isTLuser) {
              context.push('/tl_login/tlhomepage');
              box.write('TLemailID', user.email);
            } else {
              throw FirebaseAuthException(
                  code: "You are not a TL Can you login to Tech");
            }
          } else {
            if (querySnapshot.docs.first.get('isTLuser') == isTLuser) {
              box.write('employeeEmailId', user!.email);
              final fcmToken = await FirebaseMessaging.instance.getToken();

              for (var doc in querySnapshot.docs) {
                await doc.reference.update({'fcmToken': fcmToken});
              }

              final uid = FirebaseAuth.instance.currentUser?.uid ?? "testUser";
              print("Print UID============ $uid");
              print('FCM Token saved for $uid: $fcmToken');
              box.write('FCMToken', fcmToken);
              context.push('/login/emphomepage');
            } else {
              throw FirebaseAuthException(
                  code:
                      "Bro! You are Promoted to TL Bruh and why you are still logging as an Employee, Please Log in as TL");
            }
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      // TODO
      CustomSnackbar.show(
          context: context, message: e.code, type: SnackbarType.error);
    }
  }
}
