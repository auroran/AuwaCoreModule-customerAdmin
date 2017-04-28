<header>
	<button class="fa fa-save" role="saveCustomer" data-id="{$customer->id_customer}"></button>
	<button class="fa fa-address-card" role="editAddress"></button>
</header>
<article>

	<section class="col1">
		<fieldset>
			<label>
				Validé
			</label>
			<div>
				<select class="btn-switch" name="customer_enable">
					<option value="0"{if !$customer->isValidated()} selected="selected"{/if}>Non</option>
					<option value="1"{if $customer->isValidated()} selected="selected"{/if}>Oui</option>
				</select>
			</div>
		</fieldset>
		<fieldset>
			<label>
				Nom
			</label>
			<div>
				<input type="text" name="customer_lastname" value="{$customer->lastname}">
			</div>
		</fieldset>
		<fieldset>
			<label>
				Prénom
			</label>
			<div>
				<input type="text" name="customer_forname" value="{$customer->forname}">
			</div>
		</fieldset>
		<fieldset>
			<label>
				Login
			</label>
			<div>
				<input type="text" name="customer_login" value="{$customer->login}">
			</div>
		</fieldset>
		<fieldset>
			<label>
				Mot de passe
			</label>
			<div>
				<input type="text" name="customer_passwd" value="{$customer->getPasswd()}" style="text-security:disc; -webkit-text-security:disc; -mox-text-security:disc;">
			</div>
		</fieldset>
		<fieldset>
			<label>
				E-mail
			</label>
			<div>
				<input type="text" name="customer_mail" value="{$customer->mail}">
			</div>
		</fieldset>
		<fieldset>
			<label>
				Téléphone
			</label>
			<div>
				<input type="text" name="customer_phone" value="{$customer->phone}">
			</div>
		</fieldset>
	</section>
	<section class="col2">
		<fieldset>
			<label>
				Adresse de facturation
			</label>
			<div>
				<select type="text" name="invoice_address" class="with-btn addressSelector">
					<option value="0">Choisissez une adresse</option>
				{foreach $customer->addresses as $id_address=>$address}
					<option value="{$id_address}"{if $customer->invoice_address==$id_address} selected="selected"{/if}>{$address->name}</option>
				{/foreach}
				</select>
				<button class="fa fa-plus" role="editAddress"></button>			
			</div>
		</fieldset>
		<fieldset>
			<label>
				Adresse de livraison
			</label>
			<div>
				<select type="text" name="delivery_address" class="with-btn addressSelector">
					<option value="0">Adresse de facturation</option>
				{foreach $customer->addresses as $id_address=>$address}
					<option value="{$id_address}"{if $customer->delivery_address==$id_address} selected="selected"{/if}>{$address->name}</option>
				{/foreach}
				</select>
				<button class="fa fa-plus" role="editAddress"></button>	
			</div>
		</fieldset><br>
		<fieldset>
			<label>
				Type de compte
			</label>
			<div>
				<select type="text" name="customer_status">
					<option value="1"{if $customer->getStatus()==1} selected="selected"{/if}>Particulier</option>
					<option value="2"{if $customer->getStatus()==2} selected="selected"{/if}>Professionnel</option>
					<option value="0"{if $customer->getStatus()==0} selected="selected"{/if}>Autre</option>
				</select>
			</div>
		</fieldset>
		<br>
		<fieldset data-type="2">
			<label>
				Compagnie
			</label>
			<div>
				<input type="text" name="customer_company" value="{$customer->company}">
			</div>
		</fieldset>
		<fieldset data-type="2">
			<label>
				Siret
			</label>
			<div>
				<input type="text" name="customer_siret" value="{$customer->siret}">
			</div>
		</fieldset>
		<fieldset data-type="2">
			<label>
				TVA Intra-communautaire
			</label>
			<div>
				<input type="text" name="customer_intracom" value="{$customer->intracom}">
			</div>
		</fieldset>
	</section>
</article>