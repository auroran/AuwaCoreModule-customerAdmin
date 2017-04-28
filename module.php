<?php
	class customerAdminModuleAdmin extends Auwa\Module{
		public function __construct(){
			$this->name = 'customerAdmin';
			$this->author = 'Grégory GAUDIN';
			$this->_path = _SYS_MOD_DIR_.'customerAdmin/';
			$this->autoControllerLoad=array('customers');
			// end of construtor
			return $this->e;
		}
	}
?>