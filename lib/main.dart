import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:todolist/config/firebase_options.dart';
import 'package:todolist/view/page/home_page.dart';
import 'package:todolist/view_model/darkmode_view_model.dart';
import 'package:todolist/view_model/platform_view_model.dart';
import 'package:todolist/view_model/todo_list_view_model.dart';
import 'package:todolist/view_model/user_data_view_model.dart';
import 'package:todolist/view_model/user_view_model.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => PlatformViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProxyProvider<UserViewModel, UserDataViewModel>(
          create: (context) => UserDataViewModel(context.read<UserViewModel>()),
          update: (_, value, __) => UserDataViewModel(value),
        ),
        ChangeNotifierProxyProvider<UserDataViewModel, DarkmodeViewModel>(
          create: (context) =>
              DarkmodeViewModel(context.read<UserDataViewModel>()),
          update: (_, value, __) => DarkmodeViewModel(value),
        ),
        ChangeNotifierProxyProvider<UserDataViewModel, TodoListViewModel>(
          create: (context) =>
              TodoListViewModel(context.read<UserDataViewModel>()),
          update: (_, value, __) => TodoListViewModel(value),
        ),
      ],
      child: Builder(builder: (context) {
        context.read<PlatformViewModel>().size = MediaQuery.of(context).size;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "TODO List",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.orange.shade100,
              brightness: context.watch<DarkmodeViewModel>().brightness,
            ),
            useMaterial3: true,
          ),
          home: const HomePage(),
        );
      }),
    );
  }
}
