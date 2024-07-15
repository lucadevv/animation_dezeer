import 'package:audioplayers/audioplayers.dart';
import 'package:dezeer_animation/home_screen.dart';
import 'package:dezeer_animation/models/music.dart';
import 'package:dezeer_animation/provider/bloc/reproductor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) =>
          ReproductorBloc()..add(FetcTracksEvent(listModel: musicProvider)),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        home: const HomeScreen(),
      ),
    );
  }
}
