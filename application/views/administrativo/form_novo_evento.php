<?php if (!$this->input->is_ajax_request()) include_once(dirname(__FILE__) . '/header.php'); ?>

<div id="main-container">

    <div class="col-md-12">	
        <h3 class="headline m-top-md"><?= ucfirst("Cadastro de Evento") ?><span class="line"></span></h3>

        
        <ul class="nav nav-tabs">
          <li role="presentation" class="tab calendario"><a href=".calendario">CALENDÁRIO</a></li>
          <li role="presentation" class="tab preco disabled "><a href=".preco">PREÇO</a></li>
          <li role="presentation" class="tab anuncio disabled"><a href=".anuncio">ANUNCIO</a></li>
          <li role="presentation" class="tab fotos disabled"><a href=".fotos">FOTOS</a></li>
          <li role="presentation" class="tab localizacao disabled"><a href=".localizacao">LOCALIZAÇÃO</a></li>
          <li role="presentation" class="tab sobre disabled"><a href=".sobre">SOBRE O LOCAL</a></li>
      </ul>

      <div class="panel-body">



       <!--  <form action="" method="post" class="form-horizontal no-margin form-border" enctype="multipart/form-data">  -->               

            <div class="calendario tabcontent">

            <div class="form-group">
                <label for="exampleInputName2">Data do Evento</label>
                <div class="error">Campo Obrigatório</div>
                <input type="date" name="start" id="start" class="form-control" id="exampleInputName2" placeholder="Jane Doe">
             </div>

             <div class="form-group">
                <label for="exampleInputName2">Fim do Evento</label>
                <div class="error">Campo Obrigatório</div>
                <input type="date" name="end" id="end" class="form-control" id="exampleInputName2" placeholder="Jane Doe">
            </div>

            <div class="form-group">
                <label for="exampleInputName2">Fim Participação</label>
                <div class="error">Campo Obrigatório</div>
                <input type="date" name="end_subscription" id="end_subscription" class="form-control" id="exampleInputName2" placeholder="Jane Doe">
            </div>



            <div class="form-group">
                <div class="">
                    <button type="button" data-proxima=".preco" data-atual=".calendario" value="Salvar" class="btn btn-primary btn-next">Próxima</button>
                </div>
            </div>

        </div>

        <div class="preco tabcontent">

        <div class="form-group">
             <label for="exampleInputName2">Preço</label>
             <div class="error">Campo Obrigatório</div>
             <input type="text" name="price" class="form-control currency" id="exampleInputName2" placeholder="R$">
         </div>

         <div class="form-group">
             <label for="exampleInputName2">Número de convidados</label>
             <div class="error">Campo Obrigatório</div>
             <input type="text" name="num_users" class="form-control" id="exampleInputName2" placeholder="">
         </div>

         <div class="form-group">
             <label for="exampleInputName2">Número de Acompanhantes por convidado</label>
             <div class="error">Campo Obrigatório</div>
             <input type="text" name="invite_limit" class="form-control" id="exampleInputName2" placeholder="">
         </div>

         <div class="form-group">
            <div class="">
                <button type="button" data-proxima=".calendario" data-atual=".preco" value="Salvar" class="btn btn-danger btn-next">Anterior</button>
                <button type="button" data-proxima=".anuncio" data-atual=".preco" value="Salvar" class="btn btn-primary btn-next">Próxima</button>
            </div>
        </div>

    </div>

    <div class="anuncio tabcontent">

    <div class="form-group">
         <label for="exampleInputName2">Título do evento</label>
          <div class="error">Campo Obrigatório</div>
         <input type="text" name="name" class="form-control" id="exampleInputName2" placeholder="">
     </div>

     <div class="form-group">

        <label for="exampleInputName2">Tipo de evento</label>
        <div class="error">Campo Obrigatório</div>


        <?php 

        $url = SITE_URL."api/evento/getTypes";

        $ch = curl_init();

        curl_setopt( $ch, CURLOPT_URL, $url );
        curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
        curl_setopt( $ch, CURLOPT_HEADER, false );
                            //curl_setopt( $ch, CURLOPT_POST, true );
                            //curl_setopt( $ch, CURLOPT_POSTFIELDS, $postfields );

        $categorias = json_decode(curl_exec( $ch ));

        curl_close($ch);

        ?>

        <select class="form-control" name="event_type_id">
            <option value="">Selecione o tipo de evento</option>
            <?php foreach($categorias as $categoria): ?>
                <option value="<?php echo $categoria->event_type_id; ?>"><?php echo $categoria->name; ?></option>
            <?php endforeach; ?>
        </select>

    </div>

    <div class="form-group">

        <label for="exampleInputName2">Descrição</label>
         <div class="error">Campo Obrigatório</div>

        <textarea name="description" id="description" class="form-control" cols="30" rows="10"></textarea>


    </div>

    <div class="form-group">
     <label for="exampleInputName2">Status</label>
      <div class="error">Campo Obrigatório</div>
     <select name="status" class="form-control">
         <option value="">Selecione o status do evento</option>
         <option value="enable">Ativo</option>
         <option value="disable">Inativo</option>
     </select>
 </div>

 <div class="form-group">
    <label for="exampleInputName2">Evento Privado</label>
    <div class="error">Campo Obrigatório</div>
     <select class="form-control" name="private">
         <option value="sim">Sim</option>
         <option value="não">Não</option>
     </select>
 </div>

 <div class="form-group">
    <div class="">
        <button type="button" data-proxima=".preco" data-atual=".anuncio" value="Salvar" class="btn btn-danger btn-next">Anterior</button>
        <button type="button" data-proxima=".fotos" data-atual=".anuncio" value="Salvar" class="btn btn-primary btn-next">Próxima</button>
    </div>
</div>





</div>

<div class="fotos tabcontent">


    <div class="form-group">
    <form id="formulario" method="post" enctype="multipart/form-data" >
        <div class="error">Selecione pelo menos uma foto para o evento</div>
        <input type="file" name="photo" id="btn-upload" >
    </form>


    <ul class="listaFotos">
    </ul>

    </div>


    <div class="form-group">
        <div class="">
            <button type="button" data-proxima=".anuncio" data-atual=".fotos" value="Salvar" class="btn btn-danger btn-next">Anterior</button>
            <button type="button" data-proxima=".localizacao" data-atual=".fotos" value="Salvar" class="btn btn-primary btn-next">Próxima</button>
        </div>
    </div>

</div>

<div class="localizacao tabcontent">

    <div class="form-group">  
        <label for="exampleInputName2">CEP(Somente números)</label>
        <div class="error">Campo Obrigatório</div>
        <input type="text" name="zipcode" id="zipcode" class="form-control">  
    </div>

    <div class="form-group">  
        <label for="exampleInputName2">Endereço</label>
        <div class="error">Campo Obrigatório</div>
        <input type="text" name="street" id="street" class="form-control">  
    </div>

    <div class="form-group">  
        <label for="exampleInputName2">Numero</label>
        <div class="error">Campo Obrigatório</div>
        <input type="text" name="number" id="number" class="form-control">  
    </div>

    <div class="form-group">  
        <label for="exampleInputName2">Estado</label>
        <div class="error">Campo Obrigatório</div>
        <input type="text" name="state" id="state" class="form-control">  
    </div>

    <div class="form-group">  
        <label for="exampleInputName2">Cidade</label>
        <div class="error">Campo Obrigatório</div>
        <input type="text" name="city" id="city" class="form-control">  
    </div>


    <div class="form-group">  
        <label for="exampleInputName2">Bairro</label>
        <div class="error">Campo Obrigatório</div>
        <input type="text" name="neighborhood" id="neighborhood" class="form-control">  
    </div>

    <div class="form-group">
        <div class="">
            <button type="button" data-proxima=".fotos" data-atual=".localizacao" value="Salvar" class="btn btn-danger btn-next">Anterior</button>
            <button type="button" data-proxima=".sobre" data-atual=".localizacao" value="Salvar" class="btn btn-primary btn-next">Próxima</button>
        </div>
    </div>

      <input type="hidden" name="token" id="token" value="<?php echo $token; ?>">

</div>

<div class="sobre tabcontent">

    <?php 

    $url = SITE_URL."api/evento/getInfoTipoEventos";

    $ch = curl_init();

    curl_setopt( $ch, CURLOPT_URL, $url );
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
    curl_setopt( $ch, CURLOPT_HEADER, false );
                        //curl_setopt( $ch, CURLOPT_POST, true );
                        //curl_setopt( $ch, CURLOPT_POSTFIELDS, $postfields );

    $inforesult = json_decode(curl_exec( $ch ));

    $infoDados =  $inforesult->html;


    curl_close($ch);


    foreach ($infoDados as $info) {



        if($info->field_type == 'text'){

            echo "
            <div class='form-group'>  
                <div for='exampleInputName2'>".$info->name."</div>
                <span class='error'>Campo Obrigatório</span>
                <input type='text' name='".$info->namefields."' id='".$info->namefields."' class='form-control'>  
            </div>
            ";

        }


        if($info->field_type == 'radio'){

            $values = explode(",", $info->field_values);
            echo "<div><label for='exampleInputName2'>".$info->name."</label>";
            echo "<div class='error'>Campo Obrigatório</div>";

            foreach ($values as $item) {
              echo "<div class='radio'>";
              echo "<label><input type='radio' value='".$item."' name='".$info->namefields."'>".$item."</label>";
              echo "</div>";
            }

          echo "</div>";

      }
  }

  ?>



  <button type="button" data-proxima=".localizacao" data-atual=".sobre" value="Salvar" class="btn btn-danger btn-next">Anterior</button>
  <button type="button" value="Salvar" id="finalizarCadastro" class="btn btn-primary btn-finalizar">Cadastrar</button>


</div>


</form>

</div>

</div>
</div>

<script>    

    $('.tabcontent').hide();

    $('.calendario.tabcontent').show();
    
    $(document).ready(function($) {

        var site = $("#site").val();
        console.log(site);
        var fotos = [];

        $('.currency').maskMoney();

        $(".btn-next").on("click",function(e){

            var proxima = $(this).attr('data-proxima');

            var atual = $(this).attr('data-atual');

            if(atual == ".calendario"){

                var erroCalendario = 0;

                $(".calendario.tabcontent input,.calendario.tabcontent select,.calendario.tabcontent textarea").each(function( index,element) {
                    if($(this).val() == ""){
                        $(this).prev().show();
                        erroCalendario +=1;
                    }else{
                        $(this).prev().hide();
                    }
                });

                if(erroCalendario == 0){
                    
                    $(".tab").addClass('disabled');

                    $(".tab"+proxima).removeClass('disabled');

                    $('.tabcontent').hide();

                    $(proxima+".tabcontent").show();

                    console.log(proxima);
                }

            }


            if(atual == ".preco"){

                var erroPreco = 0;

                $(".preco.tabcontent input,.preco.tabcontent select,.preco.tabcontent textarea").each(function( index,element) {
                    if($(this).val() == ""){
                        $(this).prev().show();
                        erroPreco +=1;
                    }else{
                        $(this).prev().hide();
                    }
                });

                if(erroPreco == 0){
                    
                    $(".tab").addClass('disabled');

                    $(".tab"+proxima).removeClass('disabled');

                    $('.tabcontent').hide();

                    $(proxima+".tabcontent").show();

                    console.log(proxima);
                }

            }


            if(atual == ".anuncio"){

                var erroAnuncio = 0;

                console.log("entrou no anuncio");

                $(".anuncio.tabcontent input,.anuncio.tabcontent select,.anuncio.tabcontent textarea").each(function( index,element) {
                    if($(this).val() == ""){
                        $(this).prev().show();
                        erroAnuncio +=1;
                    }else{
                        $(this).prev().hide();
                    }
                });

                console.log(erroAnuncio);

                if(erroAnuncio == 0){
                    
                    $(".tab").addClass('disabled');

                    $(".tab"+proxima).removeClass('disabled');

                    $('.tabcontent').hide();

                    $(proxima+".tabcontent").show();

                    console.log(proxima);
                }

            }

            if(atual == ".fotos"){

                var erroFotos = 0;

                if(fotos.length == 0){
                    console.log("O array ta vazio");
                    $('.fotos.tabcontent').children('.error').show();
                    erroFotos += 1;
                }else{
                     $('.fotos.tabcontent').children('.error').hide();
                }


                if(erroFotos == 0){
                    
                    $(".tab").addClass('disabled');

                    $(".tab"+proxima).removeClass('disabled');

                    $('.tabcontent').hide();

                    $(proxima+".tabcontent").show();

                    console.log(proxima);
                }


            }

            if(atual == ".localizacao"){

                console.log("entrou no localização");

                var erroLocalizacao = 0;

                $(".localizacao.tabcontent input[type='text']").each(function( index,element) {
                    if($(this).val() == ""){
                        console.log("teste de localização");
                        console.log( $(this).prev());
                        $(this).prev().show();
                        erroLocalizacao +=1;
                    }else{
                        $(this).prev().hide();
                    }
                });


                if(erroLocalizacao == 0){
                    
                    $(".tab").addClass('disabled');

                    $(".tab"+proxima).removeClass('disabled');

                    $('.tabcontent').hide();

                    $(proxima+".tabcontent").show();

                    console.log(proxima);
                }

            }


        });

        $(".nav-tabs a").on("click",function(e){
            e.preventDefault();

            var abrir = $(this).attr('href');


        });

        $("#btn-upload").on("change",function(e){

            console.log("entorou aqui");
            var form = document.querySelector("#formulario");

            //form.submit();
            console.log(form);

             $.ajax({
                 url: site+"api/foto/upload", 
                 type: "POST",             
                 data: new FormData(form), 
                 contentType: false,      
                 cache: false,            
                 processData:false,       
                 success: function(data)   
                 {


                    var dataConvertida = JSON.parse(data);

                    console.log(dataConvertida.upload_data.file_name);
       

                    var novoObj = {};
                    novoObj.imagem = dataConvertida.upload_data.file_name;
                    novoObj.href = dataConvertida.upload_data.file_name; 
                    novoObj.principal = "sim";
                    fotos.push(novoObj);

                    urlArquivos = site+"/uploads/"+dataConvertida.upload_data.file_name;


                     var li = "<li>";
                     li +="<figure>";
                     li +="<img src='"+urlArquivos+"'>";
                     li +="</figure>";
                     li +="<p class='btn btn-danger btn-excluir-foto' data-img='"+dataConvertida.upload_data.file_name+"' btn-block'>Excluir</p>"
                     li +="</li>";

                     $(".listaFotos").append(li);

                 

                 }
             });
        });

        $("body").on("click",".btn-excluir-foto",function(e){

            $(this).parent("li").remove();


            var imagem = $(this).attr('data-img');

            console.log(fotos);

            for(foto in fotos){

                if(fotos[foto].imagem == imagem){
                    delete fotos[foto];
                }
                
            }

        });


        $("#finalizarCadastro").on("click",function(){

            $(".error").hide();

            eventoFormData = {
                'start': $("[name='start']").val(),
                'end': $("[name='end']").val(),
                'end_subscription':$("[name='end_subscription']").val(),
                'price':$("[name='price']").val(),
                'name':$("[name='name']").val(),
                'description':$("[name='description']").val(),
                'status':$("[name='status']").val(),
                'street':$("[name='street']").val(),
                'number':$("[name='number']").val(),
                'state':$("[name='state']").val(),
                'city':$("[name='city']").val(),
                'neighborhood':$("[name='neighborhood']").val(),
                'zipcode':$("[name='zipcode']").val(),
                'picture':'',
                'event_type_id':$("[name='event_type_id']").val(),
                'invite_limit':$("[name='invite_limit']").val(),
                'num_users':$("[name='num_users']").val(),
                'private':$("[name='private']").val()
            }


            eventoFormData.fotos = fotos;

            eventoFormData.user_id = $("#token").val();


            var objFields = {};

            var erros = 0;

            $(".sobre.tabcontent input").each(function( index,element) {
        

              var name = $( this ).attr('name');

              console.log($( this ).attr('type'));

      

              if($( this ).attr('type') == "radio"){


                if(objFields.hasOwnProperty(name) == false){




                var query = "input[name='"+name+"']:checked";

                var value =  $(query).val();


                if(value != '' && value != undefined){
                    objFields[name] = value;
                     $(this).parent().parent().parent().children('.error').hide();
                }else{

                    console.log($(this).parent().parent().parent().children('.error'));

                    $(this).parent().parent().parent().children('.error').show();


                    erros +=1;
                }



               

                }


              }else{

                if($(this).val() != ""){

                    objFields[$(this).attr('name')] = $(this).val();
                    $(this).prev().hide();

                }else{

                    console.log($(this).parent().parent().parent().children('.error'));

                    // $(this).prev().show();

                    // console.log( );

                    $(this).prev().show();


                    erros +=1;

                }
              }

            });

          

            if(erros == 0){

                 eventoFormData.fields = objFields;


                 jQuery.ajax({
                   url: site+'api/evento/novo/',
                   type: 'POST',
                   dataType: 'json',
                   data:  eventoFormData,
                   complete: function(xhr, textStatus) {
                     //called when complete
                   },
                   success: function(data, textStatus, xhr) {
                      console.log(data);
                      location.href="/administrativo/eventos";
                   },
                   error: function(xhr, textStatus, errorThrown) {
                     //called when there is an error
                   }
                 });
                 



            }else{
                alert("Preencha todos os campos");
            }

           

        



        });


    });

</script>

<?php if (!$this->input->is_ajax_request()) include_once(dirname(__FILE__) . '/footer.php'); ?>
