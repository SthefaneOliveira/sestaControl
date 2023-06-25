import 'package:flutter/material.dart';
import 'package:meu_app/database.dart';
import 'package:meu_app/profile_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(MdiIcons.arrowLeft),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Sistema de Doações'),
          ),
          body: ListView(
            children: const [
              Task('Arroz',
                  'https://cdn-icons-png.flaticon.com/512/6327/6327276.png', 4),
              Task('Feijão',
                  'https://cdn-icons-png.flaticon.com/512/6030/6030278.png', 2),
              Task('Leite',
                  'https://cdn-icons-png.flaticon.com/512/5900/5900617.png', 4),
              Task('Açucar',
                  'https://cdn-icons-png.flaticon.com/512/5847/5847839.png', 4),
              Task('Café',
                  'https://cdn-icons-png.flaticon.com/512/1106/1106263.png', 5),
            ],
          ),
        ));
  }
}

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  const Task(this.nome, this.foto, this.dificuldade, {Key? key})
      : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int qtd = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            color: Colors.green,
            height: 140,
          ),
          Column(
            children: [
              Container(
                color: Colors.white,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 72,
                      height: 100,
                      child: Image.network(
                        widget.foto,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            widget.nome,
                            style: const TextStyle(
                                fontSize: 23, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              MdiIcons.star,
                              size: 15,
                              color: (widget.dificuldade > 1)
                                  ? Colors.green
                                  : Colors.green[100],
                            ),
                            Icon(
                              MdiIcons.star,
                              size: 15,
                              color: (widget.dificuldade > 2)
                                  ? Colors.green
                                  : Colors.green[100],
                            ),
                            Icon(
                              MdiIcons.star,
                              size: 15,
                              color: (widget.dificuldade >= 3)
                                  ? Colors.green
                                  : Colors.green[100],
                            ),
                            Icon(
                              MdiIcons.star,
                              size: 15,
                              color: (widget.dificuldade >= 4)
                                  ? Colors.green
                                  : Colors.green[100],
                            ),
                            Icon(
                              MdiIcons.star,
                              size: 15,
                              color: (widget.dificuldade >= 5)
                                  ? Colors.green
                                  : Colors.green[100],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      // função que aumenta a quantiade
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {});
                            qtd++;
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(MdiIcons.arrowUp),
                              Text(
                                'KG',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      // função que deminui a quantiade
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {});
                            if (qtd > 0) {
                              qtd--;
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(MdiIcons.arrowDown),
                              Text(
                                'KG',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.dificuldade >= 0)
                            ? (qtd / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Quantidade: $qtd',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
