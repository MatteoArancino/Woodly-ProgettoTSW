package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Prodotto;
import util.DBConnection;

public class ProdottoDAO {

    /**
     * Recupera tutti i prodotti (mobili pronti) presenti nel database
     * @return List<Prodotto> una lista di oggetti Prodotto
     */
    public List<Prodotto> getAllProdotti() {
        List<Prodotto> listaProdotti = new ArrayList<>();
        String query = "SELECT * FROM prodotti";


        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                
                // Prendiamo i dati dalle colonne del DB (usando i nomi esatti delle tabelle)
                prodotto.setId(rs.getInt("id"));
                prodotto.setNome(rs.getString("nome"));
                prodotto.setDescrizione(rs.getString("descrizione"));
                prodotto.setPrezzo(rs.getDouble("prezzo"));
                prodotto.setQuantitaMagazzino(rs.getInt("quantita_magazzino"));
                prodotto.setImmagineUrl(rs.getString("immagine_url"));
                prodotto.setCategoria(rs.getString("categoria"));

                // Aggiungiamo il prodotto appena creato alla lista
                listaProdotti.add(prodotto);
            }

        } catch (SQLException e) {
            System.err.println("Errore nel metodo getAllProdotti di ProdottoDAO:");
            e.printStackTrace();
        }

        return listaProdotti;
    }

    /**
     * Recupera un singolo prodotto in base al suo ID
     */
    public Prodotto getProdottoById(int id) {
        Prodotto prodotto = null;
        String query = "SELECT * FROM prodotti WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
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
        // Query con operatore LIKE per una ricerca flessibile
        String query = "SELECT * FROM prodotti WHERE nome LIKE ? OR descrizione LIKE ? OR categoria LIKE ?";

        try (Connection conn = DBConnection.getConnection();
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
                    // Se hai altri campi nel costruttore/proprietà del tuo modello inseriscili qui
                    
                    listaRisultati.add(p);
                }
            }
        } catch (SQLException e) {
            System.err.println("Errore in ProdottoDAO.cercaProdotti:");
            e.printStackTrace();
        }
        return listaRisultati;
    }
}