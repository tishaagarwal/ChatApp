import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ReelsPage extends StatefulWidget {
  const ReelsPage({Key? key}) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  late PageController _pageController;
  late List<String> _videoUrls;
  late int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _videoUrls = [
      'P6AwCCvGC58', // YouTube video ID
      'LXB3gap6P8k', // YouTube video ID
      'FcBfgqZH1_A', // YouTube video ID
    ];
    _currentPageIndex = 0;
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reels'),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _videoUrls.length,
            itemBuilder: (context, index) {
              return YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: _videoUrls[index],
                  flags: YoutubePlayerFlags(
                    autoPlay: true,
                    mute: false,
                  ),
                ),
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
          ),
          Positioned(
            left: 16.0,
            bottom: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    // Handle like action
                  },
                  icon: Icon(Icons.favorite_border),
                ),
                IconButton(
                  onPressed: () {
                    // Handle comment action
                  },
                  icon: Icon(Icons.comment),
                ),
                IconButton(
                  onPressed: () {
                    // Handle share action
                  },
                  icon: Icon(Icons.share),
                ),
                IconButton(
                  onPressed: () {
                    // Handle save action
                  },
                  icon: Icon(Icons.save_alt),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
