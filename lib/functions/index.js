const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.addFaculty = functions.https.onRequest(async (req, res) => {
  if (req.method !== 'POST') {
    return res.status(405).send('Method Not Allowed');
  }

  const {
    id,
    name,
    dean,
    professorName,
    professorDesignation,
    phoneNumber,
    email,
    address,
    subjects,
  } = req.body;

  try {
    await admin.firestore().collection('faculties').doc(id).set({
      id: id,
      name: name,
      dean: dean,
      professorName: professorName,
      professorDesignation: professorDesignation,
      phoneNumber: phoneNumber,
      email: email,
      address: address,
      subjects: subjects,
    });

    res.status(201).send('Faculty added successfully.');
  } catch (error) {
    console.error('Error adding faculty:', error);
    res.status(500).send('Error adding faculty: ' + error.message);
  }
});

exports.editFaculty = functions.https.onRequest(async (req, res) => {
  if (req.method !== 'PUT') {
    return res.status(405).send('Method Not Allowed');
  }

  const {
    id,
    name,
    dean,
    professorName,
    professorDesignation,
    phoneNumber,
    email,
    address,
    subjects,
  } = req.body;

  try {
    await admin.firestore().collection('faculties').doc(id).update({
      name: name,
      dean: dean,
      professorName: professorName,
      professorDesignation: professorDesignation,
      phoneNumber: phoneNumber,
      email: email,
      address: address,
      subjects: subjects,
    });

    res.status(200).send('Faculty updated successfully.');
  } catch (error) {
    console.error('Error updating faculty:', error);
    res.status(500).send('Error updating faculty: ' + error.message);
  }
});

exports.deleteFaculty = functions.https.onRequest(async (req, res) => {
  if (req.method !== 'DELETE') {
    return res.status(405).send('Method Not Allowed');
  }

  const id = req.query.id;

  try {
    await admin.firestore().collection('faculties').doc(id).delete();
    res.status(200).send('Faculty deleted successfully.');
  } catch (error) {
    console.error('Error deleting faculty:', error);
    res.status(500).send('Error deleting faculty: ' + error.message);
  }
});

exports.getAllFaculties = functions.https.onRequest(async (req, res) => {
  if (req.method !== 'GET') {
    return res.status(405).send('Method Not Allowed');
  }

  try {
    const snapshot = await admin.firestore().collection('faculties').get();
    const faculties = snapshot.docs.map((doc) => doc.data());
    res.status(200).json(faculties);
  } catch (error) {
    console.error('Error fetching faculties:', error);
    res.status(500).send('Error fetching faculties: ' + error.message);
  }
});
