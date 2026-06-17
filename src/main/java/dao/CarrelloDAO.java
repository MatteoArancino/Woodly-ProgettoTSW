package dao;

import java.sql.*;
import java.util.List;
import javax.naming.*;
import javax.sql.DataSource;
import model.Carrello;
import model.ItemCarrello;
import model.Prodotto;

public class CarrelloDAO {

    private Connection getConnection() throws SQLException {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            return ((DataSource) envCtx.lookup("jdbc/woodly_db")).getConnection();
        } catch (NamingException e) {
            throw new SQLException("Errore JNDI", e);
        }
    }

    // SALVA IL CARRELLO (svuota il vecchio e inserisce il nuovo)
    public void salvaCarrello(int idUtente, Carrello carrello) throws SQLException {
        String delete = "DELETE FROM carrello_salvato WHERE id_utente = ?";
        String insert = "INSERT INTO carrello_salvato (id_utente, id_prodotto, quantita) VALUES (?, ?, ?)";

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement psDel = conn.prepareStatement(delete);
                 PreparedStatement psIns = conn.prepareStatement(insert)) {
                
                psDel.setInt(1, idUtente);
                psDel.executeUpdate();
                
                for (ItemCarrello item : carrello.getItems()) {
                    psIns.setInt(1, idUtente);
                    psIns.setInt(2, item.getProdotto().getId());
                    psIns.setInt(3, item.getQuantita());
                    psIns.executeUpdate();
                }
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }

    // CARICA IL CARRELLO (ricostruisce l'oggetto)
    public Carrello caricaCarrello(int idUtente) throws SQLException {
        Carrello carrello = new Carrello();
        String query = "SELECT p.*, c.quantita FROM carrello_salvato c " +
                       "JOIN prodotti p ON c.id_prodotto = p.id WHERE c.id_utente = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setPrezzo(rs.getDouble("prezzo"));
                    p.setImmagineUrl(rs.getString("immagine_url"));
                    
                    carrello.aggiungiProdotto(p, rs.getInt("quantita"));
                }
            }
        }
        return carrello;
    }
}