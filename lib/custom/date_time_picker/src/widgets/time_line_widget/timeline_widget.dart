import 'package:flutter/material.dart';

import '../../properties/easy_day_props.dart';
import '../../properties/time_line_props.dart';
import '../../utils/utils.dart';
import '../easy_day_widget/easy_day_widget.dart';

/// A widget that displays a timeline of days.
class TimeLineWidget extends StatefulWidget {
  TimeLineWidget({
    super.key,
    required this.initialDate,
    required this.focusedDate,
    required this.activeDayTextColor,
    required this.activeDayColor,
    this.inactiveDates,
    this.dayProps = const EasyDayProps(),
    this.locale = "en_US",
    this.timeLineProps = const EasyTimeLineProps(),
    this.onDateChange,
    this.itemBuilder,
  })  : assert(timeLineProps.hPadding > -1, "Can't set timeline hPadding less than zero."),
        assert(timeLineProps.separatorPadding > -1, "Can't set timeline separatorPadding less than zero."),
        assert(timeLineProps.vPadding > -1, "Can't set timeline vPadding less than zero.");

  final DateTime initialDate;
  final DateTime? focusedDate;
  final Color activeDayTextColor;
  final Color activeDayColor;
  final List<DateTime>? inactiveDates;
  final EasyTimeLineProps timeLineProps;
  final EasyDayProps dayProps;
  final OnDateChangeCallBack? onDateChange;
  final ItemBuilderCallBack? itemBuilder;
  final String locale;

  @override
  State<TimeLineWidget> createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLineWidget> {
  EasyDayProps get _dayProps => widget.dayProps;
  EasyTimeLineProps get _timeLineProps => widget.timeLineProps;
  bool get _isLandscapeMode => _dayProps.landScapeMode;
  double get _dayWidth => _dayProps.width;
  double get _dayHeight => _dayProps.height;
  double get _dayOffsetConstrains => _isLandscapeMode ? _dayHeight : _dayWidth;

  late ScrollController _controller;

  late DateTime _today; // New variable to store today's date

  @override
  void initState() {
    super.initState();

    _today = DateTime.now(); // Initialize today’s date

    _controller = ScrollController(
      initialScrollOffset: _calculateDateOffset(widget.initialDate),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Only hide past dates within the current month, show all dates for future months
  bool _isTodayOrFuture(DateTime date) {
    final DateTime todayDate = DateTime(_today.year, _today.month, _today.day); // Reset _today to date only
    final DateTime comparedDate = DateTime(date.year, date.month, date.day); // Reset date for comparison

    // If the date is in the current month and year, hide dates before today
    if (date.month == _today.month && date.year == _today.year) {
      return !comparedDate.isBefore(todayDate); // Only show today and future dates within the current month
    }

    // For future months, always show the dates
    return true;
  }

  /// Adjust the offset calculation to exclude past dates
  double _calculateDateOffset(DateTime date) {
    final startDate = DateTime(_today.year, _today.month, _today.day); // Start from today
    int offset = date.difference(startDate).inDays;
    double adjustedHPadding =
        _timeLineProps.hPadding > EasyConstants.timelinePadding ? (_timeLineProps.hPadding - EasyConstants.timelinePadding) : 0.0;

    if (offset == 0) {
      return 0.0;
    }

    return (offset * _dayOffsetConstrains) + (offset * _timeLineProps.separatorPadding) + adjustedHPadding;
  }

  @override
  Widget build(BuildContext context) {
    final initialDate = _today;

    return Container(
      height: _isLandscapeMode ? _dayWidth : _dayHeight,
      margin: _timeLineProps.margin,
      color: _timeLineProps.decoration == null ? _timeLineProps.backgroundColor : null,
      decoration: _timeLineProps.decoration,
      child: ClipRRect(
        borderRadius: _timeLineProps.decoration?.borderRadius ?? BorderRadius.zero,
        child: ListView.separated(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
            horizontal: _timeLineProps.hPadding,
            vertical: _timeLineProps.vPadding,
          ),
          itemBuilder: (context, index) {
            // Calculate the date by adding the index (number of days) to the initialDate
            final currentDate = DateTime(widget.initialDate.year, widget.initialDate.month).add(Duration(days: index));

            // Hide past dates within the current month
            if (!_isTodayOrFuture(currentDate)) {
              return const SizedBox(); // Don't render past dates within the current month
            }

            // Determine if the current date is selected
            final isSelected = widget.focusedDate != null
                ? EasyDateUtils.isSameDay(widget.focusedDate!, currentDate)
                : EasyDateUtils.isSameDay(widget.initialDate, currentDate);

            // Check if this date should be deactivated (only for inactiveDates)
            bool isDisabledDay = false;
            if (widget.inactiveDates != null) {
              for (DateTime inactiveDate in widget.inactiveDates!) {
                if (EasyDateUtils.isSameDay(currentDate, inactiveDate)) {
                  isDisabledDay = true;
                  break;
                }
              }
            }

            // Return the day widget or custom item builder
            return widget.itemBuilder != null
                ? _dayItemBuilder(
                    context,
                    isSelected,
                    currentDate,
                  )
                : EasyDayWidget(
                    easyDayProps: _dayProps,
                    date: currentDate,
                    locale: widget.locale,
                    isSelected: isSelected,
                    isDisabled: isDisabledDay,
                    onDayPressed: () => _onDayChanged(isSelected, currentDate),
                    activeTextColor: widget.activeDayTextColor,
                    activeDayColor: widget.activeDayColor,
                  );
          },
          separatorBuilder: (context, index) {
            return const SizedBox();
          },
          itemCount: EasyDateUtils.getDaysInMonth(initialDate),
        ),
      ),
    );
  }

  InkWell _dayItemBuilder(
    BuildContext context,
    bool isSelected,
    DateTime date,
  ) {
    return InkWell(
      onTap: () => _onDayChanged(isSelected, date),
      borderRadius: BorderRadius.circular(_dayProps.activeBorderRadius),
      child: widget.itemBuilder!(
        context,
        date.day.toString(),
        EasyDateFormatter.shortDayName(date, widget.locale).toUpperCase(),
        EasyDateFormatter.shortMonthName(date, widget.locale).toUpperCase(),
        date,
        isSelected,
      ),
    );
  }

  void _onDayChanged(bool isSelected, DateTime currentDate) {
    widget.onDateChange?.call(currentDate);
  }
}
