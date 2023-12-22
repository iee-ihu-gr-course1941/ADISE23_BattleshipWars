var me={token:null,piece_color:null};
var game_status={};
var board={};
var last_update=new Date().getTime();
var timer=null;


$(function(){
    draw_empty_board();
    fill_board();
  //  fill_red_lost();
   //  fill_yellow_lost();

    $('#ludo_login').click(login_to_game);
    $('#ludo_reset').click(reset_board);
    $('#players_reset').click(reset_players);
 

    $('#do_move').click(do_move);
    $('#move_div').hide();
    $('#do_move_roll').click(roll_dice);
    $('#move_div_roll').hide();
    $('YY1.png').click(roll_dice_Y1);
 

   // $('#the_move_src').change( update_moves_selector);
	//$('#do_move2').click( do_move2);
});

function roll_dice(){
    
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
  } else {
     makeImagesClickableR();
  }

          
     },
     error: function() {
         alert('Error occurred while rolling the dice.');
     }
 });
// game_status_update();
    }

//dice anmimation 

$('#play').click(function(){
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
  } else {
     makeImagesClickableR();
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
 
    
  });

 
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
                alert('js Database updated successfully!');
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

    //reload ta pieces
    $('#red_win_pieces').empty();
    $('#yellow_win_pieces').empty();

}



function fill_board_by_data(data) {
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
    fill_red_win();
    fill_yellow_win();
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
         if(game_status.p_turn==me.piece_color &&  me.piece_color!=null) {
           x=0;
            // do play
         if(game_stat_old.p_turn!=game_status.p_turn) {
                fill_board();
          }
  

          $('#move_div_roll').show(1000);
           $('#move_div').show(1000);

           fill_board_by_data(data);
         //  fill_red_lost();
          // fill_yellow_lost();
           timer=setTimeout(function() { game_status_update();}, 4000);
          
        } else {
            // must wait for something
                 
          var theMoveInput = document.getElementById("the_move");

          // Clear the input value
          theMoveInput.value = "";
            $('#move_div_roll').hide(5000);
          $('#move_div').hide(5000);
            fill_board_by_data(data);
          //  fill_red_lost();
          //  fill_yellow_lost();
         timer=setTimeout(function() { game_status_update();}, 4000);
         
        }
 

    }
 
      function update_info(){
            $('#game_info').html("I am Player: "+me.piece_color+", my name is "+me.username 
            +'<br>Token='+me.token+'<br>Game state: '+game_status.status+', '+ game_status.p_turn+' must play now.'  );
            
            
        }
   
   
        function do_move() {
            var s = $('#the_move').val();
            
            var a = s.trim().split(/[ ]+/);
            if(a.length!=4) {
             //   alert('Must give 4 numbers');
                return;
            }

            var result_Y = checkYYImagesBeforeMove();
            var result_R = checkRRImagesBeforeMove();


            var hasYYImage =result_Y.hasYYImage;
            var hasRRImage=result_R.hasRRImage;

            var imageY= result_Y.imageName;
            var imageR= result_R.imageName;



            //elegxw ama o paiktis pou paizei exei diko tou pioni sti thesi pou thelei na paei an oxi kanei thn kinisi
            if (hasYYImage === false && game_status.p_turn === 'Y' || hasRRImage === false && game_status.p_turn === 'R') {
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


        //elegxw an o kokkinos paei na faei pioni tou kitrinou
        if (hasYYImage === true && game_status.p_turn === 'R'){
                       alert('FAGATE TO PIONI TOU ANTIPALOU!');
                       
        
          //  $("#imageContainer").append(`<img src="${imageY}"  >`);
          fill_red_win();
            fill_yellow_win();
        }
        
      //elegxw an o kitrinos paei na faei pioni tou kokkinou
    if (hasRRImage === true && game_status.p_turn === 'Y') {
        alert('FAGATE TO PIONI TOU ANTIPALOU!');
        fill_red_win();
        fill_yellow_win();
    //  $("#imageContainer").append(`<img src="${imageR}"  >`);
    }
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
                   makeImagesUnclickableR();
               } else {
                  makeImagesClickableY();

                   makeImagesUnclickableR();
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
     


  function roll_dice_Y2() {
   
     // Make an AJAX call to the server to perform the move
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
                    makeImagesUnclickableR();
                } else {
                   makeImagesClickableY();

                    makeImagesUnclickableR();
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
                    makeImagesUnclickableR();
                } else {
                   makeImagesClickableY();

                    makeImagesUnclickableR();
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
                     makeImagesUnclickableR();
                 } else {
                    makeImagesClickableY();
 
                     makeImagesUnclickableR();
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
         // Make an AJAX call to the server to perform the move
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
                    makeImagesUnclickableY();
                } else {
                    makeImagesClickableR();
                    makeImagesUnclickableY();
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
        // Make an AJAX call to the server to perform the move
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
                   makeImagesUnclickableY();
               } else {
                   makeImagesClickableR();
                   makeImagesUnclickableY();
               //   do_move();
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
        // Make an AJAX call to the server to perform the move
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
                    makeImagesUnclickableY();
                } else {
                    makeImagesClickableR();
                    makeImagesUnclickableY();
             //      do_move();
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
     


      function roll_dice_R4() {
        // Make an AJAX call to the server to perform the move
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
                         makeImagesUnclickableY();
                     } else {
                         makeImagesClickableR();
                         makeImagesUnclickableY();
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
     


       function makeImagesClickableR() {
        // Make all image td elements clickable and highlighted
        $('.piece').filter('[src^="images/R"]').parent('td').addClass('clickableR').click(onImageClickR);
 
    }
    function makeImagesUnclickableR() {
        // Remove clickability and highlighting from image td elements
        $('.piece').parent('td').removeClass('clickableR').off('click', onImageClickR);
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
   

    function makeImagesClickableY() {
        // Make all image td elements clickable and highlighted
        $('.piece').filter('[src^="images/Y"]').parent('td').addClass('clickableY').click(onImageClickY);
       // $('.piece').parent('td').addClass('clickableY').click(onImageClickY);
    }
    function makeImagesUnclickableY() {
        // Remove clickability and highlighting from image td elements
        $('.piece').parent('td').removeClass('clickableY').off('click', onImageClickY);
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


  function is_yellow_image_clicked() {
    return isOnImageClickYCalled;
}

function reset_yellow_img_click_status() {
    isOnImageClickYCalled = false;
}


 
function is_red_image_clicked() {
    return isOnImageClickRCalled;
}

function reset_red_img_click_status() {
    isOnImageClickRCalled = false;
}
    
 

        function move_result(data){
          //  fill_board_by_data
         
            fill_board_by_data(data);
            game_status_update();
        }
        
 
        

 
         
        