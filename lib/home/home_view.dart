import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_api_app/logic/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home View'),
        ),
        // `BlocListener` - <> berilgen cubit je bloctu ugup turat jana
        // state ke jarasha berilgen function dy atkarat
        body: Center(
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeErrorState) {
                showAdaptiveDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Oop! Error value'),
                    content: Text('Value is ${state.message}'),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  if (state is HomeInitialState) const Text('Initial'),
                  if (state is HomeLoadingState)
                    const CircularProgressIndicator(),
                  if (state is HomeSuccessState) Text('Success: ${state.data}'),
                  if (state is HomeErrorState) Text('Error: ${state.message}'),
                  if (!(state is HomeInitialState ||
                      state is HomeLoadingState ||
                      state is HomeSuccessState ||
                      state is HomeErrorState))
                    const Text('Unknown'),
                  ElevatedButton(
                    onPressed: () {
                      final homeCubit = context.read<HomeCubit>();
                      homeCubit.parseNumber('123fr');
                    },
                    child: const Text('Parse Number'),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
