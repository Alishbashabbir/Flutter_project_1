import 'package:flutter/material.dart';
import 'package:my_app/models/faculty.dart';
import 'package:my_app/service/faculty_service.dart';
import 'package:my_app/widgets/custom_text_field.dart';

class AddFacultyScreen extends StatefulWidget {
  const AddFacultyScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddFacultyScreenState createState() => _AddFacultyScreenState();
}

class _AddFacultyScreenState extends State<AddFacultyScreen> {
  final FacultyService _facultyService = FacultyService();
  final TextEditingController facultyIdController = TextEditingController();
  final TextEditingController facultyNameController = TextEditingController();
  final TextEditingController facultyDeanController = TextEditingController();
  final TextEditingController professorNameController = TextEditingController();
  final TextEditingController professorDesignationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController subjectsController = TextEditingController();

  List<Faculty> faculties = [];

  @override
  void initState() {
    super.initState();
    // Load faculties from Firestore or local storage
    _loadFaculties();
  }

  void _loadFaculties() async {
    faculties = await _facultyService.getFacultiesLocally(); // Fetch faculties from local storage
    setState(() {});
  }

  void addFaculty() async {
    String id = facultyIdController.text.trim();
    String name = facultyNameController.text.trim();
    String dean = facultyDeanController.text.trim();
    String professorName = professorNameController.text.trim();
    String professorDesignation = professorDesignationController.text.trim();
    String phoneNumber = phoneController.text.trim();
    String email = emailController.text.trim();
    String address = addressController.text.trim();
    String subjects = subjectsController.text.trim();

    if (id.isNotEmpty &&
        name.isNotEmpty &&
        dean.isNotEmpty &&
        professorName.isNotEmpty &&
        professorDesignation.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        email.isNotEmpty &&
        address.isNotEmpty &&
        subjects.isNotEmpty) {
      Faculty newFaculty = Faculty(
        id: id,
        name: name,
        dean: dean,
        professorName: professorName,
        professorDesignation: professorDesignation,
        phoneNumber: phoneNumber,
        email: email,
        address: address,
        subjects: subjects,
      );

      // Add faculty locally
      faculties.add(newFaculty);
      setState(() {});

      // Clear input fields
      facultyIdController.clear();
      facultyNameController.clear();
      facultyDeanController.clear();
      professorNameController.clear();
      professorDesignationController.clear();
      phoneController.clear();
      emailController.clear();
      addressController.clear();
      subjectsController.clear();

      // Save faculties locally
      await _facultyService.saveFacultiesLocally(faculties);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Faculty added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  void editFaculty(int index) async {
    String id = facultyIdController.text.trim();
    String name = facultyNameController.text.trim();
    String dean = facultyDeanController.text.trim();
    String professorName = professorNameController.text.trim();
    String professorDesignation = professorDesignationController.text.trim();
    String phoneNumber = phoneController.text.trim();
    String email = emailController.text.trim();
    String address = addressController.text.trim();
    String subjects = subjectsController.text.trim();

    if (id.isNotEmpty &&
        name.isNotEmpty &&
        dean.isNotEmpty &&
        professorName.isNotEmpty &&
        professorDesignation.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        email.isNotEmpty &&
        address.isNotEmpty &&
        subjects.isNotEmpty) {
      Faculty updatedFaculty = Faculty(
        id: id,
        name: name,
        dean: dean,
        professorName: professorName,
        professorDesignation: professorDesignation,
        phoneNumber: phoneNumber,
        email: email,
        address: address,
        subjects: subjects,
      );

      // Update faculty locally
      faculties[index] = updatedFaculty;
      setState(() {});

      // Clear input fields
      facultyIdController.clear();
      facultyNameController.clear();
      facultyDeanController.clear();
      professorNameController.clear();
      professorDesignationController.clear();
      phoneController.clear();
      emailController.clear();
      addressController.clear();
      subjectsController.clear();

      // Save faculties locally
      await _facultyService.saveFacultiesLocally(faculties);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Faculty updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  void deleteFaculty(int index) async {
    faculties.removeAt(index);
    setState(() {});

    // Save faculties locally
    await _facultyService.saveFacultiesLocally(faculties);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Faculty deleted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Faculty'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: facultyIdController,
                labelText: 'Faculty ID', maxLines:3,
              ),
              CustomTextField(
                controller: facultyNameController,
                labelText: 'Faculty Name', maxLines: 3,
              ),
              CustomTextField(
                controller: facultyDeanController,
                labelText: 'Faculty Dean', maxLines: 3,
              ),
              CustomTextField(
                controller: professorNameController,
                labelText: 'Professor Name', maxLines: 3,
              ),
              CustomTextField(
                controller: professorDesignationController,
                labelText: 'Professor Designation', maxLines: 3,
              ),
              CustomTextField(
                controller: phoneController,
                labelText: 'Telephone Number', maxLines: 3,
              ),
              CustomTextField(
                controller: emailController,
                labelText: 'Email', maxLines: 3,
              ),
              CustomTextField(
                controller: addressController,
                labelText: 'Address', maxLines: 3,
              ),
              CustomTextField(
                controller: subjectsController,
                labelText: 'Teaching Subjects',
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: addFaculty,
                child: const Text('Add Faculty'),
              ),
              const SizedBox(height: 20),
              if (faculties.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: faculties.length,
                  itemBuilder: (context, index) {
                    Faculty faculty = faculties[index];
                    return ListTile(
                      title: Text(faculty.name),
                      subtitle: Text(faculty.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteFaculty(index),
                      ),
                      onTap: () {
                        facultyIdController.text = faculty.id;
                        facultyNameController.text = faculty.name;
                        facultyDeanController.text = faculty.dean;
                        professorNameController.text = faculty.professorName;
                        professorDesignationController.text = faculty.professorDesignation;
                        phoneController.text = faculty.phoneNumber;
                        emailController.text = faculty.email;
                        addressController.text = faculty.address;
                        subjectsController.text = faculty.subjects;

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Edit Faculty'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    controller: facultyIdController,
                                    labelText: 'Faculty ID', maxLines: 3,
                                  ),
                                  CustomTextField(
                                    controller: facultyNameController,
                                    labelText: 'Faculty Name', maxLines: 3,
                                  ),
                                  CustomTextField(
                                    controller: facultyDeanController,
                                    labelText: 'Faculty Dean', maxLines: 3,
                                  ),
                                  CustomTextField(
                                    controller: professorNameController,
                                    labelText: 'Professor Name', maxLines: 3,
                                  ),
                                  CustomTextField(
                                    controller: professorDesignationController,
                                    labelText: 'Professor Designation', maxLines: 3,
                                  ),
                                  CustomTextField(
                                    controller: phoneController,
                                    labelText: 'Telephone Number', maxLines: 3,
                                  ),
                                  CustomTextField(
                                    controller: emailController,
                                    labelText: 'Email', maxLines: 3,
                                  ),
                                  CustomTextField(
                                    controller: addressController,
                                    labelText: 'Address', maxLines: 3,
                                  ),
                                  CustomTextField(
                                    controller: subjectsController,
                                    labelText: 'Teaching Subjects',
                                    maxLines: 4,
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  editFaculty(index);
                                  Navigator.pop(context);
                                },
                                child: const Text('Save'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}


