<?php
function getvar($variable) {
    if(isset($_POST[$variable]) && $_POST[$variable] !== '') {
        return $_POST[$variable];
    } elseif(isset($_GET[$variable]) && $_GET[$variable] !== '') {
        return $_GET[$variable];
    } else {
        return "";
    }
}
