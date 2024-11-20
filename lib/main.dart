import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'data/loaddata.dart';
import 'domain/affirmation.dart';
import 'domain/affirmationDetail.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ScaffoldSample(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final affirmation = loaddata()[id];
        return AffirmationDetail(affirmation: affirmation);
      },
    ),
  ],
);

class ScaffoldSample extends StatelessWidget {
  const ScaffoldSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Dev")),
      body: const AffirmationList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 10,
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(children: const [
          DrawerHeader(child: Text("My First Drawer")),
          ListTile(title: Text("Item1")),
          ListTile(
            title: Text("Item2"),
          )
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle),
          ),
        ],
        onTap: (int indexOfItem) {},
      ),
    );
  }
}

class AffirmationCard extends StatefulWidget {
  final Affirmation affirmation;
  final int index;

  const AffirmationCard(this.affirmation, this.index, {super.key});

  @override
  State<AffirmationCard> createState() => _AffirmationCardState();
}

class _AffirmationCardState extends State<AffirmationCard> {
  int likeCount = 0;
  int dislikeCount = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/details/${widget.index}');
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              widget.affirmation.image,
              height: 194,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.affirmation.desc,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up, color: Colors.green),
                  onPressed: () {
                    setState(() {
                      likeCount++;
                    });
                  },
                ),
                Text('$likeCount'),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.thumb_down, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      dislikeCount++;
                    });
                  },
                ),
                Text('$dislikeCount'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AffirmationList extends StatelessWidget {
  const AffirmationList({super.key});

  @override
  Widget build(BuildContext context) {
    final affirmations = loaddata();
    return ListView.builder(
      itemCount: affirmations.length,
      itemBuilder: (context, index) {
        return AffirmationCard(affirmations[index], index);
      },
    );
  }
}
