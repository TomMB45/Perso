<?php
include ("../connect/db.php");

$query ="DELETE FROM Users WHERE role = 'CNV' AND create_datetime < DATE_ADD(CURRENT_DATE(), INTERVAL +3 MONTH)";
$result = mysqli_query($con, $query);
if ($result) {
    echo "ok";
} else {
    echo "error";
}
?>