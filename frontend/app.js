// frontend/app.js

document.addEventListener('DOMContentLoaded', () => {
    const loginForm = document.getElementById('login-form');
  
    // Handle login form submission
    loginForm.addEventListener('submit', event => {
      event.preventDefault();
  
      const emailInput = document.getElementById('email');
      const passwordInput = document.getElementById('password');
  
      const loginData = {
        email: emailInput.value,
        password: passwordInput.value,
      };
  
      // Send login data to the API for authentication
      fetch('http://localhost:3000/api/authenticate', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(loginData),
      })
        .then(response => response.json())
        .then(data => {
          // Handle authentication response
          if (data.success) {
            alert('Login successful!');
            // Redirect to the desired page
            window.location.href = '/dashboard.html';
          } else {
            alert('Login failed. Please check your credentials.');
          }
        })
        .catch(error => console.error(error));
    });
  });

  