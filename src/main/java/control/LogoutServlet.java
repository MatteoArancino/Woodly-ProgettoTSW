package control;

import java.io.IOException;
import java.sql.SQLException;

import dao.CarrelloDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Carrello;
import model.Utente;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            // 2. Recupera l'utente e il carrello dalla sessione
            Utente utente = (Utente) session.getAttribute("utenteLoggato");
            Carrello carrello = (Carrello) session.getAttribute("carrello");
            
            // 3. Se l'utente era loggato e ha un carrello, SALVALO NEL DB!
            if (utente != null && carrello != null && !carrello.getItems().isEmpty()) {
                try {
                    CarrelloDAO carrelloDao = new CarrelloDAO();
                    carrelloDao.salvaCarrello(utente.getId(), carrello);
                    System.out.println("Carrello salvato per l'utente ID: " + utente.getId()); // Log di controllo
                } catch (SQLException e) {
                    System.out.println("Errore nel salvataggio del carrello!");
                    e.printStackTrace();
                }
            }
            
            // 3. Ora che è tutto al sicuro nel DB, possiamo distruggere la sessione
            session.invalidate();
        }
        
        response.sendRedirect(request.getContextPath() + "/home");
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}