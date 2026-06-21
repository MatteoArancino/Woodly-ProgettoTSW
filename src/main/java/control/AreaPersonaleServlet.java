package control;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.OrdineDAO;
import dao.RichiestaPreventivoDAO; 
import model.Ordine;
import model.RichiestaSuMisura;   
import model.Utente;

@WebServlet("/area-personale") 
public class AreaPersonaleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            HttpSession session = request.getSession(false); 
            Utente utenteLoggato = (session != null) ? (Utente) session.getAttribute("utenteLoggato") : null;
    
            // Protezione di sicurezza: se l'utente non è loggato non può vedere il profilo
            if (session == null || session.getAttribute("sessionToken") == null || utenteLoggato == null) {
                request.setAttribute("erroreLogin", "Devi prima effettuare il login per accedere alla tua area riservata!");
                request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
                return;
            }

        // 1. Se è loggato, prendiamo lo storico dei suoi ordini tradizionali
        OrdineDAO ordineDao = new OrdineDAO();
        List<Ordine> storicoOrdini = ordineDao.getOrdiniPerUtente(utenteLoggato.getId());
        request.setAttribute("storicoOrdini", storicoOrdini);

        // 2. Prendiamo lo storico delle sue richieste su misura
        RichiestaPreventivoDAO preventivoDao = new RichiestaPreventivoDAO();
        List<RichiestaSuMisura> mieRichieste = preventivoDao.getRichiesteByUtente(utenteLoggato.getId());
        request.setAttribute("mieRichieste", mieRichieste); 

        request.getRequestDispatcher("/WEB-INF/view/areaPersonale.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}