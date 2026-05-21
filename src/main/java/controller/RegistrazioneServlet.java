package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.UtenteDAO;
import model.Utente;

@WebServlet("/RegistrazioneServlet")
public class RegistrazioneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Utente nuovoUtente = new Utente(nome, cognome, email, password);
        
        UtenteDAO dao = new UtenteDAO();
        boolean successo = dao.registraUtente(nuovoUtente);
        
        if(successo) {
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("registrazione.jsp?errore=true");
        }
    }
}