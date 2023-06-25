import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database.dart';
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>(
          create: (_) => AppDatabase(),
          dispose: (_, db) => db.close(),
        ),
      ],
      child: MaterialApp(
        title: 'Cadastro de Usuário',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
