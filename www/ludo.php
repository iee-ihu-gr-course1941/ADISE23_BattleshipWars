<?php

//ludo.php dilosh path me ton server


//print_r("HERE!!!!!!");
require_once "../lib/dbconnect.php";
require_once "../lib/board.php";
require_once "../lib/game.php"; 
require_once "../lib/users.php";
 

$method = $_SERVER['REQUEST_METHOD'];
$request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
// $request = explode('/', trim($_SERVER['SCRIPT_NAME'],'/'));
// Σε περίπτωση που τρέχουμε php –S 
$input = json_decode(file_get_contents('php://input'),true);
if($input==null) {
    $input=[];
}
if(isset($_SERVER['HTTP_X_TOKEN'])) {
    $input['token']=$_SERVER['HTTP_X_TOKEN'];
} else {
    $input['token']='';
}

// print_r($request );

 switch ($r=array_shift($request)) {
    case 'board' :
	switch ($b=array_shift($request)) {
		case '': 
		case null: handle_board($method);break;
 	case 'piece': handle_piece($method, $request[0],$request[1],$input);
 				break;
	// case 'player': handle_player($method, $request[0],$input);
					//break;
					default: header("HTTP/1.1 404 Not Found");
                            break;
			
 
	}
		break;
	case 'status': 
		if(sizeof($request)==0) {handle_status($method);}
		else {header("HTTP/1.1 404 Not Found");}
		break;
 	case 'players': handle_player($method, $request,$input);
  			break;
	case 'delete_players': handle_delete_players($method);
	break;


	 case 'roll': handle_roll($method);  break;
	  
			case 'rollY1':   handle_roll_Y1($method); break;
			case 'rollY2':handle_roll_Y2($method); break;
			case 'rollY3':handle_roll_Y3($method); break;
			case 'rollY4':handle_roll_Y4($method); break;
  
				case 'rollR1':handle_roll_R1($method); break;
				case 'rollR2':handle_roll_R2($method); break;
				case 'rollR3':handle_roll_R3($method); break;
				case 'rollR4':handle_roll_R4($method); break;

				case 'rollG1':   handle_roll_G1($method); break;
				case 'rollG2':handle_roll_G2($method); break;
				case 'rollG3':handle_roll_G3($method); break;
				case 'rollG4':handle_roll_G4($method); break;
	  
					case 'rollB1':handle_roll_B1($method); break;
					case 'rollB2':handle_roll_B2($method); break;
					case 'rollB3':handle_roll_B3($method); break;
					case 'rollB4':handle_roll_B4($method); break;

				case 'highlightY1':   handle_highlight_Y1($method); break;
				case 'highlightY2':handle_highlight_Y2($method); break;
				case 'highlightY3':handle_highlight_Y3($method); break;
				case 'highlightY4':handle_highlight_Y4($method); break;
	  
					case 'highlightR1':handle_highlight_R1($method); break;
					case 'highlightR2':handle_highlight_R2($method); break;
					case 'highlightR3':handle_highlight_R3($method); break;
					case 'highlightR4':handle_highlight_R4($method); break;

					case 'highlightG1':   handle_highlight_G1($method); break;
					case 'highlightG2':handle_highlight_G2($method); break;
					case 'highlightG3':handle_highlight_G3($method); break;
					case 'highlightG4':handle_highlight_G4($method); break;
		  
						case 'highlightB1':handle_highlight_B1($method); break;
						case 'highlightB2':handle_highlight_B2($method); break;
						case 'highlightB3':handle_highlight_B3($method); break;
						case 'highlightB4':handle_highlight_B4($method); break;

	 case 'yellow_win_pieces':handle_yellow_win_pieces($method);break;
	 case 'red_win_pieces':handle_red_win_pieces($method);break;
	 case 'green_win_pieces':handle_green_win_pieces($method);break;
	 case 'blue_win_pieces':handle_blue_win_pieces($method);break;

	 case 'return_losers_home' : handle_losers($method);break;
	 case 'timer' : handle_timer($method); break;

	 case 'check_turn': handle_check_turn($method);break;
	 case 'reset_timer' : handle_reset_timer($method);break;
	//case 'move_y':handle_move_y($method);
   // default: 	
	header("HTTP/1.1 404 Not Found");
    print "<h1>not FOUND</h1>";
	exit;
}



function handle_reset_timer($method) {
    if($method=='GET') {
		reset_timer();
      }  else {header('HTTP/1.1 405 Method Not Allowed');}
}



function handle_check_turn($method) {
    if($method=='GET') {
		check_turn();
      }  else {header('HTTP/1.1 405 Method Not Allowed');}
}



function handle_timer($method) {
    if($method=='GET') {
		get_timer_value();
      }  else {header('HTTP/1.1 405 Method Not Allowed');}
}

function handle_losers($method) {
    if($method=='GET') {
	 return_home();
      }  else {header('HTTP/1.1 405 Method Not Allowed');}
}

function handle_yellow_win_pieces($method) {
    if($method=='GET') {
	 fill_yellow_win_pieces();
      }  else {header('HTTP/1.1 405 Method Not Allowed');}
}

function handle_red_win_pieces($method) {
    if($method=='GET') {
		fill_red_win_pieces(); 
    }  else {header('HTTP/1.1 405 Method Not Allowed');}
}

function handle_green_win_pieces($method) {
    if($method=='GET') {
	 fill_green_win_pieces();
      }  else {header('HTTP/1.1 405 Method Not Allowed');}
}
function handle_blue_win_pieces($method) {
    if($method=='GET') {
	 fill_blue_win_pieces();
      }  else {header('HTTP/1.1 405 Method Not Allowed');}
}

function handle_delete_players($method) {
    if($method=='GET') {
		header('HTTP/1.1 405 Method Not Allowed');
    } else if ($method=='POST') {
		reset_players();
    }  else {header('HTTP/1.1 405 Method Not Allowed');}
    
}


    function handle_roll($method) {
        if($method=='GET') {
    		roll();
     
         }    else {header('HTTP/1.1 405 Method Not Allowed');}
        
     }
 function handle_roll_Y1($method) {
    if($method=='GET') {
		roll_dice(1);
 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_Y1($method) {
    if($method=='GET') {
 Y1_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_roll_Y2($method) {
    if($method=='GET') {
		roll_dice(2);
 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }

 function handle_highlight_Y2($method) {
    if($method=='GET') {
 Y2_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }


 function handle_roll_Y3($method) {
    if($method=='GET') {
		roll_dice(3);
	 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_Y3($method) {
    if($method=='GET') {
 Y3_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }


 function handle_roll_Y4($method) {
    if($method=='GET') {
		roll_dice(4);
		 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_Y4($method) {
    if($method=='GET') {
 Y4_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }


 function handle_roll_R1($method) {
    if($method=='GET') {
		roll_dice(111);
	 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_R1($method) {
    if($method=='GET') {
		R1_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_roll_R2($method) {
    if($method=='GET') {
		roll_dice(222);
	 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_R2($method) {
    if($method=='GET') {
		R2_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_roll_R3($method) {
    if($method=='GET') {
		roll_dice(333);
	 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_R3($method) {
    if($method=='GET') {
		R3_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_roll_R4($method) {
    if($method=='GET') {
		roll_dice(444);
	 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_R4($method) {
    if($method=='GET') {
		R4_highlight();
     }    else {header('HTTP/1.1 4050 Method Not Allowed');}
    
 }
 
 function handle_roll_G1($method) {
    if($method=='GET') {
		roll_dice(1111);
 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_G1($method) {
    if($method=='GET') {
 G1_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_roll_G2($method) {
    if($method=='GET') {
		roll_dice(2222);
 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_G2($method) {
    if($method=='GET') {
 G2_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_roll_G3($method) {
    if($method=='GET') {
		roll_dice(3333);
 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_G3($method) {
    if($method=='GET') {
 G3_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_roll_G4($method) {
    if($method=='GET') {
		roll_dice(4444);
 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_G4($method) {
    if($method=='GET') {
 G4_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 
function handle_roll_B1($method) {
    if($method=='GET') {
		roll_dice(11);
 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_B1($method) {
    if($method=='GET') {
 B1_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_roll_B2($method) {
    if($method=='GET') {
		roll_dice(22);
 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_B2($method) {
    if($method=='GET') {
 B2_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_roll_B3($method) {
    if($method=='GET') {
		roll_dice(33);
 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_B3($method) {
    if($method=='GET') {
 B3_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_roll_B4($method) {
    if($method=='GET') {
		roll_dice(44);
 
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }
 function handle_highlight_B4($method) {
    if($method=='GET') {
 B4_highlight();
     }    else {header('HTTP/1.1 405 Method Not Allowed');}
    
 }


function handle_board($method) {
    if($method=='GET') {
            show_board();
    } else if ($method=='POST') {
		reset_board();
    } else {
        header('HTTP/1.1 405 Method Not Allowed');
    }
    
}

function handle_piece($method, $x,$y,$input) {
	if($method=='GET') {
		show_piece($x,$y);
	} else if ($method=='PUT') {
		move_piece($x,$y,$input['x'],$input['y'],  
				   $input['token']);
	}    


}
function handle_player($method, $p,$input) {
    switch ($b=array_shift($p)) {
	 	//case '':
	 //case null: if($method=='GET') {show_users($method);}
	 	//		   else {header("HTTP/1.1 400 Bad Request"); 
 		//			 print json_encode(['errormesg'=>"Method $method not allowed here."]);}
   
		
		
		          
        case 'R':  handle_user($method, $b,$input);
		break;
			case 'B':  handle_user($method, $b,$input);
			break;
		case 'G':  handle_user($method, $b,$input);
		break;
			case 'Y': handle_user($method, $b,$input);
					break;
		default: header("HTTP/1.1 404 Not Found");
				 print json_encode(['errormesg'=>"Player $b not found."]);
                 break;
	}
}


function handle_status($method) {
    if($method=='GET') {
        show_status();
    } else {
        header('HTTP/1.1 405 Method Not Allowed');
    }
}
?>