package model;

import java.io.Serializable;

/**
 * Classe Model che rappresenta un mobile (prodotto pronto) nel catalogo di Woodly.
 */
public class Prodotto implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String nome;
    private String descrizione;
    private double prezzo; 
    private int quantitaMagazzino;
    private String immagineUrl;
    private String categoria;

   
    public Prodotto() {
    }

    public Prodotto(int id, String nome, String descrizione, double prezzo, int quantitaMagazzino, String immagineUrl, String categoria) {
        this.id = id;
        this.nome = nome;
        this.descrizione = descrizione;
        this.prezzo = prezzo;
        this.quantitaMagazzino = quantitaMagazzino;
        this.immagineUrl = immagineUrl;
        this.categoria = categoria;
    }

    public Prodotto(String nome, String descrizione, double prezzo, int quantitaMagazzino, String immagineUrl, String categoria) {
        this.nome = nome;
        this.descrizione = descrizione;
        this.prezzo = prezzo;
        this.quantitaMagazzino = quantitaMagazzino;
        this.immagineUrl = immagineUrl;
        this.categoria = categoria;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescription() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public double getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(double prezzo) {
        this.prezzo = prezzo;
    }

    public int getQuantitaMagazzino() {
        return quantitaMagazzino;
    }

    public void setQuantitaMagazzino(int quantitaMagazzino) {
        this.quantitaMagazzino = quantitaMagazzino;
    }

    public String getImmagineUrl() {
        return immagineUrl;
    }

    public void setImmagineUrl(String immagineUrl) {
        this.immagineUrl = immagineUrl;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    @Override
    public String toString() {
        return "Prodotto [id=" + id + ", nome=" + nome + ", prezzo=" + prezzo + ", quantita=" + quantitaMagazzino + ", categoria=" + categoria + "]";
    }
}