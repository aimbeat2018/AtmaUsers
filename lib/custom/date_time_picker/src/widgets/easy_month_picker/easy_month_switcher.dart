import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';

/// A widget that displays a button for switching to the previous or next month.
class EasyMonthSwitcher extends StatefulWidget {
  const EasyMonthSwitcher({
    super.key,
    required this.locale,
    required this.value,
    this.onMonthChange,
    this.style,
  });

  /// A `String` that represents the locale code to use for formatting the month name in the switcher.
  final String locale;

  /// The currently selected month.
  final EasyMonth? value;

  /// A callback function that is called when the selected month changes.
  final OnMonthChangeCallBack? onMonthChange;

  /// The text style applied to the month string.
  final TextStyle? style;

  @override
  State<EasyMonthSwitcher> createState() => _EasyMonthSwitcherState();
}

class _EasyMonthSwitcherState extends State<EasyMonthSwitcher> {
  List<EasyMonth> _yearMonths = [];
  int _currentMonth = 0;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _yearMonths = EasyDateUtils.getYearMonths(_now, widget.locale);
    _currentMonth = widget.value != null ? (widget.value!.vale - 1) : 0;
  }

  bool get _isLastMonth => _currentMonth == _yearMonths.length - 1;
  bool get _isFirstMonth => _currentMonth == 0;

  /// Check if the current month in the list is the actual current month
  bool get _isCurrentMonth {
    final DateTime selectedMonth = DateTime(_now.year, _yearMonths[_currentMonth].vale, 1);
    return selectedMonth.month == _now.month && selectedMonth.year == _now.year;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: screenWidth * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Conditionally show the back arrow based on if it's the current month
          if (!_isCurrentMonth)
            Flexible(
              child: IconButton(
                onPressed: () {
                  if (_isFirstMonth) {
                    return;
                  }
                  setState(() {
                    _currentMonth--;
                  });
                  widget.onMonthChange?.call(_yearMonths[_currentMonth]);
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: _isFirstMonth ? null : Colors.black,
                ),
              ),
            ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _yearMonths[_currentMonth].name,
                textAlign: TextAlign.center,
                style: widget.style,
              ),
            ),
          ),
          // Always show the forward arrow except for the last month
          Flexible(
            child: IconButton(
              onPressed: () {
                if (_isLastMonth) {
                  return;
                }
                setState(() {
                  _currentMonth++;
                });
                widget.onMonthChange?.call(_yearMonths[_currentMonth]);
              },
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: _isLastMonth ? null : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
