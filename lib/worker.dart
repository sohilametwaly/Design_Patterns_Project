class Worker {
  String id;
  String name = '';
  String phone = '';
  double salary;
  String jobTitle = '';

  Worker(this.id, this.name, this.phone, this.salary, this.jobTitle);

  String get _name => name;
  set _name(String value) {
    name = value;
  }

  String get _phone => phone;
  set _phone(String value) {
    phone = value;
  }

  double get _salary => salary;
  set _salary(double value) {
    if (value >= 0) {
      salary = value;
    } else {
      print("Salary cannot be negative.");
    }
  }

  String get _jobTitle => jobTitle;
  set _jobTitle(String value) {
    jobTitle = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'salary': salary,
      'phone': phone,
      'jobTitle': jobTitle
    };
  }
}