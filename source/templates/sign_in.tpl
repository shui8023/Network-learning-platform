<{include file= "header.tpl"}>
<section class="page-wrapper">
    <section class="form-wrapper">
        <div class="form-title">登录</div>
        <form method="post" action="">
            <div class="form-control-group form-tips-wrapper">
             	<div class="well well-warning">错误提示框</div>
            </div>
            <div class="form-control-group">
             	<input type="text" name="email" class="form-control" placeholder="邮箱" tabindex="1"/>
            </div>
            <div class="form-control-group">
                <input type="password" name="password" class="form-control" placeholder="密码" tabindex="2"/>
            </div>
            <div class="form-control-group">
            	<input type="submit" class="btn btn-block btn-green btn-submit" value="登录" tabindex="3"/>
            </div>
        </form>
        <div class="form-separator"></div>
        <a class="btn btn-block btn-blue" href="<{$site_domain}>/sign_up.php">注册</a>
        <div class="form-separator"></div>
        <a class="btn btn-block btn-orange" href="<{$site_domain}>/forgetpd.php">找回密码</a>
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
        function showErrTips(msg) {
            $('.form-tips-wrapper .well').html(msg);
            $('.form-tips-wrapper').fadeIn(500);
        }

        $('.btn-submit').click(function() {
            $('.form-tips-wrapper').hide();
            
            var mailVal = $('[name="email"]').val();
            var pwdVal = $('[name="password"]').val();
            if (FormUtil.checkEmail(mailVal) == false) {
                showErrTips("请输入正确的邮箱");
                return false;
            } else if (FormUtil.checkPwd(pwdVal) == false) {
                showErrTips("请输入正确的密码");
                return false;
            }

            var params = {
                mail: mailVal,
                password: $.md5(pwdVal)
            };

            $.post('<{$site_domain}>/server/login.server.php', params, function(data) {
                var result = JSON.parse(data);

                if (result.status == 'true') {
                    location.href = '<{$site_domain}>/user_profile.php';
                } else {
                    showErrTips(result.data);
                }
            });
            return false;
        });
    });
</script>
</html>