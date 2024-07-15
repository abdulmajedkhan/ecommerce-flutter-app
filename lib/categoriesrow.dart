import 'package:flutter/material.dart';
class CatRow extends StatelessWidget {
  const CatRow({super.key, required this.catTitle});
  final String catTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(5),
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: const Border(
                right: BorderSide(color: Colors.black),
                left: BorderSide(color: Colors.black),
                bottom: BorderSide(color: Colors.black),
                top: BorderSide(color: Colors.black))),
        child: Center(
          child: Text(
            catTitle,
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
