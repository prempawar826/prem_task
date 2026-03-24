import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prem_task/core/appcolors.dart';
import 'package:prem_task/datastore/hiveclass.dart';
import 'package:prem_task/task2/controller/todoprovider.dart';
import 'package:prem_task/widigets/commantextfiled.dart';
import 'package:provider/provider.dart';
class TodoFormView extends StatefulWidget {
    final bool isEdit;
  final Todo? todo;
  const TodoFormView({super.key,    this.isEdit = false,
    this.todo,});

  @override
  State<TodoFormView> createState() => _TodoFormViewState();
}

class _TodoFormViewState extends State<TodoFormView> {

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.todo != null) {
      var provider = Provider.of<TodoProvider>(context, listen: false);
      provider.titleController.text = widget.todo!.title;
      provider.descriptionController.text = widget.todo!.description;
      int minutes = widget.todo!.mainduration ~/ 60;
      int seconds = widget.todo!.mainduration % 60;
      provider.minutesController.text = minutes.toString();
      provider.secondsController.text = seconds.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var todoProvider = Provider.of<TodoProvider>(context,listen: false);
    return Scaffold(
        resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Appcolors.primarycolor,
        title:  Text('Add Todo',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: size.height * 0.025  ),),
      ),
      body: SafeArea(
  child: SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.02),

          CustomeTextFiled(
            prefixicon: Icons.title,
            size: size,
            hinttitle: 'Title',
            controller: todoProvider.titleController,
          ),

          SizedBox(height: size.height * 0.02),

          CustomeTextFiled(
            size: size,
            hinttitle: 'Description',
            controller: todoProvider.descriptionController,
            prefixicon: Icons.description_sharp,
          ),

          SizedBox(height: size.height * 0.02),

          Row(
            children: [
              Expanded(
                child: CustomeTimeTextFiled(
                  size: size,
                  hinttitle: 'Minuts',
                  minuts: true,
                  controller: todoProvider.minutesController,
                  prefixicon: Icons.timer,
                ),
              ),
              SizedBox(width: size.width * 0.02),
              Expanded(
                child: CustomeTimeTextFiled(
                  size: size,
                  hinttitle: 'Second',
                  minuts: false,
                  controller: todoProvider.secondsController,
                  prefixicon: Icons.timer_sharp,
                ),
              ),
            ],
          ),

          SizedBox(height: size.height * 0.04),

          Row(
            children: [
              Expanded(
                child: CustomeButtons(
                  size: size,
                  buttonname: 'Cancel',
                  borderlinebutton: true,
                  ontapbutton: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(width: size.width * 0.04),
              Expanded(
                child: CustomeButtons(
                  size: size,
                  buttonname: widget.isEdit ?  'Update' : 'Add',
                  ontapbutton: () {
                    int minutes = int.tryParse(todoProvider.minutesController.text) ?? 0;
                    int seconds = int.tryParse(todoProvider.secondsController.text) ?? 0;

                    if(widget.isEdit && widget.todo != null) {
                      todoProvider.updateTodo(
                        widget.todo!,
                        title: todoProvider.titleController.text,
                        duration: (minutes * 60) + seconds,
                      );
                    } else {  

                    todoProvider.addTodo(
                      Todo(
                        id: DateTime.now().toString(),
                        title: todoProvider.titleController.text,
                        description: todoProvider.descriptionController.text,
                        duration: (minutes * 60) + seconds,
                        mainduration: (minutes * 60) + seconds, 
                      ),
                    );
                    }

                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20), 
        ],
      ),
    ),
  ),
)
    );
  }
}
