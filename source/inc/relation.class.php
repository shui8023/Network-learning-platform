<?php
	require_once('conn.php');

class Relation{
	
	private $conn;
    private $fromuid;

	public function __construct($id){
		$this->conn = new Nlpdb();
        $this->fromuid = $id;
	}

	/*@add_relation:添加关注着信息
	 *@from_uid,是关注者
	 *@to_uid，是被关注者
	 *return:返回false/true
	 */
	public function add_relation($touid){
		#if (!is_numeric($from_uid) || !is_numeric($to_uid) || ($from_uid == $to_uid)) {
		#	return false;
		#}
        $query_str = "select fromuid, touid from user_relation where fromuid = $this->fromuid and touid = $touid";

        $result = $this->conn->query($query_str);

        if ($result != 'nothing'){
            return array("status" => false, "error" => "can't follow a man again");
        }

		$query_str = "insert into `user_relation`(fromuid, touid) value('$this->fromuid', '$touid')";
		
		$sql_error = "add_relation error";
		
		$result = $this->conn->query($query_str, $sql_error);

        if ($result == false){
            return array("status" => false, "error" => "follow error");
        }
        else{
            return array("status" => true);   
        }
		
	}
	/*@delete_relation:取消关注
	 *@from_uid:是关注者
	 *@to_uid:是被关注者
	 *return:返回false/ture
	 */
	public function delete_relation($touid) {
		#if (!is_numeric($from_uid) || !is_numeric($to_uid) || ($from_uid == $to_uid)) {
		#	return false;
		#}
        $query_str = "select fromuid, touid from user_relation where fromuid = $this->fromuid and touid = $touid";

        $result = $this->conn->query($query_str);

        if ($result == 'nothing'){
            return array("status" => false, "error" => "you don't follow this guy");
        }
		
		$query_str = "delete from  `user_relation` where fromuid = '$this->fromuid' and touid = '$touid'";
		
		$sql_error = "delete_relation  sql error";
		
		$result = $this->conn->query($query_str);

        if ($result == false){
            return array("status" => false, "error" => "cancel follow error");
        }
        else{
            return array("status" => true);
        }

	}
	
	/*@cat_relation:查看关注uid的人和查看uid关注的人
	 *@uid:登录人的uid
	 *@tag：tag = 0, 查询uid关注的人，tag=1,查询关注uid的人
	 *return:返回用户的头像，用户名，个性签名和学校的二维数组,没有数据返回false
	 */
	public function cat_relation($tag) { 
		if (($tag != 0 && $tag != 1))  {
			return array("status" => false, "error" => "tag error");
		}
		
		if ($tag == 0) {
			$query_str = "select uid, name, logo, sign, school from `user_info`  where user_info.uid = any(select touid from `user_relation` where fromuid = '$this->fromuid' )";

			$sql_error = "cat_relation sql error";

			$result = $this->conn->query($query_str, $sql_error);

			if ($result == false) {
				
				return array("status" => false, "error" => "cat follow error");
			}
            else if ($result == 'nothing'){
                return array("status" => true, "content" => null);
            }
            else{
                $num = count($result);
                while($num){
                    $key = key($result);
                    if ($this->get_relation($this->fromuid, $result[$key]['uid'])){
                        $result[$key]['relation'] = 1;
                    }
                    else{
                        $result[$key]['relation'] = 0;
                    }
                    next($result);
                    $num -= 1;
                }
			    return array("status" => true, "content" => $result);
            
            }
			
		}

		if ($tag  == 1) {
			$query_str = "select uid, name, logo, sign, school from `user_info`where user_info.uid = any(select fromuid from `user_relation` where touid = '$this->fromuid')";
			
			$sql_error = "cat_relation sql error";
			$result = $this->conn->query($query_str, $sql_error);

			if ($result == false) {
				
				return array("status" => false, "error" => "cat fans error");
			}
            else if ($result == 'nothing'){
                return array("status" => true, "content" => null);
            }
            else{
                $num = count($result);
                while($num){
                    $key = key($result);
                    if ($this->get_relation($result[$key]['uid'])){
                        $result[$key]['relation'] = 1;
                    }
                    else{
                        $result[$key]['relation'] = 0;
                    }
                    next($result);
                    $num -= 1;
                }
                return array("status" => true, "content" => $result);
            }

		}
	}

	
	/*@count_relation:查看关注uid的人的数量和查看uid关注的人的数量
	 *@uid:被查询人的uid
	 *@tag：tag=0,查询uid关注的人的数量，tag=1,查询关注uid的人的数量
	 *return:返回关注者的数量int,出错返回false
	 */
	public function count_relation($tag) {
		if (($tag != 0 && $tag != 1))  {
			return array("status" => false, "error" => "tag error");
		}
		
		if ($tag == 0) {
			$query_str = "select count(uid) from `user_info`  where user_info.uid = any(select touid from `user_relation` where fromuid = '$this->fromuid' )";
			
			$sql_error = "count_relation sql error";
			$result = $this->conn->query($query_str, $sql_error);

			if ($result == false) {
				return array("status" => false, "error" => "count follow error");
			}
            else if ($result == 'nothing'){
                return array("status" => true, "content" => 0);
            }
            else{
			    return array("status" => true, "content" => (int)$result[0]["count(uid)"]);
            }
		}

		if ($tag  == 1) {
			$query_str = "select count(uid) from `user_info`where user_info.uid = any(select fromuid from `user_relation` where touid = '$this->fromuid')";
			
			$sql_error = "count_relation sql error";
			$result = $this->conn->query($query_str, $sql_error);

			if ($result == false) {
				return array("status" => false, "error" => "count fans error");
			}
            else if ($result == 'nothing'){
                return array("status" => true, "content" => 0);
            }
            else{
			    return array("status" => true, "content" => (int)$result[0]["count(uid)"]);
            
            }
			
		}
		
	}

    //获取当前操作用户和所访问的目标用户， 操作用户是否关注目标用户
    public function get_relation($touid, $fromuid = 1000){
        if ($fromuid == 1000){
            $fromuid = $this->fromuid;
        }
        $query_str ="select rid from user_relation where fromuid = $fromuid and touid = $touid";
        $sql_error = "get_relation error";

        $result = $this->conn->query($query_str, $sql_error);

        if ($result == 'nothing'){              
            return 0;           //不存在关系
        }
        else{
            return 1;           //存在关系
        }
    }

	
	function __destruct()
	{

	}
	
}
?>
