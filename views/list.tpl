<header>
	<button class="fa fa-plus" role="addCustomer"></button>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<button><i class="fa fa-address-card"></i></button><input type="text" class="search" data-filter="begins" data-filtername="name" placeholder="nom">&nbsp;
	<button><i class="fa fa-envelope"></i></button><input type="text" class="search" data-filter="begins" data-filtername="email" placeholder="email">
</header>
<article>
	<ul class="customlist adv">
	<?php foreach ($list as $customer) {?>
		<li class="item_line" data-id="{$customer['id_customer']}" data-controller="none" data-email="{$customer['mail']}" data-name="{$customer['lastname']}">
			<td >
				<i class="fa fa-{if $customer['status']==1}user-circle{else}{if $customer['status']==2}users{else}question{/if}{/if} fa-4x"></i>
				<span><b>{$customer['login']}</b><hr><i>{$customer['forname']} {$customer['lastname']}</i></span>
			</td>
		</li>
	<?php } ?>
</div>
