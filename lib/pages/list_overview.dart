import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/list_controller.dart';
import 'package:flutter_application_1/models/list_model.dart';

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
      appBar: AppBar(
        title: const Text('List Overview'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'List Overview',
              style: TextStyle(fontSize: 26),
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

                      //*Hero/gesture for later when viewing the item
                      return GestureDetector(
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
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 10),
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
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
