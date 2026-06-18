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

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdottoDAO dao = new ProdottoDAO();
        
        // Recuperiamo i 4 prodotti più venduti basandoci sugli ordini
        List<Prodotto> prodottiPiuVenduti = dao.getProdottiPiuVenduti(4);
        
        // Per sicurezza: se il DB non ha ancora registrato nessuna vendita, 
        // mostriamo comunque 4 prodotti dal catalogo per non lasciare la Home vuota.
        if (prodottiPiuVenduti == null || prodottiPiuVenduti.isEmpty()) {
            List<Prodotto> tuttiIProdotti = dao.getAllProdotti();
            if (tuttiIProdotti != null && tuttiIProdotti.size() > 4) {
                prodottiPiuVenduti = tuttiIProdotti.subList(0, 4);
            } else {
                prodottiPiuVenduti = tuttiIProdotti; // Se ci sono meno di 4 prodotti, li prende tutti
            }
        }
        
        // Mettiamo la lista dentro un attributo della request chiamato "prodottiPiuVenduti"
        request.setAttribute("prodottiPiuVenduti", prodottiPiuVenduti);
        
        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}