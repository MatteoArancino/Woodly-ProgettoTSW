document.addEventListener("DOMContentLoaded", function() {
    const form = document.getElementById("formLogin");
    const emailInput = document.getElementById("email");
    const passwordInput = document.getElementById("password");
    
    const errEmail = document.getElementById("errEmail");
    const errPassword = document.getElementById("errPassword");

    // Espressione regolare per l'email
    const regexEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    // --- FUNZIONI DI VALIDAZIONE SINGOLE ---
    function validaEmail() {
        errEmail.textContent = "";
        const emailValue = emailInput.value.trim();
        
        if (emailValue === "") {
            errEmail.textContent = "Il campo Email non può essere vuoto.";
            return false;
        } else if (!regexEmail.test(emailValue)) {
            errEmail.textContent = "Inserisci un indirizzo email valido (es. nome@dominio.it).";
            return false;
        }
        return true;
    }

    function validaPassword() {
        errPassword.textContent = "";
        const passwordValue = passwordInput.value.trim();
        
        if (passwordValue === "") {
            errPassword.textContent = "Il campo Password non può essere vuoto.";
            return false;
        }
        return true;
    }


    emailInput.addEventListener("change", validaEmail);
    passwordInput.addEventListener("change", validaPassword);

    // --- VALIDAZIONE AL PREMERE DI SUBMIT ---
    form.addEventListener("submit", function(event) {
        // Esegue le validazioni contemporaneamente
        let eValido = validaEmail();
        let pValido = validaPassword();

        // Se anche solo un campo è invalido, blocchiamo la partenza verso la Servlet
        if (!eValido || !pValido) {
            event.preventDefault();
        }
    });
});