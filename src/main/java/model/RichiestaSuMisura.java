package model; 

import java.sql.Timestamp;

public class RichiestaSuMisura {
    
    private int id;
    private int idUtente;
    private String tipoMobile;
    private int altezzaCm;
    private int larghezzaCm;
    private int profonditaCm;
    private String materiale;
    private String noteCliente;
    private Double prezzoProposto; 
    private String stato;
    private Timestamp dataRichiesta;
    private String nomeUtente;
    private String cognomeUtente;
  
    public RichiestaSuMisura() {
    }

    // --- Getters e Setters ---
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public String getTipoMobile() {
        return tipoMobile;
    }

    public void setTipoMobile(String tipoMobile) {
        this.tipoMobile = tipoMobile;
    }

    public int getAltezzaCm() {
        return altezzaCm;
    }

    public void setAltezzaCm(int altezzaCm) {
        this.altezzaCm = altezzaCm;
    }

    public int getLarghezzaCm() {
        return larghezzaCm;
    }

    public void setLarghezzaCm(int larghezzaCm) {
        this.larghezzaCm = larghezzaCm;
    }

    public int getProfonditaCm() {
        return profonditaCm;
    }

    public void setProfonditaCm(int profonditaCm) {
        this.profonditaCm = profonditaCm;
    }

    public String getMateriale() {
        return materiale;
    }

    public void setMateriale(String materiale) {
        this.materiale = materiale;
    }

    public String getNoteCliente() {
        return noteCliente;
    }

    public void setNoteCliente(String noteCliente) {
        this.noteCliente = noteCliente;
    }

    public Double getPrezzoProposto() {
        return prezzoProposto;
    }

    public void setPrezzoProposto(Double prezzoProposto) {
        this.prezzoProposto = prezzoProposto;
    }

    public String getStato() {
        return stato;
    }

    public void setStato(String stato) {
        this.stato = stato;
    }

    public Timestamp getDataRichiesta() {
        return dataRichiesta;
    }

    public void setDataRichiesta(Timestamp dataRichiesta) {
        this.dataRichiesta = dataRichiesta;
    }

    public String getNomeUtente() {
        return nomeUtente;
    }

    public void setNomeUtente(String nomeUtente) {
        this.nomeUtente = nomeUtente;
    }

    public String getCognomeUtente() {
        return cognomeUtente;
    }

    public void setCognomeUtente(String cognomeUtente) {
        this.cognomeUtente = cognomeUtente;
    }
}