<?php

function debugMsg($msg) {
    print "\t$msg".PHP_EOL;
}

function execute(PDO $db, $stmt, $params)
{
    $sth = $db->prepare($stmt);
    if(!$sth->execute($params)) {
        var_dump($sth->errorInfo());
        exit;
    }
    return $sth;
}

function transformTimeToSeconds($time)
{
    $time = explode(':', $time);
    return (($time[0] * (3600)) + ($time[1] * 60) + $time[2]);
}

/*
 * Initialisation de la connexion PDO
 */
$dsn        = "mysql:dbname=test;host=192.168.122.195;charset=utf8";
$user       = "root";
$password   = "mysql";

try {
    $db = new PDO($dsn, $user, $password);
} catch (PDOException $e) {
    debugMsg('La connexion a la base de données a échouée : ' . $e->getMessage());
    exit;
}

/*
 * Initialisation des options / fichiers de données
 */
$dataPath = __DIR__.'/../data/';

$options  = getopt('', ['file:']);

$filename = $dataPath.$options['file'];

if(!file_exists($filename)) {
    debugMsg("Le fichier de donnée n'existe pas");
    exit;
}

/*
 * Traitement du fichier
 */
if (($handle = fopen($filename, "r")) !== FALSE) {

    $db->beginTransaction();

    while (($data = fgetcsv($handle, 1000, ";")) !== FALSE) {

        /*
         * Corrige les problèmes d'encodage UTF-8
         */
        $data = array_map("utf8_encode", $data);

        list($compte, $facture, $abonne, $date, $heure, $dureeR, $dureeF, $type) = $data;

        /*
         * On commence à partir du moment où on détecte un chiffre comme numero
         * de compte
         */
        if(!is_numeric($compte))
            continue;

        /*
         * On transforme les champs date & heure en une valeur datetime SQL
         */
        $date = explode('/', $date);
        $date = $date[2].'-'.$date[1].'-'.$date[0].' '.$heure;

        /*
         * Détecte dans quelle table on va insérer la données
         */
        $table = 'autre';
        if(strstr($type, 'appel') or strstr($type, 'appels')) {
            $table = 'appel';
        } elseif(strstr($type, 'connexion') or strstr($type, 'connexions')) {
            $table = 'connexion';
        } elseif(strstr($type, 'sms')) {
            $table = 'sms';
        }

        /*
         * Initialise les paramètres d'INSERT
         */
        $params = [
                ':compte' => $compte,
                ':facture'=> $facture,
                ':abonne' => $abonne,
                ':date'   => $date,
                ':dureeR' => $dureeR,
                ':dureeF' => $dureeF,
                ':type'   => $type,
                ':recu'   => 0
        ];

        /*
         * Détecte s'il s'agit d'un appel/sms envoyé ou reçu
         */
        if(strstr($type, 'reçu'))
            $params[':recu'] = 1;

        $res = execute($db,
                "insert into $table values(NULL,
                    :compte, :facture, :abonne, :date, :dureeR, :dureeF, :type, :recu)",
                $params);

    }

    if($db->commit())
        debugMsg("Import terminé");

} else {
    debugMsg("Impossible d'ouvrir le fichier");
    exit;
}

debugMsg('');
debugMsg("Analyze en cours");
debugMsg('');

debugMsg("Durée totale réeele des appels effectués après le 15/02/2012 :");

$date = "2012-02-15 00:00:00";

$sth = execute($db,
        "select dureeRelle
         from appel
         where `date` >= :date and recu = 0",
        [':date' => $date]);

$startDate = new DateTime('2000-01-01');
$endDate   = clone $startDate;
while($row = $sth->fetch(PDO::FETCH_COLUMN)) {
    $seconds = transformTimeToSeconds($row);
    $endDate->add( new DateInterval('PT'.$seconds.'S'));
}

$interval = $startDate->diff($endDate, true);
debugMsg($interval->format('%a jours, %H heures, %I min, %S sec'));

debugMsg('');
debugMsg('TOP10 volumes data factures hors 8.00/18.00');

$stmt = $db->query("select abonne, SUM(dureeFacturee) as volume
                    from connexion
                    where TIME(`date`) between '00:00:00' AND '07:59:59'
                        OR TIME(`date`) between '18:00:00' AND '23:59:59'
                    group by abonne
                    order by volume desc
                    limit 10");

foreach($stmt->fetchAll() as $row)
    debugMsg("- Abonné #".$row['abonne']." (".$row['volume'].")");

debugMsg('');
debugMsg("Nombre de SMS envoyés");

$sth = $db->query("select count(abonne) from sms");
debugMsg($sth->fetchColumn());

