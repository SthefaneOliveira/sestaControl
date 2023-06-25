import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
import 'package:provider/provider.dart';
import 'database.dart';
import 'login_screen.dart';
import 'package:meu_app/listItens.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Preencha os controladores com os valores existentes do usuário
    usernameController.text = widget.user.username;
    passwordController.text = widget.user.password;
  }

  @override
  void dispose() {
    // Limpe os controladores quando a tela for descartada
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _editProfile(BuildContext context) async {
    final database = Provider.of<AppDatabase>(context, listen: false);

    final updatedUser = UsersCompanion(
      id: Value(widget.user.id),
      username: Value(usernameController.text),
      password: Value(passwordController.text),
    );

    await database.updateUser(updatedUser);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Perfil Atualizado'),
          content: Text('O perfil foi atualizado com sucesso.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProfile(BuildContext context) async {
    final database = Provider.of<AppDatabase>(context, listen: false);

    final userToDelete = UsersCompanion(
      id: Value(widget.user.id),
      username: Value(widget.user.username),
      password: Value(widget.user.password),
    );

    await database.deleteUser(userToDelete);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Perfil Excluído'),
          content: Text('O perfil foi excluído com sucesso.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        leading: IconButton(
          icon: Icon(MdiIcons.arrowLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.restart), //de atualizar
            onPressed: () {
              _editProfile(context);
            },
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyApp()),
              );
            },
            icon: Icon(Icons.abc),
            label: Text(' '),
          ),
          IconButton(
            icon: Icon(MdiIcons.delete), // deletar
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Excluir Perfil'),
                    content: Text('Tem certeza de que deseja excluir o perfil?'),
                    actions: [
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('Excluir'),
                        onPressed: () {
                          Navigator.pop(context);
                          _deleteProfile(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
            ),
          ],
        ),
      ),
    );
  }
}
