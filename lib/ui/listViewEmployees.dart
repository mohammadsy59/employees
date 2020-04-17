import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:employees/model/employee.dart';
import 'package:employees/utils/database_helper.dart';
import 'package:employees/ui/employee_screen.dart';

class ListViewEmployees extends StatefulWidget {
  @override
  _ListViewEmployeesState createState() => new _ListViewEmployeesState();
}

class _ListViewEmployeesState extends State<ListViewEmployees> {
  DatabaseHelper db = new DatabaseHelper();
  List<Employee> items = new List();
  @override
  void initState() {
    super.initState();
    db.getAllEmployees().then((employees) {
      setState(() {
        employees.forEach((employee) {
          items.add(Employee.fromMap(employee));
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'All Employees',
        home: Scaffold(
          backgroundColor: Colors.deepPurpleAccent,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text('All Employees'),
          ),
          body: Center(
            child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        new Expanded(
                          child: ListTile(
                            title: Text(
                              '${items[position].name}',
                              style:
                              TextStyle(fontSize: 22.0, color: Colors.redAccent),
                            ),
                            subtitle: Text(
                              '${items[position].age},${items[position].city},${items[position].department}',
                              style: TextStyle(
                                  fontSize: 18.0, fontStyle: FontStyle.italic),

                            ),
                            leading: Column(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(22.0),),
                                CircleAvatar(
                                  radius: 18.0,
                                  backgroundColor: Colors.amber,
                                  child: Text(
                                    '${items[position].id}',
                                    style: TextStyle(
                                        fontSize: 22.0, color: Colors.redAccent),
                                  ),
                                ),
                                IconButton(icon: Icon(Icons.delete,color: Colors.red),
                                    onPressed: ()=>_deleteEmployee(context,items[position],position))
                              ],
                            ),
                            onTap: ()=> _navigateToEmployee(context,items[position]),
                          ),
                        )
                      ],
                    )

                  ],
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.orange,
            onPressed: ()=> _createNewEmployee(context),
          ),
        ),
    );
  }

  _deleteEmployee(BuildContext context, Employee employee, int position) async{
    db.deleteEmployee(employee.id).then((employees){
      setState(() {
        items.removeAt(position);
      });
    }
    );
  }

  void _navigateToEmployee(BuildContext context, Employee employee)async {
    String result = await Navigator.push(context,
        MaterialPageRoute(builder: (context)=> EmployeeScreen(employee))
    );
    if(result == 'update'){
      db.getAllEmployees().then((employees){
        setState(() {
          items.clear();
          employees.forEach((employee){
            items.add(Employee.fromMap(employee));
          });
        });
      });
    }
  }

  void _createNewEmployee(BuildContext context) async{
    String result = await Navigator.push(context,
        MaterialPageRoute(builder: (context)=> EmployeeScreen(
            Employee( '', '', '', '', '')))
    );
    if(result == 'save'){
      db.getAllEmployees().then((employees){
        setState(() {
          items.clear();
          employees.forEach((employee){
            items.add(Employee.fromMap(employee));
          });
        });
      });
    }

  }


}
