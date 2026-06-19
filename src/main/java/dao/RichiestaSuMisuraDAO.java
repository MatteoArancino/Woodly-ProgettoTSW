package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import model.RichiestaSuMisura;

public class RichiestaSuMisuraDAO {

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

    // 1. INSERIMENTO: L'utente invia una nuova richiesta
    public boolean inserisciRichiesta(RichiestaSuMisura richiesta) {
        String query = "INSERT INTO richieste_su_misura (id_utente, tipo_mobile, altezza_cm, larghezza_cm, profondita_cm, materiale, note_cliente, stato) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?, 'In attesa')";
        
        try (Connection con = getConnection(); 
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, richiesta.getIdUtente());
            ps.setString(2, richiesta.getTipoMobile());
            ps.setInt(3, richiesta.getAltezzaCm());
            ps.setInt(4, richiesta.getLarghezzaCm());
            ps.setInt(5, richiesta.getProfonditaCm());
            ps.setString(6, richiesta.getMateriale());
            ps.setString(7, richiesta.getNoteCliente());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Errore nel metodo inserisciRichiesta di RichiestaSuMisuraDAO:");
            e.printStackTrace();
            return false;
        }
    }

    // 2. RECUPERO GLOBALE AGGIORNATO: L'admin vede TUTTE le richieste con Nome e Cognome dell'utente
    public List<RichiestaSuMisura> recuperaTutte() {
        List<RichiestaSuMisura> lista = new ArrayList<>();
        String query = "SELECT r.*, u.nome AS nome_utente, u.cognome AS cognome_utente " +
                       "FROM richieste_su_misura r " +
                       "JOIN utenti u ON r.id_utente = u.id " +
                       "ORDER BY r.data_richiesta DESC";
        
        try (Connection con = getConnection(); 
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                lista.add(estraiDaResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Errore nel metodo recuperaTutte di RichiestaSuMisuraDAO:");
            e.printStackTrace();
        }
        return lista;
    }

    // 3. RECUPERO UTENTE: Il cliente vede le sue richieste 
    public List<RichiestaSuMisura> recuperaPerUtente(int idUtente) {
        List<RichiestaSuMisura> lista = new ArrayList<>();
        String query = "SELECT r.*, u.nome AS nome_utente, u.cognome AS cognome_utente " +
                       "FROM richieste_su_misura r " +
                       "JOIN utenti u ON r.id_utente = u.id " +
                       "WHERE r.id_utente = ? " +
                       "ORDER BY r.data_richiesta DESC";
        
        try (Connection con = getConnection(); 
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(estraiDaResultSet(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Errore nel metodo recuperaPerUtente di RichiestaSuMisuraDAO:");
            e.printStackTrace();
        }
        return lista;
    }

    // 4. AGGIORNAMENTO ADMIN: L'admin cambia lo stato e inserisce il prezzo
    public boolean aggiornaPreventivoAdmin(int idRichiesta, String nuovoStato, Double prezzoProposto) {
        String query = "UPDATE richieste_su_misura SET stato = ?, prezzo_proposto = ? WHERE id = ?";
        
        try (Connection con = getConnection(); 
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setString(1, nuovoStato);
            
            if (prezzoProposto != null) {
                ps.setDouble(2, prezzoProposto);
            } else {
                ps.setNull(2, java.sql.Types.DECIMAL);
            }
            
            ps.setInt(3, idRichiesta);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Errore nel metodo aggiornaPreventivoAdmin di RichiestaSuMisuraDAO:");
            e.printStackTrace();
            return false;
        }
    }

    private RichiestaSuMisura estraiDaResultSet(ResultSet rs) throws SQLException {
        RichiestaSuMisura r = new RichiestaSuMisura();
        r.setId(rs.getInt("id"));
        r.setIdUtente(rs.getInt("id_utente"));
        r.setTipoMobile(rs.getString("tipo_mobile"));
        r.setAltezzaCm(rs.getInt("altezza_cm"));
        r.setLarghezzaCm(rs.getInt("larghezza_cm"));
        r.setProfonditaCm(rs.getInt("profondita_cm"));
        r.setMateriale(rs.getString("materiale"));
        r.setNoteCliente(rs.getString("note_cliente"));
        
      
        r.setNomeUtente(rs.getString("nome_utente"));
        r.setCognomeUtente(rs.getString("cognome_utente"));
        
        double prezzo = rs.getDouble("prezzo_proposto");
        if (rs.wasNull()) {
            r.setPrezzoProposto(null);
        } else {
            r.setPrezzoProposto(prezzo);
        }
        
        r.setStato(rs.getString("stato"));
        r.setDataRichiesta(rs.getTimestamp("data_richiesta"));
        return r;
    }
}