var me={token:null,piece_color:null};
var game_status={};
var board={};
var last_update=new Date().getTime();
var timer=null;

 


$(function(){
    draw_empty_board();

    fill_board();
 
   fill_red_win();
   fill_yellow_win();
   fill_green_win();
   fill_blue_win();
 
 //reset_timer();
 reset_board();
reset_players();
    $('#ludo_login').click(login_to_game);
    $('#ludo_reset').click(reset_board);
    $('#players_reset').click(reset_players);
    
$('#play').click(play);
    // $('#resetButton').click(reset_timer);

 //startTimer();
    $('#do_move').click(do_move);
    $('#move_div').hide();
    $('#do_move_roll').click(roll_dice);
    $('#move_div_roll').hide();
    $('YY1.png').click(roll_dice_Y1);
 
});


function check_turn(){
    $.ajax({
        url: 'ludo.php/check_turn/',  
        method: 'GET',
    dataType: "json",
    headers: { "X-Token": me.token },
        contentType: 'application/json',
        data: { action: 'check_turn' }, 
        
        
        // Pass the action as part of the data
        success: function(data) {
            console.log("Success Response:", data);
         //   game_status_update();
            
          },
         error: function() {
             alert('Error occurred while checking turn.');
         }
     });
   game_status_update();
        }
    
 

var time = document.getElementById("time");
var minute = document.getElementById("min");
var second = document.getElementById("sec");
var startButton = document.getElementById("start");
var resetButton = document.getElementById("reset");
var seti = undefined;
var mm = "00";
var ss = "30";

startButton.addEventListener("click", start );
//roll_dice.addEventListener("click",start);

function start() {
    if (startButton.innerHTML === "START") {
      startButton.innerHTML = "PAUSE";
      mm = minute.value;
      ss = second.value;
      if (minute.value === "") minute.value = "00";
      if (second.value === "") second.value = "00";
      minute.setAttribute("disabled", true);
      second.setAttribute("disabled", true);
      seti = setInterval(function () {
        if (second.value > 0) {
          second.value -= 1;
          if (second.value < 10 && second.value >= 0) {
            second.value = "0" + second.value;
          }
        }
        else if (minute.value > 0) {
          second.value = "59";
          minute.value -= 1;
          if (minute.value < 10 && minute.value >= 0) {
            minute.value = "0" + minute.value;
          }
        }
        else {
          clearInterval(seti);
          document.body.style.backgroundImage = "linear-gradient(to top left, #c0392b, #e74c3c , #9b59b6)";
          setTimeout(function() {
            alert("Time Out !");
            res();
          }, 100);
        }
      }, 1000);
    }
    else {
      minute.removeAttribute("disabled");
      second.removeAttribute("disabled");
      startButton.innerHTML = "START";
      clearInterval(seti);
    }
  }
resetButton.addEventListener("click", res);

function res() {
  clearInterval(seti);
  minute.value = mm;
  second.value = ss;
  minute.removeAttribute("disabled");
  second.removeAttribute("disabled");
  startButton.innerHTML = "START";
  document.body.style.backgroundImage = "linear-gradient(to top left, #2980b9, #9b59b6)";
}

 
function roll_dice(){
    
    // Send an AJAX request to the server to update the database
$.ajax({
    url: 'ludo.php/roll/',  
    method: 'GET',
dataType: "json",
headers: { "X-Token": me.token },
    contentType: 'application/json',
    data: { action: 'roll' }, 
    
    
    // Pass the action as part of the data
    success: function(data) {
        console.log("Success Response:", data);
        
            $("#diceResult").text("Dice Result: " +data[0].generated_dice_result); 
               if (game_status.p_turn == 'Y') {
                 makeImagesClickableY();
  } else if (game_status.p_turn == 'R'){
     makeImagesClickableR();
  } else if (game_status.p_turn == 'G'){
    makeImagesClickableG();
 } else if (game_status.p_turn == 'B'){
    makeImagesClickableB();
 }

          
     },
     error: function() {
         alert('Error occurred while rolling the dice.');
     }
 });
// game_status_update();
    }

//dice anmimation 

 function play(){
    start(); 
    $('#platform').removeClass('stop').addClass('playing');

      
      // Send an AJAX request to the server to update the database
$.ajax({
    url: 'ludo.php/roll/', // Adjust the path to your server-side script
    method: 'GET',
dataType: "json",
headers: { "X-Token": me.token },
    contentType: 'application/json',
    data: { action: 'roll' }, 
    
    
    // Pass the action as part of the data
    success: function(data) {
        console.log("Success Response:", data);
        
            $("#diceResult").text("Dice Result: " +data[0].generated_dice_result); 
            if (game_status.p_turn == 'Y') {
                makeImagesClickableY();
 } else if (game_status.p_turn == 'R'){
    makeImagesClickableR();
 } else if (game_status.p_turn == 'G'){
   makeImagesClickableG();
} else if (game_status.p_turn == 'B'){
   makeImagesClickableB();
}
  $('#dice')
    setTimeout(function(){
      $('#platform').removeClass('playing').addClass('stop');
      var number = data[0].generated_dice_result ;
    
      //var number  = 6;
      var x = 0, y = 20, z = -20;
      switch(number){
          case 1:
            x = 0; y = 20; z = -20;
            break;
          case 2:
            x = -100; y = -150; z = 10;
            break;
          case 3:
            x = 0; y = -100; z = -10;
            break;
          case 4:
            x = 0; y = 100; z = -10;
            break;
          case 5:
            x = 80; y = 120; z = -10;
            break;
          case 6:
            x = 0; y = 200; z = 10;
            break;
      }
    
      $('#dice').css({
        'transform': 'rotateX(' + x + 'deg) rotateY(' + y + 'deg) rotateZ(' + z + 'deg)'
      });
      
      $('#platform').css({
        'transform': 'translate3d(0,0, 0px)'
      });
      
      $('#point').html(number);
      
    }, 1000);

          
     },
     error: function() {
         alert('Error occurred while rolling the dice.');
     }

 // game_status_update();
});
 
    
  } 

 
//methodos elegxou iparksis kitrinwn pioniwn sto destination pioniou  pou paizei
function checkYYImagesBeforeMove() {
    // Extract the last 2 digits from the input #the_move
    var moveInputValue = $('#the_move').val().trim();
    var moveValues = moveInputValue.split(/\s+/);

            
    var x = moveValues[2];
    var y = moveValues[3];

    // Build the square ID
    var squareId = 'square_' + x + '_' + y  ;
    var tdElement = $('#square_' + x + '_' + y  );

    var imageName = $(tdElement).find('img').attr('src'); // Get the image source
    
    // elegxos an ksekina to image me YY
    if (imageName && imageName.startsWith('images/YY')) {
       

    
        console.log('Image with src starting with "YY" exists!YOU CANT MOVE');
        return { hasYYImage: true, imageName: imageName };
    } else {
        // There is no such image inside the <td>
        console.log('No image with src starting with "YY" found.');
        return { hasYYImage: false, imageName: null };
    }}
 
    //methodos elegxou iparksis prasinwn pioniwn sto destination pioniou  pou paizei
function checkGGImagesBeforeMove() {
    // Extract the last 2 digits from the input #the_move
    var moveInputValue = $('#the_move').val().trim();
    var moveValues = moveInputValue.split(/\s+/);

            
    var x = moveValues[2];
    var y = moveValues[3];

    // Build the square ID
    var squareId = 'square_' + x + '_' + y  ;
    var tdElement = $('#square_' + x + '_' + y  );

    var imageName = $(tdElement).find('img').attr('src'); // image source
    
    // elegxos an ksekina to image me GG
    if (imageName && imageName.startsWith('images/GG')) {
       

    
        console.log('Image with src starting with "GG" exists!YOU CANT MOVE');
        return { hasGGImage: true, imageName: imageName };
    } else {
        // There is no such image inside the <td>
        console.log('No image with src starting with "GG" found.');
        return { hasGGImage: false, imageName: null };
    }}
  //methodos elegxou iparksis MPLE pioniwn sto destination pioniou  pou paizei
    function checkBBImagesBeforeMove() {
        // Extract the last 2 digits from the input #the_move
        var moveInputValue = $('#the_move').val().trim();
        var moveValues = moveInputValue.split(/\s+/);
    
                
        var x = moveValues[2];
        var y = moveValues[3];
    
        // Build the square ID
        var squareId = 'square_' + x + '_' + y  ;
        var tdElement = $('#square_' + x + '_' + y  );
    
        var imageName = $(tdElement).find('img').attr('src'); // image source
        
        // elegxos an ksekina to image me BB
        if (imageName && imageName.startsWith('images/BB')) {
           
    
        
            console.log('Image with src starting with "BB" exists!YOU CANT MOVE');
            return { hasBBImage: true, imageName: imageName }; //EPISTREFW OBJECT ME 2 VALUES
        } else {
            // There is no such image inside the <td>
            console.log('No image with src starting with "BB" found.');
            return { hasBBImage: false, imageName: null };
        }}

//methodos elegxou iparksis kokkinwn pioniwn sto destination pioniou  pou paizei
    function checkRRImagesBeforeMove() {
        // Extract the last 2 digits from the input #the_move
        var moveInputValue = $('#the_move').val().trim();
        var moveValues = moveInputValue.split(/\s+/);
    
                
        var x = moveValues[2];
        var y = moveValues[3];
    
        // Build the square ID
        var squareId = 'square_' + x + '_' + y  ;
        var tdElement = $('#square_' + x + '_' + y  );
        var tdElement = $('#square_' + x + '_' + y  );

    var imageName = $(tdElement).find('img').attr('src'); // Get the image source
    
    // Check if the image name starts with "YY"
    if (imageName && imageName.startsWith('images/RR')) {
       

    
        console.log('Image with src starting with "RR" exists!YOU CANT MOVE');
        return { hasRRImage: true, imageName: imageName };
    } else {
        // There is no such image inside the <td>
        console.log('No image with src starting with "RR" found.');
        return { hasRRImage: false, imageName: null };
    }} 




 function reset_players() {
    
        // Send an AJAX request to the server to update the database
        $.ajax({
            url: 'ludo.php/delete_players/', // Adjust the path to your server-side script
            method: 'POST',
dataType: "json",
         
            contentType: 'application/json',
            data: { action: 'reset_players' }, // Pass the action as part of the data
            success: function(response) {
                // Handle the response from the server
              alert('WELCOME!');
            },
            error: function() {
                alert('js Error occurred while updating the database.');
            }
        });
    // game_status_update();

    } 
 

function draw_empty_board(p) {
    if(p!='B'||p!='R'||p!='G') {p='Y';}
	var draw_init = {
		'Y': {i1:11,i2:0,istep:-1,j1:1,j2:12,jstep:1},
		'R': {i1:1,i2:12,istep:1, j1:11,j2:0,jstep:-1}
	};
	var s=draw_init[p];

    var t = '<table id="ludo_table">';

    for(var i=s.i1;i!=s.i2;i+=s.istep) {
		t += '<tr>';
		for(var j=s.j1;j!=s.j2;j+=s.jstep) {
                    t += '<td class="ludo_square" id="square_' + j + '_' + i + '">' + j + ',' + i + '</td>';
        }
        t += '</tr>';
    }
    t += '</table>';

    $('#ludo_board').html(t);
 
}
 
    
function fill_board() {
	$.ajax({url: "ludo.php/board/", 
		headers: {"X-Token": me.token},
		success: fill_board_by_data });
}

function reset_board() {
	$.ajax({url: "ludo.php/board/", headers: {"X-Token": me.token}, method: 'POST',  success: fill_board_by_data });
	$('#move_div').hide();
    $('#move_div_roll').hide(); 
	$('#game_initializer').show(2000);
    //reset_timer();
res();
    //reload ta pieces
    $('#red_win_pieces').empty();
    $('#yellow_win_pieces').empty();
    $('#green_win_pieces').empty();
    $('#blue_win_pieces').empty();

}



function fill_board_by_data(data) {
  //  return_losers_home();
    fill_red_win();
    fill_yellow_win();
    fill_green_win();
    fill_blue_win();
   // fill_red_win();
   // fill_yellow_win();
    board=data;
    for(var i=0;i<data.length;i++) {
		var o = data[i];
		var id = '#square_'+ o.x +'_' + o.y;
		var c = (o.piece!=null)?o.piece_color + o.piece:'';
		var pc= (o.piece!=null)?'piece'+o.piece_color:'';
		var im = (o.piece!=null)?'<img class="piece '+pc+'" src="images/'+c+'.png">':'';
		$(id).addClass(o.b_color+'_square').html(im);
    //    $(id).click(click_on_piece);
    }
    
    }
    
    function login_to_game() {

        if($('#username').val()=='') {
            alert('You have to set a username');
            return;
        }
        var p_color = $('#pcolor').val();
        draw_empty_board(p_color);
        fill_board();
        
        $.ajax({url: "ludo.php/players/"+p_color, 
                method: 'PUT',
                dataType: "json",
                headers: {"X-Token": me.token},
                contentType: 'application/json',
                data: JSON.stringify( {username: $('#username').val(), piece_color: p_color}),
                success: login_result,
                error: login_error});
    } 
 

    function login_result(data) {
        check_turn();
        me = data[0];
        $('#game_initializer').hide();
       update_info();
          game_status_update();
    }
    
    
    function login_error(data, y, z, c) {
        var x = data.responseJSON;
     
            alert(x.errormesg);
       
    }
  
   
    function game_status_update() {
	        clearTimeout(timer);
        $.ajax({url: "ludo.php/status/", success: update_status,headers: {"X-Token": me.token} });
    }
    
    function update_status(data) {
        last_update=new Date().getTime();
       var game_stat_old = game_status;
        game_status=data[0];
        update_info();
        clearTimeout(timer);
        $('#play').prop('disabled', false);
         if(game_status.p_turn==me.piece_color &&  me.piece_color!=null) {
           x=0;
            // do play
         if(game_stat_old.p_turn!=game_status.p_turn) {
            fill_red_win();
            fill_yellow_win();
            fill_green_win();
            fill_blue_win();
         // return_losers_home();    
            fill_board();
          

          }
          fill_red_win();
          fill_yellow_win();
          fill_green_win();
          fill_blue_win();
        //  return_losers_home();
          fill_board();
          $('#play').prop('disabled', false);
          //reset_timer();
          
          $('#move_div_roll').show(1000);
           $('#move_div').show(1000);
          // reset_timer();
          // 
         // fetchTimerValue();
          // startTimer();
        // timer=setTimeout(function() { game_status_update();}, 4000);
          
        } else {
         var theMoveInput = document.getElementById("the_move");

          // Clear the input value
       //   return_losers_home();
          fill_board();

          theMoveInput.value = "";
            $('#move_div_roll').hide(5000);
          $('#move_div').hide(5000);
          $('#play').prop('disabled', true);
        //   reset_timer();
         timer=setTimeout(function() { game_status_update();}, 1000);
         
        }
 

    }
 
      function update_info(){
      //  return_losers_home();

        if (game_status.status!=='ended'){
            $('#game_info').html("I am Player: "+me.piece_color+", my name is "+me.username 
            +'<br>Token='+me.token+'<br>Game state: '+game_status.status+', '+ game_status.p_turn+' must play now.'  );
        }else{
         
         if(game_status.result==='Y'){
            $('#game_info').html("I am Player: "+me.piece_color+", my name is "+me.username 
            +'<br>Token='+me.token+'<br>Game state: '+game_status.status+', ' + game_status.result+'YELLOW PLAYER WINS.');  
            alert('YELLOW PLAYER WINS.');
           // reset_board();
           // reset_players();
            location.reload();
           

        }
         if(game_status.result==='R'){
            $('#game_info').html("I am Player: "+me.piece_color+", my name is "+me.username 
            +'<br>Token='+me.token+'<br>Game state: '+game_status.status+', ' + game_status.result+'RED PLAYER WINS.');   
            alert('RED PLAYER WINS.');
          //  reset_board();
           // reset_players();
            location.reload();
        }
         if(game_status.result==='G'){
            $('#game_info').html("I am Player: "+me.piece_color+", my name is "+me.username 
            +'<br>Token='+me.token+'<br>Game state: '+game_status.status+', ' + game_status.result+'GREEN PLAYER WINS.');  
            alert('GREEN PLAYER WINS.'); 
         //   reset_board();
          //  reset_players();
            location.reload();
           
        }
         if(game_status.result==='B'){
            $('#game_info').html("I am Player: "+me.piece_color+", my name is "+me.username 
            +'<br>Token='+me.token+'<br>Game state: '+game_status.status+', ' + game_status.result+'BLUE PLAYER WINS.');   
            alert('BLUE PLAYER WINS.'); 
         //   reset_board();
         //   reset_players();
            location.reload();
        }
       
        }
            
        }
   
        var buttonClicked = false;
        function do_move() {
            buttonClicked = true;
            var s = $('#the_move').val();
            
            var a = s.trim().split(/[ ]+/);
            if(a.length!=4) {
             //   alert('Must give 4 numbers');
                return;
            }
      
// elegxos iparksis pioniwn sto destination me ti xrisi twn check methodwn poy epistrefoun obj me 2 values(mia boolean gia tin iparksi kai mia poy leei pio pioni iparxei)
            var result_Y = checkYYImagesBeforeMove();
            var result_R = checkRRImagesBeforeMove();
            var result_G = checkGGImagesBeforeMove();
            var result_B = checkBBImagesBeforeMove();


            var hasYYImage =result_Y.hasYYImage;
            var hasRRImage=result_R.hasRRImage;
            var hasGGImage =result_G.hasGGImage;
            var hasBBImage=result_B.hasBBImage;

            var imageY= result_Y.imageName;
            var imageR= result_R.imageName;
            var imageG= result_G.imageName;
            var imageB= result_B.imageName;



            //elegxw ama o paiktis pou paizei exei diko tou pioni sti thesi pou thelei na paei an oxi kanei thn kinisi
            if (hasYYImage === false && game_status.p_turn === 'Y' || hasRRImage === false && game_status.p_turn === 'R'||hasGGImage === false && game_status.p_turn === 'G' || hasBBImage === false && game_status.p_turn === 'B') {
                $.ajax({url: "ludo.php/board/piece/"+a[0]+'/'+a[1], 
                    method: 'PUT',
                    dataType: "json",
                    contentType: 'application/json',
                    data: JSON.stringify( {x: a[2], y: a[3]}),
                  // data: JSON.stringify( {x: a[2], y: a[3] , "X-Token": me.token  }),
                  //to token απο ορισμα, το βαζω στους headers(αλλαγη ludo.php)
                    headers: {"X-Token": me.token},
                    success: move_result,
                    
                    error: login_error});
            
        }else {
            //alliws an iparxeei diko tou pioni sti thesi poy thelei na paei apagorevetai
            alert('ILLEGAL MOVE!');
        }
                var imageContainer = $("#imageContainer");
        //elegxw an o kitrinos paei na faei pioni tou mple
        if (hasBBImage === true && game_status.p_turn === 'Y'){
            alert('ΦΑΓΑΤΕ ΤΟ ΠΙΟΝΙ ΤΟΥ ΜΠΛΕ, ΕΠΙΣΤΡΕΦΕΙ ΣΤΗΝ ΑΡΧΙΚΗ ΤΟΥ ΘΕΣΗ!');
            
return_losers_home();
fill_board();
}
        //elegxw an o kitrinos paei na faei pioni tou prasinou
        if (hasGGImage === true && game_status.p_turn === 'Y'){
            alert('ΦΑΓΑΤΕ ΤΟ ΠΙΟΝΙ ΤΟΥ ΠΡΑΣΙΝΟΥ, ΕΠΙΣΤΡΕΦΕΙ ΣΤΗΝ ΑΡΧΙΚΗ ΤΟΥ ΘΕΣΗ!');
            
return_losers_home();
fill_board();
}
      //elegxw an o kitrinos paei na faei pioni tou kokkinou
      if (hasRRImage === true && game_status.p_turn === 'Y') {
        alert('ΦΑΓΑΤΕ ΤΟ ΠΙΟΝΙ ΤΟΥ ΚΟΚΚΙΝΟΥ, ΕΠΙΣΤΡΕΦΕΙ ΣΤΗΝ ΑΡΧΙΚΗ ΤΟΥ ΘΕΣΗ!');
          
        return_losers_home();
        fill_board();
 
    }

        //elegxw an o kokkinos paei na faei pioni tou kitrinou
        if (hasYYImage === true && game_status.p_turn === 'R'){
                       alert('ΦΑΓΑΤΕ ΤΟ ΠΙΟΝΙ ΤΟΥ ΚΙΤΡΙΝΟΥ, ΕΠΙΣΤΡΕΦΕΙ ΣΤΗΝ ΑΡΧΙΚΗ ΤΟΥ ΘΕΣΗ!');
                       
        return_losers_home();
        fill_board();
        }

                //elegxw an o kokkinos paei na faei pioni tou mple
                if (hasBBImage === true && game_status.p_turn === 'R'){
                    alert('ΦΑΓΑΤΕ ΤΟ ΠΙΟΝΙ ΤΟΥ ΜΠΛΕ, ΕΠΙΣΤΡΕΦΕΙ ΣΤΗΝ ΑΡΧΙΚΗ ΤΟΥ ΘΕΣΗ!');
                    
     return_losers_home();
     fill_board();
     }
      //elegxw an o kokkinos paei na faei pioni tou prasinou
     if (hasGGImage === true && game_status.p_turn === 'R'){
            alert('ΦΑΓΑΤΕ ΤΟ ΠΙΟΝΙ ΤΟΥ ΠΡΑΣΙΝΟΥ, ΕΠΙΣΤΡΕΦΕΙ ΣΤΗΝ ΑΡΧΙΚΗ ΤΟΥ ΘΕΣΗ!');
                    
     return_losers_home();
     fill_board();
     }
           //elegxw an o mple paei na faei pioni tou kitrinou
           if (hasYYImage === true && game_status.p_turn === 'B'){
            alert('ΦΑΓΑΤΕ ΤΟ ΠΙΟΝΙ ΤΟΥ ΚΙΤΡΙΝΟΥ, ΕΠΙΣΤΡΕΦΕΙ ΣΤΗΝ ΑΡΧΙΚΗ ΤΟΥ ΘΕΣΗ!');
                    
     return_losers_home();
     fill_board();
     }
             //elegxw an o mple paei na faei pioni tou prasinou
             if (hasGGImage === true && game_status.p_turn === 'B'){
                alert('ΦΑΓΑΤΕ ΤΟ ΠΙΟΝΙ ΤΟΥ ΠΡΑΣΙΝΟΥ, ΕΠΙΣΤΡΕΦΕΙ ΣΤΗΝ ΑΡΧΙΚΗ ΤΟΥ ΘΕΣΗ!');
                        
         return_losers_home();
         fill_board();
         }      
                    //elegxw an o mple paei na faei pioni tou kokkinou
                    if (hasRRImage === true && game_status.p_turn === 'B'){
                        alert('ΦΑΓΑΤΕ ΤΟ ΠΙΟΝΙ ΤΟΥ ΚΟΚΚΙΝΟΥ, ΕΠΙΣΤΡΕΦΕΙ ΣΤΗΝ ΑΡΧΙΚΗ ΤΟΥ ΘΕΣΗ!');
                                
                 return_losers_home();
                 fill_board();
                 }
    //elegxw an o prasinos paei na faei pioni tou kokkinou
    if (hasRRImage === true && game_status.p_turn === 'G'){
         alert('ΦΑΓΑΤΕ ΤΟ ΠΙΟΝΙ ΤΟΥ ΚΟΚΚΙΝΟΥ, ΕΠΙΣΤΡΕΦΕΙ ΣΤΗΝ ΑΡΧΙΚΗ ΤΟΥ ΘΕΣΗ!');
                                            
        return_losers_home();
    fill_board();
                             }
        //elegxw an o prasinos paei na faei pioni tou mple
        if (hasBBImage === true && game_status.p_turn === 'G'){
            alert('ΦΑΓΑΤΕ ΤΟ ΠΙΟΝΙ ΤΟΥ ΜΠΛΕ, ΕΠΙΣΤΡΕΦΕΙ ΣΤΗΝ ΑΡΧΙΚΗ ΤΟΥ ΘΕΣΗ!');
                                               
           return_losers_home();
       fill_board();
                                }
                                    //elegxw an o prasinos paei na faei pioni tou kitrinou
    if (hasYYImage === true && game_status.p_turn === 'G'){
        alert('ΦΑΓΑΤΕ ΤΟ ΠΙΟΝΙ ΤΟΥ ΚΙΤΡΙΝΟΥ, ΕΠΙΣΤΡΕΦΕΙ ΣΤΗΝ ΑΡΧΙΚΗ ΤΟΥ ΘΕΣΗ!');
                                           
       return_losers_home();
   fill_board();
                            }

}
   
function return_losers_home(){
    $.ajax({
        url: "ludo.php/return_losers_home",
        method: 'GET',
        dataType: "json",
        contentType: 'application/json',
        data: { action: 'return_home' },
        headers: { "X-Token": me.token },
        success: function(response) {
            // Handle the success response
          //fill_board_by_data();
          //fill_board();
        },
        error: function(xhr, status, error) {
            // Handle errors
            console.error(xhr.responseText);
        }
    });

}

function fill_red_win() {
    $.ajax({
        url: "ludo.php/red_win_pieces",
        method: 'GET',
        dataType: "json",
        contentType: 'application/json',
        data: { action: 'fill_red_win_pieces' },
        headers: { "X-Token": me.token },
        success: function (response) {
            var container = $('#red_win_pieces');
            
            // Clear the existing images
            container.empty();

            // Check if response has pieceValues and it's an array
            if (response.pieceValues && Array.isArray(response.pieceValues)) {
                // Iterate through the pieces and add new images
                $.each(response.pieceValues, function (index, pieceValue) {
                    var imageUrl = 'images/R' + pieceValue + '.png';
                    container.append('<img src="' + imageUrl + '" alt="' + pieceValue + '">');
                });
            } else {
                console.error("Pieces not found");
            }
        },
        error: function (xhr, status, error) {
            console.error("Error Response:", xhr.responseText);
        }
    });
}
function fill_green_win() {
    $.ajax({
        url: "ludo.php/green_win_pieces",
        method: 'GET',
        dataType: "json",
        contentType: 'application/json',
        data: { action: 'fill_green_win_pieces' },
        headers: { "X-Token": me.token },
        success: function (response) {
            var container = $('#green_win_pieces');
            
            // Clear the existing images
            container.empty();

            // Check if response has pieceValues and it's an array
            if (response.pieceValues && Array.isArray(response.pieceValues)) {
                // Iterate through the pieces and add new images
                $.each(response.pieceValues, function (index, pieceValue) {
                    var imageUrl = 'images/G' + pieceValue + '.png';
                    container.append('<img src="' + imageUrl + '" alt="' + pieceValue + '">');
                });
            } else {
                console.error("Pieces not found");
            }
        },
        error: function (xhr, status, error) {
            console.error("Error Response:", xhr.responseText);
        }
    });
}

function fill_blue_win() {
    $.ajax({
        url: "ludo.php/blue_win_pieces",
        method: 'GET',
        dataType: "json",
        contentType: 'application/json',
        data: { action: 'fill_blue_win_pieces' },
        headers: { "X-Token": me.token },
        success: function (response) {
            var container = $('#blue_win_pieces');
            
            // Clear the existing images
            container.empty();

            // Check if response has pieceValues and it's an array
            if (response.pieceValues && Array.isArray(response.pieceValues)) {
                // Iterate through the pieces and add new images
                $.each(response.pieceValues, function (index, pieceValue) {
                    var imageUrl = 'images/B' + pieceValue + '.png';
                    container.append('<img src="' + imageUrl + '" alt="' + pieceValue + '">');
                });
            } else {
                console.error("Pieces not found");
            }
        },
        error: function (xhr, status, error) {
            console.error("Error Response:", xhr.responseText);
        }
    });
}

   function fill_yellow_win(){
    $.ajax({
        url: "ludo.php/yellow_win_pieces",
        method: 'GET',
        dataType: "json",
        contentType: 'application/json',
        data: { action: 'fill_yellow_win_pieces'},
      
        headers: { "X-Token": me.token },
        success: function (response) {
            var container = $('#yellow_win_pieces');
            
            // Clear the existing images
            container.empty();
           
            // Check if response has pieceValues and it's an array
            if (response.pieceValues && Array.isArray(response.pieceValues)) {
                // Iterate through the pieces and add new images
                $.each(response.pieceValues, function (index, pieceValue) {
                    var imageUrl = 'images/Y' + pieceValue + '.png';
                    container.append('<img src="' + imageUrl + '" alt="' + pieceValue + '">');
                });
            } else {
                console.error("Pieces not found");
            }
        },
      error: function (xhr, status, error) {
          // Handle the error response
          console.error("Error Response:", xhr.responseText);
          // You might want to handle errors and display an appropriate message
        }
    } );
   }
//oi functions roll_dice gia kathe piece epistrefoun tis sintetagmenes me vasi to zari kai fwtismeno to path
function roll_dice_Y1() {
    $.ajax({
        url: "ludo.php/rollY1",
        method: 'GET',
        dataType: "json",
        contentType: 'application/json',
        data: { action: 'roll_dice' , piece_num:1 },
      
        headers: { "X-Token": me.token },
        success: function (data) {
           console.log("Success Response:", data);

        
          if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
               $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
         
                // Check if the dice result is 6
                if ('dice' in data && data[data.length - 1].dice === 6) {
                    makeImagesClickableY();
                    makeImagesUnclickableB();
                    makeImagesUnclickableR();
                    makeImagesUnclickableG();
               } else {
                makeImagesClickableY();
                makeImagesUnclickableB();
                makeImagesUnclickableR();
                makeImagesUnclickableG();
               }
              $("#the_move").val(
                  " " + data[data.length - 1].prev_x +
                  " " + data[data.length - 1].prev_y +
                  " " + data[data.length - 1].new_x +
                  "  " + data[data.length - 1].new_y
              );

            
          } else {
              console.error("Invalid dice result:", data);
            
          }
      },
      error: function (xhr, status, error) {
          console.error("Error Response:", xhr.responseText);
          }
      }); 
       $.ajax({
         url: "ludo.php/highlightY1",
         method: 'GET',
         dataType: "json",
         contentType: 'application/json',
         data: { action: 'Y1_highlight'  },
       
         headers: { "X-Token": me.token },
         success: function (data) {
            console.log("highlight coordinates : ", data);

            data.forEach(function(item) {
                var squareId = 'square_' + item.x + '_' + item.y;
                $('#' + squareId).addClass('highlight'); // Add a CSS class for highlighting
              
             // Remove the "highlight" class after 1000 milliseconds (1 seconds)
               setTimeout(function() {
                 $('#' + squareId).removeClass('highlight');
              },  1000);
              });
            }
              ,
       error: function (xhr, status, error) {
        
           console.error("Error Response:", xhr.responseText);
 
       }
     } );
    }
     


  function roll_dice_Y2() {
       $.ajax({
         url: "ludo.php/rollY2",
         method: 'GET',
         dataType: "json",
         contentType: 'application/json',
         data: { action: 'roll_dice' , piece_num:2 },
         headers: { "X-Token": me.token },
         success: function (data) {
            console.log("Success Response:", data);

         
           if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
                $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
          
                 // Check if the dice result is 6
                 if ('dice' in data && data[data.length - 1].dice === 6) {
                    makeImagesClickableY();
                    makeImagesUnclickableB();
                    makeImagesUnclickableR();
                    makeImagesUnclickableG();
                } else {
                    makeImagesClickableY();
                    makeImagesUnclickableB();
                    makeImagesUnclickableR();
                    makeImagesUnclickableG();
                }
               $("#the_move").val(
                   " " + data[data.length - 1].prev_x +
                   " " + data[data.length - 1].prev_y +
                   " " + data[data.length - 1].new_x +
                   "  " + data[data.length - 1].new_y
               );
 
             
           } else {
               console.error("Invalid dice result:", data);
 
           }
       },
       error: function (xhr, status, error) {
 
           console.error("Error Response:", xhr.responseText);
 
       }
   });        
   $.ajax({
     url: "ludo.php/highlightY2",
     method: 'GET',
     dataType: "json",
     contentType: 'application/json',
     data: { action: 'Y2_highlight'  },
   
     headers: { "X-Token": me.token },
     success: function (data) {
        console.log("highlight coordinates : ", data);

        data.forEach(function(item) {
            var squareId = 'square_' + item.x + '_' + item.y;
            $('#' + squareId).addClass('highlight'); // Add a CSS class for highlighting
          
         // Remove the "highlight" class after 1000 milliseconds (1 seconds)
           setTimeout(function() {
             $('#' + squareId).removeClass('highlight');
          },  1000);
          });
        }
          ,
   error: function (xhr, status, error) {
      
       console.error("Error Response:", xhr.responseText);
      
   }
 } );
}

   function roll_dice_Y3() {
         $.ajax({
         url: "ludo.php/rollY3",
         method: 'GET',
         dataType: "json",
         contentType: 'application/json',
         data: { action: 'roll_dice' , piece_num:3 },
         headers: { "X-Token": me.token },
         success: function (data) {
             // Handle the success response
             console.log("Success Response:", data);

             if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
                $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
          
                 // Check if the dice result is 6
                 if ('dice' in data && data[data.length - 1].dice === 6) {
                    makeImagesClickableY();
                    makeImagesUnclickableB();
                    makeImagesUnclickableR();
                    makeImagesUnclickableG();
                } else {
                    makeImagesClickableY();
                    makeImagesUnclickableB();
                    makeImagesUnclickableR();
                    makeImagesUnclickableG();
                }
 
               $("#the_move").val(
                   " " + data[data.length - 1].prev_x +
                   " " + data[data.length - 1].prev_y +
                   " " + data[data.length - 1].new_x +
                   "  " + data[data.length - 1].new_y
               ); 
           } else {
               console.error("Invalid dice result:", data);
            }
       },
       error: function (xhr, status, error) {
           console.error("Error Response:", xhr.responseText);
       }
   });         
   $.ajax({
     url: "ludo.php/highlightY3",
     method: 'GET',
     dataType: "json",
     contentType: 'application/json',
     data: { action: 'Y3_highlight'  },
   
     headers: { "X-Token": me.token },
     success: function (data) {
        console.log("highlight coordinates : ", data);

        data.forEach(function(item) {
            var squareId = 'square_' + item.x + '_' + item.y;
            $('#' + squareId).addClass('highlight'); // Add a CSS class for highlighting
          
         // Remove the "highlight" class after 1000 milliseconds (1 seconds)
           setTimeout(function() {
             $('#' + squareId).removeClass('highlight');
          },  1000);
          });
        }
          ,
   error: function (xhr, status, error) {
   
       console.error("Error Response:", xhr.responseText);
 
   }
 } );
} 

   function roll_dice_Y4() {
       $.ajax({
         url: "ludo.php/rollY4",
         method: 'GET',
         dataType: "json",
         contentType: 'application/json',
         data: { action: 'roll_dice' , piece_num:4 },
         headers: { "X-Token": me.token },
         success: function (data) {
            
             console.log("Success Response:", data);
 
          
            if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
                 $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
           
                  // Check if the dice result is 6
                  if ('dice' in data && data[data.length - 1].dice === 6) {
                     makeImagesClickableY();
                     makeImagesUnclickableB();
                     makeImagesUnclickableR();
                     makeImagesUnclickableG();
                 } else {
                    makeImagesClickableY();
                    makeImagesUnclickableB();
                    makeImagesUnclickableR();
                    makeImagesUnclickableG();
               //    do_move();
                 }
 
               $("#the_move").val(
                   " " + data[data.length - 1].prev_x +
                   " " + data[data.length - 1].prev_y +
                   " " + data[data.length - 1].new_x +
                   "  " + data[data.length - 1].new_y
               );
           } else {
               console.error("Invalid dice result:", data);
                }
       },
       error: function (xhr, status, error) {
           console.error("Error Response:", xhr.responseText);
                  }
    });         
    $.ajax({
      url: "ludo.php/highlightY4",
      method: 'GET',
      dataType: "json",
      contentType: 'application/json',
      data: { action: 'Y4_highlight'  },
    
      headers: { "X-Token": me.token },
      success: function (data) {
         console.log("highlight coordinates : ", data);
 
         data.forEach(function(item) {
             var squareId = 'square_' + item.x + '_' + item.y;
             $('#' + squareId).addClass('highlight'); // Add a CSS class for highlighting
           
          // Remove the "highlight" class after 3000 milliseconds (3 seconds)
            setTimeout(function() {
              $('#' + squareId).removeClass('highlight');
           },  1000);
           });
         }
           ,
    error: function (xhr, status, error) {
        // Handle the error response
        console.error("Error Response:", xhr.responseText);
        // You might want to handle errors and display an appropriate message
    }
  } );
 } 
 

     function roll_dice_R1() {
         $.ajax({
             url: "ludo.php/rollR1",
             method: 'GET',
             dataType: "json",
             contentType: 'application/json',
             data: { action: 'roll_dice' , piece_num:111 },
             headers: { "X-Token": me.token },
             success: function (data) {
              
                 console.log("Success Response:", data);
      
                         
           if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
            $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
      
             // Check if the dice result is 6
             if ('dice' in data && data[data.length - 1].dice === 6) {
                makeImagesClickableR();
                makeImagesUnclickableB();
                makeImagesUnclickableY();
                makeImagesUnclickableG();
                } else {
                    makeImagesClickableR();
                    makeImagesUnclickableB();
                    makeImagesUnclickableY();
                    makeImagesUnclickableG();
                //    do_move();
                               }
        
                   $("#the_move").val(
                       " " + data[data.length - 1].prev_x +
                       " " + data[data.length - 1].prev_y +
                       " " + data[data.length - 1].new_x +
                       "  " + data[data.length - 1].new_y
                   );
               
               } else {
                   console.error("Invalid dice result:", data);
                   // Handle the case where 'dice' is not present or invalid
               }
           },
           error: function (xhr, status, error) {
               // Handle the error response
               console.error("Error Response:", xhr.responseText);
               // You might want to handle errors and display an appropriate message
            }
        });         
        $.ajax({
          url: "ludo.php/highlightR1",
          method: 'GET',
          dataType: "json",
          contentType: 'application/json',
          data: { action: 'R1_highlight'  },
        
          headers: { "X-Token": me.token },
          success: function (data) {
             console.log("highlight coordinates : ", data);
     
             data.forEach(function(item) {
                 var squareId = 'square_' + item.x + '_' + item.y;
                 $('#' + squareId).addClass('highlight'); // Add a CSS class for highlighting
               
              // Remove the "highlight" class after 3000 milliseconds (3 seconds)
                setTimeout(function() {
                  $('#' + squareId).removeClass('highlight');
               },  1000);
               });
             }
               ,
        error: function (xhr, status, error) {
            // Handle the error response
            console.error("Error Response:", xhr.responseText);
            // You might want to handle errors and display an appropriate message
        }
      } );
     } 
     


       function roll_dice_R2() {
        $.ajax({
            url: "ludo.php/rollR2",
            method: 'GET',
            dataType: "json",
            contentType: 'application/json',
            data: { action: 'roll_dice' , piece_num:222 },
            headers: { "X-Token": me.token },
            success: function (data) {
             
                console.log("Success Response:", data);
     
                        
          if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
           $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
     
            // Check if the dice result is 6
            if ('dice' in data && data[data.length - 1].dice === 6) {
                makeImagesClickableR();
                makeImagesUnclickableB();
                makeImagesUnclickableY();
                makeImagesUnclickableG();
               } else {
                makeImagesClickableR();
                makeImagesUnclickableB();
                makeImagesUnclickableY();
                makeImagesUnclickableG();
    
                              }
       
                  $("#the_move").val(
                      " " + data[data.length - 1].prev_x +
                      " " + data[data.length - 1].prev_y +
                      " " + data[data.length - 1].new_x +
                      "  " + data[data.length - 1].new_y
                  );
              
              } else {
                  console.error("Invalid dice result:", data);
                 }
          },
          error: function (xhr, status, error) {
              console.error("Error Response:", xhr.responseText);
            }
        });         
        $.ajax({
          url: "ludo.php/highlightR2",
          method: 'GET',
          dataType: "json",
          contentType: 'application/json',
          data: { action: 'R2_highlight'  },
        
          headers: { "X-Token": me.token },
          success: function (data) {
             console.log("highlight coordinates : ", data);
     
             data.forEach(function(item) {
                 var squareId = 'square_' + item.x + '_' + item.y;
                 $('#' + squareId).addClass('highlight'); // Add a CSS class for highlighting
               
              // Remove the "highlight" class after 3000 milliseconds (3 seconds)
                setTimeout(function() {
                  $('#' + squareId).removeClass('highlight');
               },  1000);
               });
             }
               ,
        error: function (xhr, status, error) {
            // Handle the error response
            console.error("Error Response:", xhr.responseText);
            // You might want to handle errors and display an appropriate message
        }
      } );
     } 
     
      function roll_dice_R3() {
        $.ajax({
            url: "ludo.php/rollR3",
            method: 'GET',
            dataType: "json",
            contentType: 'application/json',
            data: { action: 'roll_dice' , piece_num:333 },
            headers: { "X-Token": me.token },
             success: function (data) {
              
                 console.log("Success Response:", data);
      
                         
           if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
            $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
      
             // Check if the dice result is 6
             if ('dice' in data && data[data.length - 1].dice === 6) {
                makeImagesClickableR();
                makeImagesUnclickableB();
                makeImagesUnclickableY();
                makeImagesUnclickableG();
                } else {
                    makeImagesClickableR();
                    makeImagesUnclickableB();
                    makeImagesUnclickableY();
                    makeImagesUnclickableG();
                              }
       
                  $("#the_move").val(
                      " " + data[data.length - 1].prev_x +
                      " " + data[data.length - 1].prev_y +
                      " " + data[data.length - 1].new_x +
                      "  " + data[data.length - 1].new_y
                  );
              
              } else {
                  console.error("Invalid dice result:", data);
              }
          },
          error: function (xhr, status, error) {
              console.error("Error Response:", xhr.responseText);
            }
        });         
        $.ajax({
          url: "ludo.php/highlightR3",
          method: 'GET',
          dataType: "json",
          contentType: 'application/json',
          data: { action: 'R3_highlight'  },
        
          headers: { "X-Token": me.token },
          success: function (data) {
             console.log("highlight coordinates : ", data);
     
             data.forEach(function(item) {
                 var squareId = 'square_' + item.x + '_' + item.y;
                 $('#' + squareId).addClass('highlight'); // Add a CSS class for highlighting
               
              // Remove the "highlight" class after 1000 milliseconds (1 seconds)
                setTimeout(function() {
                  $('#' + squareId).removeClass('highlight');
               },  1000);
               });
             }
               ,
        error: function (xhr, status, error) {
            console.error("Error Response:", xhr.responseText);
        }
      } );
     } 
     


      function roll_dice_R4() {
          $.ajax({
            url: "ludo.php/rollR4",
            method: 'GET',
            dataType: "json",
            contentType: 'application/json',
            data: { action: 'roll_dice' , piece_num:444},
            headers: { "X-Token": me.token },
            success: function (data) {
                console.log("Success Response:", data);
      
                         
                if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
                 $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
           
                  // Check if the dice result is 6
                  if ('dice' in data && data[data.length - 1].dice === 6) {
                         makeImagesClickableR();
                         makeImagesUnclickableB();
                         makeImagesUnclickableY();
                         makeImagesUnclickableG();
                     } else {
                        makeImagesClickableR();
                        makeImagesUnclickableB();
                        makeImagesUnclickableY();
                        makeImagesUnclickableG();
                                    }
             
       
                  $("#the_move").val(
                      " " + data[data.length - 1].prev_x +
                      " " + data[data.length - 1].prev_y +
                      " " + data[data.length - 1].new_x +
                      "  " + data[data.length - 1].new_y
                  );
              
              } else {
                  console.error("Invalid dice result:", data);
              }
          },
          error: function (xhr, status, error) {
              console.error("Error Response:", xhr.responseText);
    
            }
        });         
        $.ajax({
          url: "ludo.php/highlightR4",
          method: 'GET',
          dataType: "json",
          contentType: 'application/json',
          data: { action: 'R4_highlight'  },
        
          headers: { "X-Token": me.token },
          success: function (data) {
             console.log("highlight coordinates : ", data);
     
             data.forEach(function(item) {
                 var squareId = 'square_' + item.x + '_' + item.y;
                 $('#' + squareId).addClass('highlight'); // Add a CSS class for highlighting
            //afairesi class meta apo 1 defterolepto
                setTimeout(function() {
                  $('#' + squareId).removeClass('highlight');
               },  1000);
               });
             }
               ,
        error: function (xhr, status, error) {
            // Handle the error response
            console.error("Error Response:", xhr.responseText);
        }
      } );
     } 
     
     function roll_dice_G1() {
        $.ajax({
            url: "ludo.php/rollG1",
            method: 'GET',
            dataType: "json",
            contentType: 'application/json',
            data: { action: 'roll_dice' , piece_num:1111 },          
            headers: { "X-Token": me.token },
            success: function (data) {
               console.log("Success Response:", data);    
            
              if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
                   $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);

                    // Check if the dice result is 6
                    if ('dice' in data && data[data.length - 1].dice === 6) {
                       makeImagesClickableG();
                       makeImagesUnclickableR();
                       makeImagesUnclickableY();
                       makeImagesUnclickableB();
                   } else {
                    makeImagesClickableG();
                    makeImagesUnclickableR();
                    makeImagesUnclickableY();
                    makeImagesUnclickableB();
                 //    do_move();
                   }
                  $("#the_move").val(
                      " " + data[data.length - 1].prev_x +
                      " " + data[data.length - 1].prev_y +
                      " " + data[data.length - 1].new_x +
                      "  " + data[data.length - 1].new_y
                  );  
              } else {
                  console.error("Invalid dice result:", data);
                      }
          },
          error: function (xhr, status, error) {
               console.error("Error Response:", xhr.responseText);
                   }
          }); 
           $.ajax({
             url: "ludo.php/highlightG1",
             method: 'GET',
             dataType: "json",
             contentType: 'application/json',
             data: { action: 'G1_highlight'  },
           
             headers: { "X-Token": me.token },
             success: function (data) {
                console.log("highlight coordinates : ", data);
    
                data.forEach(function(item) {
                    var squareId = 'square_' + item.x + '_' + item.y;
                    $('#' + squareId).addClass('highlight'); // dimiourgia class highlight
                  
                 // afairesi tou class meta apo 1 defterolepto
                   setTimeout(function() {
                     $('#' + squareId).removeClass('highlight');
                  },  1000);
                  });
                }
                  ,
           error: function (xhr, status, error) {
               console.error("Error Response:", xhr.responseText);
         
           }
         } );
        }

        function roll_dice_G2() {
            $.ajax({
                url: "ludo.php/rollG2",
                method: 'GET',
                dataType: "json",
                contentType: 'application/json',
                data: { action: 'roll_dice' , piece_num:2222 },              
                headers: { "X-Token": me.token },
                success: function (data) {
                   console.log("Success Response:", data);        
                
                  if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
                       $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
                 
                        // Check if the dice result is 6
                        if ('dice' in data && data[data.length - 1].dice === 6) {
                           makeImagesClickableG();
                           makeImagesUnclickableR();
                           makeImagesUnclickableY();
                           makeImagesUnclickableB();
                       } else {
                        makeImagesClickableG();
                        makeImagesUnclickableR();
                        makeImagesUnclickableY();
                        makeImagesUnclickableB();
                     //    do_move();
                       }
                      $("#the_move").val(
                          " " + data[data.length - 1].prev_x +
                          " " + data[data.length - 1].prev_y +
                          " " + data[data.length - 1].new_x +
                          "  " + data[data.length - 1].new_y
                      );
                          
                  } else {
                      console.error("Invalid dice result:", data);   }
              },
              error: function (xhr, status, error) {
                       console.error("Error Response:", xhr.responseText);
                             }
              }); 
               $.ajax({
                 url: "ludo.php/highlightG2",
                 method: 'GET',
                 dataType: "json",
                 contentType: 'application/json',
                 data: { action: 'G2_highlight'  },
               
                 headers: { "X-Token": me.token },
                 success: function (data) {
                    console.log("highlight coordinates : ", data);
        
                    data.forEach(function(item) {
                        var squareId = 'square_' + item.x + '_' + item.y;
                        $('#' + squareId).addClass('highlight'); // prosthetw to class highlight 
                      
                     // afairww to class meta apo 1 defterolepto
                       setTimeout(function() {
                         $('#' + squareId).removeClass('highlight');
                      },  1000);
                      });
                    }
                      ,
               error: function (xhr, status, error) {                 
                   console.error("Error Response:", xhr.responseText);                    
               }
             } );
            }
            function roll_dice_G3() {
                $.ajax({
                    url: "ludo.php/rollG3",
                    method: 'GET',
                    dataType: "json",
                    contentType: 'application/json',
                    data: { action: 'roll_dice' , piece_num:3333 },              
                    headers: { "X-Token": me.token },
                    success: function (data) {
                       console.log("Success Response:", data);        
                    
                      if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
                           $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
                     
                            // Check if the dice result is 6
                            if ('dice' in data && data[data.length - 1].dice === 6) {
                               makeImagesClickableG();
                               makeImagesUnclickableR();
                               makeImagesUnclickableY();
                               makeImagesUnclickableB();
                           } else {
                            makeImagesClickableG();
                            makeImagesUnclickableR();
                            makeImagesUnclickableY();
                            makeImagesUnclickableB();
                         //    do_move();
                           }
                          $("#the_move").val(
                              " " + data[data.length - 1].prev_x +
                              " " + data[data.length - 1].prev_y +
                              " " + data[data.length - 1].new_x +
                              "  " + data[data.length - 1].new_y
                          );
                              
                      } else {
                          console.error("Invalid dice result:", data);   }
                  },
                  error: function (xhr, status, error) {
                           console.error("Error Response:", xhr.responseText);
                                 }
                  }); 
                   $.ajax({
                     url: "ludo.php/highlightG3",
                     method: 'GET',
                     dataType: "json",
                     contentType: 'application/json',
                     data: { action: 'G3_highlight'  },
                   
                     headers: { "X-Token": me.token },
                     success: function (data) {
                        console.log("highlight coordinates : ", data);
            
                        data.forEach(function(item) {
                            var squareId = 'square_' + item.x + '_' + item.y;
                            $('#' + squareId).addClass('highlight'); // prosthetw to class highlight 
                          
                         // afairww to class meta apo 1 defterolepto
                           setTimeout(function() {
                             $('#' + squareId).removeClass('highlight');
                          },  1000);
                          });
                        }
                          ,
                   error: function (xhr, status, error) {                 
                       console.error("Error Response:", xhr.responseText);                    
                   }
                 } );
                }
   function roll_dice_G4() {
       $.ajax({
           url: "ludo.php/rollG4",
           method: 'GET',
           dataType: "json",
           contentType: 'application/json',
           data: { action: 'roll_dice' , piece_num:4444 },              
           headers: { "X-Token": me.token },
           success: function (data) {
              console.log("Success Response:", data);        
           
             if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
                  $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
            
                   // Check if the dice result is 6
                   if ('dice' in data && data[data.length - 1].dice === 6) {
                      makeImagesClickableG();
                      makeImagesUnclickableR();
                      makeImagesUnclickableY();
                      makeImagesUnclickableB();
                  } else {
                   makeImagesClickableG();
                   makeImagesUnclickableR();
                   makeImagesUnclickableY();
                   makeImagesUnclickableB();
                //    do_move();
                  }
                 $("#the_move").val(
                     " " + data[data.length - 1].prev_x +
                     " " + data[data.length - 1].prev_y +
                     " " + data[data.length - 1].new_x +
                     "  " + data[data.length - 1].new_y
                 );
                     
             } else {
                 console.error("Invalid dice result:", data);   }
         },
         error: function (xhr, status, error) {
                  console.error("Error Response:", xhr.responseText);
                        }
         }); 
          $.ajax({
            url: "ludo.php/highlightG4",
            method: 'GET',
            dataType: "json",
            contentType: 'application/json',
            data: { action: 'G4_highlight'  },
          
            headers: { "X-Token": me.token },
            success: function (data) {
               console.log("highlight coordinates : ", data);
   
               data.forEach(function(item) {
                   var squareId = 'square_' + item.x + '_' + item.y;
                   $('#' + squareId).addClass('highlight'); // prosthetw to class highlight 
                 
                // afairww to class meta apo 1 defterolepto
                  setTimeout(function() {
                    $('#' + squareId).removeClass('highlight');
                 },  1000);
                 });
               }
                 ,
          error: function (xhr, status, error) {                 
              console.error("Error Response:", xhr.responseText);                    
          }
        } );
       }

       function roll_dice_B1() {
        $.ajax({
            url: "ludo.php/rollB1",
            method: 'GET',
            dataType: "json",
            contentType: 'application/json',
            data: { action: 'roll_dice' , piece_num:11 },              
            headers: { "X-Token": me.token },
            success: function (data) {
               console.log("Success Response:", data);        
            
              if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
                   $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
             
                    // Check if the dice result is 6
                    if ('dice' in data && data[data.length - 1].dice === 6) {
                       makeImagesClickableB();
                       makeImagesUnclickableR();
                       makeImagesUnclickableY();
                       makeImagesUnclickableG();
                   } else {
                    makeImagesClickableB();
                    makeImagesUnclickableR();
                    makeImagesUnclickableY();
                    makeImagesUnclickableG();
                 //    do_move();
                   }
                  $("#the_move").val(
                      " " + data[data.length - 1].prev_x +
                      " " + data[data.length - 1].prev_y +
                      " " + data[data.length - 1].new_x +
                      "  " + data[data.length - 1].new_y
                  );
                      
              } else {
                  console.error("Invalid dice result:", data);   }
          },
          error: function (xhr, status, error) {
                   console.error("Error Response:", xhr.responseText);
                         }
          }); 
           $.ajax({
             url: "ludo.php/highlightB1",
             method: 'GET',
             dataType: "json",
             contentType: 'application/json',
             data: { action: 'B1_highlight'  },
           
             headers: { "X-Token": me.token },
             success: function (data) {
                console.log("highlight coordinates : ", data);
    
                data.forEach(function(item) {
                    var squareId = 'square_' + item.x + '_' + item.y;
                    $('#' + squareId).addClass('highlight'); // prosthetw to class highlight 
                  
                 // afairww to class meta apo 1 defterolepto
                   setTimeout(function() {
                     $('#' + squareId).removeClass('highlight');
                  },  1000);
                  });
                }
                  ,
           error: function (xhr, status, error) {                 
               console.error("Error Response:", xhr.responseText);                    
           }
         } );
        }


        function roll_dice_B2() {
            $.ajax({
                url: "ludo.php/rollB2",
                method: 'GET',
                dataType: "json",
                contentType: 'application/json',
                data: { action: 'roll_dice' , piece_num:22 },              
                headers: { "X-Token": me.token },
                success: function (data) {
                   console.log("Success Response:", data);        
                
                  if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
                       $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
                 
                        // Check if the dice result is 6
                        if ('dice' in data && data[data.length - 1].dice === 6) {
                           makeImagesClickableB();
                           makeImagesUnclickableR();
                           makeImagesUnclickableY();
                           makeImagesUnclickableG();
                       } else {
                        makeImagesClickableB();
                        makeImagesUnclickableR();
                        makeImagesUnclickableY();
                        makeImagesUnclickableG();
                     //    do_move();
                       }
                      $("#the_move").val(
                          " " + data[data.length - 1].prev_x +
                          " " + data[data.length - 1].prev_y +
                          " " + data[data.length - 1].new_x +
                          "  " + data[data.length - 1].new_y
                      );
                          
                  } else {
                      console.error("Invalid dice result:", data);   }
              },
              error: function (xhr, status, error) {
                       console.error("Error Response:", xhr.responseText);
                             }
              }); 
               $.ajax({
                 url: "ludo.php/highlightB2",
                 method: 'GET',
                 dataType: "json",
                 contentType: 'application/json',
                 data: { action: 'B2_highlight'  },
               
                 headers: { "X-Token": me.token },
                 success: function (data) {
                    console.log("highlight coordinates : ", data);
        
                    data.forEach(function(item) {
                        var squareId = 'square_' + item.x + '_' + item.y;
                        $('#' + squareId).addClass('highlight'); // prosthetw to class highlight 
                      
                     // afairww to class meta apo 1 defterolepto
                       setTimeout(function() {
                         $('#' + squareId).removeClass('highlight');
                      },  1000);
                      });
                    }
                      ,
               error: function (xhr, status, error) {                 
                   console.error("Error Response:", xhr.responseText);                    
               }
             } );
            }

            function roll_dice_B3() {
                $.ajax({
                    url: "ludo.php/rollB3",
                    method: 'GET',
                    dataType: "json",
                    contentType: 'application/json',
                    data: { action: 'roll_dice' , piece_num:33 },              
                    headers: { "X-Token": me.token },
                    success: function (data) {
                       console.log("Success Response:", data);        
                    
                      if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
                           $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
                     
                            // Check if the dice result is 6
                            if ('dice' in data && data[data.length - 1].dice === 6) {
                               makeImagesClickableB();
                               makeImagesUnclickableR();
                               makeImagesUnclickableY();
                               makeImagesUnclickableG();
                           } else {
                            makeImagesClickableB();
                            makeImagesUnclickableR();
                            makeImagesUnclickableY();
                            makeImagesUnclickableG();
                         //    do_move();
                           }
                          $("#the_move").val(
                              " " + data[data.length - 1].prev_x +
                              " " + data[data.length - 1].prev_y +
                              " " + data[data.length - 1].new_x +
                              "  " + data[data.length - 1].new_y
                          );
                              
                      } else {
                          console.error("Invalid dice result:", data);   }
                  },
                  error: function (xhr, status, error) {
                           console.error("Error Response:", xhr.responseText);
                                 }
                  }); 
                   $.ajax({
                     url: "ludo.php/highlightB3",
                     method: 'GET',
                     dataType: "json",
                     contentType: 'application/json',
                     data: { action: 'B3_highlight'  },
                   
                     headers: { "X-Token": me.token },
                     success: function (data) {
                        console.log("highlight coordinates : ", data);
            
                        data.forEach(function(item) {
                            var squareId = 'square_' + item.x + '_' + item.y;
                            $('#' + squareId).addClass('highlight'); // prosthetw to class highlight 
                          
                         // afairww to class meta apo 1 defterolepto
                           setTimeout(function() {
                             $('#' + squareId).removeClass('highlight');
                          },  1000);
                          });
                        }
                          ,
                   error: function (xhr, status, error) {                 
                       console.error("Error Response:", xhr.responseText);                    
                   }
                 } );
                }

                function roll_dice_B4() {
                    $.ajax({
                        url: "ludo.php/rollB4",
                        method: 'GET',
                        dataType: "json",
                        contentType: 'application/json',
                        data: { action: 'roll_dice' , piece_num:44 },              
                        headers: { "X-Token": me.token },
                        success: function (data) {
                           console.log("Success Response:", data);        
                        
                          if (Array.isArray(data) && data.length > 0 && 'dice' in data[data.length - 1]) {
                               $("#diceResult").text("Dice Result: " + data[data.length - 1].dice);
                         
                                // Check if the dice result is 6
                                if ('dice' in data && data[data.length - 1].dice === 6) {
                                   makeImagesClickableB();
                                   makeImagesUnclickableR();
                                   makeImagesUnclickableY();
                                   makeImagesUnclickableG();
                               } else {
                                makeImagesClickableB();
                                makeImagesUnclickableR();
                                makeImagesUnclickableY();
                                makeImagesUnclickableG();
                             //    do_move();
                               }
                              $("#the_move").val(
                                  " " + data[data.length - 1].prev_x +
                                  " " + data[data.length - 1].prev_y +
                                  " " + data[data.length - 1].new_x +
                                  "  " + data[data.length - 1].new_y
                              );
                                  
                          } else {
                              console.error("Invalid dice result:", data);   }
                      },
                      error: function (xhr, status, error) {
                               console.error("Error Response:", xhr.responseText);
                                     }
                      }); 
                       $.ajax({
                         url: "ludo.php/highlightB4",
                         method: 'GET',
                         dataType: "json",
                         contentType: 'application/json',
                         data: { action: 'B4_highlight'  },
                       
                         headers: { "X-Token": me.token },
                         success: function (data) {
                            console.log("highlight coordinates : ", data);
                
                            data.forEach(function(item) {
                                var squareId = 'square_' + item.x + '_' + item.y;
                                $('#' + squareId).addClass('highlight'); // prosthetw to class highlight 
                              
                             // afairww to class meta apo 1 defterolepto
                               setTimeout(function() {
                                 $('#' + squareId).removeClass('highlight');
                              },  1000);
                              });
                            }
                              ,
                       error: function (xhr, status, error) {                 
                           console.error("Error Response:", xhr.responseText);                    
                       }
                     } );
                    }
    
  function makeImagesClickableY() {
      // Make all image td elements clickable and highlighted
      $('.piece').filter('[src^="images/Y"]').parent('td').addClass('clickableY').click(onImageClickY);
     // $('.piece').parent('td').addClass('clickableY').click(onImageClickY);
  }
    function makeImagesClickableR() {
     // Make all image td elements clickable and highlighted
     $('.piece').filter('[src^="images/R"]').parent('td').addClass('clickableR').click(onImageClickR);
  }
  function makeImagesClickableG() {
     // Make all image td elements clickable and highlighted
     $('.piece').filter('[src^="images/G"]').parent('td').addClass('clickableG').click(onImageClickG);
  }
  function makeImagesClickableB() {
     // Make all image td elements clickable and highlighted
     $('.piece').filter('[src^="images/B"]').parent('td').addClass('clickableB').click(onImageClickB);
  }

  function makeImagesUnclickableY() {
    // Remove clickability and highlighting from image td elements
    $('.piece').parent('td').removeClass('clickableY').off('click', onImageClickY);
}
    function makeImagesUnclickableR() {
        // Remove clickability and highlighting from image td elements
        $('.piece').parent('td').removeClass('clickableR').off('click', onImageClickR);
    }
    function makeImagesUnclickableG() {
        // Remove clickability and highlighting from image td elements
        $('.piece').parent('td').removeClass('clickableG').off('click', onImageClickG);
    }
    function makeImagesUnclickableB() {
        // Remove clickability and highlighting from image td elements
        $('.piece').parent('td').removeClass('clickableB').off('click', onImageClickB);
    }

    var isOnImageClickRCalled = false;
    function onImageClickR(e) {
        isOnImageClickRCalled = true;
        var clickedTd = e.currentTarget;
        var imageName = $(clickedTd).find('img').attr('src'); // Get the image source
    
        // Check if the image name starts with "RR"
        if (imageName && imageName.startsWith('images/RR')) {
            // Extract the number from the image name (assuming it follows the RR1, RR2 pattern)
            var imageNumber = imageName.replace('images/RR', '').replace('.png', '');
          
            // Use a switch statement to distinguish different actions based on the image number
            switch (imageNumber) {
                case '1':
                    // Action for RR1
                    console.log('Clicked on RR1:', imageName);
                 //   do_move();
                    roll_dice_R1();
                   // do_move();
                    break;
                case '2':
                    // Action for RR2
                    console.log('Clicked on RR2:', imageName);
                   // do_move();
                    roll_dice_R2();
                 //   do_move();
                    // Add your custom logic for RR2
                    break;
                case '3':
                    // Action for RR3
                    console.log('Clicked on RR3:', imageName);
                //    do_move();
                    roll_dice_R3();
                  //  do_move();
                    // Add your custom logic for RR3
                    break;
                case '4':
                    // Action for RR4
                    console.log('Clicked on RR4:', imageName);
                 //   do_move();
                    roll_dice_R4();
                 //  do_move();
                    // Add your custom logic for RR4
                    break;
                default:
                    // Default action if the image number doesn't match any case
                    console.log('Clicked on RR image with unknown number:', imageName);
                    // Add default logic
            }
        } else {
            console.log('Clicked on non-RR image:', imageName);
            // Add logic for other images if needed
        }
    }
    var isOnImageClickGCalled = false;
    function onImageClickG(e) {
        isOnImageClickGCalled = true;
        var clickedTd = e.currentTarget;
        var imageName = $(clickedTd).find('img').attr('src'); // Get the image source
    
        // Check if the image name starts with "GG"
        if (imageName && imageName.startsWith('images/GG')) {
         
            var imageNumber = imageName.replace('images/GG', '').replace('.png', '');
 
            switch (imageNumber) {
                case '1': 
                    console.log('Clicked on GG1:', imageName);
                     roll_dice_G1();
                    break;
                case '2':
                     console.log('Clicked on GG2:', imageName);
                    roll_dice_G2(); 
                    break;
                case '3':
                    // Action for GG3
                    console.log('Clicked on RR3:', imageName);
                    roll_dice_G3();        
                    break;
                case '4':
                    console.log('Clicked on RR4:', imageName);                
                    roll_dice_G4();
                    break;
                default:
                    console.log('Clicked on GG image with unknown number:', imageName);

            }
        } else {
            console.log('Clicked on non-GG image:', imageName);
        }
    }

    var isOnImageClickBCalled = false;
    function onImageClickB(e) {
        isOnImageClickBCalled = true;
        var clickedTd = e.currentTarget;
        var imageName = $(clickedTd).find('img').attr('src'); // Get the image source
    
        // Check if the image name starts with "GG"
        if (imageName && imageName.startsWith('images/BB')) {
         
            var imageNumber = imageName.replace('images/BB', '').replace('.png', '');
 
            switch (imageNumber) {
                case '1': 
                    console.log('Clicked on BB1:', imageName);
                     roll_dice_B1();
                    break;
                case '2':
                     console.log('Clicked on BB2:', imageName);
                    roll_dice_B2(); 
                    break;
                case '3':
                    // Action for BB3
                    console.log('Clicked on BB3:', imageName);
                    roll_dice_B3();        
                    break;
                case '4':
                    console.log('Clicked on BB4:', imageName);                
                    roll_dice_B4();
                    break;
                default:
                    console.log('Clicked on BB image with unknown number:', imageName);

            }
        } else {
            console.log('Clicked on non-BB image:', imageName);
        }
    }

    var isOnImageClickYCalled = false;
    function onImageClickY(e) {
        isOnImageClickYCalled = true;
        var clickedTd = e.currentTarget;
        var imageName = $(clickedTd).find('img').attr('src'); // Get the image source
    
        // Check if the image name starts with "YY"
        if (imageName && imageName.startsWith('images/YY')) {
             
            var imageNumber = imageName.replace('images/YY', '').replace('.png', '');
          
            // Use a switch statement to distinguish different actions based on the image number
            switch (imageNumber) {
                case '1':
                    // Action for YY1
                    console.log('Clicked on YY1:', imageName);
                 //   do_move();
                    roll_dice_Y1();
                //   do_move();
                    break;
                case '2':
                    // Action for YY2
                    console.log('Clicked on YY2:', imageName);
        //           do_move();
              roll_dice_Y2();
            //     do_move();
                    // Add your custom logic for YY2
                    break;
                case '3':
                    // Action for YY3
                    console.log('Clicked on YY3:', imageName);
                   // do_move();
                  roll_dice_Y3();
              //      do_move();
                    // Add your custom logic for YY3
                    break;
                case '4':
                    // Action for YY4
                    console.log('Clicked on YY4:', imageName);
                  //  do_move();
                    roll_dice_Y4();
                //    do_move();
                    // Add your custom logic for YY4
                    break;
                default:
                    // Default action if the image number doesn't match any case
                    console.log('Clicked on YY image with unknown number:', imageName);
                    // Add default logic
            }
        } else {
            console.log('Clicked on non-YY image:', imageName);
            // Add logic for other images if needed
        }
    }

  // Define a variable to track if onImageClickY is called

 
  function is_red_image_clicked() {
    return isOnImageClickRCalled;
}
  function is_yellow_image_clicked() {
    return isOnImageClickYCalled;
}
function is_green_image_clicked() {
    return isOnImageClickGCalled;
}
function is_blue_image_clicked() {
    return isOnImageClickBCalled;
}
function reset_yellow_img_click_status() {
    isOnImageClickYCalled = false;
}
function reset_green_img_click_status() {
    isOnImageClickGCalled = false;
}
function reset_blue_img_click_status() {
    isOnImageClickBCalled = false;
}



function reset_red_img_click_status() {
    isOnImageClickRCalled = false;
}
    
 

        function move_result(data){
            fill_red_win();
            fill_yellow_win();
            fill_green_win();
            fill_blue_win();
            fill_board_by_data(data);
            game_status_update();
           // reset_timer();
           res();
check_turn();
 clearInterval(seti);
 document.body.style.backgroundImage = "linear-gradient(to top left, #c0392b, #e74c3c , #9b59b6)";

 setTimeout(function() {
  //alert("Εκανες κινηση! ");        
 
     var theMoveInput = document.getElementById("the_move");

 

theMoveInput.value = "";
$('#move_div_roll').hide(5000);
$('#move_div').hide(5000);

timer=setTimeout(function() { game_status_update();}, 4000);
;
}, 100);  

        }
        
 
        

 
         
        