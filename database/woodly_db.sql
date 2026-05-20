-- 1. Creazione del database
CREATE DATABASE IF NOT EXISTS woodly_db;
USE woodly_db;

-- 2. Tabella Utenti (Clienti e Amministratori)
CREATE TABLE utenti (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- Qui andrà salvata la password criptata
    ruolo ENUM('admin', 'cliente') DEFAULT 'cliente',
    data_registrazione DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabella Prodotti (I mobili già pronti in catalogo)
CREATE TABLE prodotti (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descrizione TEXT,
    prezzo DECIMAL(10,2) NOT NULL, -- Formato perfetto per la valuta (es. 1250.50)
    quantita_magazzino INT DEFAULT 0,
    immagine_url VARCHAR(255),
    categoria VARCHAR(50) -- es. 'Tavoli', 'Sedie', 'Armadi'
);

-- 4. Tabella Ordini (Lo storico degli acquisti dei mobili pronti)
CREATE TABLE ordini (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_utente INT NOT NULL,
    data_ordine DATETIME DEFAULT CURRENT_TIMESTAMP,
    totale DECIMAL(10,2) NOT NULL,
    stato ENUM('In elaborazione', 'Spedito', 'Consegnato', 'Annullato') DEFAULT 'In elaborazione',
    FOREIGN KEY (id_utente) REFERENCES utenti(id) ON DELETE CASCADE
);

-- 5. Tabella Dettaglio Ordini (Cosa c'è dentro ogni ordine)
CREATE TABLE dettaglio_ordini (
    id_ordine INT NOT NULL,
    id_prodotto INT NOT NULL,
    quantita INT NOT NULL,
    prezzo_acquisto DECIMAL(10,2) NOT NULL, -- Congela il prezzo al momento dell'acquisto
    PRIMARY KEY (id_ordine, id_prodotto),
    FOREIGN KEY (id_ordine) REFERENCES ordini(id) ON DELETE CASCADE,
    FOREIGN KEY (id_prodotto) REFERENCES prodotti(id)
);

-- 6. Tabella Richieste su Misura (I preventivi personalizzati)
CREATE TABLE richieste_su_misura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_utente INT NOT NULL,
    tipo_mobile VARCHAR(100) NOT NULL, -- es. 'Libreria angolare'
    altezza_cm INT NOT NULL,
    larghezza_cm INT NOT NULL,
    profondita_cm INT NOT NULL,
    materiale VARCHAR(100) NOT NULL, -- es. 'Legno di Quercia'
    note_cliente TEXT,
    prezzo_proposto DECIMAL(10,2) DEFAULT NULL, -- L'admin lo compilerà dopo aver valutato
    stato ENUM('In attesa', 'Preventivo inviato', 'Accettato', 'Rifiutato') DEFAULT 'In attesa',
    data_richiesta DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_utente) REFERENCES utenti(id) ON DELETE CASCADE
);