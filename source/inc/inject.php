<?php

class Inject{
    public function __construct(){

    }

    public function _addslashes($string){
        if(!get_magic_quotes_gpc()){
            if(is_array($string)){
                foreach($string as $key=>$value){
                    $string[addslashes($key)] = $this->_addslashes($value);
                }

            }
            else{
                $string =  htmlspecialchars(addslashes($string));
                return $string;
            }
            return $string;
        }
    }
    
    #对邮箱字符匹配是否合法
    public function check_email($str){
    	$str = $this->_addslashes($str);
		if (preg_match("/^[\w!#$%&'*+\/=?^_`{|}~-]+(?:\.[\w!#$%&'*+\/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?$/", $str, $matches)){
            return true;
        }
        else{
            return false;
        }
    }

    #对用户呢称匹配是否合法
    public function check_name(){
    
    }
    
    #对用户个性签名匹配是否合法
    public function check_sign(){
    
    }

}

$inject = new Inject();
?>
