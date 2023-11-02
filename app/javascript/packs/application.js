import React from 'react';
import { createRoot } from 'react-dom/client';
import PropTypes from 'prop-types';
import Home from '../components/Home';

document.addEventListener('DOMContentLoaded', () => {
    const targetElement = document.getElementById('home');
    if (targetElement) {
        const root = createRoot(targetElement);
        root.render(<Home />);
    }
});


