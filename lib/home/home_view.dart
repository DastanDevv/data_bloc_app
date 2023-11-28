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
      body: BlocListener<HomeCubit, HomeState>(
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
        child: Center(
          child: Column(
            children: [
              // BlocBuilder -  <> berilgen cubit je bloc menen state ugup turat
              // state ke jarasha ozun kurat
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeInitialState) {
                    return const Text('Initial');
                  } else if (state is HomeLoadingState) {
                    return const CircularProgressIndicator();
                  } else if (state is HomeSuccessState) {
                    return Text('Success: ${state.data}');
                  } else if (state is HomeErrorState) {
                    return Text('Error: ${state.message}');
                  } else {
                    return const Text('Unknown');
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  final homeCubit = context.read<HomeCubit>();
                  homeCubit.parseNumber('123fr');
                },
                child: const Text('Parse Number'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
