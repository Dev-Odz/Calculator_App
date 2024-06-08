// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calculator_bloc.dart';

class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class OnChangeEvent extends CalculatorEvent {
  final String result;
  const OnChangeEvent({
    required this.result,
  });

  @override
  List<Object> get props => [result.length];
}

class OnDeleteEvent extends CalculatorEvent {}

class OnClearEvent extends CalculatorEvent {}

class OnRemoveLastDigitEvent extends CalculatorEvent {}

// ignore: must_be_immutable
class OnSolveEvent extends CalculatorEvent {
  String? firstNumber;
  String? secondNumber;
  String? operator;
  bool? isEqual;

  OnSolveEvent({
    required this.firstNumber,
    required this.secondNumber,
    required this.operator,
    required this.isEqual,
  });
}
