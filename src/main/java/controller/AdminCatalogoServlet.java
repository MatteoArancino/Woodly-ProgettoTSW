package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.ProdottoDAO;
import model.Prodotto;

@WebServlet("/admin/catalogo")
public class AdminCatalogoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (!"admin".equals(session.getAttribute("ruolo"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        ProdottoDAO dao = new ProdottoDAO();
        String action = request.getParameter("action");
        
        // CANCELLAZIONE PRODOTTO
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminaProdotto(id);
            response.sendRedirect(request.getContextPath() + "/admin/catalogo");
            return;
        }
        
        // MODIFICA: CARICA I DATI NEL FORM SE RICHIESTO
        String idModifica = request.getParameter("idModifica");
        if (idModifica != null) {
            Prodotto prodDaModificare = dao.getProdottoById(Integer.parseInt(idModifica));
            request.setAttribute("prodottoSelezionato", prodDaModificare);
        }

        List<Prodotto> tuttiIProdotti = dao.getAllProdotti();
        request.setAttribute("prodotti", tuttiIProdotti);
        request.getRequestDispatcher("/WEB-INF/view/admin/gestioneCatalogo.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (!"admin".equals(session.getAttribute("ruolo"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        ProdottoDAO dao = new ProdottoDAO();
        
        // RECUPERO DATI DAL FORM INSERIMENTO/MODIFICA
        String idStr = request.getParameter("id");
        String nome = request.getParameter("nome");
        String descrizione = request.getParameter("descrizione");
        double prezzo = Double.parseDouble(request.getParameter("prezzo"));
        int qta = Integer.parseInt(request.getParameter("quantita"));
        String imgUrl = request.getParameter("immagineUrl");
        String categoria = request.getParameter("categoria");

        Prodotto p = new Prodotto();
        p.setNome(nome);
        p.setDescrizione(descrizione);
        p.setPrezzo(prezzo);
        p.setQuantitaMagazzino(qta);
        p.setImmagineUrl(imgUrl);
        p.setCategoria(categoria);

        if (idStr == null || idStr.trim().isEmpty()) {
            // INSERIMENTO NUOVO
            dao.inserisciProdotto(p);
        } else {
            // AGGIORNAMENTO ESISTENTE
            p.setId(Integer.parseInt(idStr));
            dao.modificaProdotto(p);
        }

        response.sendRedirect(request.getContextPath() + "/admin/catalogo");
    }
}