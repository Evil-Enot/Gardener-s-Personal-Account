import 'package:diploma/notifications/notification_service.dart';
import 'package:diploma/pages/auth_page.dart';
import 'package:diploma/pages/bills_page.dart';
import 'package:diploma/pages/info_page.dart';
import 'package:diploma/pages/login_page.dart';
import 'package:diploma/pages/main_page.dart';
import 'package:diploma/pages/meters_page.dart';
import 'package:diploma/pages/payment_page.dart';
import 'package:diploma/pages/settings_page.dart';
import 'package:diploma/pages/url_page.dart';
import 'package:diploma/pages/zero_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  NotificationService().init();
  await GetStorage.init('Storage');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const ZeroPage(),
        '/login': (context) => const LoginPage(),
        '/url': (context) => const UrlPage(),
        '/auth': (context) => const AuthPage(),
        '/main': (context) => const MainPage(),
        '/info': (context) => const InfoPage(),
        '/bills': (context) => const BillsPage(),
        '/meters': (context) => const MetersPage(),
        '/settings': (context) => const SettingsPage(),
        '/payment': (context) => const PaymentPage(),
      },
      title: "Кабинет садовода",
    ),
  );
}
