import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/list_controller.dart';
import 'package:flutter_application_1/models/list_model.dart';
import 'package:flutter_application_1/pages/dashboard.dart';
import 'package:flutter_application_1/pages/list_items.dart';
import 'package:flutter_application_1/pages/pick_meal.dart';

class ListOverview extends StatefulWidget {
  const ListOverview({Key? key}) : super(key: key);

  @override
  _ListOverviewState createState() => _ListOverviewState();
}

class _ListOverviewState extends State<ListOverview> {
  final ListController _listController = ListController();
  late Future<List<Lists>> _listsFuture;

  @override
  void initState() {
    super.initState();
    _listsFuture = _listController.fetchUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFF2E7D32),
        elevation: 2,
        title: Text(
          'List overview',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'List Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<Lists>>(
                future: _listsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No lists available');
                  }

                  final lists = snapshot.data!;
                  return GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: lists.length,
                    itemBuilder: (context, index) {
                      final list = lists[index];

                      return Container(
                        height: 300,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListItems(
                                  title: list.title,
                                  userId: list.userId,
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: "list_${list.id}",
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Image.network(
                                      'https://www.themealdb.com/images/media/meals/llcbn01574260722.jpg',
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      list.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
              },
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.restaurant),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PickMealPage()));
              },
            ),
            label: 'Choose-meal',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ListOverview()));
              },
            ),
            label: 'List',
          ),
        ],
      ),
    );
  }
}
