import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, -1),
      child: SafeArea(
        top: true,
        left: false,
        right: false,
        bottom: false,
        child: Container(
          alignment: const AlignmentDirectional(0, 1),
          height: const Size.fromHeight(kToolbarHeight).height,
          width: const Size.fromHeight(kToolbarHeight).width,
          color: Colors.white,
          child: const Text(
            "Deezer Animation",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
