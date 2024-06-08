import 'package:flutter/material.dart';

import '../bloc/bloc_imports.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    Key? key,
  }) : super(key: key);

  Widget button(BuildContext context, {required String value}) {
    return SizedBox(
      height: 64,
      width: 64,
      child: ElevatedButton(
        onPressed: () {
          if (value == '=') {
            _calculateExpression(context, operator: '=', isEqual: true);
          } else if (value == 'C') {
            _clearFields(context);
          } else if (value == '⌫') {
            _removeLastDigit(context);
          } else {
            if (value == '+' || value == '-' || value == 'x' || value == '÷') {
              _calculateExpression(context, operator: value, isEqual: false);
            } else {
              _addCharacters(context, num: value);
            }
          }
        },
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  void _addCharacters(BuildContext context, {required String num}) {
    context.read<CalculatorBloc>().add(OnChangeEvent(result: num));
  }

  void _calculateExpression(BuildContext context,
      {required String operator, required bool? isEqual}) {
    context.read<CalculatorBloc>().add(OnSolveEvent(
        firstNumber: '',
        secondNumber: '',
        operator: operator,
        isEqual: isEqual));
  }

  void _clearFields(BuildContext context) {
    context.read<CalculatorBloc>().add(OnClearEvent());
  }

  void _removeLastDigit(BuildContext context) {
    context.read<CalculatorBloc>().add(OnRemoveLastDigitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            button(context, value: '⌫'),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            button(context, value: '7'),
            const SizedBox(
              width: 10,
            ),
            button(context, value: '8'),
            const SizedBox(
              width: 10,
            ),
            button(context, value: '9'),
            const SizedBox(
              width: 10,
            ),
            button(context, value: 'x'),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            button(context, value: '4'),
            const SizedBox(
              width: 10,
            ),
            button(context, value: '5'),
            const SizedBox(
              width: 10,
            ),
            button(context, value: '6'),
            const SizedBox(
              width: 10,
            ),
            button(context, value: '-'),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            button(context, value: '1'),
            const SizedBox(
              width: 10,
            ),
            button(context, value: '2'),
            const SizedBox(
              width: 10,
            ),
            button(context, value: '3'),
            const SizedBox(
              width: 10,
            ),
            button(context, value: '+'),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            button(context, value: 'C'),
            const SizedBox(
              width: 10,
            ),
            button(context, value: '0'),
            const SizedBox(
              width: 10,
            ),
            button(context, value: '÷'),
            const SizedBox(
              width: 10,
            ),
            button(context, value: '='),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
