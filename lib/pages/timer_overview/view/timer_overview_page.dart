import 'package:app/pages/home/home.dart';
import 'package:app/pages/timer_overview/timer_overview.dart';
import 'package:app/pages/timer_overview/widgets/time_picker.dart';
import 'package:app/pages/timer_running/timer_running.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerOverviewPage extends StatelessWidget {
  const TimerOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerOverviewCubit(),
      child: const TimerOverviewView(),
    );
  }
}

class TimerOverviewView extends StatelessWidget {
  const TimerOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerCubit = context.select((TimerOverviewCubit cubit) => cubit);

    return Scaffold(
      body: BlocBuilder<TimerOverviewCubit, TimerOverviewState>(
        builder: (_, state) {
          return Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              children: [
                SizedBox(height: 50),
                Text('Timer'),
                SizedBox(height: 30),
                DurationPicker(
                    onChangedSeconds: (value) =>
                        timerCubit.updateSeconds(value),
                    onChangedMinutes: (value) =>
                        timerCubit.updateMinutes(value),
                    onChangedHours: (value) => timerCubit.updateHours(value),
                    onPressedAdd: ()=> timerCubit.saveTimerItem(),
                    seconds: state.seconds,
                    minutes: state.minutes,
                    hours: state.hours,
                ),
                SizedBox(height: 30),
                Flexible(
                  // width: double.maxFinite,
                  // height: double.maxFinite,
                  child: state.timerEntity.items.length > 0
                      ? ListView.builder(
                    itemCount: state.timerEntity.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Text('#${index+1}'),
                        title: Text('${state.timerEntity.summaryDurationString(index)}'),
                        trailing: Text('${state.timerEntity.items[index].formattedDuration()}'),
                      );
                    },
                  )
                      : const Center(child: Text('No items')),
                ),

              ],
            ),
          );
        },
      ),
      //
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TimerRunningPage(timerEntity: timerCubit.state.timerEntity,))
          );
        },
        key: const Key('__homeView_add_timer_item__'),
        child: const Icon(Icons.directions_run),
      ),
    );
  }
}

class DurationPicker extends StatelessWidget {
  const DurationPicker(
      {Key? key,
      required this.onChangedSeconds,
      required this.onChangedMinutes,
      required this.onChangedHours,
        required this.onPressedAdd,
      required this.seconds,
      required this.minutes,
      required this.hours})
      : super(key: key);

  final int seconds;
  final int minutes;
  final int hours;

  final ValueChanged<int> onChangedSeconds;
  final ValueChanged<int> onChangedMinutes;
  final ValueChanged<int> onChangedHours;
  final VoidCallback? onPressedAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            NumberPicker(
                infiniteLoop: true,
                value: hours,
                minValue: 0,
                maxValue: 24,
                step: 1,
                haptics: true,
                onChanged: onChangedHours),
            Text('< h >'),
          ],
        ),
        Column(
          children: [
            NumberPicker(
                infiniteLoop: true,
                value: minutes,
                minValue: 0,
                maxValue: 60,
                step: 1,
                haptics: true,
                onChanged: onChangedMinutes),
            Text('< m >'),
          ],
        ),
        Column(
          children: [
            NumberPicker(
                infiniteLoop: true,
                value: seconds,
                minValue: 0,
                maxValue: 60,
                step: 5,
                haptics: true,
                onChanged: onChangedSeconds),
            Text('< s >'),
          ],
        ),
        IconButton(
            // color: Theme.of(context).primaryColor,
            onPressed: onPressedAdd,
            icon: Icon(
            Icons.add,
        ))
      ],
    );
  }
}
