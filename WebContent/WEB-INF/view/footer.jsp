<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer>
    <div class="footer-container">
        <div class="footer-col">
            <h4>Contatti Woodly</h4>
            <p>📧 info@woodly.it</p>
            <p>📞 +39 0123 456789</p>
            <p>📍 Via degli Amanti del legno, 12 - Italia</p>
        </div>
        <div class="footer-col">
            <h4>Servizio Clienti</h4>
            <ul>
                <li><a href="#">Spedizioni e Consegne</a></li>
                <li><a href="#">Resi e Rimborsi</a></li>
                <li><a href="#">FAQ / Domande Frequenti</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Note Legali</h4>
            <ul>
                <li><a href="#">Privacy Policy</a></li>
                <li><a href="#">Termini e Condizioni</a></li>
            </ul>
        </div>
    </div>
    
    <hr class="footer-divider">
    
    <div class="footer-bottom">
        <p>&copy; 2026 Woodly S.r.l. - Tutti i diritti riservati</p>
        <div class="payment-badges">
            💳 Visa / Mastercard | 🅿️ PayPal | 🍏 Apple Pay
        </div>
    </div>
    
    <script>
	    window.addEventListener("beforeunload", function() {
	        // Salva la posizione esatta dello scroll in memoria
	        localStorage.setItem("scrollPosition", window.scrollY);
	    });
	
	    // Appena la pagina ha finito di caricare
	    window.addEventListener("load", function() {
	        // Controlla se c'è una posizione salvata in memoria
	        let savedPosition = localStorage.getItem("scrollPosition");
	        if(savedPosition !== null) {
	            // Torna esattamente a quell'altezza
	            window.scrollTo(0, parseInt(savedPosition));
	            // Pulisce la memoria
	            localStorage.removeItem("scrollPosition");
	        }
	    });
	</script>	
</footer>