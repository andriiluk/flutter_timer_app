import 'dart:developer';

import 'package:app/models/models.dart';
import 'package:app/pages/timer_overview/timer_overview.dart';
import 'package:app/pages/timer_running/cubit/timer_running_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class TimerRunningPage extends StatelessWidget {
  const TimerRunningPage({Key? key, required this.timerEntity})
      : super(key: key);
  final TimerEntity timerEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerRunningCubit(timerEntity: timerEntity),
      child: TimerRunningView(),
    );
  }
}

class TimerRunningView extends StatelessWidget {
  TimerRunningView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.select((TimerRunningCubit cubit) => cubit);

    Timer.periodic(Duration(seconds: 1), (timer) {
      log('tick, ${cubit.state}');
      if (cubit.state.isRunning()) {
        cubit.doTick();
      }

      if (cubit.state.isFinished()) {
        timer.cancel();
      }
    });

    return Scaffold(
      body: BlocBuilder<TimerRunningCubit, TimerRunningState>(
          builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: GestureDetector(
                  child: Icon(Icons.backspace_outlined),
                  onTap: () {
                    cubit.setStatus(TimerStatus.canceled);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TimerOverviewPage()));
                  },
                ),
              ),
            ]),
            SizedBox(
              height: 60,
            ),
            Text('${trimNulls(state.itemCountdown)}', textScaleFactor: 6,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${trimTrailingNulls(state.overallCount)}', textScaleFactor: 3,),
                  Text('${trimTrailingNulls(state.overallCountdown)}', textScaleFactor: 3,),
                ],
              ),
            ),

            // Buttons: play, pause, stop, refresh
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    // color: Theme.of(context).primaryColor,
                    onPressed: () => cubit.toggleStatus(),
                    icon: Icon(
                      state.isWaiting() ? Icons.play_arrow : Icons.pause,
                      size: 40,
                    )),
                state.isFinished()
                    ? Container()
                    : IconButton(
                        // color: Theme.of(context).primaryColor,
                        onPressed: () => cubit.setStatus(TimerStatus.canceled),
                        icon: Icon(
                          Icons.stop,
                          size: 40,
                        )),
                IconButton(
                    // color: Theme.of(context).primaryColor,
                    onPressed: () => cubit.refresh(),
                    icon: Icon(
                      Icons.refresh,
                      size: 40,
                    )),
              ],
            ),
            // List of timer items
            Flexible(
             // width: double.maxFinite,
             // height: double.maxFinite,
             child:
               (cubit.timerEntity.items.length > 0)
                   ? ListView.builder(
                 itemCount: cubit.timerEntity.items.length,
                 itemBuilder: (BuildContext context, int index) {
                   return ListTile(
                     leading: Text('# ${index + 1}',
                       textScaleFactor: index == state.currentItem ? 1.5 : 1),
                     title: Text('${trimTrailingNulls(cubit.timerEntity.items[index].duration)}',
                         textScaleFactor: index == state.currentItem ? 2 : 1),
                   );
                 },
               )
                   : const Center(child: Text('No items')),
           )
          ],
        );
      }),
    );

  }
}
