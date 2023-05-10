import 'package:flutter/material.dart';

void main() {
  runApp(const HomeTab());
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var selectedCountry;
  var names;
  bool usa = false;
  bool egy = false;
  String? country;
  String? car;
  String? nme;
  bool notify = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white10,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          child:
                          DropdownButton(
                            alignment: Alignment.center,
                            hint: const Text("Choose the Country"),
                            items: ["USA", "UAE", "SY", "EG", "SA"].map((e) => DropdownMenuItem(value: e,
                                      child: Text(e,
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold)),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCountry = value;
                              });
                            },
                            value: selectedCountry,
                          )),
                      DropdownButton(
                        icon: const Icon(Icons.ac_unit, color: Colors.red),
                        hint: const Text("Choose Name"),
                        items: [
                          "Pavly",
                          "Waheb",
                          "Shehata",
                          "Black-pearl",
                          "Giant"
                        ]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            names = val;
                          });
                        },
                        value: names,
                      ),
                      Container(
                        height: 200,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: PageView(children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                color: Colors.blue),
                            child: const Text("Strawberry Pavlova Recipe",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                                "Pavlova is a meringue-based dessert named after the Russian ballerina Anna Pavlova . Pavlova features a crisp crust and soft, light inside, topped with fruit and whipped cream",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                          ),
                          const Image(
                            image: AssetImage("Images/straw.jpg"),
                            fit: BoxFit.fill,
                          )
                        ]),
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: const [
                                                Icon(Icons.star_rate_sharp,
                                                    color: Colors.yellow),
                                                Icon(Icons.star_rate_sharp,
                                                    color: Colors.yellow),
                                                Icon(Icons.star_rate_sharp,
                                                    color: Colors.yellow),
                                                Icon(Icons.star_half_sharp,
                                                    color: Colors.yellow),
                                                Icon(Icons.star_rate_sharp),
                                              ],
                                            ),
                                            const Text("              "),
                                            const Text(
                                              "17 review",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ]),
                              Container(
                                alignment: Alignment.center,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: const [
                                          Icon(
                                            Icons.restaurant,
                                            color: Colors.green,
                                            size: 40,
                                          ),
                                          Text("Feed"),
                                          Text("2 - 4"),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: const [
                                          Icon(
                                            Icons.category,
                                            color: Colors.green,
                                            size: 40,
                                          ),
                                          Text("Feed"),
                                          Text("2 - 4"),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: const [
                                          Icon(
                                            Icons.coffee,
                                            color: Colors.green,
                                            size: 40,
                                          ),
                                          Text("Feed"),
                                          Text("2 - 4"),
                                        ],
                                      ),
                                    ]),
                              )
                            ],
                          )),
                    ]),
              ),
              Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    title: Text("ElevatedButton"),
                                  );
                                });
                          },
                          icon: const Icon(Icons.ac_unit),
                          label: const Text("Click")),
                      MaterialButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  title: Text("Facebook(MaterialButton)"),
                                );
                              });
                        },
                        child: const Icon(Icons.facebook_sharp,
                            color: Colors.blue, size: 60),
                      ),
                    ],
                  )),
              GestureDetector(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text("Avengers Assemble "),
                          content: Text("LongPress GestureDetector"),
                          titleTextStyle: TextStyle(color: Colors.redAccent),
                          contentTextStyle:
                              TextStyle(color: Colors.yellowAccent),
                          alignment: Alignment.center,
                          titlePadding: EdgeInsets.all(2),
                          contentPadding: EdgeInsets.all(2),
                          backgroundColor: Colors.black,
                          actions: [
                            BackButton(color: Colors.blue),
                          ],
                        );
                      });
                },
                onDoubleTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text("Avengers "),
                          content: Text("DoubleTap GestureDetector"),
                          titleTextStyle: TextStyle(color: Colors.redAccent),
                          contentTextStyle:
                              TextStyle(color: Colors.yellowAccent),
                          alignment: Alignment.center,
                          titlePadding: EdgeInsets.all(2),
                          contentPadding: EdgeInsets.all(2),
                          backgroundColor: Colors.black,
                        );
                      });
                },
                child: const Image(
                  image: AssetImage("Images/iron.jpg"),
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 70,
                child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text("Country USA"),
                    subtitle: const Text("America"),
                    tileColor: Colors.yellowAccent,
                    value: usa,
                    onChanged: (val) {
                      setState(() {
                        usa = val!;
                      });
                    }),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 70,
                child: CheckboxListTile(
                    title: const Text("Country Egypt"),
                    tileColor: Colors.red,
                    subtitle: const Text("Masr"),
                    secondary: const Icon(Icons.flag_circle),
                    isThreeLine: true,
                    selected: egy,
                    value: egy,
                    onChanged: (val) {
                      setState(() {
                        egy = val!;
                      });
                    }),
              ),
              Container(
                color: Colors.blue,
                child: Column(
                  children: [
                    RadioListTile(
                        activeColor: Colors.red,
                        selected: nme == "pavly" ? true : false,
                        title: const Text("Pavly"),
                        value: "pavly",
                        groupValue: nme,
                        onChanged: (val) {
                          setState(() {
                            nme = val!;
                          });
                        }),
                    RadioListTile(
                        activeColor: Colors.yellow,
                        selected: nme == "waheb" ? true : false,
                        title: const Text("Waheb"),
                        value: "waheb",
                        groupValue: nme,
                        onChanged: (val) {
                          setState(() {
                            nme = val!;
                          });
                        }),
                    RadioListTile(
                        activeColor: Colors.blue,
                        selected: nme == "shehata" ? true : false,
                        title: const Text("Shehata"),
                        value: "shehata",
                        groupValue: nme,
                        onChanged: (val) {
                          setState(() {
                            nme = val!;
                          });
                        }),
                  ],
                ),
              ),
              Container(
                color: Colors.yellowAccent,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text("Egypt  "),
                            Radio(
                                value: "EGY",
                                groupValue: country,
                                onChanged: (val) {
                                  setState(() {
                                    country = val!;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("USA    "),
                            Radio(
                                value: "USA",
                                groupValue: country,
                                onChanged: (val) {
                                  setState(() {
                                    country = val!;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Russia"),
                            Radio(
                                value: "RUS",
                                groupValue: country,
                                onChanged: (val) {
                                  setState(() {
                                    country = val!;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text("Mclaren       "),
                            Radio(
                                value: "Mac",
                                groupValue: car,
                                onChanged: (val) {
                                  setState(() {
                                    car = val!;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Bugatti         "),
                            Radio(
                                value: "Bug",
                                groupValue: car,
                                onChanged: (val) {
                                  setState(() {
                                    car = val!;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Lamborghini"),
                            Radio(
                                value: "Lamb",
                                groupValue: car,
                                onChanged: (val) {
                                  setState(() {
                                    car = val!;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SwitchListTile(
                value: notify,
                onChanged: (val) {
                  setState(() {
                    notify = val;
                  });
                },
                title: const Text("Turn on notification"),
                activeColor: Colors.red,
                secondary: const Icon(
                  Icons.accessibility_new,
                  color: Colors.red,
                ),
                subtitle: const Text("Notification"),
                controlAffinity: ListTileControlAffinity.leading,
                tileColor: Colors.blue,
                enableFeedback: true,
                activeTrackColor: Colors.yellow,
                inactiveThumbColor: Colors.black,
                inactiveTrackColor: Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
