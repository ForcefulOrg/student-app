import React, { useEffect, useState } from 'react';
import axios from 'axios';
import '../App.css'; // Add this line
import Student from '../types/Student';

function App() {
  const [students, setStudents] = useState<Student[]>([]);
  const [newStudent, setNewStudent] = useState({ name: '', age: '', summary: '' });
  const [loading, setLoading] = useState(true);
  const backendUrl = process.env.REACT_APP_BACKEND_URL;
  const environment = process.env.NODE_ENV;

  useEffect(() => {
    console.log(`Backend URL: ${backendUrl}`);
    const fetchStudents = async () => {
      try {
        console.log('Fetching student data...');
        const response = await fetch(`${backendUrl}/api/students`);
        const students = await response.json();
        console.log('Student data:', students);
        setStudents(students);
      } catch (error) {
        console.error('Error fetching student data:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchStudents();
  }, [backendUrl]);

  const addStudent = () => {
    axios
      .post(`${backendUrl}/api/students`, {
        name: newStudent.name,
        age: parseInt(newStudent.age, 10),
        summary: newStudent.summary,
      })
      .then((response) => {
        const student = new Student(response.data.id, response.data.name, response.data.age, response.data.summary);
        setStudents([...students, student]);
        setNewStudent({ name: '', age: '', summary: '' });
        alert('Student added successfully!');
      })
      .catch((error) => console.error('Error adding student:', error));
  };

  return (
    <div className='app-container'>
      {loading ? (
        <div>Loading...</div>
      ) : (
        <div>
          <h1>Student List</h1>
          <table className='student-table'>
            <thead>
              <tr>
                <th>Name</th>
                <th>Age</th>
                <th>Summary</th>
              </tr>
            </thead>
            <tbody>
              {students.map((student) => (
                <tr key={student.id}>
                  <td>{student.name}</td>
                  <td>{student.age}</td>
                  <td>{student.summary}</td>
                </tr>
              ))}
            </tbody>
          </table>
          <h2>Add New Student</h2>
          <div className='form-container'>
            <label>
              Name:
              <input
                type='text'
                value={newStudent.name}
                onChange={(e) => setNewStudent({ ...newStudent, name: e.target.value })}
              />
            </label>
            <label>
              Age:
              <input
                type='text'
                value={newStudent.age}
                onChange={(e) => setNewStudent({ ...newStudent, age: e.target.value })}
              />
            </label>
            <label>
              Summary:
              <input
                type='text'
                value={newStudent.summary}
                onChange={(e) => setNewStudent({ ...newStudent, summary: e.target.value })}
              />
            </label>
            <button onClick={addStudent}>Add Student</button>
          </div>
        </div>
      )}
      <p>Backend url: {backendUrl}</p>
      <p>Environment: {environment}</p>
    </div>
  );
}

export default App;
