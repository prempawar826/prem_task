import 'package:flutter/material.dart';
import 'package:prem_task/task1/task1animation.dart';
import 'package:prem_task/task2/pages/showtododata.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color themeColor = Color(0xFF6200EE);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("My Tasks",style: TextStyle(fontWeight: FontWeight.w600),),
        centerTitle: true,
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding:  const EdgeInsets.symmetric(horizontal:  8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            taskcard("Task 1", "Design Animation Screen.", Icons.design_services,(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Task1Screen()));
            }),
            taskcard("Task 2", "Todo Application", Icons.api,(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ShowTodoDataView()));
            }),
            taskcard("Task 3", "List Filters", Icons.bug_report,(){
            
            }),
          ],
        ),
      ),
    );
  }

  Widget taskcard(String title, String description, IconData icon,Function onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            themeColor,
            themeColor.withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: themeColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () => onTap(),
      ),
    );
  }
}