<{include file="header.tpl"}>
<section class="page-wrapper">
    <section class="form-wrapper">
        <div class="form-title">注册</div>
        <form method="post" action="">
            <div class="form-control-group form-tips-wrapper">
                <div class="well well-warning">错误提示框</div>
            </div>
            <div class="form-control-group">
                <input type="text" name="username" class="form-control" placeholder="用户名" autocomplete="off" tabindex="1"/>
            </div>
            <div class="form-control-group">
                <input type="password" name="password" class="form-control" placeholder="密码" autocomplete="off" tabindex="2"/>
            </div>
            <div class="form-control-group">
                <input type="text" name="email" class="form-control" placeholder="邮箱" autocomplete="off" tabindex="3"/>
            </div>
            <div class="form-control-group">
            	<input type="submit" class="btn btn-block btn-orange btn-submit" value="注册" tabindex="4"/> 	
            </div>

        </form>
        <div class="form-separator"></div>
        <a class="btn btn-block btn-green" href="<{$site_domain}>/sign_in.php">登录</a>
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

        $('.btn-submit').click(function() {
            $('.form-tips-wrapper').hide();

            var usernameVal = $('[name="username"]').val();
            var pwdVal = $('[name="password"]').val();
            var mailVal = $('[name="email"]').val();
            if (FormUtil.checkEmail(mailVal) == false) {
                showTipsMsg("error", "请输入正确的邮箱");
                return false;
            } else if (FormUtil.checkPwd(pwdVal) == false) {
                showTipsMsg("error", "请输入正确的密码");
                return false;
            }

            $(this).attr('disabled', 'disabled');

            var params = {
                name: usernameVal,
                mail: mailVal,
                password: $.md5(pwdVal)
            };
            console.log(params);
            $.post('<{$site_domain}>/server/signup.server.php', params, function(data) {
                console.log(data);
                var result = JSON.parse(data);

                if (result.status == 'true') {
                    showTipsMsg("success", "恭喜你，注册成功");
                    //location.href = '<{$site_domain}>/dashboard.php';
                } else {
                    showTipsMsg("error", result.data);
                    $(this).removeAttr('disabled'); 
                }
            });
            return false;
        });
    });
</script>
</html>