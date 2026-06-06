package controller;

import java.io.IOException;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.UtenteDAO;
import model.Utente;

@WebServlet("/login") // Mappatura dell'URL pulito
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 1. Mostra la pagina di login quando si clicca sul link
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    // 2. Elabora le credenziali inviate dal form
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UtenteDAO dao = new UtenteDAO();
        Utente utente = dao.verificaLogin(email, password); 

        if (utente != null) {
            HttpSession session = request.getSession();
            session.setAttribute("utenteLoggato", utente);
            
            // Recuperiamo il ruolo, togliamo gli spazi bianchi e lo costringiamo in MINUSCOLO
            String ruoloPulito = "user";
            if (utente.getRuolo() != null) {
                ruoloPulito = utente.getRuolo().trim().toLowerCase();
            }
            
            session.setAttribute("ruolo", ruoloPulito);
            
            // REQUISITO DI SICUREZZA: Generazione Session Token sicuro
            String sessionToken = UUID.randomUUID().toString();
            session.setAttribute("sessionToken", sessionToken);

            // Reindirizziamo alla Servlet del catalogo
            response.sendRedirect(request.getContextPath() + "/catalogo");
        } else {
            // LOGIN ERRATO
            request.setAttribute("erroreLogin", "Email o Password errate. Riprova.");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }
}