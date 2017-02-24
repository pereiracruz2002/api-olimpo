<!doctype html>
<html ng-app="App">
<head prefix="og: https://ogp.me/ns# fb: http://ogp.me/ns/fb# facileme: https://ogp.me/ns/fb/facileme#">
    <meta name="fragment" content="!" />
    <meta charset="utf-8">
    <title ng-bind="pageTitle">Dinner 4 Friends</title>
    <meta name='robots' content='index,follow' />

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/angular_material/1.1.0/angular-material.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="/assets/css/style.css" />

      <script   src="http://code.jquery.com/jquery-1.12.4.min.js"   integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="   crossorigin="anonymous"></script>

    
    <!--[if lt IE 9]>
        <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="//oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    </head>
    <body layout="row">




    <div layout="column" flex id="content" role="main">


    <img src="" alt="">

    <form action="">

        <ul>
        
            <?php foreach ($listagem as $item): ?>

                <div>
                    <input type="checkbox" name="email[]" id="email" value="<?php echo $item["name"]; ?>|<?php echo $item["email"]; ?>"> <?php echo $item["name"]; ?>[<?php echo $item["email"]; ?>]
                </div>
            
            <?php endforeach; ?>

        </ul>

        <input type="submit" value="Enviar Convites">
    
    </form>



    <!--
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-route.min.js"></script>
    -->

    
    </div>



   
    </body>
</html>
