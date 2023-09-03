import 'package:math_mate/core/domain/model/history.dart';
import 'package:math_mate/presentation/bloc/history/history_bloc.dart';
import 'package:math_mate/presentation/widgets/app_bar.dart';
import 'package:math_mate/presentation/widgets/error_dialog.dart';
import 'package:math_mate/presentation/widgets/history_card.dart';
import 'package:math_mate/presentation/widgets/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _onGetHistoryList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, [false]);
        return true;
      },
      child: Scaffold(
        appBar: PrimaryAppBar(context, 'History',
            leadingWidget: GestureDetector(
              onTap: () => Navigator.pop(context, [false]),
              child: const Icon(Icons.arrow_back_rounded),
            ),
            actionWidgets: [
              GestureDetector(
                onTap: _onDeleteHistoryClick,
                child: const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(Icons.delete)),
              )
            ]),
        body: BlocListener<HistoryBloc, HistoryState>(
          listener: _onHistoryBlocListener,
          child: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state.list.isEmpty) {
                return const EmptyState();
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  itemCount: state.list.length > 5 ? 5 : state.list.length,
                  itemBuilder: (context, index) => HistoryCard(
                    state.list[index],
                    onTap: _onHistoryDetailClick,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _onGetHistoryList() {
    BlocProvider.of<HistoryBloc>(context).add(HistoryEventGetHistoryList());
  }

  void _onDeleteHistoryClick() {
    BlocProvider.of<HistoryBloc>(context).add(HistoryEventDeleteHistory());
  }

  void _onHistoryDetailClick(History history) {
    BlocProvider.of<HistoryBloc>(context)
        .add(HistoryEventHistoryDetailClick(history));
  }

  Future<void> _onHistoryBlocListener(
      BuildContext context, HistoryState state) async {
    if (state is HistoryStateHistoryDetailClicked) {
      Navigator.pop(context, [true, state.history]);
    } else if (state is HistoryStateError) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => ErrorDialog(state.errMessage),
      );
    }
  }
}
