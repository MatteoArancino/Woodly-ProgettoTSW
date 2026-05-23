package model;

import java.util.ArrayList;
import java.util.List;

public class Carrello {
    private List<ItemCarrello> items;

    public Carrello() {
        this.items = new ArrayList<>();
    }

    public List<ItemCarrello> getItems() {
        return items;
    }

    public void aggiungiProdotto(Prodotto p, int quantita) {
        for (ItemCarrello item : items) {
            if (item.getProdotto().getId() == p.getId()) {
                item.incrementaQuantita(quantita);
                return; // Prodotto trovato e aggiornato, usciamo dal metodo
            }
        }
        items.add(new ItemCarrello(p, quantita));
    }

    public void rimuoviProdotto(int idProdotto) {
        items.removeIf(item -> item.getProdotto().getId() == idProdotto);
    }

    public double getPrezzoTotaleCarrello() {
        double totale = 0;
        for (ItemCarrello item : items) {
            totale += item.getPrezzoTotaleItem();
        }
        return totale;
    }

    public void svuota() {
        items.clear();
    }
    
    public int getQuantitaTotale() {
        int totale = 0;
        for (ItemCarrello item : items) {
            totale += item.getQuantita();
        }
        return totale;
    }
}