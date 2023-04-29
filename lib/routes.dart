import 'package:gamed/features/authentication/screens/select_role_screen.dart';
import 'package:gamed/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:gamed/features/student_portal/screens/student_dashboard/student_dashboard.dart';
import 'package:get/get.dart';

import 'features/student_portal/screens/Announcements/StudentAnnouncements.dart';


class AppRoutes {
  static const String firstScreen = '/';
  static const String secondScreen = '/roleselection';
  static const String studentDashboard = '/student/dashboard';
  static const String studentAnnouncements = '/student/announcements';

    static List<GetPage> pages = [
    GetPage(name: firstScreen, page: () => SplashScreen()),

    GetPage(name: secondScreen, page: () => RoleSelectionScreen()),
    GetPage(name: studentDashboard, page: () => StudentDashboard()),
    GetPage(name: studentAnnouncements , page: () =>StudentAnnouncements() ),
  ];
}
