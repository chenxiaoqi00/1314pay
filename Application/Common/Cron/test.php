<?php
if (!defined('THINK_PATH')) exit();
//if (filemtime($lock) < time()-$cron[3]['second']) {
	file_put_contents("a.txt", date("Y-m-d H:i:s") . "\r\n<br>", FILE_APPEND);
//}
