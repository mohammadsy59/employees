
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:employees/model/employee.dart';
import 'package:employees/utils/database_helper.dart';

class EmployeeScreen extends StatefulWidget{
  final Employee employee;
  EmployeeScreen(this.employee);
  @override
  _EmployeeScreenState createState() => new _EmployeeScreenState();




}

class _EmployeeScreenState extends State<EmployeeScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _ageController;
  TextEditingController _nameController;
  TextEditingController _cityController;
  TextEditingController _departmentController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _ageController = new TextEditingController(text: widget.employee.age);
    _nameController = new TextEditingController(text: widget.employee.name);
    _cityController = new TextEditingController(text: widget.employee.city);
    _departmentController = new TextEditingController(text: widget.employee.department);
    _descriptionController = new TextEditingController(text: widget.employee.description);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('EmployeeDB'),
      ),
      body: new Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(controller: _departmentController,
              decoration: InputDecoration(labelText: 'Department'),),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(controller: _cityController,
              decoration: InputDecoration(labelText: 'City'),),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),),
            Padding(padding: EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.employee.id != null) ? Text('Update') : Text('Save'),
              onPressed: (){
                if(widget.employee.id != null){
                  db.updateEmployee(Employee.fromMap({
                    'id': widget.employee.id,
                    'age': widget.employee.age,
                    'name': widget.employee.name,
                    'city': widget.employee.city,
                    'department': widget.employee.department,
                    'description': widget.employee.description,
                  })).then((_){
                    Navigator.pop(context,'update');
                   });
                }else{
                db.saveEmployee(Employee(_ageController.text, _nameController.text,
                    _departmentController.text, _cityController.text, _descriptionController.text)).then((_){
                  Navigator.pop(context,'save');
                });
                }
              },
              color: Colors.deepOrange,
            )

          ],
        ),
      ),
    );
  }
}