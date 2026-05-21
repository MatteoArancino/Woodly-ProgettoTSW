package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Utente;
import util.DBConnection;

public class UtenteDAO {


    public boolean registraUtente(Utente u) {
        boolean inserito = false;
        String query = "INSERT INTO utenti (nome, cognome, email, password, ruolo) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, u.getNome());
            ps.setString(2, u.getCognome());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword());
            ps.setString(5, u.getRuolo()); // Di base sarà "cliente"

            int righeModificate = ps.executeUpdate();
            if (righeModificate > 0) {
                inserito = true;
            }

        } catch (SQLException e) {
            System.err.println("Errore in UtenteDAO.registraUtente:");
            e.printStackTrace();
        }

        return inserito;
    }

    
    public Utente login(String email, String password) {
        Utente utenteLoggato = null;
        String query = "SELECT * FROM utenti WHERE email = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
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
}