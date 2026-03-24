
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prem_task/core/appcolors.dart';

class CustomeButtons extends StatelessWidget {
  String buttonname;
  Function ontapbutton;
  bool?  borderlinebutton = false;
   CustomeButtons({
    super.key,
    required this.size,
    required this.buttonname,
    required this.ontapbutton,
     this.borderlinebutton
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontapbutton();
      },
      child: Container(
       height: size.height * 0.06,
       width: size.width * 0.42,
       decoration: 
      BoxDecoration(
        border: Border.all(
          color: Appcolors.primarycolor
        ),
       borderRadius: BorderRadius.circular(8),
       color: borderlinebutton == true ? Colors.transparent: Appcolors.primarycolor
      ),
      child: Center(
        child: Text(buttonname,style: TextStyle(color:
        borderlinebutton  == true? Appcolors.primarycolor : Colors.white,fontSize: size.height * 0.020,fontWeight: FontWeight.w600),),
      ),
      ),
    );
  }
}

class CustomeTextFiled extends StatelessWidget {
  String? hinttitle;
  TextEditingController? controller;
 IconData? prefixicon; 
   CustomeTextFiled({
    super.key,
    required this.size,
    required this.hinttitle,
    required this.controller,
    this.prefixicon
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixicon),
        hintText: hinttitle,
        
        hintStyle: TextStyle(fontSize: size.height * 0.020),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide:     const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        )
      ),
    );
  }
}





class CustomeTimeTextFiled extends StatefulWidget {
  final String? hinttitle;
  final TextEditingController? controller;
  final IconData? prefixicon;
  final bool minuts;
  final Size size;

  const CustomeTimeTextFiled({
    super.key,
    required this.size,
    required this.hinttitle,
    required this.controller,
    this.prefixicon,
    required this.minuts,
  });

  @override
  State<CustomeTimeTextFiled> createState() => _CustomeTimeTextFiledState();
}

class _CustomeTimeTextFiledState extends State<CustomeTimeTextFiled> {
  String? errorText;

  void validate(String value) {
    if (value.isEmpty) {
      errorText = 'Required';
      return;
    }

    int val = int.tryParse(value) ?? 0;

    if (widget.minuts) {
      if (val > 5) {
        errorText = 'Max 5 minutes allowed';
      } else {
        errorText = null;
      }
    } else {
      if (val > 59) {
        errorText = 'Max 59 seconds allowed';
      } else {
        errorText = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(2), 
      ],
      onChanged: (value) {
        setState(() {
          validate(value); 
        });
      },
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefixicon),
        hintText: widget.hinttitle,
        errorText: errorText,
        hintStyle: TextStyle(fontSize: widget.size.height * 0.020),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}