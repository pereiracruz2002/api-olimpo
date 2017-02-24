<?php if(!$this->input->is_ajax_request()) include_once(dirname(__FILE__).'/../header.php'); ?>
  <div class="row">
  	<div class="panel-heading">
      <h2><?=ucfirst($titulo)?> 
	  <?php if (in_array('C', $crud)): ?>
		<a href="<?=$url?>/novo" class="btn btn-primary"><span>Novo</span></a>
	  <?php endif ?>
	  </h2>
        
        <?php if (isset($crud)): ?>
            <?php if (in_array('C', $crud)): ?>
                <!--<a href="<?= $url ?>/novo" class="btn btn-primary btn-sm">Cadastrar Novo</a>-->
            <?php endif ?>
            <?php if (isset($acoes_controller)): ?>
                <?php foreach ($acoes_controller as $acao_extra): ?>
                    <a href="<?= site_url($acao_extra['url']); ?>" title="<?= $acao_extra['title']; ?>" class="btn <?= $acao_extra['class']; ?> btn-sm"><?= $acao_extra['title']; ?></a>
                <?php endforeach; ?>
            <?php endif; ?>
        <?php endif; ?>
    </div>
    
    <div class="panel-body">
       <?php $c->_call_pre_table(); ?>
       <?php if ($this->campos_busca):?>
        <div class="well">
            <form method="post" class="form-inline filtro" action="<?= $url; ?>/listar">
                <fieldset>
                    <legend>Buscar</legend>
                    <?php foreach ($camposBusca as $name): ?>
                        <?php if ($this->model->fields[$name]['type'] == 'select'): ?>
                            <select name="<?php echo $name ?>" class="form-control input-sm">
                                <?php foreach ($this->model->fields[$name]['values'] as $key => $val): ?>
                                    <option value="<?php echo $key ?>"><?php echo $val ?></option>
                                <?php endforeach; ?>
                            </select>
                        <?php else: ?>
                            <input name="<?php echo $name ?>" type="<?php echo $this->model->fields[$name]['type'] ?>" value="<?php echo (isset($this->model->fields[$name]['value']) ? $this->model->fields[$name]['value'] : '') ?>" placeholder="<?php echo $this->model->fields[$name]['label'] ?>" class="form-control input-sm" />
                        <?php endif; ?>
                    <?php endforeach; ?>
                    <input type="submit" value="Procurar" class="btn btn-sm btn-primary" />
                </fieldset>
            </form>
        </div>
        <?php endif; ?>

    <?php if (!$itens): ?>
        <div class="alert alert-danger">Nenhum registro encontrado</div>
    <?php endif; ?>
    <div class="table-responsive">
		<table class="table table-striped small">
		  <thead>
		    <tr>
		      <?foreach($campos as $campo):?>
		        <th scope="col"><?=$model->fields[$campo]['label']?></th>
		      <?endforeach?>
		        <th>&nbsp;</th>
		    </tr>
		  </thead>
		  <tbody>
		    <? foreach($itens as $row):?>
		    <tr>
		      <? foreach($campos as $campo):?>
		        <td class="<?=url_title($campo) ; ?>"><?=$row->{$campo}?></td>
		      <? endforeach?>
		      <td class="acoes">
		        <?php if (in_array('P', $crud)): ?>
		            <a class="btn btn-xs btn-info btn btn-info" href="<?= $url ?>/visualizar/<?= $row->{$model->id_col} ?>" title="Visulizar este registro" class="btn btn-mini btn-warning"><i class="fa fa-eye"></i> Ver</a>
		        <?php endif; ?>
		        <?php if (in_array('U', $crud)): ?>
		            <a class="btn btn-xs btn-info btn btn-warning" href="<?= $url ?>/editar/<?= $row->{$model->id_col} ?>" title="Editar este registro" class="btn btn-mini btn-info"><i class="fa fa-pencil"></i> Editar</a>
		        <?php endif; ?>
		        <?php if (in_array('D', $crud)): ?>
		            <a class="btn btn-xs btn btn-danger delete" href="<?= $url ?>/deletar/<?= $row->{$model->id_col} ?>" title="Deletar este registro"><i class="fa fa-times-circle"></i> Deletar</a>
		        <?php endif ?>

		        <?php foreach ($acoes_extras as $acao_extra): ?>
		            <a href="<?= site_url($acao_extra['url'] . "/" . $row->{$model->id_col}); ?>" class="btn btn-xs <?= $acao_extra['class']; ?>" <?php echo(isset($acao_extra['attr'])? $acao_extra['attr'] : '') ?>><?= $acao_extra['title']; ?></a>
		        <?php endforeach; ?>
		      </td>
		    </tr>
		    <?php endforeach?>
		  </tbody>
		</table>
    </div>
    <?=$paginacao ?>
  </div><!--/panel-body-->
  </div><!--/row-->
<?php if(!$this->input->is_ajax_request()) include_once(dirname(__FILE__).'/../footer.php'); ?>
