
class ServicesList{

  final String  servicename;
  final String image;

  ServicesList({this.servicename,this.image});

  static List<ServicesList> allServices()
  {
    var lstOfCities = new List<ServicesList>();
    lstOfCities.add(new ServicesList(servicename:"Leave tracker",image: "tracker.png"));
    lstOfCities.add(new ServicesList(servicename:"Leave balance",image: "balance.png"));
    lstOfCities.add(new ServicesList(servicename:"BirthDays",image: "birthday.png"));
    lstOfCities.add(new ServicesList(servicename:"Task",image: "task.png"));
    lstOfCities.add(new ServicesList(servicename:"kRA",image: "task.png"));
    return lstOfCities;
  }
}