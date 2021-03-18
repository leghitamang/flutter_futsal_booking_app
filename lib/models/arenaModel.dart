class Arena {
  int arenaId;
  String arenaName;
  String description;
  String location;
  String arenaImage;
  String price;
  static List<String> amenities= ['Parking', 'Locker', 'Shower'];
  // static List timeSlots = ['6:15-7:15', '7:15-8:15', '8:15-9:15', '9:15-10:15','10:15-11:15'];

  Arena({
    this.arenaId,
    this.arenaName,
    this.description,
    this.location,
    this.price,
    this.arenaImage,
           
  });

  factory Arena.fromJson(arenaJson) {
    return Arena(
      arenaId: arenaJson['id'],
      arenaName: arenaJson['name'],
      description: arenaJson['description'],
      arenaImage: arenaJson['image'],
      price: arenaJson['price'],
      location: arenaJson['location'],    
    );
  }
}
