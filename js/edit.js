(function(){
	var _customer_nodeId = 'customerAdmincustomers';
	var _ctrl = 'customers';
	var _module = 'customerAdmin';
	var _customer_contextmenu = {
		'.customlist li':{
			'edit':{
				class: 'fa fa-pencil',
				text: 'Éditer',
				fn: function(o,e){
					o.click();
				}
			},
			'delete' : {
				class: 'fa fa-remove',
				text: 'Supprimer',
				fn : function(o,e){
					id = o.attr('data-id');
					if (!confirm('Voulez-vous vraiment supprimer ce client (#'+id+') ? ')) return;
					var callback={
						success: function(){
							Acui.notice('Client supprimé', 'success');
							Acui(_customer_nodeId).refresh();
						}
					};
					Acui.callCore('deleteCustomer', {id_customer: id, obj:true}, _ctrl, _module, callback );
				}
			}
		}
	};

	Acui(_customer_nodeId).ready(function(){

		this.contextMenu(_customer_contextmenu, true);
		this.setEvents('click',{
			'[role=addCustomer]': function(){
				var $li = $('<li>', {'class':'item_line','data-controller': Acui.$controllerSelector.val()});
				Acui(_customer_nodeId).get().append($li);
				$li.trigger('click').remove();
			},
			'.item_line': function(){
				var id = $(this).attr('data-id');
				var nodeId = 'customerEdit_'+id;
				var data = {
					id: id,
					controller: _ctrl,
					module: _module,
					action: 'edit',
				}
				var ready = function(){
					Acui(nodeId).setEvents('click', {
						'[role=saveCustomer]': function(){
							if ( Acui(nodeId, 'select[name=customer_status]').val() == 2 
								 && ( 	Acui(nodeId, 'input[name=customer_company]').val()==''
								 		|| Acui(nodeId, 'input[name=customer_siret]').val()==''
								 		|| Acui(nodeId, 'input[name=customer_intracom]').val()==''
								 	)
								 ){
								return Acui.notice('Il manque des informations sur l\'entreprise', 'warning');
							}
							$o = $(this);
							var data = {
								id_customer : $o.attr('data-id'),
								obj: {}
							};
							Acui(nodeId, 'fieldset select[name], fieldset input[name], fieldset textarea[name]').each(function(){
								data.obj[ $(this).attr('name').replace('customer_','') ] = $(this).val();
							});
							Acui.callCore('setCustomer', data, 'customers', 'customerAdmin', {
								success: function(r){
									$o.attr('data-id', r.id_customer);
									Acui(nodeId).setTitle('Client '+r.forname+' '+r.lastname+ ' | #'+r.id_customer);
									Acui(nodeId, 'select[name=delivery_address]').val(r.delivery_address);
									Acui(_customer_nodeId).refresh();
									Acui.notice('Client enregistré', 'success');
								}
							});
						},
						'[role=editAddress]': function(){
							if ( !Acui(nodeId, '[role=saveCustomer]').attr('data-id') ){
								return Acui.notice('Le client doit être enregistré avant', 'warning');
							}
							var addressNodeId = Acui.createId();
							var data = {
								address : $(this).attr('data-address') ? $(this).attr('data-address')  :false,
								customer: Acui(nodeId, '[role=saveCustomer]').attr('data-id'),
								controller: _ctrl,
								module: _module,
								action: 'editAddress',
							}
							var ready = function(){
								Acui(addressNodeId).setEvents('click', {
									'[role=saveAddress]': function(){
										var data = {
											id_address: $(this).attr('data-id'),
											obj: {}
										};
										Acui(addressNodeId, 'fieldset select, fieldset input, fieldset textarea').each(function(){
											data.obj[ $(this).attr('name') ] = $(this).val();
										});
										var callback = {
											success: function(r){
												console.log(r);
												Acui.notice('Adresse enregistrée', 'success');
												Acui(addressNodeId).setTitle("Édition de l'adresse "+r.name);
												if (data.id_address)
													Acui(nodeId, '.addressSelector option[value='+r.id_address+']').text(r.name);
												else {
													Acui(nodeId, '.addressSelector')
																.append( $('<option value="'+r.id_address+'">').text(r.name) );
												}
											}
										}
										Acui.callCore('setAddress', data , _ctrl, _module, callback);
									},
									'[role=removeAddress]':function(){
										var id = $(this).attr('data-id');
										if (!confirm('Voulez-vous vraiment supprimer cette adresse ? ')) return;
											var callback={
												success: function(){
													Acui.notice('Adresse supprimée', 'success');
													Acui(nodeId, '.addressSelector option[value='+id+']').remove();
													Acui(addressNodeId).close();
												}
											};
											Acui.callCore('deleteAddress', {id_address: id, obj:true}, _ctrl, _module, callback );
									}
								})
							};
							Acui.open(addressNodeId, data, 'addressEditor mergeHeader', ready);
						}
					});

					Acui(nodeId).setEvents('change', {
						'select[name=customer_status]': function(){
							Acui(nodeId, '[data-type]').hide();
							Acui(nodeId, '[data-type='+$(this).val()+']').show();
						},
						'select.addressSelector': function(){
							var $b = $(this).next('button');
							$b.attr({
								'class': $(this).val()==0 ? 'fa fa-plus' : 'fa fa-edit',
								'data-address': $(this).val()
							})
						}
					});
					Acui(nodeId,'select[name=customer_status], select.addressSelector').trigger('change');
				}
				Acui.open(nodeId, data, 'customerEditor mergeHeader', ready);
			}

		})
	})
})()