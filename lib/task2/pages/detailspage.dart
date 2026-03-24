import 'package:flutter/material.dart';
import 'package:prem_task/core/appcolors.dart';
import 'package:prem_task/widigets/commanbuttons.dart';
import 'package:provider/provider.dart';
import 'package:prem_task/datastore/hiveclass.dart';
import 'package:prem_task/task2/controller/todoprovider.dart';

class TodoDetailsPage extends StatelessWidget {
  final Todo todo;

  const TodoDetailsPage({super.key, required this.todo});

  String formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);



    final total = todo.mainduration;
    final remaining = todo.getRemainingSeconds();
    final elapsed = total - remaining;

    double progress = total == 0 ? 0 : elapsed / total;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor:  Appcolors.primarycolor,
        title: const Text("Todo Details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5F6FA), Color(0xFFEAF2FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: const BoxDecoration(
                  color: Appcolors.primarycolor,
              
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [

                    /// TITLE
                    Text(
                      todo.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      todo.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      formatTime(remaining),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        minHeight: 8,
                        backgroundColor: Colors.white24,
                        valueColor:
                            const AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          infoTile("Total", formatTime(total), Colors.black87),
                          infoTile("Elapsed", formatTime(elapsed),Appcolors.accentGreen),
                          infoTile("Remaining", formatTime(remaining), Appcolors.accentRed),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Status: "),
                          Text(
                            todo.isCompleted
                                ? "Completed"
                                : todo.isRunning
                                    ? "Running"
                                    : "Paused",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: todo.isCompleted
                                  ?Appcolors. accentGreen
                                  : todo.isRunning
                                      ?Appcolors. accentOrange
                                      : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

             todo.isCompleted ? SizedBox.shrink() : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [

                    Expanded(
                      child: actionbutton(
                        "Start",
                        Icons.play_arrow,
                       Appcolors. accentGreen,
                        () => provider.startTimer(todo.id),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: actionbutton(
                        "Pause",
                        Icons.pause,
                      Appcolors.  accentOrange,
                        () => provider.pauseTimer(todo.id),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: actionbutton(
                        "Done",
                        Icons.check,
                        Appcolors.accentRed,
                        () => provider.complettimer(todo.id),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoTile(String title, String value, Color color) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    );
  }

}