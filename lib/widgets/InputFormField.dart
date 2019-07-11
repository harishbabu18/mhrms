import 'package:flutter/material.dart';


class InputFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  InputFormField({this.label, this.controller});
@override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText:label+ "....",
            labelText: label),
        validator: (value){
        if(value.isEmpty){
          return label+' Not Found';
        }
        return null;
      },)
      ,)
      ,],
    );
  }
}