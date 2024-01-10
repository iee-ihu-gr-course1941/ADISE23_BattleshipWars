# ADISE23_LUDO_GAME
Table of Contents
=================
   * [Εγκατάσταση](#εγκατάσταση)
      * [Απαιτήσεις](#απαιτήσεις)
      * [Οδηγίες Εγκατάστασης](#οδηγίες-εγκατάστασης)
   * [Περιγραφή API](#περιγραφή-api)
      * [Methods](#methods)
         * [Board](#board)
            * [Ανάγνωση Board](#ανάγνωση-board)
            * [Αρχικοποίηση Board](#αρχικοποίηση-board)
         * [Piece](#piece)
            * [Ανάγνωση Θέσης/Πιονιού](#ανάγνωση-θέσηςπιονιού)
            * [Μεταβολή Θέσης Πιονιού](#μεταβολή-θέσης-πιονιού)
         * [Player](#player)
            * [Ανάγνωση στοιχείων παίκτη](#ανάγνωση-στοιχείων-παίκτη)
            * [Καθορισμός στοιχείων παίκτη](#καθορισμός-στοιχείων-παίκτη)
         * [Status](#status)
            * [Ανάγνωση κατάστασης παιχνιδιού](#ανάγνωση-κατάστασης-παιχνιδιού)
      * [Entities](#entities)
         * [Board](#board-1)
         * [Players](#players)
         * [Game_status](#game_status)


# Demo Page

Μπορείτε να κατεβάσετε τοπικά ή να επισκευτείτε την σελίδα: 
https://users.iee.ihu.gr/~asidirop/adise21/Lectures21-chess/



# Εγκατάσταση

## Απαιτήσεις

* Apache2
* Mysql Server
* php

## Οδηγίες Εγκατάστασης

 * Κάντε clone το project σε κάποιον φάκελο <br/>
  `$ git clone https://github.com/iee-ihu-gr-course1941/ADISE23_LUDO_GAME.git`
  

 * Βεβαιωθείτε ότι ο φάκελος είναι προσβάσιμος από τον Apache Server. πιθανόν να χρειαστεί να καθορίσετε τις παρακάτω ρυθμίσεις.

 * Θα πρέπει να δημιουργήσετε στην Mysql την βάση με όνομα 'adise23_ludo_game' και να φορτώσετε σε αυτήν την βάση τα δεδομένα από το αρχείο schema.sql

 * Θα πρέπει να φτιάξετε το αρχείο lib/config_local.php το οποίο να περιέχει:
```
    <?php
	$DB_PASS = 'κωδικός';
	$DB_USER = 'όνομα χρήστη';
    ?>
```

# Περιγραφή Παιχνιδιού

Το γκρινιάρης παίζεται ως εξής: Στην αρχή του παιχνιδιού ο κάθε παίκτης παίρνει 4 φιγούρες του ίδιου χρώματος, οι οποίες τοποθετούνται στη βάση του(ίδιου χρώματος).Ο κάθε παίκτης όταν έρχεται η σειρά του, ρίχνει το ζάρι και μετακινεί την φιγούρα του τόσα τετραγωνάκια όσα δείχνει ο αριθμός τον οποίο έφερε στο ζάρι ή εναλλακτικά βγάζει απο την αφετηρία του ένα άλλο πιόνι. Αφού κάνει   όλο το γύρο του πίνακα πάνω στα λευκά τετραγωνάκια, επιστρέφει στην Αφετηρία του και τοποθετεί τις φιγούρες του στα εσωτερικά τετραγωνάκια ασφαλείας του χρώματός του.

Οι κανόνες είναι οι εξης: 
Εάν τώρα ένας παίκτης ρίξει το ζάρι και η κίνησή του αυτή καταλήξει σε τετραγωνάκι στο οποίο βρίσκεται φιγούρα άλλου παίκτη,  υποχρεωτικά μεταφέρεται απο εκεί και επανατοποθετείται πίσω στη βάση του.

Εάν τώρα ένας παίκτης ρίξει το ζάρι και η κίνησή του αυτή καταλήξει σε τετραγωνάκι στο οποίο βρίσκεται φιγούρα του ίδιου του παίκτη που παίζει,η κίνηση θεωρείται παράνομη και δεν επιτρέπεται.

Όταν ολοκληρώσει 39 υπ΄αριθμόν κινήσεις τότε βγαίνει το πιόνι απο το παιχνίδι, αφού έκανε εναν ολοκληρωμένο κύκλο.

Νικητής είναι αυτός ο οποίος θα καταφέρει πρώτος να κάνει τον κύκλο και με τα 4 πιόνιο του χρώματός του.

Η βάση μας κρατάει τους εξής πίνακες και στοιχεία 
1.board 
2.board_empty 
3.blue_win_pieces 
4.dice 
5.error_log 
6.game_status 
7.green_win_pieces 
8.missing_pieces 
9.players 
10.players_empty 
11.red_win_pieces 
12.temp 
13.timer_table 
14.users 
15.yellow_win_pieces

Η εφαρμογή απαπτύχθηκε μέχρι το σημείο οπου μπορεί ο χρήστης να κανεί έναν νέο λογαριασμό ή να συνδεθεί εάν έχει ήδη, και έπειτα να παίξει με 1,2 ή 3 αντιπάλους.

Πραγματοποιείται έλεγχος ζαριάς(που γίνεται generate σε επίπεδο βάσης με την roll_diceOUT ή οποια τροφοδοτέι την roll_dice(@generated_dice_result, piece)  )

Ελεγχος κινήσεων με βάση 4 path (ενα για καθε χρώμα) στο οποίο προστίθεται ο αριθμός ζαριου και είναι πάντα διαθέσιμος για κάθε πιόνι. (Πραγματοποιείται εσωτερικα της roll_dice που γεμίζει τον πίνακα dice μέσω του οποίου βρισκουμε τις συντεταγμενες έναρξης, προορισμού και διαδρομης με βαση τα path.)

Έλεγχος ύπαρξης ίδιου ή διαφορετικού χρώματος πιονιού(αν είναι ίδιου χρώματος, η κίνηση δε πραγματοποιείται εμφανίζοντας κατάλληλο μηνυμα στον χρήστη, αλλίως γίνεται η κινηση επιστρέφοντας το πιόνι του αντιπάλου στην αρχική του θέση.)

Ελέγχος του μονοπατιού που γίνεται highlight υποδηλώνοντας τα κουτακια που διασχίζει ο παίκτης.(με την βοηθεια κατάλληλων μεθόδων που επενεργούν πάνω στις στηλες prev_path και new_path του πινακα dice, βρίσκοντας τις συντεταγμένες των τετραγωνων που θα γινει το highlight για 1''.)

Έλεγχος ολοκλήρωσης του path και απο τα 4 πιόνια, δηλαδή έλεγχος νικητή.(μέθοδος check_winner οπου ελέγχει εαν υπάρχουν 4 πιόνια στους πινακες που αποθηκεύονται τα pieces Που ολοκλήρωσαν τον κυκλο.)

Έλεγχος σειράς(32 πιθανες περιπτώσεις) αναλόγως του αριθμού των παικτων και του χρώματος τους.(check_turn : B>R>G>Y)

Έλεγχος χρόνου: το αρχικό πλάνο ηταν να γίνονται ανα 1000ms ajax calls στη βαση οπου κάνοντας χρήση των μεθόδων timer_decrease, timer_reset, timer_value που επενεργούν πανω στον πινακα timer_table Που σε καθε κληση μειώνεται κατα 1'' να εμφανίζεται στη διεπαφή. Το πρόβλημα όμως λόγω του οτι η βαση ειναι ασύγχρονη, ήταν οτι τα δευτερόλεπτα μειωνόταν γρηγοροτερα από το προσδοκόμενο, μη αφήνοντας μας επιλογή παρά να προγραμματιστει σε js.

Έλεγχος timeout: αλλαζει ή σειρά εάν περάσουν 30'' από τη ζαρία και δεν πραγματοποιηθεί κίνηση.
Έλεγχος deadlock(Εαν δεν υπάρξει κίνηση αλλάζει το status του παιχνιδιού.)

Έλεγχος αν ο χρήστης που προσπαθεί να συνδεθεί, υπάρχει ή οχι στο σύστημα.

Έλεγχος αν το χρώμα επιλογής, είναι διαθέσιμο.

Έλεγχος αν ο παίκτης ανήκει στο παιχνίδι ή οχι.

## Συντελεστές

Όλα τα μέλη τις ομάδας ασχολήθηκαν σε όλα τα επίπεδα της εφαρμογής.

 

 


# Περιγραφή API

## Methods


### Board
#### Ανάγνωση Board

```
GET /board/
```

Επιστρέφει το [Board](#Board).

#### Αρχικοποίηση Board
```
POST /board/
```

Αρχικοποιεί το Board, δηλαδή το παιχνίδι. Γίνονται reset τα πάντα σε σχέση με το παιχνίδι.
Επιστρέφει το [Board](#Board).

### Piece
#### Ανάγνωση Θέσης/Πιονιού

```
GET /board/piece/:x/:y/
```

Κάνει την κίνηση του πιονιού από την θέση x,y στην νέα θέση. Προφανώς ελέγχεται η κίνηση αν είναι νόμιμη καθώς και αν είναι η σειρά του παίκτη να παίξει με βάση το token.
Επιστρέφει τα στοιχεία από το [Board](#Board-1) με συντεταγμένες x,y.
Περιλαμβάνει το χρώμα του πιονιού και τον τύπο.

#### Μεταβολή Θέσης Πιονιού

```
PUT /board/piece/:x/:y/
```
Json Data:

| Field             | Description                 | Required   |
| ----------------- | --------------------------- | ---------- |
| `x`               | Η νέα θέση x                | yes        |
| `y`               | Η νέα θέση y                | yes        |

Επιστρέφει τα στοιχεία από το [Board](#Board-1) με συντεταγμένες x,y.
Περιλαμβάνει το χρώμα του πιονιού και τον τύπο

### Highlight
#### Επισήμανση συντεταγμένων της κίνησης 

```
GET /highlightR1?action=R1_highlight
```
**το R1 είναι παράδειγμα. Στη θέση αυτόυ θα μπορούσε να είναι το Y1,Y2,Y3,Y4,R2,R3,R4,B1,B2,B3,B4.

### ROLL DICE
#### Φόρτωση τυχαίου αριθμού απο το 1 ως το 6 

```
GET /roll/?action=roll
```
**το roll τροφοδοτει την συνάρτηση roll_dice που δέχεται ως παράμετρο το generated_dice_result και το πιόνι του οποίου επρόκειτω να υπολογιστούν οι νέες συντεταγμένες με βάση το path του και τις συντεταγμένες του.


### ROLL 
#### Φόρτωση τυχαίου αριθμού απο το 1 ως το 6 

```
GET /roll/?action=roll
```
**το roll τροφοδοτει την συνάρτηση roll_dice που δέχεται ως παράμετρο το generated_dice_result και το πιόνι του οποίου επρόκειτω να υπολογιστούν οι νέες συντεταγμένες με βάση το path του και τις συντεταγμένες του. Υπάρχουν 16 τέτοιες κλήσεις, ας δουμε ενδεικτικά για την R1 παρακάτω.

### ROLL_DICE(xyz) για υπολογισμό συντεταγμενων πιονιου (16 στο συνολο)
#### Τροφοδότηση του αριθμού ζαριού και του κωδικού του piece για εμφάνιση νέων συντεταγμένων.

```
GET /rollR1?action=roll_dice&piece_num=111
```

***Με αυτη την κλήση πετυχαίνουμε να πάρουμε τον αριθμο του ζαριού και αναλόγως της παραμέτρου piece_num να υπολογίσουμε το destination.(βοηθα ο πίνακας dice)
H κωδικοποίηση των πιονιων εχει ως εξης:
ΚΙΤΡΙΝΟΣ: πιονι1: 1, πιονι2: 2, πιονι3: 3, πιονι4:4,
ΜΠΛΕ: π1:11 , π2: 22, π3: 33, π4: 44,
ΚΟΚΚΙΝΟΣ: π1:111, π2:222, π3:333, π4: 444,
ΠΡΑΣΙΝΟΣ: π1:1111, π2:2222, π3:3333, π4:4444

**


### HIGHLIGHTxyz για υπολογισμό highlighted συντεταγμενων πιονιου (16 στο συνολο)
#### Highlighted squares με βαση τα path
```
GET /highlightR1?action=R1_highlight

```
*Yπαρχουν συνολικά 16, όσες και τα πιόνια.Ενδεικτικα βλέπουμε αναφορικά με το πρωτό πίονι του κόκκινου παίκτη(R1).

***Με αυτη την κλήση πετυχαίνουμε να πάρουμε τον αριθμο των συντεταγμενων όλων όσων βρίσκονται ανάμεσα στις συντεταγμένες έναρξης+1 εως τις συντεταγμένες προορισμού, αναλόγως του αποτελέσματος της roll, και της roll_dice(piece_num) .Bοηθα ο πίνακας dice, οπου κρατάει το previous και το next path μεσω των οποιων ΄γινεται προσπέλαση στις συντεταγμένες του board για τις οποίες το path του κάθε χρωματος πληρέι τις προυποθεσεις, που ειναι προφανως ο αριθμός του ζαριού. 

**
### WIN PIECES

#### Γέμισμα του πίνακα win_pieces με τα πιόνια που έκαναν εναν πλήρη κύκλο(path>39).(4 ΣΥΝΟΛΙΚΑ)
```
GET /red_win_pieces?action=fill_red_win_pieces

```

Ενδεικτικά βλέπουμε όσον αφορά των έλεγχο των κόκκινων πιονιών για τα οποία επαληθεύεται οτι ολοκλήρωσαν 39 κινήσεις, δηλαδη το Path τους έφτασε >39.

**Σε αυτο το σημείο αξίζει να σημειωθεί οτι η ανυπαρξια των πιονιών απο το board ηταν κατι που εκμεταλλευτηκαμε προκειμένου όταν κάποιος παικτης πεφτει σε πιονι αντιπαλου να επιστρέφει στην αρχική του θεση(θα εξηγηθει παρακατω).Επομενως ασχετως με το οτι το board μας ειναι 11Χ11, δημιουργησαμε καποιες "κρυφες θέσεις" προκειμενου όταν ενα piece ολοκληρώσει τις 39 κινήσεις  να ΜΗΝ φαινεται στο board, αλλα να υπαρχει μεσα σε αυτο.

Επομενως οι κρυφές θεσεις εχουν ως εξης
ΚΙΤΡΙΝΟΣ: (100,1) (100,2) (100,3) (100,4)
ΜΠΛΕ:      (20,1)  (20,2) (20,3) (20,4)
ΚΟΚΚΙΝΟΣ: (30,1)  (30,2) (30,3) (30,4)
ΠΡΑΣΙΝΟΣ: (40,1)  (40,2) (40,3) (40,4)

και βάση αυτών πραγματοποιείται η εμφάνιση τους στα πιόνια που ολοκληρωσαν τον κύκλο.
```
GET /yellow_win_pieces?action=fill_yellow_win_pieces

```
```
GET /green_win_pieces?action=fill_green_win_pieces

```
```
GET /blue_win_pieces?action=fill_blue_win_pieces

```

### RETURN LOSERS HOME

#### Επιστροφή πιονιών στην αρχική τους θέση
```
GET /return_losers_home?action=return_home
```
Οπως προαναφέρθηκε η ανυπαρξία πιονιών στο board, ήταν κατι που εκμεταλλευτήκαμε προκειμένου να υλοποιήσουμε τον έλεγχο περίπτωσης παιξιάς στην οποία ενας παίκτης τρώει το πιόνι ενός αντιπάλου του.

### CHECK TURN

#### Αναγνώριση σειράς επόμενου παίκτη
```
GET /check_turn/?action=check_turn
```
Αφορά 32 εμφολευμένους ελέγχους μέσα απο τους οποίους δίνεται προτεραιότητα ως εξής αναλόγως του συνολικού αριθμού παικτων που είναι συνδεδεμένοι στο παιχνιδι:
B>R>G>Y.

Ο έλεγχος τίθεται σε εφαρμογή κάθε φορα που πραγματοποιέιται μια κίνηση πιονιού.

### ΕΙΚΟΝΕΣ ΠΙΟΝΙΩΝ

#### ΦΟΡΤΩΣΗ PNG ΣΤΟΙΧΕΙΩΝ ΓΙΑ ΚΑΘΕ ΠΙΟΝΙ(16 ΣΥΝΟΛΙΚΑ)
```
GET /images/YY3.png
```
**παραπανω βλεπουμε ενδεικτικα οσον αφορα το τριτο κίτρινο πιόνι.





### Player

#### Ανάγνωση στοιχείων παίκτη
```
GET /players/:p
```

Επιστρέφει τα στοιχεία του παίκτη p ή όλων των παικτών αν παραληφθεί. Το p μπορεί να είναι 'B' ή 'W'.

#### Καθορισμός στοιχείων παίκτη
```
PUT /players/:p
```
Json Data:

| Field             | Description                 | Required   |
| ----------------- | --------------------------- | ---------- |
| `username`        | Το username για τον παίκτη p. | yes        |
| `color`           | To χρώμα που επέλεξε ο παίκτης p. | yes        |


Επιστρέφει τα στοιχεία του παίκτη p και ένα token. Το token πρέπει να το χρησιμοποιεί ο παίκτης καθόλη τη διάρκεια του παιχνιδιού.

#### Διαγραφή στοιχείων παικτών
```
GET /delete_players/
```

Διαγραφή όλων των στοιχείων των παικτών. Ενεργοποιείται επιπλέον σε κάθε restart του board, Οπως επισης και μετα απο τη ληξη του παιχνιδιού κατα το οποίο βγήκε κάποιος νικητής.

### Status

#### Ανάγνωση κατάστασης παιχνιδιού
```
GET /status/
```

Επιστρέφει το στοιχείο [Game_status](#Game_status).



## Entities


### Board
---------

Το board είναι ένας πίνακας, ο οποίος στο κάθε στοιχείο έχει τα παρακάτω:


| Attribute                | Description                                  | Values                              |
| ------------------------ | -------------------------------------------- | ----------------------------------- |
| `x`                      | H συντεταγμένη x του τετραγώνου              | 1..11                                |
| `y`                      | H συντεταγμένη y του τετραγώνου              | 1..11                                |
| `b_color`                | To χρώμα του τετραγώνου                      | 'R','G','B','Y','W','MIX','GR','BR','BY','GY'                             |
| `piece_color`            | To χρώμα του πιονιού                         | ,'MIX','GR','BR','BY','GY'                         |
| `piece`                  | To Πιόνι που υπάρχει στο τετράγωνο           | 'Y1','Y2','Y3','Y4','R1','R2','R3','R4','B1','B2','B3','B4','G1','G2','G3','G4', null       |
| `y_path`                  | Πίνακας με τα δυνατά τετράγωνα (x,y) που μπορεί να μετακινηθούν τα κίτρινα πιόνια.   | 
| `r_path`                  | Πίνακας με τα δυνατά τετράγωνα (x,y) που μπορεί να μετακινηθούν τα κοκκινα πιόνια.   | 
| `b_path`                  | Πίνακας με τα δυνατά τετράγωνα (x,y) που μπορεί να μετακινηθούν τα μπλε πιόνια.   | 
| `g_path`                  | Πίνακας με τα δυνατά τετράγωνα (x,y) που μπορεί να μετακινηθούν τα πρασινα πιόνια.   | 

  |


### Players
---------

O κάθε παίκτης έχει τα παρακάτω στοιχεία:


| Attribute                | Description                                  | Values                              |
| ------------------------ | -------------------------------------------- | ----------------------------------- |
| `username`               | Όνομα παίκτη                                 | String                              |
| `piece_color`            | To χρώμα που παίζει ο παίκτης                | 'B','W'                             |
| `token  `                | To κρυφό token του παίκτη. Επιστρέφεται μόνο τη στιγμή της εισόδου του παίκτη στο παιχνίδι | HEX |


### Game_status
---------

H κατάσταση παιχνιδιού έχει τα παρακάτω στοιχεία:


| Attribute                | Description                                  | Values                              |
| ------------------------ | -------------------------------------------- | ----------------------------------- |
| `status  `               | Κατάσταση             | 'not active', 'initialized', 'started', 'ended', 'aborded'     |
| `p_turn`                 | To χρώμα του παίκτη που παίζει        | 'B','W',null                              |
| `result`                 |  To χρώμα του παίκτη που κέρδισε |'B','W',null                              |
| `last_change`            | Τελευταία αλλαγή/ενέργεια στην κατάσταση του παιχνιδιού         | timestamp |