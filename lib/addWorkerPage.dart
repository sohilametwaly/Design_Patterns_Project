import 'package:flutter/material.dart';
import 'package:design_patterns_project/Manager/Manager.dart';
import 'package:design_patterns_project/worker.dart';


class AddWorkerPage extends StatefulWidget {
  final Manager manager;

  AddWorkerPage({required this.manager});

  @override
  _AddWorkerPageState createState() => _AddWorkerPageState();
}

class _AddWorkerPageState extends State<AddWorkerPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _phoneController = TextEditingController();
  final _salaryController = TextEditingController();


  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final worker = Worker(
        DateTime.now().millisecondsSinceEpoch.toString(),
        _nameController.text,
        _phoneController.text,
        double.tryParse(_salaryController.text) ?? 0.0,
        _jobTitleController.text,
      );

      widget.manager.addWorker(worker);
      Navigator.pop(context,true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Worker')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the worker\'s name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jobTitleController,
                decoration: InputDecoration(labelText: 'Job Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the worker\'s job title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the worker\'s phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _salaryController,
                decoration: InputDecoration(labelText: 'Salary'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the worker\'s salary';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid salary';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Worker'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}