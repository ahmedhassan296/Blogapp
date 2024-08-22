// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"


// document.addEventListener('DOMContentLoaded', function() {
//     document.querySelectorAll('.reply-link').forEach(function(link) {
//       link.addEventListener('click', function(event) {
//         event.preventDefault();
        
//         // Get the comment ID from the data attribute
//         const commentId = this.dataset.commentId;
        
//         // Find the reply form container
//         const replyFormContainer = document.getElementById(`reply-form-${commentId}`);
        
//         // Check if the form is already loaded
//         if (!replyFormContainer.innerHTML.trim()) {
//           // Fetch the reply form via AJAX
//           fetch(`/posts/${replyFormContainer.dataset.postId}/comments/${commentId}/replies/new`)
//             .then(response => response.text())
//             .then(html => {
//               replyFormContainer.innerHTML = html;
//             })
//             .catch(error => console.error('Error loading reply form:', error));
//         } else {
//           // If form is already loaded, just toggle visibility
//           replyFormContainer.classList.toggle('d-none');
//         }
//       });
//     });
//   });
  


  document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.reply-link').forEach(link => {
    link.addEventListener('click', event => {
      event.preventDefault();
      const commentId = event.target.dataset.commentId;
      const form = document.getElementById(`reply-form-${commentId}`);
      form.style.display = form.style.display === 'none' || form.style.display === '' ? 'block' : 'none';
    });
  });
});
