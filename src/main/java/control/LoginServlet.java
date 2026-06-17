package control;

import java.io.IOException;
import java.util.UUID;
import java.sql.SQLException; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.UtenteDAO;
import dao.CarrelloDAO; 
import model.Utente;
import model.Carrello;  

@WebServlet("/login") 
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UtenteDAO dao = new UtenteDAO();
        Utente utente = dao.verificaLogin(email, password); 

        if (utente != null) {
            HttpSession session = request.getSession();
            session.setAttribute("utenteLoggato", utente);
            
            String ruoloPulito = "user";
            if (utente.getRuolo() != null) {
                ruoloPulito = utente.getRuolo().trim().toLowerCase();
            }
            
            session.setAttribute("ruolo", ruoloPulito);
            
            String sessionToken = UUID.randomUUID().toString();
            session.setAttribute("sessionToken", sessionToken);

              try {
            	
                CarrelloDAO carrelloDao = new CarrelloDAO();
                
                // Recuperiamo il carrello "Ospite" (quello che l'utente ha riempito prima di loggarsi)
                Carrello carrelloOspite = (Carrello) session.getAttribute("carrello");
                
                // Carichiamo il carrello salvato nel DB per questo utente
                Carrello carrelloDb = carrelloDao.caricaCarrello(utente.getId());
                
                // Facciamo la FUSIONE 
                if (carrelloDb == null) {
                    carrelloDb = new Carrello();
                }
                
                if (carrelloOspite != null && !carrelloOspite.getItems().isEmpty()) {
                    // Travasiamo tutti i prodotti del carrello ospite in quello del DB
                    for (model.ItemCarrello item : carrelloOspite.getItems()) {
                        // Il metodo aggiungiProdotto dovrebbe già gestire l'incremento delle quantità se il prodotto è già presente
                        carrelloDb.aggiungiProdotto(item.getProdotto(), item.getQuantita());
                    }
                    
                    // Salviamo subito il carrello unito nel DB
                    carrelloDao.salvaCarrello(utente.getId(), carrelloDb);
                }
                
                // Mettiamo il carrello definitivo e unito in sessione
                session.setAttribute("carrello", carrelloDb);
                
            } catch (SQLException e) {
                e.printStackTrace();
                if (session.getAttribute("carrello") == null) {
                    session.setAttribute("carrello", new Carrello());
                }
            }

            // Reindirizziamo alla Servlet del catalogo
            response.sendRedirect(request.getContextPath() + "/catalogo");
        } else {
            request.setAttribute("erroreLogin", "Email o Password errate. Riprova.");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }
}