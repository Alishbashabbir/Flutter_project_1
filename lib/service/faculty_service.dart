import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/faculty.dart';

class FacultyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFaculty({
    required String id,
    required String name,
    required String dean,
    required String professorName,
    required String professorDesignation,
    required String phoneNumber,
    required String email,
    required String address,
    required String subjects,
  }) async {
    try {
      await _firestore.collection('faculties').doc(id).set({
        'id': id,
        'name': name,
        'dean': dean,
        'professorName': professorName,
        'professorDesignation': professorDesignation,
        'phoneNumber': phoneNumber,
        'email': email,
        'address': address,
        'subjects': subjects,
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error adding faculty: $e');
    }
  }

  getFacultiesLocally() {}

  saveFacultiesLocally(List<Faculty> faculties) {}
}
