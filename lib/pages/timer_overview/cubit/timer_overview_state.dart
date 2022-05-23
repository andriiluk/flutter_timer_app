part of 'timer_overview_cubit.dart';

abstract class TimerState extends Equatable {}

class TimerOverviewState extends TimerState {
  TimerOverviewState({
    required this.timerEntity,
    this.seconds = 30,
    this.minutes = 0,
    this.hours = 0,
  });

  final TimerEntity timerEntity;

  final int seconds;
  final int minutes;
  final int hours;

  TimerOverviewState copyWith({
    TimerEntity? timerEntity,
    int? seconds,
    int? minutes,
    int? hours,
  }) {
    return TimerOverviewState(
        timerEntity: timerEntity ?? this.timerEntity,
        seconds: seconds ?? this.seconds,
        minutes: minutes ?? this.minutes,
        hours: hours ?? this.hours,
    );
  }

  @override
  List<Object?> get props => [timerEntity, seconds, minutes, hours];
}
