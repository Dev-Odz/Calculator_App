// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Operation extends Equatable {
  String firstNumber;
  String secondNumber;
  String operator;
  bool isEqual;

  Operation({
    required this.firstNumber,
    required this.secondNumber,
    required this.operator,
    required this.isEqual,
  });

  @override
  List<Object?> get props => [
        firstNumber,
        secondNumber,
        operator,
        isEqual,
      ];

  Operation copyWith({
    String? firstNumber,
    String? secondNumber,
    String? operator,
    bool? isEqual,
  }) {
    return Operation(
      firstNumber: firstNumber ?? this.firstNumber,
      secondNumber: secondNumber ?? this.secondNumber,
      operator: operator ?? this.operator,
      isEqual: isEqual ?? this.isEqual,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstNumber': firstNumber,
      'secondNumber': secondNumber,
      'operator': operator,
      'isEqual': isEqual,
    };
  }

  factory Operation.fromMap(Map<String, dynamic> map) {
    return Operation(
      firstNumber: map['firstNumber'] as String,
      secondNumber: map['secondNumber'] as String,
      operator: map['operator'] as String,
      isEqual: map['isEqual'] as bool,
    );
  }
}
