import 'package:flutter/material.dart';

import '../../core/theme/style.dart';

class MyCustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      // IconButton(
      //   icon: Icon(TourMaker.filter),
      //   onPressed: () {
      //     // Get.toNamed(Routes.f);
      //   },
      // ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: 100.0,
      child: Card(
        color: Colors.red,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('This is a suggestion'),
    );
  }

  @override
  String get searchFieldLabel => 'Search Destinations';

  // @override
  // String get hintText => 'Enter a keyword';

  @override
  TextInputAction get textInputAction => TextInputAction.search;
  // @override
  // InputDecoration get textInputDecoration => InputDecoration(
  //       enabledBorder: InputBorder.none,
  //       focusedBorder: InputBorder.none,
  //       border: InputBorder.none,
  //     );

  TextInputType get textInputType => TextInputType.text;
  Widget buildSearchField() {
    return TextField(
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Search',
      ),
      onChanged: (String value) {
        query = value;
      },
    );
  }
}

// @override
// InputDecorationTheme get inputDecorationTheme => InputDecorationTheme();
@override
ThemeData appBarTheme(BuildContext context) {
  return ThemeData(
    canvasColor: Colors.white,
    appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: fontColor,
        )),
  );
}
  // assert(context != null);
  // final ThemeData theme = Theme.of(context);
  // assert(theme != null);
  // return theme.copyWith(

  //   primaryColor: Colors.red,
  //   primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
  //   primaryTextTheme: theme.primaryTextTheme.copyWith(
  //       subtitle1:
  //           theme.textTheme.titleMedium!.copyWith(color: Colors.white)),
  //   textTheme: theme.textTheme.copyWith(
  //       subtitle1:
  //           theme.textTheme.titleMedium!.copyWith(color: Colors.white)),
  // );


// class Search extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [SizedBox()];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {
//         close(context, '');
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Container(
//       height: 100.0,
//       width: 100.0,
//       child: Card(
//         color: Colors.red,
//         child: Center(
//           child: Text(query),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 1,
//           child: Column(
//             children: [
//               InkWell(
//                 onTap: () {},
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   color: Colors.red,
//                 ),
//               ),
//               InkWell(
//                 onTap: () {},
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   color: Colors.black,
//                 ),
//               ),
//               InkWell(
//                 onTap: () {},
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   color: Colors.green,
//                 ),
//               ),
//               InkWell(
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   color: Colors.purple,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: Container(
//             color: Colors.green,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   String get searchFieldLabel => 'Search Destinations';
//   @override
//   TextInputAction get textInputAction => TextInputAction.search;
//   @override
//   InputDecoration get textInputDecoration => InputDecoration(
//         enabledBorder: InputBorder.none,
//         focusedBorder: InputBorder.none,
//         border: InputBorder.none,
//       );

//   @override
//   TextInputType get textInputType => TextInputType.text;

//   @override
//   InputDecorationTheme get inputDecorationTheme => InputDecorationTheme();
//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     return ThemeData(
//       canvasColor: Colors.white,
//       appBarTheme: AppBarTheme(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           iconTheme: IconThemeData(
//             color: fontColor,
//           )),
//     );
//   }
// }

// // class TopToBottomTabBar extends StatelessWidget {
// //   final List<Tab>? tabs;
// //   final List<Widget>? tabViews;

// //   TopToBottomTabBar({@required this.tabs, @required this.tabViews});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: <Widget>[
// //         TabBar(
// //           controller: ,
// //           tabs: tabs!,
// //         ),
// //         Expanded(
// //           child: TabBarView(
// //             children: tabViews!,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Top to Bottom TabBar'),
// //       ),
// //       body: TopToBottomTabBar(
// //         tabs: [
// //           Tab(
// //             text: 'Tab 1',
// //             icon: Icon(Icons.home),
// //           ),
// //           Tab(
// //             text: 'Tab 2',
// //             icon: Icon(Icons.favorite),
// //           ),
// //         ],
// //         tabViews: [
// //           Center(
// //             child: Text('This is Tab 1'),
// //           ),
// //           Center(
// //             child: Text('This is Tab 2'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// class Filter extends StatefulWidget {
//   const Filter({super.key});

//   @override
//   State<Filter> createState() => _FilterState();
// }

// class _FilterState extends State<Filter> {
//   @override
//   Widget build(BuildContext context) {
//     int selectedIndex = 2;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         iconTheme: IconThemeData(color: fontColor),
//         foregroundColor: fontColor,
//         title: Text('Filters'),
//       ),
//       body: Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Column(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = 0;
//                     });
//                   },
//                   child: Container(
//                     height: 50,
//                     width: double.infinity,
//                     color: Colors.red,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = 1;
//                     });
//                   },
//                   child: Container(
//                     height: 50,
//                     width: double.infinity,
//                     color: Colors.black,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = 2;
//                     });
//                   },
//                   child: Container(
//                     height: 50,
//                     width: double.infinity,
//                     color: Colors.green,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = 3;
//                     });
//                   },
//                   child: Container(
//                     height: 50,
//                     width: double.infinity,
//                     color: Colors.purple,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Container(
//               child: Center(child: selectedIndex == 0 ? Text("1") : Text("23")),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
