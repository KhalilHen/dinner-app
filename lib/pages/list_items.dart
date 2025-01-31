import 'package:flutter/material.dart';

class ListItems extends StatelessWidget {
  final String title;
  final String userId;

  const ListItems({
    Key? key,
    required this.title,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   title: Text(title),
    //   subtitle: Text(userId),
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              "List items",
              style: TextStyle(fontSize: 26),
            ),
            SizedBox(
              height: 20,
            ),
            // !! It doesn't not yet use database items
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(
                        "Item $index",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Description $index"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
// This can  use to navigate to specific dinner item. With in top a big image. then under custom description/title
// Existing title/description.
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
