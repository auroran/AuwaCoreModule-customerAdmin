<?php
namespace Auwa;
/**
 *
 * @author AuroraN <g.gaudin[@]auroran.fr>
 */
Auwa::loadPhp('shop/Customer', 'class');
class CustomersController extends CoreController{

	function loadCss(){ // from core/
		$this->addCss('customer');
	}
	function loadJs(){
		$this->addJs('edit');
	}
	function action(){
		$this->setTitle('Clients');
		switch ($this->action) {
			case 'edit':
				if( !Address::tableExists()){
					Address::createTable();
				}
				$c = Customer::getCustomer( Tools::getValue('id'), true );
				$this->setTitle('Client '.$c->getIdentity().( $c->id_customer? ' | #'.$c->id_customer:'') );
				$this->setVar(array(
					'customer'			=> $c,
				));
				$this->displayContent('edit');
				break;
			case 'editAddress':
				$a = new Address( Tools::getValue('address') );
				$this->setTitle( $a->id_address ? "Édition de l'adresse ".$a->name : "Création d'une adresse" );
				$this->setVar(array(
					'address'	=> $a, // can be id or a row
					'id_customer' => Tools::getValue('customer'),
				));
				$this->displayContent('address');
				break;
			default:
				if( !Customer::tableExists()){
					Customer::createTable();
				}
				$this->setVar(array(
					'list'	=> Customer::getCustomers()
				));
				$this->displayContent('list');
				break;
		}
	}

	public function query(){
		if ( !isset($this->data['obj']) ){
			return $this->setResponse(false, 'Variable(s) manquantes');
		}
		switch ($this->query) {
			case 'setCustomer':
				// save a customer
				$c = new Customer($this->data['id_customer']);
				$r = $c->setValues( $this->data['obj'] );
				$this->setResponse($r!==false, $r ? $c->toArray() : 'Erreur dans la sauvegarde du client #'.($c->id_customer) );
				break;
			case 'deleteCustomer':
				$c = new Customer($this->data['id_customer']);
				$r = $c->remove();
				$this->setResponse($r!==false, $r ? $r : 'Erreur dans la suppression du client');
				break;
			case 'setAddress':
				// save a customer
				$a = new Address($this->data['id_address']);
				$r = $a->setValues( $this->data['obj'] );
				$this->setResponse($r!==false, $r ? $a->toArray() : 'Erreur dans la sauvegarde de l\'adresse #'.($a->id_address) );
				break;
			case 'deleteAddress':
				$a = new Address($this->data['id_address']);
				$r = $a->remove();
				$this->setResponse($r!==false, $r ? $r : 'Erreur dans la suppression de l\'adresse');
				break;
		}
	}
}
