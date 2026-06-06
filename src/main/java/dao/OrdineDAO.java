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
    
    public java.util.List<model.Ordine> getOrdiniPerUtente(int idUtente) {
        java.util.List<model.Ordine> listaOrdini = new java.util.ArrayList<>();
        
        String queryOrdini = "SELECT * FROM ordini WHERE id_utente = ? ORDER BY data_ordine DESC";
        String queryDettagli = "SELECT d.*, p.nome AS nome_prodotto FROM dettaglio_ordini d " +
                               "JOIN prodotti p ON d.id_prodotto = p.id WHERE d.id_ordine = ?";

        Connection conn = null;
        PreparedStatement psOrdini = null;
        ResultSet rsOrdini = null;

        try {
            conn = getConnection(); 
            psOrdini = conn.prepareStatement(queryOrdini);
            psOrdini.setInt(1, idUtente);
            rsOrdini = psOrdini.executeQuery();

            while (rsOrdini.next()) {
                model.Ordine ordine = new model.Ordine();
                ordine.setId(rsOrdini.getInt("id"));
                ordine.setIdUtente(rsOrdini.getInt("id_utente"));
                ordine.setDataOrdine(rsOrdini.getTimestamp("data_ordine"));
                ordine.setTotale(rsOrdini.getDouble("totale"));
                ordine.setIndirizzo(rsOrdini.getString("indirizzo"));
                ordine.setCitta(rsOrdini.getString("citta"));
                ordine.setCap(rsOrdini.getString("cap"));
                ordine.setMetodoPagamento(rsOrdini.getString("metodo_pagamento"));
                ordine.setStato(rsOrdini.getString("stato"));

                // Per ogni ordine, andiamo a caricare i suoi dettagli (i prodotti comprati)
                java.util.List<model.DettaglioOrdine> dettagli = new java.util.ArrayList<>();
                try (PreparedStatement psDettagli = conn.prepareStatement(queryDettagli)) {
                    psDettagli.setInt(1, ordine.getId());
                    try (ResultSet rsDettagli = psDettagli.executeQuery()) {
                        while (rsDettagli.next()) {
                            model.DettaglioOrdine det = new model.DettaglioOrdine();
                            det.setIdOrdine(rsDettagli.getInt("id_ordine"));
                            det.setIdProdotto(rsDettagli.getInt("id_prodotto"));
                            det.setNomeProdotto(rsDettagli.getString("nome_prodotto"));
                            det.setQuantita(rsDettagli.getInt("quantita"));
                            det.setPrezzoAcquisto(rsDettagli.getDouble("prezzo_acquisto"));
                            dettagli.add(det);
                        }
                    }
                }
                
                ordine.setDettagli(dettagli); // Agganciamo i prodotti estratti all'ordine corrente
                listaOrdini.add(ordine);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rsOrdini != null) rsOrdini.close();
                if (psOrdini != null) psOrdini.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return listaOrdini;
    }
    
    // PER UTENTE ADMIN
    public java.util.List<model.Ordine> getOrdiniPerAdminFiltri(String dataInizio, String dataFine, String idCliente) {
        java.util.List<model.Ordine> listaOrdini = new java.util.ArrayList<>();
        
        StringBuilder queryBase = new StringBuilder("SELECT o.*, u.email FROM ordini o JOIN utenti u ON o.id_utente = u.id WHERE 1=1 ");
        
        if (dataInizio != null && !dataInizio.trim().isEmpty()) { queryBase.append("AND o.data_ordine >= ? "); }
        if (dataFine != null && !dataFine.trim().isEmpty()) { queryBase.append("AND o.data_ordine <= ? "); }
        if (idCliente != null && !idCliente.trim().isEmpty()) { queryBase.append("AND o.id_utente = ? "); }
        queryBase.append("ORDER BY o.data_ordine DESC");

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(queryBase.toString())) {
            
            int index = 1;
            if (dataInizio != null && !dataInizio.trim().isEmpty()) { ps.setString(index++, dataInizio + " 00:00:00"); }
            if (dataFine != null && !dataFine.trim().isEmpty()) { ps.setString(index++, dataFine + " 23:59:59"); }
            if (idCliente != null && !idCliente.trim().isEmpty()) { ps.setInt(index++, Integer.parseInt(idCliente)); }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    model.Ordine ordine = new model.Ordine();
                    ordine.setId(rs.getInt("id"));
                    ordine.setIdUtente(rs.getInt("id_utente"));
                    ordine.setDataOrdine(rs.getTimestamp("data_ordine"));
                    ordine.setTotale(rs.getDouble("totale"));
                    ordine.setIndirizzo(rs.getString("indirizzo") + ", " + rs.getString("citta"));
                    ordine.setMetodoPagamento(rs.getString("metodo_pagamento"));
                    ordine.setStato(rs.getString("stato"));
                    
                    ordine.setCap(rs.getString("email")); 
                    listaOrdini.add(ordine);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaOrdini;
    }
}