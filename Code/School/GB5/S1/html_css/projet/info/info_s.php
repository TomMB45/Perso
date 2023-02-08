<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Info</title>
        <link rel="stylesheet" href="info_s.css">
        <link rel="stylesheet" href="../common_css/button.css">
    </head>

    <body>
        <?php
        $serv = $_GET["s"];
        // On récupère le paramètre s passé dans l'URL correspondant au service choisi
        switch ($serv) {

            case 'covid':
                // Si le service demandé est covid, on affiche les informations correspondantes
        ?>
                <div class=en_tete_div>
                    <img src="../image/logo.png" alt="logo entreprise" class="en_tete">
                </div>
                <div>
                    <h2>Qu&#039;est-ce qu&#039;un test PCR Covid-19 ?</h2>
                        <p><em>"La<strong> PCR</strong> constitue le socle du diagnostic <strong>COVID-19</strong> tout au long de l’&eacute;pid&eacute;mie » (source : fiche Minist&egrave;re des solidarit&eacute;s et de la Sant&eacute; en date du 25 mai 2020).</em></p>
                        <p><span><span><span>La <strong>PCR ou RT-PCR </strong><a><strong>SARS-CoV-2</strong> </a>(d&eacute;signation &eacute;quivalente pour Reverse Transcriptase-Polymerase Chain reaction) est une technique de laboratoire permettant de mettre en &eacute;vidence le mat&eacute;riel g&eacute;n&eacute;tique du virus dans un &eacute;chantillon. Elle n&eacute;cessite un pr&eacute;l&egrave;vement à l’endroit le plus accessible où la concentration de virus est la plus importante, c’est-à-dire le nasopharynx, en arri&egrave;re des conduits narinaires. </span></span></span></p>
                </div>

                <div>
                    <div>
                        <h2>A quoi sert un test PCR Covid-19 ?</h2>
                            <p>Le <strong>test PCR Covid</strong> permet d’affirmer au moment du pr&eacute;l&egrave;vement si vous êtes porteur ou non du virus de la <strong>Covid-19</strong> et constitue l’examen cl&eacute; pour le diagnostic de l’infection Covid.</p>

                    </div>
                </div>

                <div>
                    <div>
                        <h2>Quand r&eacute;aliser un test PCR Covid-19 ?</h2>
                            <p><span>Vous pouvez r&eacute;aliser <strong>un test</strong> <strong>PCR Covid-19</strong> dans les cas suivants :</span></p>
                        <ul><li><span><span><span><span><span>Vous avez des <strong>symptômes Covid</strong> (fi&egrave;vre, toux, perte du gout ou de l’odorat…) </span>dans les 7 premiers jours</span></span></span></span></li>
                            <li><span><span><span><span><span><span><span><span><span><span><strong>Personne contact</strong> avec sch&eacute;ma vaccinal complet non immunod&eacute;prim&eacute;es : faire un <strong>test PCR</strong> d&egrave;s que possible</span></span></span></span></span></span></span></span></span></span></li>
                            <li><span><span><span><span><span><span><span><span><span><span><strong>Personne contact</strong> avec sch&eacute;ma vaccinal incomplet ou non vaccin&eacute;e, ou immunod&eacute;prim&eacute;es : Vous avez &eacute;t&eacute; en contact avec une personne infect&eacute;e : faire un <strong>test PCR</strong> 7 jours apr&egrave;s le dernier contact</span></span></span></span></span></span></span></span></span></span></li>
                            <li><span><span><span><strong>D&eacute;pistage Covid-19 </strong>avant un voyage à l’&eacute;tranger <span><span><span><span><span><span>(g&eacute;n&eacute;ralement dans les 72 heures avant l’heure du d&eacute;part)</span></span></span></span></span></span></span></span></span></li>
                        </ul>
                    </div>
                </div>

                <div>
                    <div>
                        <h2>Quelle est la signification d&#039;un test PCR Covid positif ?</h2>
                            <p><span><span>Un <strong>test PCR Covid19</strong> positif affirme une infection virale à SARS-CoV-2, cela signifie donc que la personne est infect&eacute;e, mais aussi infectante vis-à-vis de son entourage. Il n’ existe pas de faux positifs pour cet examen.</span></span></p>

                    </div>
                </div>

                <div>
                    <div>
                        <h2>Quelle est la signification d&#039;un test PCR Covid n&eacute;gatif ?</h2>
                            <p><span><span><span>Il existe des situations où le<strong> test PCR</strong> peut être n&eacute;gatif alors que la personne est porteuse. C’est le cas en particulier chez les patients avec des symptômes de la Covid, mais qui font leur test PCR trop tardivement, plus d’une semaine apr&egrave;s le d&eacute;but des signes (toux, fi&egrave;vre etc).</span></span></span></p>

                    </div>
                    
                </div>

                <div>
                    <div>
                        <h2>Le test de d&eacute;pistage PCR de la Covid-19 est-il rembours&eacute; ?</h2>
                            <p><strong>Depuis le 15 octobre, la gratuit&eacute; du test PCR</strong><strong> </strong>est r&eacute;serv&eacute;e aux assur&eacute;s sociaux<strong> </strong>et non assur&eacute;s r&eacute;sidant en France, selon les conditions d'&eacute;gibilit&eacute; suivantes :</p>
                    <p> </p>
                    <p>1. Pour les patients avec une <span><span>vaccination compl&egrave;te </span></span>: <u>le justificatif</u> à fournir est le <span><strong>QR code du pass sanitaire</strong></a></span> ou certificat papier de vaccination compl&egrave;te (Ameli)</p>
                    <p>2. Pour les patients munis d’une <span><span>ordonnance datant de moins de 48 heures</span></span> : <u>le justificatif</u> à fournir est une <span></span><strong>ordonnance m&eacute;dicale</strong> de moins de 48 heures</p>
                    <p>3. Pour les patients <span><span>mineurs</span></span> : <u>le justificatif</u> à fournir est la <span>p</span><strong>i&egrave;ce d’identit&eacute; en cas de doute</strong></p>
                    <p>4. Pour les <span><span>personnes cas-contact</span></span> ayant reçu un SMS ou mail de l’assurance maladie : <u>le justificatif</u> à fournir est le <strong>SMS ou mail envoy&eacute; par l’Assurance Maladie</strong></p>
                    <p>5. Pour les patients ayant une <span><span>contre-indication m&eacute;dicale à la vaccination</span></span> : <u>le </u><u>justificatif</u> à fournir est le <span></span><strong>certificat m&eacute;dical</strong> &eacute;tabli sur le formulaire sp&eacute;cifique ou d&eacute;livr&eacute; par la S&eacute;curit&eacute; Sociale</p>
                    <p>6. Pour les patients porteurs d’un <span><span>certificat de r&eacute;tablissement</span></span> : <u>le justificatif</u> à fournir est le <span><strong>QR code du pass sanitaire</a> </strong></span>correspondant à un<strong> </strong>test positif de plus de 72h et de moins de 6 mois</p>
                    <p>Pour les assur&eacute;s sociaux français, il est n&eacute;cessaire de fournir le num&eacute;ro de S&eacute;curit&eacute; Sociale valide (carte Vitale ou attestation) pour permettre la prise en charge par la S&eacute;curit&eacute; Sociale.</p>
                    <p>En l’absence de ces &eacute;l&eacute;ments, le <strong>test PCR Covid </strong>sera <strong>payant.</strong></p>
                    </div>
                    <button onclick='location.href="info.php"' type="button" class="go_back">Retour</button>
                </div>

        <?php
                break;
            case "vih": 
                // Si le paramètre est "vih", on affiche les informations sur le test de dépistage du VIH
        ?>
                <div class=en_tete_div>
                    <img src="../image/logo.png" alt="logo entreprise" class="en_tete">
                </div>
                
                <div>
                    <div>
                        <h2>Sans frais, sans ordonnance, sans rendez-vous : faire le test du VIH n&#039;a jamais &eacute;t&eacute; aussi facile</h2>
                            <p><span><span><span><span><span><span>Depuis le 1er janvier 2022, il est possible de faire un <strong>test de d&eacute;pistage du VIH</strong> <strong>sans ordonnance</strong>, <span>pris en charge à 100% sans avance de frais</span>, sur simple demande et sans rendez-vous, dans tous les laboratoires d’analyses m&eacute;dicales de France.</span></span></span></span></span></span></p>
                    <p><span><span><span><span><span><span>Si vous avez plus de 18 ans, vous pouvez aller dans un laboratoire d’analyse m&eacute;dicale Chabotomartylab pour faire votre <strong>test de s&eacute;rologie VIH :</strong></span></span></span></span></span></span></p>
                    <p><span><span><span><span><span><span>• gratuitement</span></span></span></span></span></span></p>
                    <p><span><span><span><span><span><span>• sans ordonnance</span></span></span></span></span></span></p>
                    <p><span><span><span><span><span><span>• avec votre carte vitale ou un num&eacute;ro de s&eacute;curit&eacute; sociale</span></span></span></span></span></span></p>
                    <p><span><span><span><span><span><span>• sans rendez-vous</span></span></span></span></span></span></p>
                    <p><span><span><span><span><span><span>Le test r&eacute;alis&eacute; par <strong>Chabotomartylab </strong>est un <span>test de 4&egrave;me g&eacute;n&eacute;ration sur prise de sang.</span> Il recherche la pr&eacute;sence d’anticorps anti-HIV-1 et 2. Il est totalement fiable s'il est r&eacute;alis&eacute; six semaines apr&egrave;s une prise de risque. </span></span></span></span></span></span></p>
                    <p><span><span><span><span><span><span>Le test est pris en charge à 100 % par l’Assurance Maladie, <span>vous n’avez rien à payer ni à avancer.</span></span></span></span></span></span></span></p>
                    <p><span>Si vous n’avez pas de couverture maladie, si vous voulez faire le test anonymement ou que vous avez moins de 18 ans, il est alors n&eacute;cessaire de vous rendre dans un CeGIDD.</a></span></p>
                    <p><span><span><span><span><span><span>Cette mesure, adopt&eacute;e par l’Assembl&eacute;e nationale en octobre 2021, entre dans le cadre de la loi de financement de la s&eacute;curit&eacute; sociale pour 2022. Il vient à point nomm&eacute; alors que tous les organismes de surveillance constatent une baisse du nombre de d&eacute;pistage en VIH depuis l’&eacute;pid&eacute;mie de Covid, et que beaucoup de structures ou d’associations de d&eacute;pistage hors les murs ont du suspendre leur activit&eacute;.</span></span></span></span></span></span></p>
                    <p> </p>
                    </div>
                    <button onclick='location.href="info.php"' type="button" class="go_back">Retour</button>
                </div>
            <?php
        }
        ?>
    </body>
</html>