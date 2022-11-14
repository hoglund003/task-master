const navbar = document.querySelector("nav.navbar");
const menuButton = document.querySelector(".menu-button");
const navBottomATags = document.querySelectorAll("nav.navbar .bottom a");
const weekButtons = document.querySelectorAll(".wday");
const hiddemDateInput = document.querySelector("#selected_date");
const newForm = document.querySelector("#new-form");

var i;
var navbarExpanded = false;

menuButton.addEventListener('click', () => {
  // Toggle menu apperance
  if (!navbarExpanded) {
    navbarExpanded = true;
    menuButton.classList.add("active");
    i = 1
    navBottomATags.forEach(child=>{
      child.classList.remove("not-appere");
      child.classList.add("appere", "appere" + i);
      i++
    });
  } else {
    navbarExpanded = false;
    menuButton.classList.remove("active");
    navBottomATags.forEach(child=>{
      child.classList.remove("appere");
      child.classList.add("not-appere");
    });
  }
});

document.addEventListener('click', (e) => {
  // Exit menu if clicking outside
  if (!navbar.contains(e.target)) {
    navbarExpanded = false;
    navBottomATags.forEach(child=>{
      child.classList.remove("appere");
      child.classList.add("not-appere");
    });
  }
});

let currentDate = new Date().toJSON().slice(0,10); 

weekButtons.forEach(btn=>{
  if (btn.value == currentDate){
    btn.classList.add("active");
  }

  btn.addEventListener('click', () => {
    weekButtons.forEach(btn => {
      btn.classList.remove('active');
    });
    btn.classList.add("active");
    hiddemDateInput.value = btn.value;
  });
});