// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"



document.addEventListener('turbo:submit-end', function(event) {
    if (event.detail.success) {
      const likeButton = document.getElementById(event.target.dataset.likeButtonId);
      if (likeButton) {
        likeButton.innerHTML = event.detail.responseHTML;
      }
    }
  });
  

