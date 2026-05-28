document.addEventListener("DOMContentLoaded", function() {
    const form = document.getElementById("formLogin");
    const emailInput = document.getElementById("email");
    const passwordInput = document.getElementById("password");
    
    const errEmail = document.getElementById("errEmail");
    const errPassword = document.getElementById("errPassword");

    form.addEventListener("submit", function(event) {
        let formatoValido = true;

        // Reset completo dei messaggi rossi precedenti
        errEmail.textContent = "";
        errPassword.textContent = "";

        // 1. Controllo validità dell'Email
        const emailValue = emailInput.value.trim();
        if (emailValue === "") {
            errEmail.textContent = "Il campo Email non può essere vuoto.";
            formatoValido = false;
        } else if (!emailValue.includes("@") || !emailValue.includes(".")) {
            errEmail.textContent = "Inserisci un indirizzo email valido (es. nome@dominio.it).";
            formatoValido = false;
        }

        // 2. Controllo validità della Password
        const passwordValue = passwordInput.value.trim();
        if (passwordValue === "") {
            errPassword.textContent = "Il campo Password non può essere vuoto.";
            formatoValido = false;
        }

        // Se anche solo un campo è invalido, blocchiamo la partenza del form verso la Servlet
        if (!formatoValido) {
            event.preventDefault();
        }
    });
});