package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.OrdineDAO;
import model.Carrello;
import model.Utente;
import model.ItemCarrello; 

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        if (utenteLoggato == null) {
            request.setAttribute("erroreLogin", "Devi effettuare l'accesso o registrarti per completare l'acquisto!");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            return;
        }

        if (carrello == null || carrello.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/carrello");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/view/checkout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        if (utenteLoggato == null || carrello == null || carrello.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String indirizzo = request.getParameter("indirizzo");
        String citta = request.getParameter("citta");
        String cap = request.getParameter("cap");
        String metodoPagamento = request.getParameter("metodoPagamento");

        double totaleEuro = 0;
       
        for (ItemCarrello item : carrello.getItems()) {
            totaleEuro += (item.getProdotto().getPrezzo() * item.getQuantita());
        }

        OrdineDAO ordineDao = new OrdineDAO();
        boolean esito = ordineDao.salvaOrdine(utenteLoggato.getId(), totaleEuro, indirizzo, citta, cap, metodoPagamento, carrello);

        if (esito) {
            session.removeAttribute("carrello");
            request.setAttribute("messaggioSuccesso", "Grazie del tuo acquisto! Il tuo ordine è stato ricevuto con successo.");
            request.getRequestDispatcher("/WEB-INF/view/confermaOrdine.jsp").forward(request, response);
        } else {
            request.setAttribute("erroreCheckout", "Si è verificato un problema durante l'elaborazione dell'ordine. Riprova.");
            request.getRequestDispatcher("/WEB-INF/view/checkout.jsp").forward(request, response);
        }
    }
}