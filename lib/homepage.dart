import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tesst/auth/login.dart';
import 'hometab.dart';
import 'worktab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;

  getUser() async {
    var user = FirebaseAuth.instance.currentUser;
    print(user?.email);
  }

  void iniState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            centerTitle: true,
            title: const Text(
              "CODES",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.yellowAccent,
                  fontSize: 30),
            ),
            bottom: TabBar(indicatorColor: Colors.yellowAccent, tabs: [
              Tab(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text("Home   ",
                        style: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Icon(Icons.account_balance,
                        color: Colors.yellowAccent, size: 20),
                  ],
                ),
              ),
              Tab(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text("Work   ",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    Icon(Icons.work_outline, color: Colors.blue, size: 20),
                  ],
                ),
              ),
            ]),
            leading: IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(
                Icons.send_to_mobile_outlined,
                color: Colors.yellowAccent,
                size: 18,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                },
                icon: const Icon(Icons.search,
                    color: Colors.yellowAccent, size: 18),
              ),
            ],
            backgroundColor: Colors.red,
          ),
        ),
        drawer: Drawer(
          child: Column(children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Pavly"),
              accountEmail: Text("pavlyywaheeb@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("Images/pavly.jpg"),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Login();
                  },
                ));
              },
              child: Text("SignOut"),
            ),
            ListTile(
              title: const Text("Home Page"),
              leading: const Icon(Icons.home, color: Colors.red),
              onTap: () {
                print("Home Page");
              },
            ),
            ListTile(
              title: const Text("Help"),
              leading: const Icon(Icons.help, color: Colors.blue),
              onTap: () {
                print("Help");
              },
            ),
            ListTile(
              title: const Text("About"),
              leading:
                  const Icon(Icons.help_center_outlined, color: Colors.grey),
              onTap: () {
                print("About");
              },
            ),
            ListTile(
              title: const Text("Logout"),
              leading: const Icon(Icons.exit_to_app_sharp, color: Colors.green),
              onTap: () {
                print("Logout");
              },
            ),
          ]),
        ),
        body: const TabBarView(children: [
          HomeTab(),
          WorkTab(),
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const HomePage();
              },
            ));
          },
          mini: true,
          child: const Icon(
            Icons.ac_unit,
            size: 40,
            color: Colors.red,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            enableFeedback: true,
            mouseCursor: SystemMouseCursors.click,
            iconSize: 30,
            selectedFontSize: 15,
            unselectedFontSize: 10,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.black,
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                label: "Nav 1",
                icon: Icon(
                  Icons.sports_baseball,
                  color: Colors.red,
                ),
              ),
              BottomNavigationBarItem(
                label: "Nav 2",
                icon: Icon(
                  Icons.sports_basketball,
                  color: Colors.yellowAccent,
                ),
              ),
            ]),
      ),
    );
  }
}

class DataSearch extends SearchDelegate {
  @override
  String get query => super.query;
  List names = [
    "Pavly",
    "Waheb",
    "Shehata",
    "Giant",
    "Black Pearl",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            close(context, null);
          },
          icon: const Icon(Icons.home))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List filternames =
        names.where((element) => element.contains(query)).toList();
    return ListView.builder(
      itemCount: query == "" ? names.length : filternames.length,
      itemBuilder: (context, l) {
        return InkWell(
          onTap: () {
            query = filternames[l];
          },
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: query == ""
                  ? Text("${names[l]}")
                  : Text("${filternames[l]}")),
        );
      },
    );
  }
}
