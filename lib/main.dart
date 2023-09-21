import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Tic Tac Toe"),
          ),
          body: TicTacToeProvider()),
    );
  }
}

// ignore: must_be_immutable
class TicTacToeProvider extends StatefulWidget {
  TicTacToeProvider({super.key});
  List<String> choices = [
    'O',
    'X',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  State<TicTacToeProvider> createState() => TicTacToe();
}

List<Widget> map(List list, f) {
  List<Widget> result = [];
  for (int i = 0; i < list.length; i++) {
    final choice = list[i];
    result.add(f(choice, i));
  }
  return result;
}

class TicTacToe extends State<TicTacToeProvider> {
  List<int> getNotNullIndex() {
    List<int> nullIndex = [];
    for (int index = 0; index < widget.choices.length; index++) {
      final choice = widget.choices[index];

      if (choice == '') {
        nullIndex.add(index);
      }
    }

    return nullIndex;
  }

  void generateChoice() {
    var nullIndex = getNotNullIndex();
    if (nullIndex.isNotEmpty) {
      int randomNumber = Random().nextInt(nullIndex.length);
      int? randomIndex = nullIndex[randomNumber];
      setState(() {
        widget.choices[randomIndex] = 'O';
      });
    }
  }

  void setUserChoiceAndCallBot(int index) {
    var nullIndex = getNotNullIndex();
    if (nullIndex.toString().contains(index.toString())) {
      setState(() {
        widget.choices[index] = 'X';
      });
      generateChoice();
    }
  }

  void reset() {
    setState(() {
      widget.choices = [
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 1,
      children: [
        GridView.count(
            crossAxisCount: 3,
            children: map(
                widget.choices,
                (choice, index) => InkWell(
                      onTap: () => setUserChoiceAndCallBot(index),
                      child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: Center(
                              child: choice == 'O'
                                  ? const Icon(
                                      Icons.circle_outlined,
                                      size: 80,
                                    )
                                  : choice == 'X'
                                      ? const Icon(
                                          Icons.dangerous_outlined,
                                          size: 80,
                                        )
                                      : const Text(''))),
                    )).toList()),
        Center(
            child: TextButton(
          onPressed: reset,
          child: const Text("Reset"),
        ))
      ].toList(),
    );
  }
}
