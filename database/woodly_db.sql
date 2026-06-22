-- 1. Creazione del database
DROP SCHEMA woodly_db;
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
    categoria VARCHAR(50), -- es. 'Tavoli', 'Sedie', 'Armadi'
    eliminato BOOLEAN DEFAULT FALSE
);

-- 4. Tabella Ordini (Lo storico degli acquisti dei mobili pronti)
CREATE TABLE ordini (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_utente INT NOT NULL,
    data_ordine DATETIME DEFAULT CURRENT_TIMESTAMP,
    totale DECIMAL(10,2) NOT NULL,
    indirizzo VARCHAR(255) NOT NULL,
    citta VARCHAR(100) NOT NULL,
    cap VARCHAR(10) NOT NULL,
    metodo_pagamento VARCHAR(50) NOT NULL,
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

-- 7, Tabella Carrello Persistente (Per mantenere gli articoli tra le sessioni)
CREATE TABLE carrello_salvato (
    id_utente INT,
    id_prodotto INT,
    quantita INT NOT NULL,
    PRIMARY KEY (id_utente, id_prodotto),
    FOREIGN KEY (id_utente) REFERENCES utenti(id) ON DELETE CASCADE,
    FOREIGN KEY (id_prodotto) REFERENCES prodotti(id) ON DELETE CASCADE
);

-- 1. Popoliamo la tabella UTENTI
INSERT INTO utenti (nome, cognome, email, password, ruolo) VALUES 
('Mastro', 'Geppetto', 'admin@woodly.it', 'hash_password_admin_123', 'admin'), 
('Mario', 'Rossi', 'mario.rossi@email.com', 'hash_password_mario_456', 'cliente'),
('Giulia', 'Bianchi', 'giulia.b@email.com', 'hash_password_giulia_789', 'cliente'),
('Luca', 'Verdi', 'luca.verdi@email.com', 'hash_password_luca_012', 'cliente');

-- 2. Popoliamo la tabella PRODOTTI (Il catalogo Woodly)
INSERT INTO prodotti (nome, descrizione, prezzo, quantita_magazzino, immagine_url, categoria) VALUES 
('Tavolo in Rovere Massello', 'Tavolo da pranzo in puro rovere massello, finitura a olio naturale. Dimensioni: 160x90 cm.', 849.99, 5, 'images/tavolo_rovere.png', 'Tavoli'),
('Sedia in Noce Minimal', 'Sedia dal design moderno e pulito, realizzata in legno di noce. Seduta ergonomica.', 120.99, 24, 'images/sedia_noce.png', 'Sedie'),
('Libreria a Parete "Albero"', 'Libreria componibile con ripiani sfalsati in legno di frassino. Altezza 2 metri.', 449.99, 3, 'images/libreria_frassino.png', 'Librerie'),
('Cassettiera Vintage', 'Cassettiera a 4 cassetti in legno di recupero spazzolato. Stile rustico-chic.', 399.99, 8, 'images/cassettiera_vintage.png', 'Mobili da camera'),
('Tavolino da Salotto "Goccia"', 'Tavolino basso con piano a forma di goccia in legno di ciliegio e gambe in metallo nero.', 179.99, 12, 'images/tavolino_ciliegio.png', 'Tavoli'),
('Topolino "DoppioGoccia"', 'Tavolino basso con piano a forma di goccia in legno di ciliegio e gambe in metallo nero.', 169.99, 12, null, 'Tavoli');

-- 3. Popoliamo un ordine di prova per i test
INSERT INTO ordini (id_utente, totale, indirizzo, citta, cap, metodo_pagamento, stato) VALUES 
(2, 1091.00, 'Via Roma 1', 'Milano', '20100', 'PayPal', 'Consegnato');

INSERT INTO dettaglio_ordini (id_ordine, id_prodotto, quantita, prezzo_acquisto) VALUES 
(1, 1, 1, 849.99),  
(1, 2, 2, 199.99);  

-- 4. Inseriamo una richiesta su misura di prova
INSERT INTO richieste_su_misura (id_utente, tipo_mobile, altezza_cm, larghezza_cm, profondita_cm, materiale, note_cliente, stato) VALUES 
(3, 'Armadio a muro a 4 ante', 280, 200, 60, 'Pino svedese', 'Vorrei le ante senza maniglie con sistema push-pull e una cassettiera interna.', 'In attesa');

SELECT * FROM Utenti; 
SELECT * FROM ordini;
SELECT * FROM dettaglio_ordini;
select * FROM carrello_salvato;