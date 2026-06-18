window.addEventListener("beforeunload", function() {
    localStorage.setItem("scrollPosition", window.scrollY);
});

// Usa DOMContentLoaded invece di window.addEventListener("load")
document.addEventListener("DOMContentLoaded", function() {
    let savedPosition = localStorage.getItem("scrollPosition");
    if(savedPosition !== null) {
        window.scrollTo(0, parseInt(savedPosition));
        localStorage.removeItem("scrollPosition");
    }
});