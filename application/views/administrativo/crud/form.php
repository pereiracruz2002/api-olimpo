<?php if (!$this->input->is_ajax_request()) include_once(dirname(__FILE__) . '/../header.php'); ?>

<div id="main-container">

    <div class="col-md-12">	
        <h3 class="headline m-top-md"><?= ucfirst($titulo) ?><span class="line"></span></h3>

        <?php
        if (validation_errors())
            print box_alert(validation_errors());
        if ($ok)
            print box_success('Dados salvos com sucesso!');
        ?>

        <?= $c->_call_pre_form($model, $data); ?>
        <div class="panel-body">
            <form action="<?= site_url($url . $action); ?>" method="post" class="form-horizontal no-margin form-border" enctype="multipart/form-data">                
                <? $c->_call_filter_pre_form($data); ?>
                <?= call_user_func_array(array($model, 'form'), $data) ?>
                <?=$c->_call_complemento_form($data)?>
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <input type="submit" value="Salvar" class="submit btn btn-primary" />
                    </div>
                </div>
            </form>
            <?php if (isset($data[0]['values']['estado'])): ?>
                <input type="hidden" id="estado_val" value="<?= $data[0]['values']['estado']; ?>" />
                <input type="hidden" id="cidade_val" value="<?= $data[0]['values']['cidade']; ?>" />
            <?php endif; ?>
        </div>
        <?= $c->_call_pos_form() ?>
    </div>
</div>

<?php if (!$this->input->is_ajax_request()) include_once(dirname(__FILE__) . '/../footer.php'); ?>
