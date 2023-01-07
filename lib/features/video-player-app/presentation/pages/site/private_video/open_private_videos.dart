import 'package:flutter/material.dart';

import '../../../widgets/big_custom_appbar.dart';

class OpenPrivateVideos extends StatefulWidget {
  const OpenPrivateVideos({Key? key}) : super(key: key);

  @override
  State<OpenPrivateVideos> createState() => _OpenPrivateVideosState();
}

class _OpenPrivateVideosState extends State<OpenPrivateVideos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigCustomAppBar(
        title: "Private Videos",
        firstIcon: Icons.abc,
        secondIcon: Icons.abc,
        color: Colors.transparent,
      ),
    );
  }
}
