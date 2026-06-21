package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import model.RichiestaSuMisura;

public class RichiestaPreventivoDAO {

    private Connection getConnection() throws SQLException {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource) envCtx.lookup("jdbc/woodly_db"); 
            return ds.getConnection();
        } catch (NamingException e) {
            throw new SQLException("Errore JNDI: impossibile connettersi al DataSource", e);
        }
    }
    
    public RichiestaSuMisura getRichiestaById(int idRichiesta) {
        RichiestaSuMisura richiesta = null;
        
        String query = "SELECT r.*, u.nome AS nomeUtente, u.cognome AS cognomeUtente, u.email AS emailUtente " +
                       "FROM richieste_su_misura r " +
                       "JOIN utenti u ON r.id_utente = u.id " +
                       "WHERE r.id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, idRichiesta); 
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    richiesta = new RichiestaSuMisura();
                    
                    richiesta.setId(rs.getInt("id"));
                    richiesta.setIdUtente(rs.getInt("id_utente"));
                    richiesta.setDataRichiesta(rs.getTimestamp("data_richiesta"));
                    richiesta.setStato(rs.getString("stato"));
                    
                    richiesta.setNomeUtente(rs.getString("nomeUtente"));
                    richiesta.setCognomeUtente(rs.getString("cognomeUtente"));
                    richiesta.setEmailUtente(rs.getString("emailUtente"));
                    
                    richiesta.setTipoMobile(rs.getString("tipo_mobile"));
                    richiesta.setMateriale(rs.getString("materiale"));
                    richiesta.setLarghezzaCm(rs.getInt("larghezza_cm"));
                    richiesta.setAltezzaCm(rs.getInt("altezza_cm"));
                    richiesta.setProfonditaCm(rs.getInt("profondita_cm"));
                    richiesta.setNoteCliente(rs.getString("note_cliente"));
                    
                    double prezzo = rs.getDouble("prezzo_proposto");
                    if (!rs.wasNull()) {
                        richiesta.setPrezzoProposto(prezzo);
                    }
                }
            }

        } catch (SQLException e) {
            System.err.println("Errore nel metodo getRichiestaById di RichiestaPreventivoDAO:");
            e.printStackTrace();
        }

        return richiesta;
    }
    
    public boolean aggiornaPreventivo(int idRichiesta, double prezzoOfferto) {
        String query = "UPDATE richieste_su_misura SET prezzo_proposto = ?, stato = 'Preventivo inviato' WHERE id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setDouble(1, prezzoOfferto);
            ps.setInt(2, idRichiesta);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Errore nel metodo aggiornaPreventivo di RichiestaPreventivoDAO:");
            e.printStackTrace();
            return false;
        }
    }
    
    public java.util.List<RichiestaSuMisura> getRichiesteByUtente(int idUtente) {
        java.util.List<RichiestaSuMisura> lista = new java.util.ArrayList<>();
        String query = "SELECT * FROM richieste_su_misura WHERE id_utente = ? ORDER BY data_richiesta DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, idUtente);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RichiestaSuMisura richiesta = new RichiestaSuMisura();
                    richiesta.setId(rs.getInt("id"));
                    richiesta.setIdUtente(rs.getInt("id_utente"));
                    richiesta.setTipoMobile(rs.getString("tipo_mobile"));
                    richiesta.setMateriale(rs.getString("materiale"));
                    richiesta.setLarghezzaCm(rs.getInt("larghezza_cm"));
                    richiesta.setAltezzaCm(rs.getInt("altezza_cm"));
                    richiesta.setProfonditaCm(rs.getInt("profondita_cm"));
                    richiesta.setNoteCliente(rs.getString("note_cliente"));
                    richiesta.setStato(rs.getString("stato"));
                    richiesta.setDataRichiesta(rs.getTimestamp("data_richiesta"));
                    
                    double prezzo = rs.getDouble("prezzo_proposto");
                    if (!rs.wasNull()) {
                        richiesta.setPrezzoProposto(prezzo);
                    } else {
                        richiesta.setPrezzoProposto(null);
                    }
                    
                    lista.add(richiesta);
                }
            }
        } catch (SQLException e) {
            System.err.println("Errore nel metodo getRichiesteByUtente:");
            e.printStackTrace();
        }
        return lista;
    }
}