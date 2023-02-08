<?php
include ("../connect/db.php");

$query ="SELECT name_service FROM Services";
$result = mysqli_query($con, $query);
$row = mysqli_fetch_assoc($result);
foreach ($row as $key => $value) {
    $serv = $value;
    $query = "SELECT COUNT(*) AS nb FROM user_belongs_service WHERE name_service = '$serv'";
    $result = mysqli_query($con, $query);
    $nb = mysqli_fetch_assoc($result);
    $nb = $nb["nb"];
    $query = "UPDATE Services SET nb_slot = '$nb' WHERE name_service = '$serv'";
    $result = mysqli_query($con, $query);
    if (!$result) {
        echo "Error: to update nb_slot in $serv";
    }
}
?>