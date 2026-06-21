document.addEventListener('DOMContentLoaded', () => {
    const hamburgerBtn = document.getElementById('hamburger-btn');
    const navLinks = document.querySelector('.nav-links');

    if (hamburgerBtn && navLinks) {
        hamburgerBtn.addEventListener('click', () => {
            // Mostra/nasconde il menu verticale
            navLinks.classList.toggle('active');
            // Trasforma le tre linee in una "X"
            hamburgerBtn.classList.toggle('open');
        });
    }
});