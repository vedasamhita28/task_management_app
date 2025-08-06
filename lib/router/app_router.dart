import 'package:go_router/go_router.dart';
import 'package:task_management_app/auth/login.dart';
import 'package:task_management_app/auth/sign_up.dart';
import 'package:task_management_app/auth/tl_login.dart';
import 'package:task_management_app/constants/router_names.dart';
import 'package:task_management_app/homepage/emp_homepage.dart';
import 'package:task_management_app/homepage/tl_homepage.dart';
import 'package:task_management_app/homepage/user_list.dart';
import 'package:task_management_app/welcome_screen/screens/welcome_screen.dart';

final GoRouter appRouter = GoRouter(initialLocation: '/welcome', routes: [
  GoRoute(
      name: RouteNames.welcome,
      path: '/welcome',
      builder: (context, state) => WelcomeScreen()),
  GoRoute(
      name: RouteNames.login,
      path: '/login',
      builder: (context, state) => Login(),
      routes: <RouteBase>[
        GoRoute(
            name: RouteNames.emp_homepage,
            path: 'emphomepage',
            builder: (context, state) => EmployeeHomepage())
      ]),
  GoRoute(
      name: RouteNames.tl_login,
      path: '/tl_login',
      builder: (context, state) => TlLogin(),
      routes: <RouteBase>[
        GoRoute(
            name: RouteNames.tl_homepage,
            path: 'tlhomepage',
            builder: (context, state) => TeamLeadHomepage())
      ]),
  GoRoute(
    name: RouteNames.signup,
    path: '/signup',
    builder: (context, state) => SignUp(),
  ),
  GoRoute(
    name: RouteNames.user_list,
    path: '/user_list',
    builder: (context, state) => UserListPage(),
  )
]);
