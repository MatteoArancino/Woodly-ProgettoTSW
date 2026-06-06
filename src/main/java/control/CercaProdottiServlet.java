package control;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ProdottoDAO;
import model.Prodotto;

@WebServlet("/CercaProdottiServlet")
public class CercaProdottiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String testoCercato = request.getParameter("query");
        
        if (testoCercato == null || testoCercato.trim().isEmpty()) {
            response.sendRedirect("index.jsp");
            return;
        }

        ProdottoDAO dao = new ProdottoDAO();
        List<Prodotto> prodottiTrovati = dao.cercaProdotti(testoCercato.trim());
        
        request.setAttribute("prodottiCercati", prodottiTrovati);
        request.setAttribute("chiaveCercata", testoCercato);
        
        request.getRequestDispatcher("/WEB-INF/view/risultatiRicerca.jsp").forward(request, response);
    }
}