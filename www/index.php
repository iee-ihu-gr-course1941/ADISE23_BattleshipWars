
<?php

    include_once "header.php";

?>


        <div id="h1Name"><h1 id="name">γκρινιαρης</h1></div>

    <section id='main_body'>

        <div id='ludo_board'></div>
        
        <div id="background"></div>
       
<div id="imageContainer">  </div>
<div id='yellow_lost_pieces'></div>
        <div id='red_lost_pieces'></div>

<div id="wrapper">
  <p id="point">0</p>
  <button id="play">Play</button>
  <div id="platform">
    <div id="dice">
      <div class="side front">
        <div class="dot center"></div>
      </div>
      <div class="side front inner"></div>
      <div class="side top">
        <div class="dot dtop dleft"></div>
        <div class="dot dbottom dright"></div>
      </div>
      <div class="side top inner"></div>
      <div class="side right">
        <div class="dot dtop dleft"></div>
        <div class="dot center"></div>
        <div class="dot dbottom dright"></div>
      </div>
      <div class="side right inner"></div>
      <div class="side left">
        <div class="dot dtop dleft"></div>
        <div class="dot dtop dright"></div>
        <div class="dot dbottom dleft"></div>
        <div class="dot dbottom dright"></div>
      </div>
      <div class="side left inner"></div>
      <div class="side bottom">
        <div class="dot center"></div>
        <div class="dot dtop dleft"></div>
        <div class="dot dtop dright"></div>
        <div class="dot dbottom dleft"></div>
        <div class="dot dbottom dright"></div>
      </div>
      <div class="side bottom inner"></div>
      <div class="side back">
        <div class="dot dtop dleft"></div>
        <div class="dot dtop dright"></div>
        <div class="dot dbottom dleft"></div>
        <div class="dot dbottom dright"></div>
        <div class="dot center dleft"></div>
        <div class="dot center dright"></div>
      </div>
      <div class="side back inner"></div>
      <div class="side cover x"></div>
      <div class="side cover y"></div>
      <div class="side cover z"></div>
    </div>
  </div>
</div>





        <div id='ui_Chat'>
            <a id='game_info'>
             
        </div>
     
    </section>

    <div id="gameButton">
        <button id='ludo_reset' class='btn btn-primary'>Restart</button><br><!--το κουμπι reset board βημα 1-->
       
        <div id='game_initializer'>
            <input id='username'> 
            <select id='pcolor'>
            <option value='R'>R</option>
            <option value='B'>B</option>
            <option value='G'>G</option>
            <option value='Y'>Y</option>
            </select>    
          
        <button id='ludo_login' class='btn btn-primary'>ΕΙΣΟΔΟΣ ΣΤΟ ΠΑΙΧΝΙΔΙ</button><br>
        </div>   
        <div id='move_div'>
                    Δώσε κίνηση (x1 y1 x2 y2): <input id='the_move'> 
                     <button id='do_move' class='btn btn-primary'>ΚΑΝΕ ΤΗΝ ΚΙΝΗΣΗ</button> </div>
                     <br><br>
 
</div>
                 
 
                     
                     <div id='move_div_roll'>
    Έτυχες: <span id='the_move_roll'> </span>
    <button id='do_move_roll' class='btn btn-primary'>ΡΙΞΕ ΖΑΡΙ</button>
</div>

<div id="diceResult"></div>
        

        <button id='players_reset' class='btn btn-primary'>ΤΟΟΟ ΚΟΥΜΠΙ NULL(100% ΔΟΥΛΕΥΕΙ)</button><br>

    </div>
 
 

<?php

    include_once "footer.php";

?>