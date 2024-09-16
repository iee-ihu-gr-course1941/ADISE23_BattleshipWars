<?php

function get_timer_value() {
    global $mysqli;
// Call the stored procedure
$sql = "CALL timer_value()";
$result = $mysqli ->query($sql);

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

?>