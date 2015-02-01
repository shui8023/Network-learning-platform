<{include file="header.tpl"}>
<section class="page-wrapper">
    <section class="form-wrapper">
        <div class="form-title">忘记密码</div>
        <form method="post" action="">
            <div class="form-control-group form-tips-wrapper">
                <div class="well well-warning">错误提示框</div>
            </div>
            <div class="form-control-group">
                <div class="form-input-wrapper">
                    <input type="password" name="password" class="form-control" autocomplete="off" placeholder="重置密码" tabindex="1"/>
                </div>
            </div>
            <div class="form-control-group">
                <div class="form-input-wrapper">
                    <input type="password" name="repeat-password" class="form-control" autocomplete="off" placeholder="确认密码" tabindex="2"/>
                </div>
            </div>
            <div class="form-control-group">
            	<input type="submit" class="btn btn-block btn-orange btn-submit" value="修改密码" tabindex="3"/>
            </div>
        </form>
        <div class="form-separator"></div>
        <a href="<{$site_domain}>/sign_in.php" class="btn btn-block btn-green">返回登录</a>
    </section>
</section>
<footer>
    <ul class="clearfix">
        <li>@接课网</li>
        <li><a href="#">关于</a></li>
        <li><a href="#">团队</a></li>
        <li><a href="#">博客</a></li>
    </ul>
</footer>
</body>
<script type="text/javascript" src="<{$site_domain}>/js/jquery.js"></script>
<script type="text/javascript" src="<{$site_domain}>/js/jquery.md5.js"></script>
<script type="text/javascript" src="<{$site_domain}>/plugins/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript" src="<{$site_domain}>/plugins/jQueryFullPage/js/jquery.fullPage.min.js"></script>

<!--init page events-->
<script type="text/javascript" src="<{$site_domain}>/js/app_init.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        function showTipsMsg(status, msg) {
            if (status == "success") {
                $('.form-tips-wrapper .well').removeClass('well-warning').addClass('well-success');
            } else {
                $('.form-tips-wrapper .well').removeClass('well-success').addClass('well-warning');
            }
            $('.form-tips-wrapper .well').html(msg);
            $('.form-tips-wrapper').fadeIn(500);
        }

        $('.form-wrapper .btn-submit').click(function() {
            $('.form-tips-wrapper').hide();
            
            var pwdVal = $('[name="password"]').val();
            var repwdVal = $('[name="repeat-password"]').val();

            if (FormUtil.checkPwd(pwdVal) == false) {
                showTipsMsg('error', '密码填写不正确！');
                return false;
            } else if (repwdVal != pwdVal) {
                showTipsMsg('error', '两次输入的密码不相同！');
                return false;
            }

            $(this).attr('disabled', 'disabled');

            var params = {
                password : $.md5(pwdVal),
                time : '<{$time}>',
                token : '<{$token}>',
                uid : '<{$uid}>'
            };

            $.post('<{$site_domain}>/server/reset.server.php', params, function(data) {
                var result = JSON.parse(data);
                
                if (result.status == 'true') {
                    showTipsMsg('success', '密码修改成功！');
                } else {
                    showTipsMsg('error', result.data);
                    $(this).removeAttr('disabled'); 
                }
            });
            return false;
        });
    });
</script>
</html>
