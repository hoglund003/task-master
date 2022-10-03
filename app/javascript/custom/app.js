const navbar = document.querySelector("nav.navbar");
const menuButton = document.querySelector(".menu-button");
const navBottomATags = document.querySelectorAll("nav.navbar .bottom a");

var navbarExpanded = false;

menuButton.addEventListener('click', () => {
  // Toggle menu apperance
  if (!navbarExpanded) {
    navbarExpanded = true;
    navBottomATags.forEach(child=>{
      child.style.display = "block";
    });
  } else {
    navbarExpanded = false;
    navBottomATags.forEach(child=>{
      child.style.display = "none";
    });
  }
});

document.addEventListener('click', (e) => {
  // Exit menu if clicking outside
  if (!navbar.contains(e.target)) {
    navbarExpanded = false;
    navBottomATags.forEach(child=>{
      child.style.display = "none";
    });
  }
});
