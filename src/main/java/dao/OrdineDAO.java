package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import model.Carrello;
import model.ItemCarrello;

public class OrdineDAO {

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

    public boolean salvaOrdine(int idUtente, double totale, String indirizzo, String citta, String cap, String metodoPagamento, Carrello carrello) {
        String queryOrdine = "INSERT INTO ordini (id_utente, totale, indirizzo, citta, cap, metodo_pagamento) VALUES (?, ?, ?, ?, ?, ?)";
        String queryDettaglio = "INSERT INTO dettaglio_ordini (id_ordine, id_prodotto, quantita, prezzo_acquisto) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement psOrdine = null;
        PreparedStatement psDettaglio = null;
        ResultSet rsKeys = null;

        try {
            conn = getConnection();
            
            conn.setAutoCommit(false); 

            // 1. INSERIMENTO DELL'ORDINE PRINCIPALE
            psOrdine = conn.prepareStatement(queryOrdine, Statement.RETURN_GENERATED_KEYS);
            psOrdine.setInt(1, idUtente);
            psOrdine.setDouble(2, totale);
            psOrdine.setString(3, indirizzo);
            psOrdine.setString(4, citta);
            psOrdine.setString(5, cap);
            psOrdine.setString(6, metodoPagamento);

            int righeOrdine = psOrdine.executeUpdate();
            if (righeOrdine == 0) {
                throw new SQLException("Impossibile salvare la testa dell'ordine.");
            }

            rsKeys = psOrdine.getGeneratedKeys();
            int idOrdineGenerato = 0;
            if (rsKeys.next()) {
                idOrdineGenerato = rsKeys.getInt(1);
            } else {
                throw new SQLException("Errore nel recupero dell'ID ordine.");
            }

            // 2. INSERIMENTO DEI DETTAGLI DEI PRODOTTI
            psDettaglio = conn.prepareStatement(queryDettaglio);
            
            for (ItemCarrello item : carrello.getItems()) {
                psDettaglio.setInt(1, idOrdineGenerato);
                psDettaglio.setInt(2, item.getProdotto().getId());
                psDettaglio.setInt(3, item.getQuantita());
                psDettaglio.setDouble(4, item.getProdotto().getPrezzo()); 
                
                psDettaglio.addBatch(); 
            }

            psDettaglio.executeBatch();

        
            conn.commit();
            System.out.println("Ordine #" + idOrdineGenerato + " salvato con successo nel DB.");
            return true;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    System.err.println("Errore durante il checkout. Eseguo il ROLLBACK della transazione.");
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rsKeys != null) rsKeys.close();
                if (psOrdine != null) psOrdine.close();
                if (psDettaglio != null) psDettaglio.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}