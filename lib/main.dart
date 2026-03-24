import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prem_task/datastore/hiveclass.dart';
import 'package:prem_task/homepage.dart';
import 'package:prem_task/task2/controller/todoprovider.dart';
import 'package:provider/provider.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
await Hive.openBox<Todo>('todoappBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => TodoProvider(),)
    ],
    
    
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prem Task',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    ),);
  }
}
