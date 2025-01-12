import React, { useEffect, useState } from 'react';
import axios from 'axios';
import '../App.css'; // Add this line
import Student from '../types/Student';

function App() {
  const [students, setStudents] = useState<Student[]>([]);
  const [newStudent, setNewStudent] = useState({ name: '', age: '' });
  const [loading, setLoading] = useState(true);
  const backendUrl = process.env.REACT_APP_BACKEND_URL;
  const environment = process.env.NODE_ENV;

  useEffect(() => {
    console.log(`Backend URL: ${backendUrl}`);
    const fetchStudents = async () => {
      try {
        console.log('Fetching student data...');
        const response = await axios.get<Student[]>(`${backendUrl}/api/students`);
        console.log('Student data:', response.data);
        setStudents(response.data);
        setLoading(false);
      } catch (error) {
        console.error('Error fetching student data:', error);
      }
    };

    fetchStudents();
  }, [backendUrl]);

  const addStudent = () => {
    axios
      .post(`${backendUrl}/api/students`, {
        name: newStudent.name,
        age: parseInt(newStudent.age, 10),
      })
      .then((response) => {
        const student = new Student(response.data.id, response.data.name, response.data.age);
        setStudents([...students, student]);
        setNewStudent({ name: '', age: '' });
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
              </tr>
            </thead>
            <tbody>
              {students.map((student) => (
                <tr key={student.id}>
                  <td>{student.name}</td>
                  <td>{student.age}</td>
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
