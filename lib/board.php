<?php
 // $sql = 'call clean_board()';



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
	
	do_move($x,$y,$x2,$y2);
	show_board();
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
  

function show_board(){
  global $mysqli;

  $sql = 'select * from board';
  $st = $mysqli -> prepare($sql);

  $st -> execute();
  $res = $st -> get_result();

  header('Content-type: application/json');
  print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);
}

function reset_board(){
  global $mysqli;

  $sql = 'call clean_board()';
  $mysqli->query($sql);
  show_board();
} 

function read_board() {
	global $mysqli;
	$sql = 'select * from board';
	$st = $mysqli->prepare($sql);
	$st->execute();
	$res = $st->get_result();
	return($res->fetch_all(MYSQLI_ASSOC));
}
 
?>