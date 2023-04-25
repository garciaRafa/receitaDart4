import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

var dataObjects = [];

void main() {
  MyApp app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("no build da classe MyApp");
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Dicas"),
          ),
          body: DataTableWidget(jsonObjects: dataObjects),
          bottomNavigationBar: NewNavBar2(),
        ));
  }
}

/*class NewNavBar extends HookWidget {
  NewNavBar();

  @override

  Widget build(BuildContext context) {
    print("no build da classe NewNavBar");
    var state = useState(1);
    return BottomNavigationBar(
      onTap: (index) {
        state.value = index;
      },
      currentIndex: state.value,
      items: [
        BottomNavigationBarItem(
          label: "Cafés",
          icon: Icon(Icons.coffee_outlined),
        ),
        BottomNavigationBarItem(
          label: "Cervejas", 
          icon: Icon(Icons.local_drink_outlined)),
        BottomNavigationBarItem(
          label: "Nações",
          icon: Icon(Icons.flag_outlined))
        ]
      );
  }
}*/

class NewNavBar2 extends StatefulWidget {

  @override

  _NewNavBar2State createState() => _NewNavBar2State();
}

class _NewNavBar2State extends State<NewNavBar2> {
  int _currentIndex = 1;

  @override

  Widget build(BuildContext context) {
    print("no build da classe NewNavBar2");
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          label: "Cafés",
          icon: Icon(Icons.coffee_outlined),
        ),
        BottomNavigationBarItem(
          label: "Cervejas",
          icon: Icon(Icons.local_drink_outlined),
        ),
        BottomNavigationBarItem(
          label: "Nações",
          icon: Icon(Icons.flag_outlined),
        ),
      ],
    );
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  DataTableWidget({this.jsonObjects = const []});

  @override
  Widget build(BuildContext context) {
    print("no build da classe DataTableWidget");
    var columnNames = ["Nome", "Estilo", "IBU"],
      propertyNames = ["name", "style", "ibu"];

    return DataTable(
      columns: columnNames.map(
        (name) => DataColumn(
          label: Expanded(
            child: Text(name,
              style: TextStyle(fontStyle: FontStyle.italic)
            )
          )
        )
      ).toList(),
      rows: jsonObjects.map(
        (obj) => DataRow(
          cells: propertyNames.map(
            (propName) => DataCell(Text(obj[propName])
            )
          ).toList()
        )
      ).toList());
  }
}


/*1. Após a primeira renderização do app, é possível notar a impressão de 3 mensagens no console: 
"no build da classe MyApp", "no build da classe DataTableWidget" e "no build da classe NewNavBar".
Isso quer dizer que todas as classes do build foram renderizadas no ínicio do app.
Ao acionar os botões da barra inferior, é possível observar que apenas o método build da classe 
NewNavBar é chamado novamente a cada interação. Com isso percebemos que o Flutter faz a reconstrução do 
Widget apenas quando necessário, ou seja, quando há alguma alteração no estado do Widget.

2. Ambas as implementações funcionam bem e produzem o mesmo resultado, contudo, o StatefulWidget precisa
da criação de uma classe para cada widget que precisa de estado, enquanto o HookWidget permite usar 
hooks para gerenciar o estado dentro de um único widget.*/