part of 'reproductor_bloc.dart';

sealed class ReproductorEvent extends Equatable {
  const ReproductorEvent();

  @override
  List<Object> get props => [];
}

class FetcTracksEvent extends ReproductorEvent {
  final List<MusicModel> listModel;

  const FetcTracksEvent({required this.listModel});
  @override
  List<Object> get props => [listModel];
}

class FetcTrackIdEvent extends ReproductorEvent {
  final MusicModel model;
  const FetcTrackIdEvent({required this.model});
  @override
  List<Object> get props => [model];
}

class PlayEvent extends ReproductorEvent {
  final int index;
  final MusicModel music;

  const PlayEvent({
    required this.index,
    required this.music,
  });
  @override
  List<Object> get props => [index, music];
}

class ScrollEvent extends ReproductorEvent {
  final int index;
  const ScrollEvent({
    required this.index,
  });
  @override
  List<Object> get props => [index];
}

class ToggleEnvet extends ReproductorEvent {}

class ResumenEvent extends ReproductorEvent {}

class StopEvent extends ReproductorEvent {}

class NextEvent extends ReproductorEvent {}

class PauseEvent extends ReproductorEvent {}

class PreviusEvent extends ReproductorEvent {}

class SeekEvent extends ReproductorEvent {
  final Duration seek;

  const SeekEvent({required this.seek});
  @override
  List<Object> get props => [seek];
}
