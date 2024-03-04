import 'package:flutter/material.dart';

class RegisterDrink extends StatefulWidget {
  const RegisterDrink({super.key});

  @override
  State<RegisterDrink> createState() => _RegisterDrinkState();
}

class _RegisterDrinkState extends State<RegisterDrink> {
  List<String> menuList = ["막걸리", "증류주"];
  @override
  Widget build(BuildContext context) {
    String dropDownValue = "막걸리";
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        const SizedBox(height: 20),
        DropdownButton(
            value: dropDownValue,
            items: menuList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                dropDownValue = value!.toString();
              });
            }),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text("술 이름"),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "가격",
          ),
        ),
      ],
    )));
  }
}
