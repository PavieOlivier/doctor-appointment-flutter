import 'package:doctor_companion/model/Appointment.dart';
import 'randomData.dart' as RDT;
import 'dart:math';

///Data will e created randomnly 
class AppointmentManager {
  static List<Appointment> appointmentList = [];

  static List generateAppointmentList() {
    var randomX = Random().nextInt(7);
    while(randomX == 0 )
    {
      randomX = Random().nextInt(40);
    }
    int randomGender;
    String imgLink;
    for (int i = 0; i < randomX; i++) {
      randomGender = Random().nextInt(2);
      if (randomGender == 0) // it is a boy
      {
        imgLink = 'https://randomuser.me/api/portraits/men/' +
            Random().nextInt(40).toString() +
            '.jpg';
      } else // it is a girl
      {
        imgLink = 'https://randomuser.me/api/portraits/women/' +
            Random().nextInt(40).toString() +
            '.jpg';
      }
      appointmentList.add(Appointment(
        patientName: RDT.lastName[Random().nextInt(RDT.lastName.length)],
        patienSurname: RDT.mames[Random().nextInt(RDT.mames.length)],
        appoitmentComment: RDT.comments[Random().nextInt(RDT.comments.length)],
        appoitmentDate: Random().nextInt(29).toString() + ' Jan 2020',
        appoitmentTime: Random().nextInt(12).toString() +
            'am - ' +
            Random().nextInt(12).toString() +
            'pm',
        phoneNumber: Random().nextInt(333333333).toString(),
        imgLink: imgLink,
      ));
      if (Random().nextInt(2) == 0)
      //true
      {
        appointmentList[i].isFuture = true;
      }
      //false
      else {
        appointmentList[i].isFuture = false;
      }
    }
    print('List is successfully generated');
    return appointmentList;
  }
}
