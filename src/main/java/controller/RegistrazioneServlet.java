package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.UtenteDAO;
import model.Utente;

@WebServlet("/registrazione") // URL pulito mappato
public class RegistrazioneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Richiesta in GET: mostra semplicemente la pagina di registrazione
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
    }

    // Richiesta in POST: elabora l'inserimento dei dati inviati dal form
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Impacchettiamo i dati dentro il Bean Utente
        Utente nuovoUtente = new Utente();
        nuovoUtente.setNome(nome);
        nuovoUtente.setCognome(cognome);
        nuovoUtente.setEmail(email);
        nuovoUtente.setPassword(password);

        UtenteDAO dao = new UtenteDAO();
        boolean registrato = dao.registraUtente(nuovoUtente);

        if (registrato) {
            // REGISTRAZIONE RIUSCITA: Reindirizziamo l'utente alla Servlet di Login
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // REGISTRAZIONE FALLITA (es. errore SQL o vincolo di email unica violato)
            request.setAttribute("erroreRegistrazione", "Impossibile completare la registrazione. L'email potrebbe essere già in uso.");
            request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
        }
    }
}