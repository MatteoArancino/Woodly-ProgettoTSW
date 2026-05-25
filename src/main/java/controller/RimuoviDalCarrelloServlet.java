package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Carrello;

@WebServlet("/RimuoviDalCarrello")
public class RimuoviDalCarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Recuperiamo l'ID del mobile da eliminare passato nell'URL (?id=...)
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int idProdotto = Integer.parseInt(idParam);
                
                // 2. Recuperiamo la sessione e il carrello corrente
                HttpSession session = request.getSession();
                Carrello carrello = (Carrello) session.getAttribute("carrello");
                
                // 3. Se il carrello esiste, eliminiamo il prodotto richiesto
                if (carrello != null) {
                    carrello.rimuoviProdotto(idProdotto);
                    System.out.println("Prodotto ID " + idProdotto + " rimosso con successo dal carrello.");
                }
                
            } catch (NumberFormatException e) {
                System.err.println("Errore nel parsing dell'ID prodotto da rimuovere.");
            }
        }
        
        // 4. Reindirizziamo l'utente direttamente alla pagina del carrello aggiornata
        response.sendRedirect("carrello.jsp");
    }
}