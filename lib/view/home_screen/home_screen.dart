import 'package:flutter/material.dart';
import 'package:project_003/controller/list_view_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // ListViewController().printData();
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    await listObj.getData();
    setState(() {});
  }

  ListViewController listObj = ListViewController();

  TextEditingController titleController = TextEditingController();
  TextEditingController showController = TextEditingController();
  bool isEditing = false;
  int? count;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "enter title",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    titleController.clear();
                    isEditing = false;

                    setState(() {});
                  },
                  child: Text("cancel"),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (isEditing == false) {
                      await listObj.addData(title: titleController.text.trim());
                      // titleList.add(titleController.text.trim());
                    } else {
                      await listObj.updateData(
                          title: titleController.text,
                          id: listObj.myList[count!]['id']);
                    }
                    fetchData();
                    titleController.clear();
                    isEditing = false;
                  },
                  child: Text(
                    isEditing == false ? "Enter" : "Edit",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listObj.myList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(listObj.myList[index]['name']),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              titleController.text =
                                  listObj.myList[index]['name'];
                              count = index;
                              isEditing = true;
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await listObj.deleteData(
                                  id: listObj.myList[index]['id']);
                              titleController.clear();
                              fetchData();
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
