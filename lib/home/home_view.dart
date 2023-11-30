import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_api_app/logic/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _parseNumber(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    homeCubit.parseNumber('123fr');
  }

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
          listener: (ctx, state) {
            if (state is HomeErrorState) {
              showAdaptiveDialog(
                context: ctx,
                builder: (ctx) => AlertDialog(
                  title: const Text('Oop! Error value'),
                  content: Text('Value is ${state.message}'),
                ),
              );
            }
          },
          builder: (ctx, state) {
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
                  onPressed: () => _parseNumber(ctx),
                  child: const Text('Parse Number'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
