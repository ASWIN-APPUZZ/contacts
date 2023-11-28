class ContactModel {
  String? id;
  final String fname;
  final String lname;
  final String address;
  final String phone;
  final String email;

  ContactModel(
      {this.id,
      required this.fname,
      required this.lname,
      required this.address,
      required this.phone,
      required this.email});

  factory ContactModel.fromJSON(Map<String, dynamic> json) {
    return ContactModel(
        id: json['_id'],
        fname: json['firstName'],
        lname: json['lastName'],
        email: json['email'],
        phone: json['phone'],
        address: json['address']);
  }
  Map<String, dynamic> toJSON() {
    return {
      "firstName": this.fname,
      "lastName": this.lname,
      "email": this.email,
      "phone": this.phone,
      "address": this.address
    };
  }
}
