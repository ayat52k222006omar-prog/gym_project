import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  var count = 0;

  void increment() {
    count++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: increment,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("Counter App")),
      body: Center(
        child: 
        Text(count.toString(), style: TextStyle(fontSize: 50)),
      ),
    );
  }
}