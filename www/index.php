<!DOCTYPE html>
<html>
<head>
    <title>ESIEE - Devoir Docker</title>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            line-height: 1.6;
        }
        h1 {
            color: #333;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bienvenue sur le serveur web ESIEE</h1>
        <p>
            <?php 
                echo "Cette ligne personnalisée a été générée par PHP le " . date("d/m/Y à H:i:s");
                
                echo "<h2>Test de connexion à la base de données</h2>";
                $host = 'db';
                $dbname = 'devLife';
                $username = 'user_dev';
                $password = 'user_password';
                
                try {
                    $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
                    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                    echo "<p style='color: green;'>Connexion à la base de données réussie!</p>";
                } catch(PDOException $e) {
                    echo "<p style='color: red;'>Erreur de connexion: " . $e->getMessage() . "</p>";
                }
            ?>
        </p>
    </div>
</body>
</html>