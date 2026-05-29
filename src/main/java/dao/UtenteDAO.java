package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import model.Utente;

public class UtenteDAO {

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

	public boolean registraUtente(Utente utente) {
	    String query = "INSERT INTO utenti (nome, cognome, email, password) VALUES (?, ?, ?, ?)";
	    
	    try (Connection con = getConnection();
	         PreparedStatement ps = con.prepareStatement(query)) {
	        
	        ps.setString(1, utente.getNome());
	        ps.setString(2, utente.getCognome());
	        ps.setString(3, utente.getEmail());
	        ps.setString(4, utente.getPassword());
	        
	        int righeModificate = ps.executeUpdate();
	        return righeModificate > 0; // Restituisce true se ha inserito la riga con successo
	        
	    } catch (SQLException e) {
	        System.err.println("Errore nel DAO durante l'inserimento dell'utente:");
	        e.printStackTrace();
	        return false;
	    }
	}

    
    public Utente login(String email, String password) {
        Utente utenteLoggato = null;
        String query = "SELECT * FROM utenti WHERE email = ? AND password = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    utenteLoggato = new Utente();
                    utenteLoggato.setId(rs.getInt("id"));
                    utenteLoggato.setNome(rs.getString("nome"));
                    utenteLoggato.setCognome(rs.getString("cognome"));
                    utenteLoggato.setEmail(rs.getString("email"));
                    utenteLoggato.setPassword(rs.getString("password"));
                    utenteLoggato.setRuolo(rs.getString("ruolo"));
                }
            }

        } catch (SQLException e) {
            System.err.println("Errore in UtenteDAO.login:");
            e.printStackTrace();
        }

        return utenteLoggato;
    }
    
    public Utente verificaLogin(String email, String password) {
        Utente utenteLoggato = null;
        
        // Query SQL: Cerca una riga che abbia esattamente quell'email e quella password
        // (Attenzione: cambia "utenti" se la tua tabella si chiama "utente")
        String query = "SELECT * FROM utenti WHERE email = ? AND password = ?";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            // Inseriamo i parametri al posto dei punti interrogativi (?)
            ps.setString(1, email);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                // Se rs.next() è vero, significa che ha trovato una corrispondenza nel DB!
                if (rs.next()) {
                    utenteLoggato = new Utente();
                    
                    // Mappiamo i dati dal Database all'oggetto Java
                    utenteLoggato.setId(rs.getInt("id"));
                    utenteLoggato.setNome(rs.getString("nome"));
                    utenteLoggato.setCognome(rs.getString("cognome"));
                    utenteLoggato.setEmail(rs.getString("email"));
                    
                    // Se nel database hai anche una colonna per il ruolo (admin/user)
                    // per proteggere le pagine, scommenta questa riga:
                    // utenteLoggato.setRuolo(rs.getString("ruolo"));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Errore nel DAO durante la verifica del login:");
            e.printStackTrace();
        }
        
        // Se tutto è andato bene restituisce l'utente, altrimenti restituisce null (login fallito)
        return utenteLoggato;
    }
    
    
}