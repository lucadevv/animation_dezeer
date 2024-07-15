import 'package:dezeer_animation/provider/bloc/reproductor_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class BoxControlWidget extends StatelessWidget {
  const BoxControlWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReproductorBloc, ReproductorState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: SizedBox(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "${state.currentPosition.inSeconds.toDouble().toString()} s.",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    Text(
                      "${state.totalPosition.inMinutes.toDouble().toString()} min.",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Slider(
                  value: state.currentPosition.inSeconds.toDouble(),
                  min: 0,
                  max: state.totalPosition.inSeconds.toDouble(),
                  onChanged: (double value) {
                    final newPosition = Duration(seconds: value.toInt());
                    context
                        .read<ReproductorBloc>()
                        .add(SeekEvent(seek: newPosition));
                  },
                ),
                Text(
                  state.currentTrack.name,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  state.currentTrack.author,
                  style: const TextStyle(color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 50,
                      onPressed: () {
                        context.read<ReproductorBloc>().add(PreviusEvent());
                      },
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      iconSize: 50,
                      onPressed: () {
                        context.read<ReproductorBloc>().add(ToggleEnvet());
                      },
                      icon: Icon(
                        state.reproductorStatus == ReproductorStatus.play
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      iconSize: 50,
                      onPressed: () {
                        context.read<ReproductorBloc>().add(NextEvent());
                      },
                      icon: const Icon(
                        Icons.skip_next_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      iconSize: 50,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.gif_box_outlined,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      iconSize: 50,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.timeline,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      iconSize: 50,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
