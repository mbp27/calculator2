import 'package:calculator2/data/models/calculation.dart';
import 'package:calculator2/helpers/utils.dart';
import 'package:calculator2/logic/cubits/calculation/calculation_cubit.dart';
import 'package:calculator2/logic/cubits/history/history_cubit.dart';
import 'package:calculator2/logic/cubits/theme/theme_cubit.dart';
import 'package:calculator2/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonModel {
  final String operator;
  final String? tooltip;
  final double size;
  final bool isBold;
  final bool isPortrait;

  ButtonModel({
    required this.operator,
    this.tooltip,
    this.size = 26.0,
    this.isBold = false,
    this.isPortrait = true,
  });
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isHistoryVisible = false;
  final ScrollController _scrollController = ScrollController();
  final List<ButtonModel> buttons = [
    ButtonModel(operator: 'C', tooltip: 'Clear'),
    ButtonModel(operator: '()', tooltip: 'Brackets'),
    ButtonModel(operator: '%', tooltip: 'Percentage', isBold: true),
    ButtonModel(operator: '÷', tooltip: 'Division', size: 32.0, isBold: true),
    ButtonModel(operator: '7'),
    ButtonModel(operator: '8'),
    ButtonModel(operator: '9'),
    ButtonModel(
      operator: '×',
      tooltip: 'Multiplication',
      size: 32.0,
      isBold: true,
    ),
    ButtonModel(operator: '4'),
    ButtonModel(operator: '5'),
    ButtonModel(operator: '6'),
    ButtonModel(operator: '-', tooltip: 'Minus', size: 32.0, isBold: true),
    ButtonModel(operator: '1'),
    ButtonModel(operator: '2'),
    ButtonModel(operator: '3'),
    ButtonModel(operator: '+', tooltip: 'Plus', size: 32.0, isBold: true),
    ButtonModel(operator: '+/-'),
    ButtonModel(operator: '0'),
    ButtonModel(operator: '.'),
    ButtonModel(operator: '=', tooltip: 'Equal', size: 32.0, isBold: true),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showHistory() {
    setState(() {
      _isHistoryVisible = !_isHistoryVisible;
    });
  }

  void _setTheme() {
    context.read<ThemeCubit>().onToggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    final histories =
        context.select((HistoryCubit cubit) => cubit.state).reversed.toList();
    final calculationState =
        context.select((CalculationCubit cubit) => cubit.state);
    final question = calculationState.question;
    final answer = calculationState.answer;
    final increase1 = calculationState.increase1;
    final increase2 = calculationState.increase2;
    final isInitial = calculationState.isInitial;
    final themeMode = context.select((ThemeCubit cubit) => cubit.state);
    final themeIcon =
        themeMode == ThemeMode.light ? Icons.brightness_4 : Icons.brightness_5;

    return BlocListener<CalculationCubit, CalculationState>(
      listener: (context, state) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        if (state.isError) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                duration: const Duration(seconds: 2),
              ),
            );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: SelectableText.rich(
                            TextSpan(
                              children: List<InlineSpan>.generate(
                                question.length,
                                (index) => TextSpan(
                                  text: question[index],
                                  style: TextStyle(
                                    color: !Utils.isNumber(question[index])
                                        ? Theme.of(context).primaryColor
                                        : null,
                                  ),
                                ),
                              ).toList(),
                            ),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: increase1
                                  ? increase2
                                      ? 26.0
                                      : 28.0
                                  : 40.0,
                            ),
                          ),
                        ),
                      ),
                      if (answer != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 22.0),
                          child: SelectableText.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '=',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: Utils.formatAmount(
                                      answer.toString().length > 15
                                          ? answer.toStringAsExponential(8)
                                          : answer.toString()),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 32.0),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Tooltip(
                                message: 'History',
                                child: IconButton(
                                  splashRadius: 20.0,
                                  onPressed:
                                      histories.isEmpty ? null : _showHistory,
                                  icon: Icon(
                                    _isHistoryVisible
                                        ? Icons.calculate
                                        : Icons.history,
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: 'Switch Theme',
                                child: IconButton(
                                  splashRadius: 20.0,
                                  onPressed: _setTheme,
                                  icon: Icon(themeIcon),
                                ),
                              ),
                              Tooltip(
                                message: 'Profile',
                                child: IconButton(
                                  splashRadius: 20.0,
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(ProfileScreen.routeName),
                                  icon: const Icon(Icons.person_outline),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Tooltip(
                          message: 'Delete',
                          child: IconButton(
                            splashRadius: 20.0,
                            disabledColor:
                                Theme.of(context).primaryColor.withOpacity(0.4),
                            color: Theme.of(context).primaryColor,
                            onPressed: isInitial
                                ? null
                                : () =>
                                    context.read<CalculationCubit>().onDelete(),
                            icon: const Icon(Icons.backspace_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1),
                  Stack(
                    children: [
                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 16.0,
                        ),
                        children: buttons
                            .map((e) => _ButtonItem(buttonModel: e))
                            .toList(),
                      ),
                      Visibility(
                        visible: _isHistoryVisible,
                        child: _buildHistory(context, histories),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistory(BuildContext context, List<Calculation> histories) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: EdgeInsets.only(
        right: (MediaQuery.of(context).size.width / 4) + 4.0,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          right: BorderSide(color: Theme.of(context).dividerColor),
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: ListView.separated(
              reverse: true,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 16.0),
              itemCount: histories.length,
              itemBuilder: (context, index) {
                final calculcation = histories[index];
                final question = calculcation.question;
                final answer = calculcation.answer;
                final answerString = answer != null
                    ? answer.toString().length > 15
                        ? answer.toStringAsExponential(8)
                        : answer.toString()
                    : null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () =>
                            context.read<CalculationCubit>().onAdd(question),
                        child: Text(
                          question,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    if (answer != null && answerString != null) ...[
                      const SizedBox(height: 6.0),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => context
                              .read<CalculationCubit>()
                              .onAdd(answer.toString()),
                          child: Text(
                            '=${Utils.formatAmount(answerString)}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<HistoryCubit>().onClear();
                _showHistory();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              child: const Text('Clear History'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonItem extends StatefulWidget {
  const _ButtonItem({
    Key? key,
    required this.buttonModel,
  }) : super(key: key);

  final ButtonModel buttonModel;

  @override
  State<_ButtonItem> createState() => __ButtonItemState();
}

class __ButtonItemState extends State<_ButtonItem> {
  String? _longPress;

  @override
  Widget build(BuildContext context) {
    final operator = widget.buttonModel.operator;
    final isHold = _longPress == operator;
    final tooltip = widget.buttonModel.tooltip ?? '';
    final isParentheses = operator == '()';
    final isDelete = operator == '⌫';
    final isClear = operator == 'C';
    final isEqual = operator == '=';
    final color = isEqual
        ? Colors.white
        : isClear
            ? Colors.red
            : Utils.isNumber(operator)
                ? Theme.of(context).textTheme.bodyMedium?.color
                : Theme.of(context).primaryColor;
    final backgroundColor = isEqual
        ? Theme.of(context).primaryColor
        : Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.1);
    final size = widget.buttonModel.size;
    final isBold = widget.buttonModel.isBold;

    return Tooltip(
      message: tooltip,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTapUp: (details) {
              setState(() {
                _longPress = null;
              });
            },
            onTapDown: (details) {
              setState(() {
                _longPress = operator;
              });
            },
            onTapCancel: () {
              setState(() {
                _longPress = null;
              });
            },
            onTap: () async {
              setState(() {
                _longPress = operator;
              });
              if (isDelete) {
                context.read<CalculationCubit>().onDelete();
              } else if (isClear) {
                context.read<CalculationCubit>().onClear();
              } else if (isEqual) {
                context.read<CalculationCubit>().onEqual();
              } else {
                context.read<CalculationCubit>().onAdd(operator);
              }
              await Future.delayed(const Duration(milliseconds: 100));
              setState(() {
                _longPress = null;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: FittedBox(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 100),
                    style: TextStyle(
                      color: color,
                      fontSize: size - (isHold ? 5 : 0),
                      letterSpacing: isParentheses ? 8 : null,
                      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                    ),
                    child: Text(operator),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
