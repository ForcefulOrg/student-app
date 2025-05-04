import React from 'react';
import ReactDOM from 'react-dom';
import './App.css';
import App from './components/App'; // Ensure this path is correct
import { createRoot } from 'react-dom/client';

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);
const container = document.getElementById('root');
const root = createRoot(container);

root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
