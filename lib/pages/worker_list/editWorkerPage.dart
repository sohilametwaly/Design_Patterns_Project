import 'package:flutter/material.dart';
import 'package:design_patterns_project/Classes/Manager/Manager.dart';
import 'package:design_patterns_project/Classes/worker.dart';

class EditWorkerPage extends StatefulWidget {
  final Worker worker;
  final Manager manager;

  EditWorkerPage({required this.worker, required this.manager});

  @override
  _EditWorkerPageState createState() => _EditWorkerPageState();
}

class _EditWorkerPageState extends State<EditWorkerPage> {
  late TextEditingController _nameController;
  late TextEditingController _jobTitleController;
  late TextEditingController _phoneController;
  late TextEditingController _salaryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.worker.name);
    _jobTitleController = TextEditingController(text: widget.worker.jobTitle);
    _phoneController = TextEditingController(text: widget.worker.phone);
    _salaryController =
        TextEditingController(text: widget.worker.salary.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Worker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _jobTitleController,
              decoration: InputDecoration(labelText: 'Job Title'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: _salaryController,
              decoration: InputDecoration(labelText: 'Salary'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _jobTitleController.text.isNotEmpty) {
                  widget.worker.name = _nameController.text;
                  widget.worker.jobTitle = _jobTitleController.text;
                  widget.worker.phone = _phoneController.text;
                  widget.worker.salary =
                      double.tryParse(_salaryController.text) ?? 0.0;

                  widget.manager.editWorker(widget.worker.id, widget.worker);
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
