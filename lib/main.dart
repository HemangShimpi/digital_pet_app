import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: _TabsCustomDemo(),
      ),
    );
  }
}

class _TabsCustomDemo extends StatefulWidget {
  @override
  __TabsCustomDemoState createState() => __TabsCustomDemoState();
}

class __TabsCustomDemoState extends State<_TabsCustomDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_custom_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Name', 'Age', 'Type', 'Extras'];
    final tabColors = [Colors.blue[50], Colors.green[50], Colors.orange[50], Colors.purple[50]];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Digital Pet App'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // First Tab - Text Input
          Container(
            color: tabColors[0],
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter your pet’s Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          // Second Tab - Card Widget
          Container(
            color: tabColors[1],
            child: Center(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Your pet’s age will be displayed here.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          // Third Tab - Alert Dialog
          Container(
            color: tabColors[2],
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Pet Type Info'),
                      content: Text('Choose a pet type wisely based on your lifestyle!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Show Pet Type Info'),
              ),
            ),
          ),
          // Fourth Tab - Bottom App Bar
          Scaffold(
            backgroundColor: tabColors[3],
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.pets),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            body: Center(
              child: Text(
                'More pet features coming soon!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
