import 'package:dezeer_animation/models/music.dart';
import 'package:dezeer_animation/provider/bloc/reproductor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReproductorBloc, ReproductorState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: musicProvider.length,
          itemBuilder: (context, index) {
            final item = musicProvider[index];

            return ListTile(
              onTap: () {
                context
                    .read<ReproductorBloc>()
                    .add(PlayEvent(music: item, index: index));
              },
              leading: Image.asset(item.imagePath),
              title: Text(item.name),
              subtitle: Text(item.author),
            );
          },
        );
      },
    );
  }
}
