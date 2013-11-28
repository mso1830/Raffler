<?php
$http=$_SERVER['REQUEST_METHOD'];
if ($http=='GET') {
  $json='[{
      "id": 1,
      "name": "kip",
      "winner": false
    }, {
      "id": 2,
      "name": "moe",
      "winner": false
    }, {
      "id": 3,
      "name": "larry",
      "winner": false
    }, {
      "id": 4,
      "name": "curly",
      "winner": false
    }]';
header("Content-type: text/json");
echo($json); }
?>
