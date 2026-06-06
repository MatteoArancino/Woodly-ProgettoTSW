package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SvuotaCarrello")
public class SvuotaCarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Rimuove completamente il carrello dalla sessione dell'utente
        session.removeAttribute("carrello");
        
        System.out.println("Il carrello è stato svuotato.");
        
        // Rimanda l'utente alla pagina del carrello (che risulterà vuoto)
        response.sendRedirect(request.getContextPath() + "/carrello");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}