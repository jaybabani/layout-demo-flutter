import 'package:flutter/material.dart';
import 'package:layout_demo_flutter/layout_type.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';

class HeroHeader extends SliverPersistentHeaderDelegate {
  HeroHeader({
    this.layoutGroup,
    this.onLayoutToggle,
    this.minExtent,
    this.maxExtent,
  });
  final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;
  double maxExtent;
  double minExtent;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/ronnie-mayo-361348-unsplash.jpg',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 4.0,
          top: 4.0,
          child: SafeArea(
            child: IconButton(
              icon: Icon(layoutGroup == LayoutGroup.nonScrollable ? Icons.filter_1 : Icons.filter_2),
              onPressed: onLayoutToggle,
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 40.0,
          child: Text(
            'Hero Image',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: Container(
            height: 20.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              )
            ),
            // color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => OverScrollHeaderStretchConfiguration();
}

class HeroPage extends StatelessWidget implements HasLayoutGroup {
  HeroPage({Key key, this.layoutGroup, this.onLayoutToggle}) : super(key: key);
  final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;

  final List<String> assetNames = [
    'assets/brady-bellini-212790-unsplash.jpg',
    'assets/stefan-stefancik-105587-unsplash.jpg',
    'assets/simon-fitall-530083-unsplash.jpg',
    'assets/anton-repponen-99530-unsplash.jpg',
    'assets/kevin-cochran-524957-unsplash.jpg',
    'assets/samsommer-72299-unsplash.jpg',
    'assets/simon-matzinger-320332-unsplash.jpg',
    'assets/meng-ji-102492-unsplash.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _scrollView(context),
    );
  }

  Widget _scrollView(BuildContext context) {
    // Use LayoutBuilder to get the hero header size while keeping the image aspect-ratio
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(

            // Odis like effect
            pinned: true,
            floating: false,
            delegate: HeroHeader(
              layoutGroup: layoutGroup,
              onLayoutToggle: onLayoutToggle,
              minExtent: 80.0,
              maxExtent: 250.0,
            ),

            // Odis like effect 2
            // pinned: true,
            // floating: true,
            // delegate: HeroHeader(
            //   layoutGroup: layoutGroup,
            //   onLayoutToggle: onLayoutToggle,
            //   minExtent: 50.0,
            //   maxExtent: 200.0,
            // ),





          ),
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    padding: _edgeInsetsForIndex(index),
                    child: Image.asset(
                      assetNames[index % assetNames.length],
                    ),
                  );
                },
                childCount: assetNames.length * 3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  EdgeInsets _edgeInsetsForIndex(int index) {
    if (index % 2 == 0) {
      return EdgeInsets.only(top: 4.0, left: 8.0, right: 4.0, bottom: 4.0);
    } else {
      return EdgeInsets.only(top: 4.0, left: 4.0, right: 8.0, bottom: 4.0);
    }
  }
}
