package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.ProdottoDAO;
import model.Carrello;
import model.Prodotto;

@WebServlet("/AggiungiAlCarrello")
public class AggiungiAlCarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Recuperiamo l'ID del prodotto passato come parametro nell'URL (es: ?id=3)
        int idProdotto = Integer.parseInt(request.getParameter("id"));
        
        // 2. Recuperiamo la sessione corrente
        HttpSession session = request.getSession();
        
        // 3. Cerchiamo se esiste già un carrello in sessione
        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("carrello", carrello); // Salviamo il nuovo carrello in sessione
        }
        
        // 4. Usiamo il ProdottoDAO per recuperare i dati completi del mobile dal DB
        ProdottoDAO dao = new ProdottoDAO();
        Prodotto p = dao.getProdottoById(idProdotto); 
        
        if (p != null) {
            // Aggiungiamo 1 unità di questo prodotto al carrello
            carrello.aggiungiProdotto(p, 1);
            System.out.println("Aggiunto al carrello: " + p.getNome() + ". Totale elementi: " + carrello.getItems().size());
        }
        
        // 5. Una volta aggiunto il prodotto, rimandiamo l'utente al catalogo 
        response.sendRedirect("catalogo");
    }
}