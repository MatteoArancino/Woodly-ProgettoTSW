package control;

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
	    	HttpSession session = request.getSession(false);
	    	if (session == null || session.getAttribute("sessionToken") == null || !"admin".equals(session.getAttribute("ruolo"))) {
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
        
        // MODIFICA: CARICA I DATI NEL FORM
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
        HttpSession session = request.getSession(false);
        
        System.out.println("Sessione trovata: " + (session != null));
        if(session != null) {
            System.out.println("Ruolo in sessione: " + session.getAttribute("ruolo"));
        }
        
        if (session == null || !"admin".equals(session.getAttribute("ruolo"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        ProdottoDAO dao = new ProdottoDAO();

        String idStr = request.getParameter("id");
        String nome = request.getParameter("nome");
        String descrizione = request.getParameter("descrizione");
        String prezzoStr = request.getParameter("prezzo");
        String qtaStr = request.getParameter("quantita");
        String categoria = request.getParameter("categoria");

        // Gestione Immagine
        jakarta.servlet.http.Part filePart = request.getPart("immagine");
        String imgUrl = request.getParameter("vecchiaImmagine"); // URL esistente di default

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            // Salviamo l'immagine nella cartella
            String uploadPath = getServletContext().getRealPath("") + "/images/" + fileName;
            filePart.write(uploadPath);
            imgUrl = "images/" + fileName;
        }

        // Costruzione oggetto Prodotto
        Prodotto p = new Prodotto();
        p.setNome(nome);
        p.setDescrizione(descrizione);
        p.setPrezzo(Double.parseDouble(prezzoStr));
        p.setQuantitaMagazzino(Integer.parseInt(qtaStr));
        p.setImmagineUrl(imgUrl);
        p.setCategoria(categoria);

        if (idStr == null || idStr.trim().isEmpty()) {
            dao.inserisciProdotto(p);
            session.setAttribute("messaggioSuccesso", "Prodotto aggiunto correttamente!");
        } else {
            p.setId(Integer.parseInt(idStr));
            dao.modificaProdotto(p);
            session.setAttribute("messaggioSuccesso", "Prodotto aggiornato correttamente!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/catalogo");
    }
}