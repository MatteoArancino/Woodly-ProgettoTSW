package control;

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
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int idProdotto = Integer.parseInt(idParam);
                HttpSession session = request.getSession();
                Carrello carrello = (Carrello) session.getAttribute("carrello");
                
                if (carrello != null) {
                    carrello.rimuoviProdotto(idProdotto);
                    System.out.println("Prodotto ID " + idProdotto + " rimosso.");
                }
            } catch (NumberFormatException e) {
                System.err.println("Errore nel parsing dell'ID.");
            }
        }
        
        // CORRETTO: Rimanda alla CarrelloServlet mappata su /carrello
        response.sendRedirect(request.getContextPath() + "/carrello");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}