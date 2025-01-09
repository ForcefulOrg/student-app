import React, { useEffect, useState } from 'react';
import '../App.css'; // Add this line

function App() {
  const [students, setStudents] = useState([]);
  const [newStudent, setNewStudent] = useState({ name: '', age: '' });

  useEffect(() => {
    fetch('http://localhost:5000/api/students') // Ensure this URL matches your backend URL
      .then((response) => response.json())
      .then((data) => setStudents(data));
  }, []);

  const addStudent = () => {
    fetch('http://localhost:5000/api/students', {
      // Ensure this URL matches your backend URL
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        name: newStudent.name,
        age: parseInt(newStudent.age, 10),
      }),
    })
      .then((response) => response.json())
      .then((data) => {
        setStudents([...students, data]);
        setNewStudent({ name: '', age: '' });
      });
  };

  return (
    <div className='app-container'>
      {' '}
      {/* Add class name */}
      <h1>Student List</h1>
      <table className='student-table'>
        {' '}
        {/* Add class name */}
        <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Age</th>
          </tr>
        </thead>
        <tbody>
          {students.map((student) => (
            <tr key={student.id}>
              <td>{student.id}</td>
              <td>{student.name}</td>
              <td>{student.age}</td>
            </tr>
          ))}
        </tbody>
      </table>
      <h2>Add New Student</h2>
      <div className='form-container'>
        {' '}
        {/* Add class name */}
        <label>
          Name:
          <input
            type='text'
            value={newStudent.name}
            onChange={(e) => setNewStudent({ ...newStudent, name: e.target.value })}
          />
        </label>
        <br />
        <label>
          Age:
          <input
            type='number'
            value={newStudent.age}
            onChange={(e) => setNewStudent({ ...newStudent, age: e.target.value })}
          />
        </label>
        <br />
        <button onClick={addStudent}>Add Student</button>
      </div>
    </div>
  );
}
export default App;
