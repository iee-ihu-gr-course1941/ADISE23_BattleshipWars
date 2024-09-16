<?php
 

function show_piece($x,$y) {
	global $mysqli;
	
	$sql = 'select * from board where x=? and y=?';
	$st = $mysqli->prepare($sql);
	$st->bind_param('ii',$x,$y);
	$st->execute();
	$res = $st->get_result();
	header('Content-type: application/json');
	print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);
}

function move_piece($x,$y,$x2,$y2,$token) {
	//ελεγχος αν εχει στειλει token ο χρηστης
	if($token==null || $token=='') {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"token is not set."]);
		exit;
	}
	
//current_color -> βρισκεται στo users.php
//επιστρεφει το row του χρωματος εαν υπαρχει
	$color = current_color($token);
	if($color==null ) {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"You are not a player of this game."]);
		exit;
	}

	//το στατους πρεπει να ναι started για να γινει μια κινηση
	//read_status()->βρισκεται στο game.php και επιστρεφει το status
		$status = read_status();
	if($status['status']!='started') {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"Game is not in action."]);
		exit;
	}

//εαν το p_turn δε ταιριαζει με το χρωμα του παικτη επιστρεφω μνμα λαθους
	if($status['p_turn']!=$color) {
		header("HTTP/1.1 400 Bad Request");
		//print json_encode(['errormesg'=>"It is not your turn."]);
		exit;
	}
//	$orig_board=read_board();
///	$board=convert_board($orig_board);

//ελεγχος κινησεων του συγκεκριμενου πιονιου(για n=0->πιονι δε μπορει να κινηθει)
//add_valid_moves_to_piece->θα προσθεσω στο πινακα τις νομιμες κινησεις του καθε πιονιου και ελεγχω
//εαν ναι τοτε do move
//	$n = add_valid_moves_to_piece($board,$color,$x,$y);

	//if($n==0) {
//		header("HTTP/1.1 400 Bad Request");
//		print json_encode(['errormesg'=>"This piece cannot move."]);
//		exit;
//	}
//	foreach($board[$x][$y]['moves'] as $i=>$move) {
	//	if($x2==$move['x'] && $y2==$move['y']) {
	   	do_move($x,$y,$x2,$y2);
 
	 	 show_board();	
		exit;
	//	}
//	}
 	header("HTTP/1.1 400 Bad Request");
 	print json_encode(['errormesg'=>"This move is illegal."]);
 	exit;
 
}

function do_move($x,$y,$x2,$y2) {
	global $mysqli;

	$sql = 'call move_piece(?,?,?,?)';
	$st = $mysqli->prepare($sql);
	$st->bind_param('iiii',$x,$y,$x2,$y2 );
	$st->execute();
//header("HTTP/1.1 200 OK.");
	//print json_encode(['errormesg'=>"INSIDE DO MOVE."]);
	//header('Content-type: application/json');
	//print json_encode(read_board(), JSON_PRETTY_PRINT);
	// show_board();
}

 
function show_board_by_player($b) {

	global $mysqli;

	$orig_board=read_board();
	$board=convert_board($orig_board);
	$status = read_status();
	if($status['status']=='started' && $status['p_turn']==$b && $b!=null) {
		// It my turn !!!!
		$n = add_valid_moves_to_board($board,$b);
		
		// Εάν n==0, τότε έχασα !!!!!
		// Θα πρέπει να ενημερωθεί το game_status.
	}
	header('Content-type: application/json');
	print json_encode($orig_board, JSON_PRETTY_PRINT);
}
 
function roll() {
    global $mysqli;

    // Call roll_diceOUT procedure
    $sql = "CALL roll_diceOUT(@generated_dice_result)";
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);
$st -> close();

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
//ipologismos newn sinntetagmenwn vasi tis prosthesis tou dice number sto ekastote path gia kathe pioni 
	$pieceNumbers = array(1, 2, 3, 4, 11,22,33,44, 111, 222, 333, 444,1111,2222,3333,4444);

	foreach ($pieceNumbers as $piece_num) {
        $sqlRollDice = "CALL roll_dice(?, @generated_dice_result)";
        $stRollDice = $mysqli->prepare($sqlRollDice);

        // Check if the prepare statement was successful for roll_dice
        if (!$stRollDice) {
            echo "Error in prepare statement: " . $mysqli->error;
        } else {
            // Bind the parameter and execute the stored procedure
            $stRollDice->bind_param("i", $piece_num);
            $stRollDice->execute();
            $stRollDice->close();}
  
}

 
}

 function roll_dice($piece_num) {
 
	switch ($piece_num) {
		case 1: roll_dice_Y1();  break;
		case 2: roll_dice_Y2();  break;
		case 3: roll_dice_Y3();   break;
		case 4: roll_dice_Y4();  break;
        case 11: roll_dice_B1(); break;
		case 22: roll_dice_B2(); break;
		case 33: roll_dice_B3(); break;
		case 44: roll_dice_B4();   break;
		case 111: roll_dice_R1(); break;
		case 222: roll_dice_R2(); break;
		case 333: roll_dice_R3(); break;
		case 444: roll_dice_R4();   break;
        case 1111: roll_dice_G1(); break;
		case 2222: roll_dice_G2(); break;
		case 3333: roll_dice_G3(); break;
		case 4444: roll_dice_G4();   break;
		default:
			echo "Invalid piece number.";
			break;
	}
}

function get_timer_value() {
    global $mysqli;
// Call the stored procedure
$sql = "CALL timer_value()";
$result = $mysqli->query($sql);

// Check if the query was successful
if ($result) {
    // Fetch the result as an associative array
    $row = $result->fetch_assoc();

    // Return the result as JSON
    header('Content-Type: application/json');
    echo json_encode($row);
} else {
    // Handle the error if the query fails
    echo "Error: " . $sql . "<br>" . $mysqli->error;
}}


function reset_timer(){
    global $mysqli;
    //epistrofi stin arxiki timi tou clock
      $sql = 'CALL timer_reset();';
      $result = $mysqli->query($sql);

      // Check if the query was successful
      if ($result) {
          // Fetch the result as an associative array
          $row = $result->fetch_assoc();
      
          // Return the result as JSON
          header('Content-Type: application/json');
          echo json_encode($row);
      } else {
          // Handle the error if the query fails
          echo "Error: " . $sql . "<br>" . $mysqli->error;
      }}

function check_turn() {
    global $mysqli;

    //enallagi tou p_turn tou game_status table analogws me to posoi paiktes einai kai poioi (32 periptwseis)
    $sql = "CALL check_turn();";
      $st = $mysqli -> prepare($sql);
    
      $st -> execute();
  
    
      if ($st->errno) {
          header('Content-type: application/json');
          print json_encode(['error' => $st->error], JSON_PRETTY_PRINT);
      } else {
          header('Content-type: application/json');
          print json_encode(['success' => true], JSON_PRETTY_PRINT);
      }
}

function roll_dice_Y1() {
	global $mysqli;

    $sql = 'CALL  Y1_dice() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
  function Y1_highlight() {
	global $mysqli;

    $sql = 'CALL  Y1_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
  }
 
function roll_dice_Y2(){
	global $mysqli;
 
    $sql = 'CALL  Y2_dice() ;';
    $st = $mysqli->prepare($sql);
	$st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function Y2_highlight() {
	global $mysqli;

    $sql = 'CALL  Y2_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}

function roll_dice_Y3(){
	global $mysqli;
	
    $sql = 'CALL  Y3_dice() ;';
    $st = $mysqli->prepare($sql);
	$st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function Y3_highlight() {
	global $mysqli;

    $sql = 'CALL  Y3_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}

function roll_dice_Y4(){
	global $mysqli;
	
    $sql = 'CALL  Y4_dice()   ;';
    $st = $mysqli->prepare($sql);
    $st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function Y4_highlight() {
	global $mysqli;

    $sql = 'CALL  Y4_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function roll_dice_R1(){
	global $mysqli;
	
    $sql = 'CALL  R1_dice() ;';
    $st = $mysqli->prepare($sql);
    $st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function R1_highlight() {
	global $mysqli;

    $sql = 'CALL  R1_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function roll_dice_R2(){
	global $mysqli;
	
    $sql = 'CALL  R2_dice() ;';
    $st = $mysqli->prepare($sql);
	$st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function R2_highlight() {
	global $mysqli;

    $sql = 'CALL  R2_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function roll_dice_R3(){
	global $mysqli;
	
    $sql = 'CALL  R3_dice() ;';
    $st = $mysqli->prepare($sql);
	$st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function R3_highlight() {
	global $mysqli;

    $sql = 'CALL  R3_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function roll_dice_R4(){
	global $mysqli;
	
    $sql = 'CALL  R4_dice() ;';
    $st = $mysqli->prepare($sql);
    $st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}

function R4_highlight() {
	global $mysqli;

    $sql = 'CALL  R4_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function roll_dice_G1(){
	global $mysqli;
	
    $sql = 'CALL  G1_dice() ;';
    $st = $mysqli->prepare($sql);
    $st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function roll_dice_G2(){
	global $mysqli;
	
    $sql = 'CALL  G2_dice() ;';
    $st = $mysqli->prepare($sql);
    $st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function roll_dice_G3(){
	global $mysqli;
	
    $sql = 'CALL  G3_dice() ;';
    $st = $mysqli->prepare($sql);
    $st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function roll_dice_G4(){
	global $mysqli;
	
    $sql = 'CALL  G4_dice() ;';
    $st = $mysqli->prepare($sql);
    $st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function roll_dice_B1(){
	global $mysqli;
	
    $sql = 'CALL  B1_dice() ;';
    $st = $mysqli->prepare($sql);
    $st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function roll_dice_B2(){
	global $mysqli;
	
    $sql = 'CALL  B2_dice() ;';
    $st = $mysqli->prepare($sql);
    $st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function roll_dice_B3(){
	global $mysqli;
	
    $sql = 'CALL  B3_dice() ;';
    $st = $mysqli->prepare($sql);
    $st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function roll_dice_B4(){
	global $mysqli;
	
    $sql = 'CALL  B4_dice() ;';
    $st = $mysqli->prepare($sql);
    $st->execute();

    // Fetch the results
    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}

function G1_highlight() {
	global $mysqli;

    $sql = 'CALL  G1_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function G2_highlight() {
	global $mysqli;

    $sql = 'CALL  G2_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function G3_highlight() {
	global $mysqli;

    $sql = 'CALL  G3_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function G4_highlight() {
	global $mysqli;

    $sql = 'CALL  G4_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function B1_highlight() {
	global $mysqli;

    $sql = 'CALL  B1_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function B2_highlight() {
	global $mysqli;

    $sql = 'CALL  B2_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function B3_highlight() {
	global $mysqli;

    $sql = 'CALL  B3_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}
function B4_highlight() {
	global $mysqli;

    $sql = 'CALL  B4_highlight() ; ';
    $st = $mysqli->prepare($sql);
    $st->execute();

    $result = $st->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    // Return the data as JSON
    header('Content-type: application/json');
    echo json_encode($data, JSON_PRETTY_PRINT);
}

function show_board(){
  global $mysqli;

  $sql = 'select * from board';
  $st = $mysqli -> prepare($sql);

  $st -> execute();
  $res = $st -> get_result();

  header('Content-type: application/json');
  print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);
}

function return_home(){
    global $mysqli;
  //epistrofi stin arxiki thesi otan kapoios antipalos trwei kapoion paikti allou xrwmatos
    $sql = 'CALL return_losers_home();';
    $st = $mysqli -> prepare($sql);
  
    $st -> execute();

  
    if ($st->errno) {
        header('Content-type: application/json');
        print json_encode(['error' => $st->error], JSON_PRETTY_PRINT);
    } else {
        header('Content-type: application/json');
        print json_encode(['success' => true], JSON_PRETTY_PRINT);
    }
}

function fill_yellow_win_pieces() {
    global $mysqli;

    // methodos pou gemizei tous 4 pinakes ton 4 xrwmatwn me ta kerdismena pieces tous
    $mysqli->query("CALL fill_winners_table();");
 
    $sql = 'SELECT DISTINCT piece FROM yellow_win_pieces WHERE id>0 ';
    $result = $mysqli->query($sql);

    $pieceValues = array();   

    if ($result->num_rows > 0) {
        // Output data of each row
        while ($row = $result->fetch_assoc()) {
            $pieceValues[] = $row["piece"];
        }
    }

    header('Content-type: application/json');
     // epistrofi associative array me ta pieceValues
    echo json_encode(['pieceValues' => $pieceValues], JSON_PRETTY_PRINT);
}

function fill_red_win_pieces() {
    global $mysqli;

    // methodos pou gemizei tous 4 pinakes ton 4 xrwmatwn me ta kerdismena pieces tous
   $mysqli->query("CALL fill_winners_table();");

    $sql = 'SELECT DISTINCT piece FROM red_win_pieces WHERE id>0';
    $result = $mysqli->query($sql);

    $pieceValues = array();  

    if ($result->num_rows > 0) {
        // Output data of each row
        while ($row = $result->fetch_assoc()) {
            $pieceValues[] = $row["piece"];
        }
    }

    header('Content-type: application/json');
      // epistrofi associative array me ta pieceValues
    echo json_encode(['pieceValues' => $pieceValues], JSON_PRETTY_PRINT);
}

function fill_green_win_pieces() {
    global $mysqli;

    // methodos pou gemizei tous 4 pinakes ton 4 xrwmatwn me ta kerdismena pieces tous
   $mysqli->query("CALL fill_winners_table();");

    $sql = 'SELECT DISTINCT piece FROM green_win_pieces WHERE id>0';
    $result = $mysqli->query($sql);

    $pieceValues = array();  // pinakas me ta piece values tou green pou kerdisan/termatisan

    if ($result->num_rows > 0) {
        // Output data of each row
        while ($row = $result->fetch_assoc()) {
            $pieceValues[] = $row["piece"];
        }
    }

    header('Content-type: application/json');
     // epistrofi associative array me ta pieceValues
    echo json_encode(['pieceValues' => $pieceValues], JSON_PRETTY_PRINT);
}

function fill_blue_win_pieces() {
    global $mysqli;

    // methodos pou gemizei tous 4 pinakes ton 4 xrwmatwn me ta kerdismena pieces tous
   $mysqli->query("CALL fill_winners_table();");

    $sql = 'SELECT DISTINCT piece FROM blue_win_pieces WHERE id>0';
    $result = $mysqli->query($sql);

    $pieceValues = array();   // pinakas me ta piece values tou blue pou kerdisan/termatisan


    if ($result->num_rows > 0) {
     
        while ($row = $result->fetch_assoc()) {
            $pieceValues[] = $row["piece"];
        }
    }

    header('Content-type: application/json');
    // epistrofi associative array me ta pieceValues
    echo json_encode(['pieceValues' => $pieceValues], JSON_PRETTY_PRINT);
}


 
function convert_board(&$orig_board) {
	$board=[];
	foreach($orig_board as $i=>&$row) {
		$board[$row['x']][$row['y']] = &$row;
	} 
	return($board);
}


function read_board() {
	global $mysqli;
	$sql = 'select * from board';
	$st = $mysqli->prepare($sql);
	$st->execute();
	$res = $st->get_result();  
	return($res->fetch_all(MYSQLI_ASSOC));
}

 

function reset_board(){
  global $mysqli;

  $sql = 'call clean_board()';
  $mysqli->query($sql);
  show_board();
} 


 
?>