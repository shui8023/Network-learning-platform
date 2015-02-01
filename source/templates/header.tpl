<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>接课网</title>
    <link rel="stylesheet" href="<{$site_domain}>/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="<{$site_domain}>/css/reset.css" />
    <link rel="stylesheet" href="<{$site_domain}>/css/common.css" />
    <link rel="stylesheet" href="<{$site_domain}>/css/wedgit.css" />
    <link rel="stylesheet" href="<{$site_domain}>/css/dashboard.css" />
    <link rel="stylesheet" href="<{$site_domain}>/css/style.css" />
    <link rel="stylesheet" href="<{$site_domain}>/css/user-relation.css" />
</head>
<body>
<header>
    <div class="navigation clearfix">
        <div class="logo pull-left">
            <a href="#"><img src="<{$site_domain}>/images/demo/logo-160-20.svg"/></a>
        </div>
        <div class="menu pull-left">
            <ul class="clearfix">
                <li class="menu-item first active"><a href="<{$site_domain}>/index.html">首页</a></li>
                <li class="menu-item menu-course menu-drop-down"><a href="#">课程</a></li>
                <li class="menu-item"><a href="index.html">求课</a></li>
            </ul>
            <div class="modal shadow course-drop-down-modal">
                <div class="inner-modal">
                    <div class=" arrow-up arrow"></div>
                    <div class="modal-body clearfix">
                        <ul class="category-list pull-left">
                            <li><a href="#">计算机</a></li>
                            <li><a href="#">数学</a></li>
                            <li><a href="#">通信</a></li>
                        </ul>
                        <ul class="course-list pull-left">
                            <li><a href="#">操作系统</a></li>
                            <li><a href="#">微机原理</a></li>
                            <li><a href="#">计算机组成原理</a></li>
                            <li><a href="#">通信原理</a></li>
                            <li><a href="#">模拟电路</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <{if $smarty.session.uid != ""}>
        <div class="navigation-right pull-right clearfix">
            <input class="form-control search-input pull-left" placeholder="搜索"/>
            <a class="link-profile" href="#">
                <div class="username pull-left">Jensyn</div>
                <div class="avatar pull-right">
                    <img src="<{$site_domain}>/images/demo/avatar.png"/>
                </div>
            </a>
            <div class="modal shadow drop-down-list">
                <div class="inner-modal">
                    <div class=" arrow-up arrow-custom"></div>
                    <ul>
                        <li><a href="#">个人中心</a></li>
                        <li><a href="#">我的课程</a></li>
                        <li><a href="<{$site_domain}>/sign_in.php">退出登录</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <{else}>
        <div class="navigation-right pull-right clearfix">
            <input class="form-control search-input pull-left" placeholder="搜索"/>
            <a href="<{$site_domain}>/sign_in.php" class="link-sign-in pull-left">登 录</a>
            <a href="<{$site_domain}>/sign_up.php" class="btn btn-green btn-sign-up pull-right">注 册</a>
        </div>
        <{/if}>
    </div>
</header>
