document.addEventListener("DOMContentLoaded", function() {
    const form = document.getElementById("formRegistrazione");
    const nome = document.getElementById("nome");
    const cognome = document.getElementById("cognome");
    const email = document.getElementById("email");
    const password = document.getElementById("password");

    const errNome = document.getElementById("errNome");
    const errCognome = document.getElementById("errCognome");
    const errEmail = document.getElementById("errEmail");
    const errPassword = document.getElementById("errPassword");

    form.addEventListener("submit", function(event) {
        let valido = true;

        // Reset dei messaggi rossi precedenti
        errNome.textContent = "";
        errCognome.textContent = "";
        errEmail.textContent = "";
        errPassword.textContent = "";

        // pattern Regex: solo lettere e spazi per i nomi, formato standard sicuro per l'email
        const regexLettere = /^[a-zA-Z\sàèìòùáéíóú軋]+$/;
        const regexEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        // 1. Validazione Nome
        if (nome.value.trim() === "") {
            errNome.textContent = "Il campo Nome non può essere vuoto.";
            valido = false;
        } else if (!regexLettere.test(nome.value.trim())) {
            errNome.textContent = "Il nome può contenere esclusivamente lettere.";
            valido = false;
        }

        // 2. Validazione Cognome
        if (cognome.value.trim() === "") {
            errCognome.textContent = "Il campo Cognome non può essere vuoto.";
            valido = false;
        } else if (!regexLettere.test(cognome.value.trim())) {
            errCognome.textContent = "Il cognome può contenere esclusivamente lettere.";
            valido = false;
        }

        // 3. Validazione Email
        if (email.value.trim() === "") {
            errEmail.textContent = "Il campo Email non può essere vuoto.";
            valido = false;
        } else if (!regexEmail.test(email.value.trim())) {
            errEmail.textContent = "Inserisci un indirizzo email valido (es: nome@dominio.it).";
            valido = false;
        }

        // 4. Validazione Password
        if (password.value.trim() === "") {
            errPassword.textContent = "Il campo Password non può essere vuoto.";
            valido = false;
        } else if (password.value.trim().length < 6) {
            errPassword.textContent = "La password deve contenere almeno 6 caratteri per sicurezza.";
            valido = false;
        }

        // Blocca l'invio alla Servlet se anche un solo controllo fallisce
        if (!valido) {
            event.preventDefault();
        }
    });
});