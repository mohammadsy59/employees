class Employee{
  // Craete Class Employee with variables  id as int , age as string
  //name as String , department as String , city as String
  //description as String

  int    _id;
  String _age;
  String _name;
  String _department;
  String _city;
  String _description;
// Crete the constructor with class variables
  Employee(this._age,this._name,this._department,this._city,this._description);

// Create map to save data from Employee as obj and its type dynamic
  Employee.map(dynamic obj){
    this._id= obj['id'];
    this._age= obj['age'];
    this._name= obj['name'];
    this._department= obj['department'];
    this._city= obj['city'];
    this._description= obj['description'];
  }
// create getters
  int get id => _id;
  String get age => _age;
  String get name => _name;
  String get department => _department;
  String get city => _city;
  String get description => _description;
// Create method that transfer data from user input to map to save them in class variables and
// input them in Database
  Map<String ,dynamic> toMap(){
    var map = new Map<String ,dynamic>();
    if(_id != null){
      map['id']= _id;
    }
    map['age']= _age;
    map['name']= _name;
    map['department']= _department;
    map['city']= _city;
    map['description']= _description;
    return map;
  }
  // Create method to read data as map from Database and output them to the user
Employee.fromMap(Map<String , dynamic> map){
    this._id = map['id'];
    this._age = map['age'];
    this._name = map['name'];
    this._department = map['department'];
    this._city = map['city'];
    this._description = map['description'];
}

}