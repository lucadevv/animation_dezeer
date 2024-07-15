import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:dezeer_animation/models/music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'reproductor_event.dart';
part 'reproductor_state.dart';

class ReproductorBloc extends Bloc<ReproductorEvent, ReproductorState> {
  final AudioPlayer audioPlayer = AudioPlayer();

  int currentTrackIndex = -1;
  ReproductorBloc() : super(ReproductorState.initial()) {
    //Escucha los cambios de duración total del audio
    audioPlayer.onDurationChanged.listen((duration) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(state.copyWith(totalPosition: duration));
    });

    // Escucha los cambios en la posición actual del audio
    audioPlayer.onPositionChanged.listen((position) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(state.copyWith(currentPosition: position));
    });

    //Escucha cuando el audio se completa
    audioPlayer.onPlayerComplete.listen((event) {
      add(NextEvent());
    });
    audioPlayer.onPlayerComplete.listen((event) {
      add(StopEvent());
    });
    on<FetcTracksEvent>(fetcTracksEvent);
    on<FetcTrackIdEvent>(fetcTrackIdEvent);
    on<PlayEvent>(playEvent);
    on<ScrollEvent>(scrollEvent);
    on<ToggleEnvet>(toggleEnvet);
    on<NextEvent>(nextEvent);
    on<PauseEvent>(pauseEvent);
    on<PreviusEvent>(previusEvent);
    on<StopEvent>(stopEvent);
    on<SeekEvent>(seekEvent);
  }

  Future<void> fetcTracksEvent(
      FetcTracksEvent event, Emitter<ReproductorState> emit) async {
    emit(state.copyWith(
      status: PlayerStatus.loading,
    ));
    try {
      final response = event.listModel;

      emit(state.copyWith(tracksList: response, status: PlayerStatus.sucess));
    } catch (e) {
      emit(state.copyWith(status: PlayerStatus.error));
    }
  }

  Future<void> fetcTrackIdEvent(
      FetcTrackIdEvent event, Emitter<ReproductorState> emit) async {
    try {
      final newState = state.copyWith(currentTrack: event.model);
      emit(newState);
    } catch (e) {
      emit(state.copyWith(status: PlayerStatus.error));
    }
  }

  Future<void> playEvent(
      PlayEvent event, Emitter<ReproductorState> emit) async {
    try {
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource(event.music.musicPath));
      currentTrackIndex = event.index;
      state.pageController.jumpToPage(currentTrackIndex);
      emit(state.copyWith(
        status: PlayerStatus.sucess,
        reproductorStatus: ReproductorStatus.play,
        index: currentTrackIndex,
        currentTrack: event.music,
      ));
    } catch (e) {
      emit(state.copyWith(status: PlayerStatus.error));
    }
  }

  Future<void> scrollEvent(
      ScrollEvent event, Emitter<ReproductorState> emit) async {
    try {
      await audioPlayer.stop();
      final itemMusic = state.tracksList[event.index];
      await audioPlayer.play(AssetSource(itemMusic.musicPath));
      currentTrackIndex = event.index;
      state.pageController.jumpToPage(currentTrackIndex);
      emit(state.copyWith(
        status: PlayerStatus.sucess,
        reproductorStatus: ReproductorStatus.play,
        index: currentTrackIndex,
        currentTrack: itemMusic,
      ));
    } catch (e) {
      emit(state.copyWith(status: PlayerStatus.error));
    }
  }

  Future<void> nextEvent(
      NextEvent event, Emitter<ReproductorState> emit) async {
    if (currentTrackIndex < state.tracksList.length - 1) {
      currentTrackIndex++;
      final nextTrack = state.tracksList[currentTrackIndex];
      state.pageController.jumpToPage(currentTrackIndex);
      add(PlayEvent(music: nextTrack, index: currentTrackIndex));
      emit(state.copyWith(
        currentTrack: nextTrack,
        index: currentTrackIndex,
      ));
    }
  }

  Future<void> previusEvent(
      PreviusEvent event, Emitter<ReproductorState> emit) async {
    if (currentTrackIndex > 0) {
      currentTrackIndex--;

      final nextTrack = state.tracksList[currentTrackIndex];
      state.pageController.jumpToPage(currentTrackIndex);
      add(PlayEvent(music: nextTrack, index: currentTrackIndex));
      emit(state.copyWith(
        currentTrack: nextTrack,
        index: currentTrackIndex,
      ));
    }
  }

  Future<void> toggleEnvet(
      ToggleEnvet event, Emitter<ReproductorState> emit) async {
    if (state.reproductorStatus == ReproductorStatus.play) {
      await audioPlayer.pause();
      emit(state.copyWith(reproductorStatus: ReproductorStatus.pause));
    } else {
      await audioPlayer.resume();
      emit(state.copyWith(reproductorStatus: ReproductorStatus.play));
    }
  }

  Future<void> seekEvent(
      SeekEvent event, Emitter<ReproductorState> emit) async {
    emit(state.copyWith(
      currentPosition: event.seek,
    ));
    await audioPlayer.seek(event.seek);
  }

  Future<void> stopEvent(
      StopEvent event, Emitter<ReproductorState> emit) async {
    await audioPlayer.stop();

    emit(state.copyWith(reproductorStatus: ReproductorStatus.stop));
  }

  Future<void> pauseEvent(
      PauseEvent event, Emitter<ReproductorState> emit) async {
    await audioPlayer.pause();
    emit(state.copyWith(reproductorStatus: ReproductorStatus.pause));
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    audioPlayer.stop();
    return super.close();
  }
}
