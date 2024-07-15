import 'dart:math';

import 'package:dezeer_animation/models/music.dart';
import 'package:dezeer_animation/pages/home_page.dart';
import 'package:dezeer_animation/pages/search_page.dart';
import 'package:dezeer_animation/provider/bloc/reproductor_bloc.dart';
import 'package:dezeer_animation/widgets/appbar_widget.dart';
import 'package:dezeer_animation/widgets/bottombar_widget.dart';
import 'package:dezeer_animation/slivers/box_control_sliver.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  double heigh = 60;
  bool isExtens = false;
  double horizontalPadding = 16;
  double containerHeigh = 0;
  late PageController pageController;
  late PageController pageControllerListImage;

  expandedReproductor() {
    setState(() {
      isExtens = true;
      horizontalPadding = 0;

      heigh = MediaQuery.of(context).size.height;
      containerHeigh = heigh - (60);
    });
  }

  microReproductor() {
    setState(() {
      isExtens = false;
      horizontalPadding = 16;
      containerHeigh = 0;
      heigh = 60;
    });
  }

  onChangedPage(int page) {
    setState(() {
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 200),
        curve: Curves.bounceInOut,
      );
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    pageControllerListImage = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    pageControllerListImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                const AppbarWidget(),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: const [HomePage(), SearchPage()],
                  ),
                ),
                BottomNav(
                  onChangePage: (int value) {
                    onChangedPage(value);
                  },
                ),
              ],
            ),
            GestureDetector(
              // onTap: isExtens == false ? expandedReproductor : null,
              onVerticalDragUpdate: (details) {
                if (details.delta.dy < 0 &&
                    heigh < MediaQuery.of(context).size.height) {
                  setState(() {
                    heigh += (-details.delta.dy * pi);

                    heigh = heigh.clamp(60, maxHeight);

                    containerHeigh += (-details.delta.dy * pi);
                    containerHeigh = containerHeigh.clamp(0, (maxHeight - 60));

                    if (heigh > 70) {
                      isExtens = true;
                    }
                    isExtens = true;
                    horizontalPadding = 16 *
                        (1 -
                            ((heigh - 60) /
                                (MediaQuery.of(context).size.height - 60)));
                    horizontalPadding = horizontalPadding.clamp(0, 16);
                  });
                } else if (details.delta.dy > 0 && heigh > 60) {
                  setState(() {
                    heigh -= (details.delta.dy * pi);
                    heigh = heigh.clamp(60, maxHeight);
                    containerHeigh -= (details.delta.dy * pi);
                    containerHeigh = containerHeigh.clamp(0, (maxHeight - 60));
                    if (heigh > 60 &&
                        heigh < MediaQuery.of(context).size.height) {
                      horizontalPadding = 16 *
                          (1 -
                              ((heigh - 60) /
                                  (MediaQuery.of(context).size.height - 60)));
                      horizontalPadding = horizontalPadding.clamp(0, 16);
                    }
                    if (heigh <= 60) {
                      isExtens = false;
                    }
                  });
                }
              },
              child: Align(
                alignment: const AlignmentDirectional(0, 0.7),
                child: SafeArea(
                  top: true,
                  right: false,
                  left: false,
                  bottom: false,
                  child: BlocBuilder<ReproductorBloc, ReproductorState>(
                    builder: (context, state) {
                      return AnimatedContainer(
                        margin:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        alignment: const AlignmentDirectional(0, -1),
                        height: heigh,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(isExtens ? 0 : 12),
                          color: Colors.black,
                        ),
                        duration: const Duration(milliseconds: 300),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: heigh),
                            duration: const Duration(milliseconds: 300),
                            builder: (BuildContext context, double value,
                                Widget? child) {
                              double translateY = (value - 60) * 0.02;
                              double opacity = horizontalPadding / 16;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    width: double.infinity,
                                    height: containerHeigh,
                                    duration: const Duration(milliseconds: 300),
                                    child: CustomScrollView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      slivers: [
                                        SliverAppBar(
                                          pinned: true,
                                          backgroundColor: Colors.transparent,
                                          title: ListTile(
                                            title: Text(
                                              state.currentTrack.name,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              state.currentTrack.author,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          leading: IconButton(
                                            onPressed: microReproductor,
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SliverToBoxAdapter(
                                          child: SizedBox(
                                            height: 400,
                                            child: PageView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: musicProvider.length,
                                              controller: state.pageController,
                                              onPageChanged: (value) {
                                                context
                                                    .read<ReproductorBloc>()
                                                    .add(ScrollEvent(
                                                        index: value));
                                              },
                                              itemBuilder: (context, index) {
                                                final item =
                                                    state.tracksList[index];
                                                return Card(
                                                  color:
                                                      Colors.primaries[index],
                                                  child: Image.asset(
                                                    item.imagePath,
                                                    fit: BoxFit.fill,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        const BoxControlWidget(),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Opacity(
                                      opacity: opacity,
                                      child: Transform.translate(
                                        offset: Offset(0, translateY),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                context
                                                    .read<ReproductorBloc>()
                                                    .add(ToggleEnvet());
                                              },
                                              icon: Icon(
                                                state.reproductorStatus ==
                                                        ReproductorStatus.play
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                color: Colors.white,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: isExtens == false
                                                  ? expandedReproductor
                                                  : null,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.currentTrack.name,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      state.currentTrack.author,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(width: 12),
                                            IconButton(
                                              onPressed: () {
                                                context
                                                    .read<ReproductorBloc>()
                                                    .add(NextEvent());
                                              },
                                              icon: const Icon(
                                                Icons.skip_next,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
