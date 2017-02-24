<?php 
foreach ($fieldsOptions as $field): 
	if($field->field_type == "text"):
?>
		<md-input-container class="md-block">
			<label class="md-required" for="<?php echo strtolower(str_replace(' ','',$field->name));?>"><?php echo $field->name;?></label>
			<input md-maxlength="30" type="text" class="ng-pristine md-input ng-empty ng-invalid ng-invalid-required ng-touched ng-untouched" aria-invalid="true" ng-trim="false" placeholder="<?php echo $field->name;?>" id="event_info_type_id_<?php echo $field->event_info_type_id;?>"  name="event_info_type_id_<?php echo $field->event_info_type_id;?>" ng-model="eventoFormData.<?php echo $field->event_info_type_id;?>" />
		</md-input-container>
		
<?php
	elseif($field->field_type == "textarea"):
?>
	<label for="description">Descrição</label>
     <textarea  class="form-control" name="description" placeholder="Descrição" ng-model="eventoFormData.description" rows="3" required></textarea>
<?php
	elseif($field->field_type=="select"):
?>
	<!-- <div class="form-group">
		<label for="status"><?php echo $field->name;?></label>
		<select name="status" class="form-control" required>
			<?php 
			$options = explode(',', $field->field_values);
			foreach($options as $option):?>
				<option value="<?php echo $option;?>"><?php echo $option;?></option>
			<?php endforeach;?>
		</select>
	</div> -->
<?php
	elseif($field->field_type == "checkbox"):
		$options = explode(',', $field->field_values);
		foreach($options as $option):
?>
		<label class="checkbox-inline">
  			<input type="checkbox" id="inlineCheckbox1" value="<?php echo $option;?>"> <?php echo $option;?>
		</label>
		 <?php endforeach;?>
<?php
	elseif($field->field_type == "radio"):
		$options = explode(',', $field->field_values);
		$i = 0;
		foreach($options as $option):
			if($i==0):
?>
		<div class="form-group">
			<label for="status"><?php echo $field->name;?></label>
		<?php endif;?>
			<div class="radio">
			  	<label>
			    	<input type="radio" id="event_info_type_id_<?php echo $field->event_info_type_id;?>"  name="event_info_type_id_<?php echo $field->event_info_type_id;?>" value="<?php echo $option;?>" ng-model="eventoFormData.<?php echo trim(strtolower($field->name))?>">
			    		<?php echo $option;?>
			  	</label>
			</div>
		<?php if($i==0):?>
			</div>
		<?php endif;?>
		<?php $i++;?>
	 <?php endforeach;?>
	<?php endif;?>
 <?php endforeach;?>