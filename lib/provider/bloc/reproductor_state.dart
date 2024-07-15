part of 'reproductor_bloc.dart';

enum ReproductorStatus { initial, play, pause, resume, stop }

enum PlayerStatus { initial, loading, sucess, error }

class ReproductorState extends Equatable {
  final List<MusicModel> tracksList;
  final Duration currentPosition;
  final Duration totalPosition;
  final PlayerStatus status;
  final ReproductorStatus reproductorStatus;
  final MusicModel currentTrack;
  final int index;
  final PageController pageController;
  const ReproductorState({
    required this.tracksList,
    required this.currentPosition,
    required this.totalPosition,
    required this.status,
    required this.reproductorStatus,
    required this.currentTrack,
    required this.index,
    required this.pageController,
  });

  ReproductorState copyWith({
    List<MusicModel>? tracksList,
    Duration? currentPosition,
    Duration? totalPosition,
    PlayerStatus? status,
    ReproductorStatus? reproductorStatus,
    MusicModel? currentTrack,
    int? index,
    PageController? pageController,
  }) {
    return ReproductorState(
      tracksList: tracksList ?? this.tracksList,
      currentPosition: currentPosition ?? this.currentPosition,
      totalPosition: totalPosition ?? this.totalPosition,
      status: status ?? this.status,
      reproductorStatus: reproductorStatus ?? this.reproductorStatus,
      currentTrack: currentTrack ?? this.currentTrack,
      index: index ?? this.index,
      pageController: pageController ?? this.pageController,
    );
  }

  factory ReproductorState.initial() {
    return ReproductorState(
      tracksList: const [],
      currentPosition: Duration.zero,
      totalPosition: Duration.zero,
      status: PlayerStatus.initial,
      currentTrack: MusicModel.empty(),
      reproductorStatus: ReproductorStatus.initial,
      index: -1,
      pageController: PageController(initialPage: 0, viewportFraction: 0.7),
    );
  }
  @override
  List<Object?> get props => [
        tracksList,
        currentPosition,
        totalPosition,
        status,
        reproductorStatus,
        currentTrack,
        index,
        pageController,
      ];
}
