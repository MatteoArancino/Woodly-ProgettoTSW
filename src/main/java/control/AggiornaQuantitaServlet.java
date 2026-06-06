package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Carrello;

@WebServlet("/AggiornaQuantita")
public class AggiornaQuantitaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        elaboraRichiesta(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        elaboraRichiesta(request, response);
    }
    
    private void elaboraRichiesta(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int idProdotto = Integer.parseInt(request.getParameter("id"));
            int nuovaQuantita = Integer.parseInt(request.getParameter("quantita"));
            
            HttpSession session = request.getSession();
            Carrello carrello = (Carrello) session.getAttribute("carrello");
            
            if (carrello != null) {
                if (nuovaQuantita <= 0) {
                    carrello.rimuoviProdotto(idProdotto);
                } else {
                    carrello.aggiornaQuantita(idProdotto, nuovaQuantita);
                }
            }
        } catch (Exception e) {
            System.err.println("Errore nell'aggiornamento della quantità.");
        }
        
        response.sendRedirect(request.getContextPath() + "/carrello");
    }
}