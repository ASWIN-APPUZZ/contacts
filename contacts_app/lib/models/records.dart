class Record {
  final String name, address, contacts, photo, url;

  const Record(
      {required this.name,
      required this.address,
      required this.contacts,
      required this.photo,
      required this.url});

  factory Record.fromJSON(Map<String, dynamic> json) {
    return Record(
        name: json['name'],
        address: json['address'],
        contacts: json['contact'],
        photo: json['photo'],
        url: json['url']);
  }
}