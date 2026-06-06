package control;

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
        int idProdotto = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        
        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("carrello", carrello);
        }
        
        ProdottoDAO dao = new ProdottoDAO();
        Prodotto p = dao.getProdottoById(idProdotto); 
        
        if (p != null) {
            carrello.aggiungiProdotto(p, 1);
            System.out.println("Aggiunto al carrello: " + p.getNome() + ". Totale elementi: " + carrello.getItems().size());
        }
        
        // Gestione intelligente del ritorno alla pagina precedente
        String paginaProvenienza = request.getHeader("referer");
        
        if (paginaProvenienza != null && !paginaProvenienza.isEmpty()) {
            response.sendRedirect(paginaProvenienza);
        } else {
            // CORRETTO: Rimanda alla Servlet della home, non al file JSP protetto!
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    // Intercetta i form inviati in POST dal catalogo
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}