import 'dart:async';

import 'package:calculator/bloc/bloc_imports.dart';
import 'package:equatable/equatable.dart';
import 'package:math_expressions/math_expressions.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc()
      : super(CalculatorState(expression: '0', firstNumber: '0', result: '0')) {
    on<OnChangeEvent>(_onChange);
    on<OnClearEvent>(_onClear);
    on<OnRemoveLastDigitEvent>(_onRemoveLastDigit);
    on<OnSolveEvent>(_onSolve);
  }

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  FutureOr<void> _onChange(OnChangeEvent event, Emitter<CalculatorState> emit) {
    var result = state.result;
    var firstNumber = state.firstNumber;
    var secondNumber = state.secondNumber;
    var expression = state.expression;
    var operator = state.operator;

    if (state.isEqual == true) {
      result = '0';
      result =
          (result == '0') ? event.result : result.toString() + event.result;

      emit(CalculatorState(
        result: result.replaceAllMapped(reg, mathFunc),
        firstNumber: result,
      ));
    } else if (state.operator == null) {
      result = (state.result == '0')
          ? event.result
          : result.toString().replaceAll(',', '') + event.result;

      emit(CalculatorState(
          result: result.replaceAllMapped(reg, mathFunc),
          firstNumber: result,
          secondNumber: '0'));
    } else if (state.operator != null) {
      result = (secondNumber == null)
          ? event.result
          : state.secondNumber.toString() + event.result;

      emit(CalculatorState(
        firstNumber: firstNumber,
        secondNumber: result,
        expression: expression,
        operator: operator,
        result: result.replaceAllMapped(reg, mathFunc),
      ));
    } else {
      result = (state.secondNumber == '0')
          ? event.result
          : state.secondNumber.toString() + event.result;

      emit(CalculatorState(
        result: result.replaceAllMapped(reg, mathFunc),
        firstNumber: state.firstNumber,
      ));
    }
  }

  FutureOr<void> _onClear(OnClearEvent event, Emitter<CalculatorState> emit) {
    emit(CalculatorState(result: '0'));
  }

  FutureOr<void> _onRemoveLastDigit(
      OnRemoveLastDigitEvent event, Emitter<CalculatorState> emit) {
    String result;
    result = (state.result == '0')
        ? '0'
        : (state.result!.length == 1)
            ? '0'
            : state.result!.substring(0, state.result!.length - 1);

    emit(CalculatorState(result: result));
  }

  FutureOr<void> _onSolve(OnSolveEvent event, Emitter<CalculatorState> emit) {
    String expression = '';
    double firstResult;
    var result = state.result;
    var firstNumber = state.firstNumber;
    var secondNumber = state.secondNumber;
    var operator = state.operator;

    //* print('firstNumber: $firstNumber');
    //* print('secondNumber: $secondNumber');
    //* print('operator: $operator');
    //* print('isEqual: ${state.isEqual}');

    //? => Followed by
    //? First number != null => +/-/÷/x
    if (firstNumber != null && secondNumber == '0' && operator == null) {
      expression =
          '${firstNumber.replaceAllMapped(reg, mathFunc)} ${event.operator}';
      emit(CalculatorState(
          result: firstNumber.replaceAllMapped(reg, mathFunc),
          firstNumber: firstNumber,
          expression: expression,
          operator: event.operator));
    } else if (firstNumber != null &&
        secondNumber == null &&
        operator != null &&
        event.operator != '=') {
      expression =
          '${firstNumber.replaceAllMapped(reg, mathFunc)} ${event.operator}';
      emit(CalculatorState(
          result: firstNumber.replaceAllMapped(reg, mathFunc),
          firstNumber: firstNumber,
          expression: expression,
          operator: event.operator));
    } else if (firstNumber != null &&
        secondNumber == null &&
        operator == '=' &&
        event.operator == '=') {
      expression =
          '${firstNumber.replaceAllMapped(reg, mathFunc)} ${event.operator}';
      emit(CalculatorState(
          result: firstNumber.replaceAllMapped(reg, mathFunc),
          firstNumber: firstNumber,
          expression: expression,
          operator: event.operator));
//? Calculate Expression
// First Number, Operator, and Second Number != null => =
    } else if (firstNumber != null &&
        operator != null &&
        event.operator == '=') {
      if (secondNumber == null) {
        secondNumber = firstNumber;
        expression = '$firstNumber $operator $secondNumber ';

        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          firstResult = exp.evaluate(EvaluationType.REAL, cm);
          result = (firstResult % 1 == 0)
              ? '${firstResult.toInt()}'
              : '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        expression = '$firstNumber $operator $secondNumber ';

        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          firstResult = exp.evaluate(EvaluationType.REAL, cm);
          result = (firstResult % 1 == 0)
              ? '${firstResult.toInt()}'
              : '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      }

      expression =
          '${firstNumber.replaceAllMapped(reg, mathFunc)} $operator ${secondNumber.replaceAllMapped(reg, mathFunc)} = ';

      emit(CalculatorState(
          result: result.replaceAllMapped(reg, mathFunc),
          firstNumber: result,
          secondNumber: secondNumber,
          expression: expression,
          operator: state.operator,
          isEqual: true));
// First Number, Operator, and Second Number != null => +/-/÷/x
    } else if (firstNumber != null &&
        secondNumber != null &&
        operator != null &&
        event.operator != '=' &&
        state.isEqual == null) {
      expression = '$firstNumber $operator $secondNumber ';

      expression = expression.replaceAll('x', '*');
      expression = expression.replaceAll('÷', '/');

      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        firstResult = exp.evaluate(EvaluationType.REAL, cm);
        result = (firstResult % 1 == 0)
            ? '${firstResult.toInt()}'
            : '${exp.evaluate(EvaluationType.REAL, cm)}';
      } catch (e) {
        result = "Error";
      }

      expression =
          '${result.replaceAllMapped(reg, mathFunc)} ${event.operator} ';

      emit(CalculatorState(
          result: result.replaceAllMapped(reg, mathFunc),
          firstNumber: result,
          expression: expression,
          operator: event.operator));
    } else if (firstNumber != null &&
        secondNumber != null &&
        operator != null &&
        event.operator != '=' &&
        state.isEqual == true) {
      expression =
          '${firstNumber.replaceAllMapped(reg, mathFunc)} ${event.operator}';
      emit(CalculatorState(
          result: firstNumber.replaceAllMapped(reg, mathFunc),
          firstNumber: firstNumber,
          expression: expression,
          operator: event.operator));
    }
  }
}

// TODO: Remove commas in double type numbers starting with 0.
// TODO: Add DECIMAL POINT Button in UI
// TODO: Improve UI - Use table as Button