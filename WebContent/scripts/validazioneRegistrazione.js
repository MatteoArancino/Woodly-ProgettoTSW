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

	// Espressione regolare
    const regexLettere = /^[a-zA-Z\sàèìòùáéíóú]+$/;
    const regexEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

	email.addEventListener("input", function() {
        let emailVal = this.value.trim();

        if (regexEmail.test(emailVal)) {
            // Nota: "verificaEmail" funziona come percorso relativo dalla tua servlet di registrazione
            fetch("verificaEmail?email=" + encodeURIComponent(emailVal))
                .then(response => response.text())
                .then(data => {
                    if (data === "occupata") {
                        errEmail.textContent = "❌ Questa email è già registrata!";
                        errEmail.style.color = "#cc3333";
                    } else if (data === "libera") {
                        errEmail.textContent = "✔ Email disponibile!";
                        errEmail.style.color = "#2e7d32";
                    }
                })
                .catch(error => console.error("Errore AJAX:", error));
        } else {
             if(errEmail.textContent.includes("✔") || errEmail.textContent.includes("❌")) {
                 errEmail.textContent = "";
             }
        }
    });
	
	
    // --- FUNZIONI DI VALIDAZIONE SINGOLE ---
    function validaNome() {
        errNome.textContent = "";
        if (nome.value.trim() === "") {
            errNome.textContent = "Il campo Nome non può essere vuoto.";
            return false;
        } else if (!regexLettere.test(nome.value.trim())) {
            errNome.textContent = "Il nome può contenere esclusivamente lettere.";
            return false;
        }
        return true;
    }

    function validaCognome() {
        errCognome.textContent = "";
        if (cognome.value.trim() === "") {
            errCognome.textContent = "Il campo Cognome non può essere vuoto.";
            return false;
        } else if (!regexLettere.test(cognome.value.trim())) {
            errCognome.textContent = "Il cognome può contenere esclusivamente lettere.";
            return false;
        }
        return true;
    }

    function validaEmail() {
        // Se c'è già un errore AJAX (email occupata), non lo sovrascriviamo
        if (errEmail.textContent.includes("già registrata")) return false; 
        
        errEmail.textContent = "";
		errEmail.style.color = "#cc3333";
		
        if (email.value.trim() === "") {
            errEmail.textContent = "Il campo Email non può essere vuoto.";
            return false;
        } else if (!regexEmail.test(email.value.trim())) {
            errEmail.textContent = "Inserisci un indirizzo email valido (es: nome@dominio.it).";
            return false;
        }
        return true;
    }

    function validaPassword() {
        errPassword.textContent = "";
        if (password.value.trim() === "") {
            errPassword.textContent = "Il campo Password non può essere vuoto.";
            return false;
        } else if (password.value.trim().length < 6) {
            errPassword.textContent = "La password deve contenere almeno 6 caratteri per sicurezza.";
            return false;
        }
        return true;
    }


    nome.addEventListener("change", validaNome);
    cognome.addEventListener("change", validaCognome);
    email.addEventListener("change", validaEmail);
    password.addEventListener("change", validaPassword);

	
	// --- VALIDAZIONE AL PREMERE DI SUBMIT ---
    form.addEventListener("submit", function(event) {
        // Esegue tutte le validazioni contemporaneamente
        let nValido = validaNome();
        let cValido = validaCognome();
        let eValido = validaEmail();
        let pValido = validaPassword();

        // Se anche uno solo è falso, blocca l'invio dei dati al server
        if (!nValido || !cValido || !eValido || !pValido) {
            event.preventDefault(); 
        }
    });
});