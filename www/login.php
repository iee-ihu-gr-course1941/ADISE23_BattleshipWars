
<?php

    include_once "header.php";

?>

<link href="../www/css/login.css" rel="stylesheet" type="text/css">
  
  
    <div id="h1Name"><h1 id="name">Login</h1></div>

    <section id='main_body'>
        
    
  <form action="../lib/login.inc.php" method="post">
      <?php
          if(isset($_GET["error"])){
              if($_GET["error"] == "emptyinput"){
                  echo "<p>Fill in all fields!</p>";
              }
              else if($_GET["error"] == "wronglogin"){
                  echo "<p>Wrong login!</p>";
              }
          }
      ?>
<div class="ring">
    <i style="--clr:#00ff0a;"></i>
    <i style="--clr:#ff0057;"></i>
    <i style="--clr:#fffd44;"></i>
    <div class="login">
      <h2>Welcome!</h2>
      <div class="inputBx">
        <input type="text" name="username" placeholder="Username/Email">
      </div>
      <div class="inputBx">
        <input type="password" name="pwd" placeholder="Password"> 
      </div>
      <div class="inputBx">
        <button id='submit' type="submit" name="submit">Login</button>
      </div>
       
    </div>
  </div>
 
     </div>
    </section>

    <div id=''></div>

    <div id="gameButton">
       
    </div>

<?php

    include_once "footer.php";

?>