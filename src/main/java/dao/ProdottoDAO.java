package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import model.Prodotto;

public class ProdottoDAO {

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
	
    /**
     * Recupera tutti i prodotti (mobili pronti) presenti nel database
     * @return List<Prodotto> una lista di oggetti Prodotto
     */
	public List<Prodotto> getAllProdotti() {
        List<Prodotto> listaProdotti = new ArrayList<>();
        String query = "SELECT * FROM prodotti WHERE eliminato = false"; 

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setId(rs.getInt("id"));
                prodotto.setNome(rs.getString("nome"));
                prodotto.setDescrizione(rs.getString("descrizione"));
                prodotto.setPrezzo(rs.getDouble("prezzo"));
                prodotto.setQuantitaMagazzino(rs.getInt("quantita_magazzino"));
                prodotto.setImmagineUrl(rs.getString("immagine_url"));
                prodotto.setCategoria(rs.getString("categoria"));
                listaProdotti.add(prodotto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaProdotti;
    }

    
    // Recupera un singolo prodotto in base al suo ID
    public Prodotto getProdottoById(int id) {
        Prodotto prodotto = null;
        String query = "SELECT * FROM prodotti WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id); // Sostituisce il primo punto interrogativo con l'id passato come parametro
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    prodotto = new Prodotto();
                    prodotto.setId(rs.getInt("id"));
                    prodotto.setNome(rs.getString("nome"));
                    prodotto.setDescrizione(rs.getString("descrizione"));
                    prodotto.setPrezzo(rs.getDouble("prezzo"));
                    prodotto.setQuantitaMagazzino(rs.getInt("quantita_magazzino"));
                    prodotto.setImmagineUrl(rs.getString("immagine_url"));
                    prodotto.setCategoria(rs.getString("categoria"));
                }
            }

        } catch (SQLException e) {
            System.err.println("Errore nel metodo getProdottoById di ProdottoDAO:");
            e.printStackTrace();
        }

        return prodotto;
    }
    
    public List<Prodotto> cercaProdotti(String parolaChiave) {
        List<Prodotto> listaRisultati = new ArrayList<>();
      
        String query = "SELECT * FROM prodotti WHERE (nome LIKE ? OR descrizione LIKE ? OR categoria LIKE ?) AND eliminato = false";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
        		
        		// Il simbolo % indica al DB di cercare la parola in qualsiasi posizione (inizio, centro, fine)
            String parametroRicerca = "%" + parolaChiave + "%";
            ps.setString(1, parametroRicerca);
            ps.setString(2, parametroRicerca);
            ps.setString(3, parametroRicerca);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setDescrizione(rs.getString("descrizione"));
                    p.setPrezzo(rs.getDouble("prezzo"));
                    p.setCategoria(rs.getString("categoria"));
                    listaRisultati.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaRisultati;
    }
    
    public List<Prodotto> getProdottiPerCategoria(String categoria) {
        List<Prodotto> lista = new ArrayList<>();
        String query;
    
        // Se la categoria è nulla o vuota, mostriamo A PRIORI tutti i prodotti
        boolean mostraTutto = (categoria == null || categoria.trim().isEmpty());
        
        if (mostraTutto) {
            query = "SELECT * FROM prodotti WHERE eliminato = false";
        } else {
            query = "SELECT * FROM prodotti WHERE LOWER(categoria) = LOWER(?) AND eliminato = false";
        }

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            if (!mostraTutto) {
                ps.setString(1, categoria.trim());
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setDescrizione(rs.getString("descrizione"));
                    p.setPrezzo(rs.getDouble("prezzo"));
                    p.setCategoria(rs.getString("categoria"));
                    lista.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    
    // METODI PER ADMIN
    public boolean inserisciProdotto(model.Prodotto p) {
        String query = "INSERT INTO prodotti (nome, descrizione, prezzo, quantita_magazzino, immagine_url, categoria) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, p.getNome());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrezzo());
            ps.setInt(4, p.getQuantitaMagazzino());
            ps.setString(5, p.getImmagineUrl());
            ps.setString(6, p.getCategoria());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean modificaProdotto(model.Prodotto p) {
        String query = "UPDATE prodotti SET nome=?, descrizione=?, prezzo=?, quantita_magazzino=?, immagine_url=?, categoria=? WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, p.getNome());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrezzo());
            ps.setInt(4, p.getQuantitaMagazzino());
            ps.setString(5, p.getImmagineUrl());
            ps.setString(6, p.getCategoria());
            ps.setInt(7, p.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminaProdotto(int id) {
        String query = "UPDATE prodotti SET eliminato = true WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
}