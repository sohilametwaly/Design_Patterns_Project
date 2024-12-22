import 'package:flutter/material.dart';
import 'package:design_patterns_project/Manager/Manager.dart';
import 'package:design_patterns_project/worker.dart';
import 'package:design_patterns_project/addWorkerPage.dart';
import 'package:design_patterns_project/editWorkerPage.dart';
import 'package:design_patterns_project/workerDetails.dart';


class WorkerListPage extends StatefulWidget {
  final Manager manager;

  WorkerListPage({required this.manager});

  @override
  _WorkerListPageState createState() => _WorkerListPageState();
}

class _WorkerListPageState extends State<WorkerListPage> {
  late Future<List<Worker>> _workersFuture;

  @override
  void initState() {
    super.initState();
    _workersFuture = _fetchWorkers();
  }

  Future<List<Worker>> _fetchWorkers() async {
    final workerData = await widget.manager.viewWorkers();
    return workerData.entries.map((entry) {
      final workerMap = entry.value;
      return Worker(
         entry.key,
         workerMap['name'],
         workerMap['phone'],
         workerMap['salary'],
         workerMap['jobTitle']
      );
    }).toList();
  }

  void _viewWorkerDetails(Worker worker) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkerDetailsPage(worker: worker),
      ),
    );
  }

  void _editWorker(Worker worker) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditWorkerPage(worker: worker, manager: widget.manager),
      ),
    );

    if (result == true) {
      setState(() {
        _workersFuture = _fetchWorkers();
      });
    }
  }

  void _navigateToAddWorkerPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddWorkerPage(manager: widget.manager),
      ),
    );

    if (result == true) {
      setState(() {
        _workersFuture = _fetchWorkers();
      });
    }
  }

  void _confirmDelete(String workerId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Worker'),
          content: Text('Are you sure you want to delete this worker?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                widget.manager.deleteWorker(workerId);
                Navigator.pop(context);
                setState(() {
                  _workersFuture = _fetchWorkers();
                });
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workers')),
      body: FutureBuilder<List<Worker>>(
        future: _workersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No workers found.'));
          }

          final workers = snapshot.data!;

          return ListView.builder(
            itemCount: workers.length,
            itemBuilder: (context, index) {
              final worker = workers[index];

              return GestureDetector(
                onTap: () => _viewWorkerDetails(worker),
                child: Card(
                  child: ListTile(
                    title: Text(worker.name),
                    subtitle: Text(worker.jobTitle),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editWorker(worker),
                          tooltip: 'Edit Worker',
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(worker.id),
                          tooltip: 'Delete Worker',
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddWorkerPage,
        child: Icon(Icons.add),
        tooltip: 'Add Worker',
      ),
    );
  }
}

