import 'package:math_mate/common/resources/colors.dart';
import 'package:math_mate/common/utils/extensions.dart';
import 'package:math_mate/core/domain/model/history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatelessWidget {
  final History history;
  final Function(History) onTap;

  const HistoryCard(this.history, {required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(history.timestamp);
    return GestureDetector(
      onTap: () => onTap(history),
      child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          decoration: BoxDecoration(
            color: ColorRes.grey900a,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      history.operation,
                      style: context.textTheme.bodyLarge,
                    ),
                    Text(
                      history.result,
                      style: context.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                '${DateFormat('yMd').format(dateTime)} \n ${DateFormat('Hm').format(dateTime)}',
                textAlign: TextAlign.end,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(Icons.arrow_forward_ios_rounded),
              )
            ],
          )),
    );
  }
}
