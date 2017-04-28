<header>
	<button class="fa fa-save" role="saveAddress" data-id="{$address->id_address}"></button>
	{if $address->id_address}<button class="fa fa-trash" role="removeAddress" data-id="{$address->id_address}"></button>{/if}
</header>
<article>
	<section>
		<fieldset>
			<label>
				Alias de l'adresse
			</label>
			<div>
				<input type="hidden" name="id_customer" value="{if $id_customer}{$id_customer}{else}{$address->id_customer}{/if}">
				<input type="text" name="name" value="{$address->name}">
			</div>
		</fieldset><br>
		<fieldset>
			<label>
				N° et Rue
			</label>
			<div>
				<input type="text" name="address" value="{$address->address}">
			</div>
		</fieldset>
		<fieldset>
			<label>
				Complément
			</label>
			<div>
				<input type="text" name="details" value="{$address->details}">
			</div>
		</fieldset>
		<fieldset>
			<label>
				Code postal
			</label>
			<div>
				<input type="text" name="postcode" value="{$address->postcode}">
			</div>
		</fieldset>
		<fieldset>
			<label>
				Ville
			</label>
			<div>
				<input type="text" name="city" value="{$address->city}">
			</div>
		</fieldset>
		<fieldset>
			<label>
				Pays
			</label>
			<div>
				<input type="text" name="country" value="{$address->country}">
			</div>
		</fieldset>
	</section>
</article>