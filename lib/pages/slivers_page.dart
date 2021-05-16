import 'package:flutter/material.dart';
import 'package:layout_demo_flutter/layout_type.dart';

class SliversPage extends StatelessWidget implements HasLayoutGroup {
  SliversPage({Key key, this.layoutGroup, this.onLayoutToggle})
      : super(key: key);
  final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            //Always visible like zak
            // pinned: true,
            // floating: false,

            //Visible on Scroll top only like Alix
            pinned: false,
            floating: true,

            expandedHeight: 50.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Slivers'),
            ),
            leading: IconButton(
              icon: Icon(layoutGroup == LayoutGroup.nonScrollable
                  ? Icons.filter_1
                  : Icons.filter_2),
              onPressed: onLayoutToggle,
            )),
        SliverPadding(
            padding: EdgeInsets.all(20.0),
            sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('grid item $index'),
                );
              },
              childCount: 20,
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('list item $index'),
              );
            },
          ),
        ),
      ],
    );
  }
}
