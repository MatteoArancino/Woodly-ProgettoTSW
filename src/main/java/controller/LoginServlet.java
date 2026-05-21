package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.UtenteDAO;
import model.Utente;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        UtenteDAO dao = new UtenteDAO();
        Utente utente = dao.login(email, password);
        
        if (utente != null) {
            HttpSession session = request.getSession();
            
            session.setAttribute("utenteLoggato", utente);
            
            System.out.println("Login riuscito per: " + utente.getEmail() + " con ruolo: " + utente.getRuolo());
            
            response.sendRedirect("index.jsp");
        } else {
            System.out.println("Tentativo di login fallito per email: " + email);
            response.sendRedirect("login.jsp?errore=true");
        }
    }
}