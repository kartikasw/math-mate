import 'package:math_mate/common/utils/enumeration/calculator_type_enum.dart';
import 'package:math_mate/common/utils/extensions.dart';
import 'package:flutter/material.dart';

class CalculatorTypeCard extends StatelessWidget {
  final CalculatorTypeEnum type;

  const CalculatorTypeCard(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: type.color, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Icon(type.icon, size: 60),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 10),
                child: Icon(type.icon, size: 35),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                type.title,
                style: context.textTheme.titleMedium,
              ),
            ),
          ),
          const Icon(Icons.arrow_circle_right_rounded, size: 30)
        ],
      ),
    );
  }
}
