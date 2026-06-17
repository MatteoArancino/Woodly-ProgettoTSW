package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.UtenteDAO;

@WebServlet("/verificaEmail")
public class VerificaEmailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        if (email == null || email.trim().isEmpty()) {
            response.getWriter().write("vuota");
            return;
        }

        UtenteDAO dao = new UtenteDAO();
        boolean esiste = dao.esisteEmail(email.trim());

        if (esiste) {
            response.getWriter().write("occupata");
        } else {
            response.getWriter().write("libera");
        }
    }
}