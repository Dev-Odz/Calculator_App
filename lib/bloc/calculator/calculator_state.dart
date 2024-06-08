// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calculator_bloc.dart';

// ignore: must_be_immutable
class CalculatorState extends Equatable {
  String? result;
  String? expression;
  String? firstNumber;
  String? secondNumber;
  String? operator;
  bool? isEqual;

  CalculatorState({
    this.result,
    this.expression,
    this.firstNumber,
    this.secondNumber,
    this.operator,
    this.isEqual,
  });

  @override
  List<Object> get props => [
        expression ?? '0',
        firstNumber ?? '0',
        secondNumber ?? '0',
        result ?? '0',
        operator ?? '',
        isEqual ?? false,
      ];
}
