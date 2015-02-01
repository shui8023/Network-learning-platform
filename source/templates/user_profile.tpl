<{include file="header.tpl"}>
<section class="page-wrapper">
    <section class="center-grid clearfix">
        <aside>
            <div class="profile-wrapper">
                <div class="profile-info clearfix">
                    <div class="avatar pull-left">
                        <a href="#">
                            <img src="<{$site_domain}>/images/demo/avatar.png"/>
                        </a>
                    </div>
                    <div class="username"><a href="#">Jensyn</a></div>
                    <div class="rank">普通会员</div>
                </div>
                <a href="#" class="btn btn-block btn-green btn-upgrade">更换头像</a>
            </div>
            <div class="aside-navigation">
                <section class="activity">
                    <h4 class="activity-title">动态</h4>
                    <ul class="activity-list">
                        <li class="active">
                            <a href="#">我的课程</a>
                        </li>
                        <li>
                            <a href="#">关注的人</a>
                        </li>
                    </ul>
                </section>
                <section class="activity">
                    <h4 class="activity-title">动态</h4>
                    <ul class="activity-list">
                        <li class="active">
                            <a href="#">我的课程</a>
                        </li>
                        <li>
                            <a href="#">关注的人</a>
                        </li>
                    </ul>
                </section>
                <a href="#" class="video-preview aside-video-preview">
                    <div class="video-thumbnail"></div>
                </a>
            </div>
        </aside>
        <section class="page-content">
        	<section class="page-content-nav">
        		<ul>
        			<li class="active"><a href="#">我的资料</a></li>
        			<li><a href="<{$site_domain}>/user_message.php">我的私信</a></li>
        		</ul>
        	</section>
			<div class="profile-form-wrapper">
				<form method="post" action="">
                    <div class="form-control-group form-tips-wrapper">
                        <div class="well well-warning">错误提示框</div>
                    </div>
					<div class="form-control-group">
						<label class="form-label">昵称</label>
						<input class="form-control" type="text" name="username" value="<{$my_profile.name}>" placeholder="昵称" tabindex="1" autocomplete="off" disabled="disabled" />
						<div class="form-data"><{$my_profile.name}></div>
					</div>
					<div class="form-control-group">
						<label class="form-label">性别</label>
						<select class="form-control">
							<option value="男">男</option>
							<option value="男">女</option>
						</select>
						<div class="form-data"><{$my_profile.sex}></div>
					</div>
					<div class="form-control-group">
						<label class="form-label">密码</label>
						<input class="form-control" type="text" name="password" placeholder="******" tabindex="2" autocomplete="off" />
						<div class="form-data">******</div>
					</div>
					<div class="form-control-group">
						<label class="form-label">邮箱</label>
						<input class="form-control" type="text" name="email" value="<{$mail}>" placeholder="邮箱" tabindex="3" autocomplete="off" disabled="disabled" />
						<div class="form-data"><{$my_profile.mail}></div>
					</div>
					<div class="form-control-group">
						<label class="form-label">学校</label>
						<input class="form-control" type="text" name="school" value="<{$school}>" placeholder="学校" tabindex="5" autocomplete="off" />
						<div class="form-data"><{$my_profile.school}></div>
					</div>
					<div class="form-control-group">
						<label class="form-label">签名</label>
						<textarea class="form-control" name="signature" placeholder="签名" tabindex="6" autocomplete="off" rows="3"></textarea>
						<div class="form-data"><{$my_profile.signature}></div>
					</div>
					<div class="form-control-group">
						<input class="btn btn-block btn-green btn-submit" type="submit" value="保存" tabindex="7"/>
						<button class="btn btn-block btn-green btn-edit">编辑</button>
					</div>
				</form>
			</div>
        </section>
    </section>
</section>
<footer>
    <ul class="link-list clearfix">
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
	$(document).ready(function () {
        function showTipsMsg(status, msg) {
            if (status == "success") {
                $('.form-tips-wrapper .well').removeClass('well-warning').addClass('well-success');
            } else {
                $('.form-tips-wrapper .well').removeClass('well-success').addClass('well-warning');
            }
            $('.form-tips-wrapper .well').html(msg);
            $('.form-tips-wrapper').fadeIn(500);
        }

		$('.profile-form-wrapper .btn-submit').click(function () {
            var sexVal = $('[name="sex"]').val();
            var pwdVal = $('[name="password"]').val();
            var schoolVal = $('[name="school"]').val();
            var signVal = $('[name="signature"]').val();

            if (FormUtil.checkPwd(pwdVal) == false) {
                showTipsMsg("error", "请输入正确的密码");
                return false;
            }
            if (FormUtil.checkCommon(schoolVal) == false) {
                showTipsMsg("error", "请填写正确的学校名称");
                return false;
            }
            if (FormUtil.checkCommon(signVal) == false) {
                showTipsMsg("error", "请正确填写个性签名");
                return false;
            }

            $('.form-tips-wrapper .well').hide();

            var params = {
                sex: sexVal,
                password: pwdVal,
                school: schoolVal,
                sign: signVal
            };

            $.post('<{$site_domain}>/server/profile.server.php', params, function() {
                var result = JSON.parse(data);
                
                if (result.status == 'true') {
                    showTipsMsg('success', '资料修改成功');
                } else {
                    showTipsMsg('error', result.data);
                    $(this).removeAttr('disabled');               
                }
            });
            $(this).hide();
			$('.profile-form-wrapper .form-control').hide();
			$('.profile-form-wrapper .form-data').show();
			$('.profile-form-wrapper .btn-edit').css('display','block');
			return false;
		});
		$('.profile-form-wrapper .btn-edit').click(function () {
            $(this).hide();
			$('.profile-form-wrapper .form-data').hide();
			$('.profile-form-wrapper .form-control').show();
			$('.profile-form-wrapper .btn-submit').show();
			return false;
		});
	});
</script>
</html>