<{include file= "header.tpl"}>
<section class="page-wrapper">
    <section class="form-wrapper">
        <div class="form-title">找回密码</div>
        <form method="post" action="">
            <div class="form-control-group form-tips-wrapper">
                <div class="well well-warning">错误提示框</div>
            </div>
            <div class="form-control-group">
				<input class="form-control" type="text" name="email" placeholder="安全邮箱" tabindex="2"/>
            </div>
            <div class="form-control-group">
            	<input type="submit" class="btn btn-block btn-orange btn-submit" value="发送邮件" tabindex="3"/>
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
            
            var mailVal = $('[name="email"]').val();
            if (FormUtil.checkEmail(mailVal) == false) {
                showTipsMsg('error', '请填写正确的邮箱地址');
                return false;
            }

            $(this).attr('disabled', 'disabled');

            var params = {
                mail: mailVal
            };
            $.post('<{$site_domain}>/server/forgetpd.server.php', params, function(data) {
                var result = JSON.parse(data);
                
                if (result.status == 'true') {
                    showTipsMsg('success', '邮件已成功发送至您的邮箱，请注意查收');
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