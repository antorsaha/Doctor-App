import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/components/top_doctors_card.dart';
import 'package:flutter_doctor_app/models/doctor.dart';

import '../screens/doctor_detail_screen.dart';

class TopDoctorsList extends StatefulWidget {
  const TopDoctorsList({Key? key}) : super(key: key);

  @override
  State<TopDoctorsList> createState() => _TopDoctorsListState();
}

class _TopDoctorsListState extends State<TopDoctorsList> {
  late QuerySnapshot querySnapshot;

  @override
  void initState() {
    super.initState();
    getTopDoctorList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: topDoctors.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            /*Navigator.of(context).pushNamed(
              '/doctor_details',
              arguments: Doctor(
                doctorName: topDoctors[index].doctorName,
                doctorDescription: topDoctors[index].doctorDescription,
                doctorHospital: topDoctors[index].doctorHospital,
                doctorIsOpen: topDoctors[index].doctorIsOpen,
                doctorNumberOfPatient: topDoctors[index].doctorNumberOfPatient,
                doctorPicture: topDoctors[index].doctorPicture,
                doctorRating: topDoctors[index].doctorRating,
                doctorSpecialty: topDoctors[index].doctorSpecialty,
                doctorYearOfExperience:
                    topDoctors[index].doctorYearOfExperience,
              ),
            );*/
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorDetailScreen(
                  doctor: topDoctors[index],
                ),
              ),
            );
          },
          child: TopDoctorsCard(
            doctor: topDoctors[index],
          ),
        );
      },
    );
  }

  getTopDoctorList() async {
    return FirebaseFirestore.instance.collection('TopDoctors');
  }
}
