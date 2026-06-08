import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sms_gpt_app/core/di/injection_container.dart' as di;
import 'package:sms_gpt_app/features/students/presentation/bloc/student_bloc.dart';
import 'package:sms_gpt_app/features/students/presentation/bloc/student_event.dart';
import 'package:sms_gpt_app/features/students/presentation/pages/login_page.dart';
import 'package:sms_gpt_app/features/students/presentation/pages/sign_up.dart';
import 'package:sms_gpt_app/features/students/presentation/pages/students_pages.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   await Hive.openBox('appBox');
//   await di.init();
//   runApp(const App());
// }

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SMS GPT App',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: Scaffold(
//         appBar: AppBar(title: const Text('SMS GPT App')),
//         body: const Center(child: Text('Welcome to SMS GPT App!')),
//       ),
//     );
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('appBox');

  await di.init();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMS GPT',
      theme: ThemeData(primarySwatch: Colors.blue),

      initialRoute: '/signup',

      routes: {
        '/signup': (context) => const SignUpPage(),
        '/login': (context) => const LoginPage(),
        '/students': (context) => BlocProvider(
          create: (_) => di.s1<StudentBloc>()..add(LoadStudents()),
          child: const StudentsPage(),
        ),
      },
    );
  }
}
