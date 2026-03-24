import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prem_task/core/appcolors.dart';
import 'package:prem_task/datastore/hiveclass.dart';
import 'package:prem_task/task2/controller/todoprovider.dart';
import 'package:prem_task/task2/pages/detailspage.dart';
import 'package:prem_task/task2/pages/todoform.dart';
import 'package:provider/provider.dart';
class ShowTodoDataView extends StatefulWidget {
  const ShowTodoDataView({super.key});

  @override
  State<ShowTodoDataView> createState() => _ShowTodoDataViewState();
}

class _ShowTodoDataViewState extends State<ShowTodoDataView> {
  @override

showtodoform(setisedit,Todo? settodos){
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  
  builder: (context) {
    return FractionallySizedBox(

        heightFactor: 0.75,
      child:  TodoFormView(
        isEdit: setisedit,
        todo: settodos,
      ),
    );
  },
);
}


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Appcolors.primarycolor,
        title:  Text('Todo Data',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: size.height * 0.025),),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        onPressed: () {
         showtodoform(false,null);
        },
        backgroundColor: Appcolors.primarycolor,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
      body: Consumer<TodoProvider>(
  builder: (context, provider, _) {
    List<Todo> todos = provider.todos;
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        var todo = todos[index];
        return buildTodoCard(todo, provider, context,
          () {
            showtodoform(true,todo);
          }
        );
     
     
      },
    );
  },
),
    );
  }
}


Widget buildTodoCard(Todo todo, TodoProvider provider, BuildContext context,Function ontapedit) {
  int remaining = todo.getRemainingSeconds();

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TodoDetailsPage(todo: todo),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: todo.isCompleted
              ? [Colors.green, Colors.greenAccent]
              : todo.isRunning
                  ? [Colors.orange, Colors.deepOrange]
                  : [const Color.fromARGB(255, 42, 130, 202), const Color.fromARGB(255, 9, 50, 122)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                todo.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
    
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  ontapedit();
                },
              ),
            ],
          ),
    
          Text(
            todo.description,
            style: const TextStyle(color: Colors.white70),
          ),
    
          const SizedBox(height: 10),
    
          Text(
            formatTime(remaining),
            style: const TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
    
          const SizedBox(height: 10),
    
          Text(
            todo.isCompleted
                ? "Completed"
                : todo.isRunning
                    ? "Running"
                    : "Paused",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
    
          const SizedBox(height: 10),
    
          Row(
            children: [
              if (!todo.isRunning && !todo.isCompleted)
                IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  onPressed: () => provider.startTimer(todo.id),
                ),
    
              if (todo.isRunning)
                IconButton(
                  icon: const Icon(Icons.pause, color: Colors.white),
                  onPressed: () => provider.pauseTimer(todo.id),
                ),
    
              if (!todo.isCompleted)
                IconButton(
                  icon: const Icon(Icons.done, color: Colors.white),
                  onPressed: () => provider.complettimer(todo.id),
                ),
    
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: () => provider.deleteTodo(todo),
              ),
            ],
          )
        ],
      ),
    ),
  );
}


String formatTime(int seconds) {
  final m = (seconds ~/ 60).toString().padLeft(2, '0');
  final s = (seconds % 60).toString().padLeft(2, '0');
  return "$m:$s";
}