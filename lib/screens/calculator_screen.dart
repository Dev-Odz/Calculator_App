import 'package:calculator/bloc/bloc_imports.dart';
import 'package:flutter/material.dart';

import '../widgets/buttons_widget.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String result = '';
  String expression = '0';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                return Text(
                  state.expression ?? '0',
                  style: const TextStyle(
                    fontSize: 48.0,
                  ),
                );
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                return Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      state.result ?? '0',
                      style: const TextStyle(
                        fontSize: 24.0 + 24.0 + 24.0,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        const Buttons()
      ],
    );
  }
}
