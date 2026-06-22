# Woodly 🪵 - E-commerce di Arredamento in Vero Legno Massello
**Woodly** è una piattaforma e-commerce completa per la vendita e la personalizzazione di mobili in legno massello di alta qualità. 
Il progetto è stato sviluppato come elaborato d'esame per il corso di **Tecnologie Software per il Web (TSW)** presso l'Università degli Studi di Salerno.
L'applicazione segue l'architettura **MVC (Model-View-Controller)**, sfruttando le tecnologie di Java Enterprise Edition (Servlet e JSP) senza l'ausilio di framework esterni (es. Spring), come richiesto dalle specifiche del corso.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Informazioni
* **Università:** Università degli Studi di Salerno (UNISA)
* **Dipartimento:** Dipartimento di Informatica
* **Corso di Laurea:** Laurea Triennale in Informatica
* **Materia di Corso:** Tecnologie Software per il Web
* **Studente:** Matteo Arancino

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Funzionalità Principali
L'applicazione si divide in tre macro-aree di utilizzo a seconda della tipologia di utente:

### 1. Area Pubblica (Guest)
* **Home Page:** Interfaccia moderna con Hero Section fotografica e testi ad alto contrasto.
* **Catalogo Prodotti:** Navigazione e visualizzazione di tutti i mobili disponibili con filtri di ricerca dedicati.
* **Gestione Carrello:** Aggiunta, rimozione, svuotamento e modifica in tempo reale della quantità dei prodotti in sessione, con layout responsive.
* **Richiesta Preventivo:** Form per l'invio di richieste personalizzate per mobili su misura.
* **Checkout:** Procedura guidata di acquisto simulato con pagina di conferma ordine.

### 2. Area Utente Autenticato
* **Autenticazione:** Sistema di Login e Registrazione con controllo dei dati e Servlet di verifica email.
* **Area Personale:** Gestione del proprio profilo, storico degli ordini effettuati e monitoraggio dello stato delle richieste di preventivo.

### 3. Pannello di Amministrazione (Admin)
* **Dashboard Centrale:** Divisione in categoria delle funzioni.
* **Gestione Catalogo:** CRUD completo (Creazione, Lettura, Aggiornamento, Eliminazione) dei prodotti a catalogo.
* **Monitoraggio Ordini:** Controllo in tempo reale di tutti gli acquisti effettuati dagli utenti.
* **Gestione Richieste:** Lettura e gestione avanzata con vista di dettaglio per le richieste di preventivo su misura inviate dai clienti.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Tecnologie e Architettura utilizzate
* **Backend:** Java SE & Java EE 
* **Frontend:** HTML5, CSS, JavaScript
* **Database:** MySQL (Struttura relazionale con approccio DAO/DataSource)
* **Server delle Servlet:** Apache Tomcat (v9.0 o superiori)
* **Pattern Architetturale:** Model-View-Controller (MVC)
  * **Model:** Classi Java (Bean) per rappresentare le entità e classi DAO per l'interazione con il DB tramite JDBC.
  * **View:** Pagine `.jsp` memorizzate in `/WEB-INF/view/` per garantire la massima sicurezza ed impedire l'accesso diretto via URL.
  * **Controller:** Servlet Java che gestiscono il flusso di navigazione e le chiamate tramite richieste GET e POST.
