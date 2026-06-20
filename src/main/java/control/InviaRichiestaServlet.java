package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.RichiestaSuMisuraDAO;
import model.RichiestaSuMisura;
import model.Utente; 

@WebServlet("/invia-richiesta")
public class InviaRichiestaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/richiestaPreventivo.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Controllo Sicurezza: l'utente deve essere loggato
        HttpSession session = request.getSession();
        Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
        
        if (utenteLoggato == null) {
            // Se non è loggato, lo rimandiamo al login
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2. Raccogliamo i dati dal form HTML
        String tipoMobile = request.getParameter("tipoMobile");
        String materiale = request.getParameter("materiale");
        String noteCliente = request.getParameter("noteCliente");

        int larghezzaCm = Integer.parseInt(request.getParameter("larghezzaCm"));
        int altezzaCm = Integer.parseInt(request.getParameter("altezzaCm"));
        int profonditaCm = Integer.parseInt(request.getParameter("profonditaCm"));

        // 3. Creiamo l'oggetto Model e lo riempiamo
        RichiestaSuMisura nuovaRichiesta = new RichiestaSuMisura();
        nuovaRichiesta.setIdUtente(utenteLoggato.getId()); 
        nuovaRichiesta.setTipoMobile(tipoMobile);
        nuovaRichiesta.setMateriale(materiale);
        nuovaRichiesta.setLarghezzaCm(larghezzaCm);
        nuovaRichiesta.setAltezzaCm(altezzaCm);
        nuovaRichiesta.setProfonditaCm(profonditaCm);
        nuovaRichiesta.setNoteCliente(noteCliente);

        // 4. Salviamo nel Database tramite il DAO
        RichiestaSuMisuraDAO dao = new RichiestaSuMisuraDAO();
        boolean successo = dao.inserisciRichiesta(nuovaRichiesta);

        // 5. Reindirizziamo l'utente
        if (successo) {
            // Rimandiamo all'area personale
            response.sendRedirect(request.getContextPath() + "/area-personale?successo=true");
        } else {
            // In caso di errore del database
            request.setAttribute("errore", "Si è verificato un errore durante l'invio. Riprova.");
            request.getRequestDispatcher("/WEB-INF/view/richiestaPreventivo.jsp").forward(request, response);
        }
    }
}