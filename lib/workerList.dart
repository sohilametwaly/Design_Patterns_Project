import 'package:design_patterns_project/editWorkerPage.dart';
import 'package:design_patterns_project/workerDetails.dart';
import 'package:flutter/material.dart';
import 'package:design_patterns_project/Manager/Manager.dart';
import 'package:design_patterns_project/worker.dart';
import 'package:design_patterns_project/addWorkerPage.dart';



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
      appBar: AppBar(
        title: Text('Workers', style: TextStyle(fontWeight: FontWeight.bold )),
        // backgroundColor: Colors.deepPurpleAccent.withOpacity(0.8),
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(

        ),
      ),
      body: FutureBuilder<List<Worker>>(
        future: _workersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 16, color: Colors.redAccent),
              ),
            );
          }

          final workers = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: workers.length,
            itemBuilder: (context, index) {
              final worker = workers[index];

              return GestureDetector(
                onTap: () => _viewWorkerDetails(worker),
                child: _buildWorkerCard(worker),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddWorkerPage,
        backgroundColor:Colors.deepPurpleAccent.withOpacity(0.8),
        child: Icon(Icons.add, size: 28,color: Colors.white,),
        tooltip: 'Add Worker',
      ),
    );
  }

  Widget _buildWorkerCard(Worker worker) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.deepPurpleAccent.withOpacity(0.8),
          child: Text(
            worker.name[0].toUpperCase(),
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          worker.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Row(
          children: [

            Text(worker.jobTitle, style: TextStyle(color: Colors.grey[700],fontSize: 20)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              shape: CircleBorder(),
              color: Colors.blueAccent.withOpacity(0.1),
              child: IconButton(
                icon: Icon(Icons.edit, color: Colors.blueAccent, size: 30),
                onPressed: () => _editWorker(worker),
                tooltip: 'Edit Worker',
                padding: EdgeInsets.all(8),
                splashRadius: 28,
                splashColor: Colors.blueAccent.withOpacity(0.3),
              ),
            ),
            SizedBox(width: 10),
            Material(
              shape: CircleBorder(),
              color: Colors.redAccent.withOpacity(0.1),
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.redAccent, size: 30),
                onPressed: () => _confirmDelete(worker.id),
                tooltip: 'Delete Worker',
                padding: EdgeInsets.all(8),
                splashRadius: 28,
                splashColor: Colors.redAccent.withOpacity(0.3),
              ),
            ),
          ],
        ),

      ),
 );
}


}
