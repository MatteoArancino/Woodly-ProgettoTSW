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

@WebServlet(urlPatterns = {"/home", "/index"})
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Istanziamo il DAO 
        ProdottoDAO dao = new ProdottoDAO();
        
        // 2. Recuperiamo tutti i prodotti dal database
        List<Prodotto> tuttiIProdotti = dao.getAllProdotti();
        
        // 3. Selezioniamo solo una parte di prodotti per la vetrina della Home
        List<Prodotto> prodottiPiuVenduti = tuttiIProdotti;
        if (tuttiIProdotti != null && tuttiIProdotti.size() > 4) {
            prodottiPiuVenduti = tuttiIProdotti.subList(0, 4); // Prende solo i primi 4 prodotti
        }
        
        // 4. Mettiamo la lista dentro un attributo della request chiamato "prodottiPiuVenduti"
        request.setAttribute("prodottiPiuVenduti", prodottiPiuVenduti);
        
        // 5. Inoltriamo la richiesta alla pagina JSP protetta
        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}