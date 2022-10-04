import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protfolio_admin_app/screens/projects/add_project/add_project_view.dart';
import 'package:protfolio_admin_app/screens/projects/delet_project/delete_project_controller.dart';
import 'package:protfolio_admin_app/screens/projects/edit_project/edit_project_view.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({Key? key}) : super(key: key);

  static final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
      .collection('projects')
      .orderBy('savedAt', descending: false)
      .snapshots(includeMetadataChanges: true);
  static final _deleteProject = Get.put(DeleteProjectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Projects",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeThemeMode(ThemeMode.light);
              } else {
                Get.changeThemeMode(ThemeMode.dark);
              }
            },
            icon: Icon(
              Icons.nightlight_round,
              color: Theme.of(context).iconTheme.color,
            ),
          )
        ],
        shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data['project_name']),
                    ),
                    subtitle: Column(
                      children: [
                        Text(data['description']),
                        //DeleteProjectView(docId:document.id),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.bottomSheet(EditProjectView(
                                    docId: document.id,
                                    name: data['project_name'],
                                    description: data['description'],
                                  ));
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  _deleteProject.deleteProject(
                                      docmentID: document.id);
                                },
                                icon: const Icon(Icons.delete)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          heroTag: "1",
            child: const Icon(Icons.add),
            onPressed: () {
              Get.bottomSheet(
                const AddProjectView(),
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
