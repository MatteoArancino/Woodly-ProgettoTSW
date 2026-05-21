package model;

import java.io.Serializable;

public class Utente implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String nome;
    private String cognome;
    private String email;
    private String password;
    private String ruolo; // Es: "admin" per te, "cliente" per gli utenti normali

    // 1. Costruttore vuoto (standard JavaBean)
    public Utente() {
    }

    // 2. Costruttore completo (per gli utenti estratti dal DB durante il Login)
    public Utente(int id, String nome, String cognome, String email, String password, String ruolo) {
        this.id = id;
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.password = password;
        this.ruolo = ruolo;
    }

    // 3. Costruttore senza ID e ruolo (per la Registrazione di un nuovo cliente)
    public Utente(String nome, String cognome, String email, String password) {
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.password = password;
        this.ruolo = "cliente"; // Ruolo di default per i nuovi iscritti
    }

    // --- Getter e Setter ---

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getCognome() { return cognome; }
    public void setCognome(String cognome) { this.cognome = cognome; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRuolo() { return ruolo; }
    public void setRuolo(String ruolo) { this.ruolo = ruolo; }

    @Override
    public String toString() {
        return "Utente [id=" + id + ", nome=" + nome + ", email=" + email + ", ruolo=" + ruolo + "]";
    }
}