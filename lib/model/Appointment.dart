import 'patient.dart';

class Appointment extends Patient {
  Appointment(
      {this.appoitmentComment,
      this.appoitmentDate,
      this.appoitmentTime,
      this.imgLink,
      this.patienSurname,
      this.patientName,
      this.phoneNumber})
      : super.named(patientName,imgLink,phoneNumber,patienSurname);

  String patientName, patienSurname, imgLink, phoneNumber;
  String appoitmentDate;
  String appoitmentTime;
  String appoitmentComment;
  bool isFuture;
}
