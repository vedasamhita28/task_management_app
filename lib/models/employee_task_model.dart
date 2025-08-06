class EmployeeTaskModel {
  String? name;
  String? email;
  String? assignedBy;
  String? task;

  EmployeeTaskModel({this.name, this.email, this.assignedBy, this.task});

  EmployeeTaskModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    assignedBy = json['assignedby'];
    task = json['task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['assignedby'] = assignedBy;
    data['task'] = task;
    return data;
  }
}
