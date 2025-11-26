<?php

	echo str_replace("##FLAG##",file_get_contents("/flag/flag.txt"),file_get_contents("./templates/flag.html"));
	
?>
