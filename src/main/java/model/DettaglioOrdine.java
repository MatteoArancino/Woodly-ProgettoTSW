package model;

public class DettaglioOrdine {
    private int idOrdine;
    private int idProdotto;
    private String nomeProdotto; 
    private int quantita;
    private double prezzoAcquisto;

    // Getters e Setters
    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }

    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }

    public String getNomeProdotto() { return nomeProdotto; }
    public void setNomeProdotto(String nomeProdotto) { this.nomeProdotto = nomeProdotto; }

    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita; }

    public double getPrezzoAcquisto() { return prezzoAcquisto; }
    public void setPrezzoAcquisto(double prezzoAcquisto) { this.prezzoAcquisto = prezzoAcquisto; }
}