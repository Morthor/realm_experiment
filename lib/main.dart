import 'package:fluent_ui/fluent_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
      theme: ThemeData(accentColor: Colors.orange),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _itemTextController = TextEditingController();
  List<Todo> _todoList = List.empty(growable: true);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.topLeft,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width/2,
                padding: const EdgeInsets.only(right: 10.0),
                child: TextFormBox(
                  controller: _itemTextController,
                  placeholder: 'Remember to ...',
                  onFieldSubmitted: (_) =>_submit(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                child: FilledButton(
                  child: const Icon(FluentIcons.add, size: 12, color: Colors.white,),
                  onPressed: _submit,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    checked: _todoList[index].completed,
                    onChanged: (value) => setState(() => _todoList[index].completed = !_todoList[index].completed),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(_todoList[index].title),
                  ),
                  trailing: IconButton(
                    icon: Icon(FluentIcons.delete, color: Colors.red,),
                    onPressed: () => removeTodo(_todoList[index]),
                  ),
                );
              },
            )
          ),
        ],
      ),
    );
  }

  void _submit(){
    if(_itemTextController.text != ''){
      setState(() {
        _todoList.add(Todo(title: _itemTextController.text));
      });
      _itemTextController.clear();
    }
  }

  void removeTodo(Todo todo){
    setState(() {
      _todoList.remove(todo);
    });
  }
}

class Todo{
  String title;
  bool completed;

  Todo({
    required this.title,
    this.completed = false,
  });

  Todo.fromMap(Map<String, dynamic> map) :
        title = map['title'],
        completed = map['completed'];

  updateTitle(title){
    this.title = title;
  }

  Map toMap(){
    return {
      'title': title,
      'completed': completed,
    };
  }
}