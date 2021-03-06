SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

SET NAMES UTF8;

-- CREATE SCHEMA IF NOT EXISTS `cd_24beta` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
-- USE `cd_24beta` ;

-- -----------------------------------------------------
-- Table `cd_user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_user` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `email` VARCHAR(100) NOT NULL DEFAULT '' ,
  `name` VARCHAR(50) NOT NULL DEFAULT '' ,
  `password` VARCHAR(32) NOT NULL DEFAULT '' ,
  `create_time` INT NOT NULL DEFAULT 0 ,
  `create_ip` VARCHAR(15) NOT NULL DEFAULT '' ,
  `state` TINYINT NOT NULL DEFAULT 0 ,
  `token` VARCHAR(32) NOT NULL DEFAULT '' ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  INDEX `state_id_idx` (`state` ASC, `id` ASC) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  INDEX `create_time_idx` (`create_time` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `cd_category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_category` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL DEFAULT '' ,
  `post_nums` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `orderid` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `state` TINYINT UNSIGNED NOT NULL DEFAULT 1 ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_unique` (`name` ASC) ,
  INDEX `category_state_idx` (`state` ASC, `orderid` ASC, `id` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `cd_post`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_post` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `post_type` TINYINT UNSIGNED NOT NULL DEFAULT 0 ,
  `category_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `topic_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `title` VARCHAR(250) NOT NULL DEFAULT '' ,
  `create_time` INT NOT NULL DEFAULT 0 ,
  `create_ip` VARCHAR(15) NOT NULL DEFAULT '' ,
  `score` BIGINT NOT NULL DEFAULT 0 ,
  `score_nums` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `comment_nums` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `visit_nums` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `digg_nums` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `favorite_nums` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `user_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `user_name` VARCHAR(50) NOT NULL DEFAULT '' ,
  `source` VARCHAR(250) NOT NULL DEFAULT '' ,
  `tags` VARCHAR(250) NOT NULL DEFAULT '' ,
  `state` INT NOT NULL DEFAULT 0 COMMENT '0: 未审核\n1: 已审核' ,
  `istop` TINYINT UNSIGNED NOT NULL DEFAULT 0 ,
  `disable_comment` TINYINT UNSIGNED NOT NULL DEFAULT 0 ,
  `recommend` TINYINT UNSIGNED NOT NULL DEFAULT 0 ,
  `hottest` TINYINT UNSIGNED NOT NULL DEFAULT 0 ,
  `homeshow` TINYINT UNSIGNED NOT NULL DEFAULT 0 ,
  `thumbnail` VARCHAR(250) NOT NULL DEFAULT '' ,
  `contributor_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `contributor` VARCHAR(50) NOT NULL DEFAULT '' ,
  `contributor_site` VARCHAR(250) NOT NULL DEFAULT '' ,
  `contributor_email` VARCHAR(250) NOT NULL DEFAULT '' ,
  `summary` TEXT NULL ,
  `content` LONGTEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `category_id_state_create_time_idx` (`category_id` ASC, `state` ASC, `create_time` ASC) ,
  INDEX `title_idx` (`title` ASC) ,
  INDEX `post_homeshow_state_idx` (`homeshow` ASC, `state` ASC, `istop` ASC, `create_time` ASC) ,
  INDEX `topic_id_state_create_time_idx` (`topic_id` ASC, `state` ASC, `create_time` ASC) ,
  INDEX `post_create_time_state_idx` (`create_time` ASC, `state` ASC) ,
  INDEX `post_recommend_state_idx` (`recommend` ASC, `state` ASC, `create_time` ASC) ,
  INDEX `post_hottest_state_idx` (`hottest` ASC, `state` ASC, `create_time` ASC) ,
  INDEX `topic_id_state_istop_create_time_idx` (`topic_id` ASC, `state` ASC, `istop` ASC, `create_time` ASC) ,
  INDEX `post_state_id_idx` (`state` ASC, `id` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `cd_comment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_comment` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `post_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `content` TEXT NULL ,
  `create_time` INT NOT NULL DEFAULT 0 ,
  `create_ip` VARCHAR(15) NOT NULL DEFAULT '' ,
  `up_nums` INT UNSIGNED NOT NULL DEFAULT 0 ,
  `down_nums` INT UNSIGNED NOT NULL DEFAULT 0 ,
  `report_nums` INT UNSIGNED NOT NULL DEFAULT 0 ,
  `user_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `user_name` VARCHAR(50) NOT NULL DEFAULT '' ,
  `state` INT UNSIGNED NOT NULL DEFAULT 0 ,
  `recommend` TINYINT UNSIGNED NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) ,
  INDEX `post_id_state_idx` (`post_id` ASC, `state` ASC, `create_time` ASC) ,
  INDEX `user_id_id_idx` (`user_id` ASC, `id` ASC) ,
  INDEX `comment_recommend_state_create_time_idx` (`recommend` ASC, `state` ASC, `create_time` ASC) ,
  INDEX `comment_state_create_time_idx` (`state` ASC, `create_time` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `cd_tag`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_tag` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL DEFAULT '' ,
  `post_nums` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  INDEX `post_nums_idx` (`post_nums` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `cd_post_tag`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_post_tag` (
  `id` BIGINT(19) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `post_id` BIGINT(19) UNSIGNED NOT NULL DEFAULT '0' ,
  `tag_id` BIGINT(19) UNSIGNED NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `post_id_tag_id_unique` (`post_id` ASC, `tag_id` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `cd_topic`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_topic` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL DEFAULT '' ,
  `post_nums` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `icon` VARCHAR(250) NOT NULL DEFAULT '' ,
  `orderid` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_unique` (`name` ASC) ,
  INDEX `orderid_idx` (`orderid` ASC, `id` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `cd_special`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_special` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `token` VARCHAR(100) NOT NULL DEFAULT '' ,
  `name` VARCHAR(100) NOT NULL DEFAULT '' ,
  `thumbnail` VARCHAR(250) NOT NULL DEFAULT '' ,
  `create_time` INT NOT NULL DEFAULT 0 ,
  `desc` VARCHAR(250) NOT NULL DEFAULT '' ,
  `state` TINYINT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `token_UNIQUE` (`token` ASC) ,
  INDEX `state_create_time_idx` (`state` ASC, `create_time` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `cd_special_post`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_special_post` (
  `id` BIGINT(19) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `special_id` BIGINT(19) UNSIGNED NOT NULL DEFAULT '0' ,
  `post_id` BIGINT(19) UNSIGNED NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `special_id_post_id_idx` (`special_id` ASC, `post_id` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'special与post的多对多中间表' ;


-- -----------------------------------------------------
-- Table `cd_auth_itemchild`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_auth_itemchild` (
  `parent` VARCHAR(64) NOT NULL ,
  `child` VARCHAR(64) NOT NULL ,
  PRIMARY KEY (`parent`, `child`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `cd_auth_item`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_auth_item` (
  `name` VARCHAR(64) NOT NULL ,
  `type` INT(11) NOT NULL ,
  `description` TEXT NULL DEFAULT NULL ,
  `bizrule` TEXT NULL DEFAULT NULL ,
  `data` TEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `cd_auth_assignment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_auth_assignment` (
  `itemname` VARCHAR(64) NOT NULL ,
  `userid` VARCHAR(64) NOT NULL ,
  `bizrule` TEXT NULL DEFAULT NULL ,
  `data` TEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`itemname`, `userid`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `cd_upload`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_upload` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `post_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `file_type` TINYINT UNSIGNED NOT NULL DEFAULT 0 ,
  `url` VARCHAR(250) NOT NULL DEFAULT '' ,
  `create_time` INT NOT NULL DEFAULT 0 ,
  `create_ip` VARCHAR(15) NOT NULL DEFAULT '' ,
  `user_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `desc` VARCHAR(250) NOT NULL DEFAULT '' ,
  `token` VARCHAR(32) NOT NULL DEFAULT '' ,
  PRIMARY KEY (`id`) ,
  INDEX `post_id_idx` (`post_id` ASC) ,
  INDEX `user_id_idx` (`user_id` ASC) ,
  INDEX `token_idx` (`token` ASC) ,
  INDEX `file_type` (`file_type` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci, 
COMMENT = '上传文件表' ;


-- -----------------------------------------------------
-- Table `cd_config`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_config` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `category_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 ,
  `config_name` VARCHAR(100) NOT NULL DEFAULT '' ,
  `config_value` TEXT NULL ,
  `config_type` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '参数类型\n0 为系统参数，不能删除\n1 为自定义参数' ,
  `name` VARCHAR(50) NOT NULL DEFAULT '' ,
  `desc` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `config_name_UNIQUE` (`config_name` ASC) ,
  INDEX `category_id_id_idx` (`category_id` ASC, `id` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci, 
COMMENT = '配置信息表' ;


-- -----------------------------------------------------
-- Table `cd_filter_keyword`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cd_filter_keyword` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `keyword` VARCHAR(50) NOT NULL DEFAULT '' ,
  `replace` VARCHAR(50) NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `keyword_UNIQUE` (`keyword` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci, 
COMMENT = '敏感关键词库' ;

-- ----------------------------
-- Table structure for `cd_link`
-- ----------------------------
CREATE TABLE IF NOT EXISTS `cd_link` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `url` varchar(250) NOT NULL DEFAULT '',
  `logo` varchar(250) NOT NULL DEFAULT '',
  `desc` varchar(250) NOT NULL DEFAULT '',
  `orderid` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `url_UNIQUE` (`url`),
  KEY `orderid_id_idx` (`orderid`,`id`)
) ENGINE=MyISAM 
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci, 
COMMENT='友情链接表';

CREATE TABLE IF NOT EXISTS `cd_adcode` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ad_id` int(10) unsigned NOT NULL,
  `adcode` text,
  `intro` varchar(250) NOT NULL DEFAULT '',
  `state` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM 
AUTO_INCREMENT=6 
DEFAULT CHARSET=utf8 
COLLATE = utf8_general_ci,  
COMMENT='广告';

CREATE TABLE IF NOT EXISTS `cd_advert` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `solt` varchar(50) NOT NULL DEFAULT '',
  `intro` varchar(250) NOT NULL DEFAULT '',
  `state` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `token_UNIQUE` (`solt`)
) ENGINE=MyISAM 
AUTO_INCREMENT=6 
DEFAULT CHARSET=utf8 
COLLATE = utf8_general_ci, 
COMMENT='广告位';

CREATE TABLE IF NOT EXISTS `cd_post_favorite` (
  `id` bigint(19) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(19) unsigned NOT NULL DEFAULT '0',
  `post_id` bigint(19) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `create_ip` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_post_id_unique` (`user_id`,`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cd_user_profile` (
  `user_id` bigint(19) unsigned NOT NULL,
  `province` int(10) unsigned NOT NULL DEFAULT '0',
  `city` int(11) NOT NULL DEFAULT '0',
  `location` varchar(100) NOT NULL DEFAULT '',
  `gender` set('0','1','2') NOT NULL DEFAULT '0',
  `description` varchar(250) NOT NULL DEFAULT '',
  `website` varchar(250) NOT NULL DEFAULT '',
  `image_url` varchar(250) NOT NULL DEFAULT '',
  `avatar_large` varchar(250) NOT NULL DEFAULT '',
  `weibo_uid` varchar(50) NOT NULL DEFAULT '0',
  `qqt_uid` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `cd_user` VALUES ('1', 'admin@24beta.com', 'admin', '4297f44b13955235245b2497399d7a93', '0', '', '1', '');
INSERT INTO `cd_link` VALUES ('1', '贝塔精读', 'http://www.24beta.com', '', '每日IT资讯精选', '0'), ('2', '24Blog', 'http://www.24chinaz.com', '', '专业PHP开源博客媒体软件', '0');
INSERT INTO `cd_auth_assignment` VALUES ('admin', '1', null, 'N;');
INSERT INTO `cd_auth_item` VALUES ('create_post', '0', 'create a post', null, 'N;'), ('update_post', '0', 'update a post', null, 'N;'), ('delete_post', '0', 'delete a post', null, 'N;'), ('enter_admin_system', '0', 'login into admin system', null, 'N;'), ('update_own_post', '1', 'update a post by author himself', 'return Yii::app()->user->id==$params[\"post\"]->user_id;', 'N;'), ('author', '2', '', null, 'N;'), ('editor', '2', '', null, 'N;'), ('admin', '2', '', null, 'N;'), ('chief_editor', '2', null, null, null), ('upload_file', '0', 'upload file', null, null), ('create_post_in_home', '0', 'create_post_in_home', null, null);
INSERT INTO `cd_auth_itemchild` VALUES ('admin', 'chief_editor'), ('admin', 'delete_post'), ('author', 'create_post'), ('author', 'update_own_post'), ('author', 'upload_file'), ('chief_editor', 'create_post_in_home'), ('chief_editor', 'editor'), ('chief_editor', 'enter_admin_system'), ('editor', 'author'), ('editor', 'update_post'), ('update_own_post', 'update_post');
INSERT INTO `cd_config` VALUES ('1', '11', 'sitename', '贝塔资讯', '0', '网站名称', '网站的名称'), ('2', '11', 'shortdesc', '我们不是一个人在战斗', '0', '网站短描述', '会附加在网页标题的后面'), ('4', '11', 'beian_code', '京ICP备09098940号-1', '0', '备案号', '备案号'), ('5', '11', 'tongji_code', '<script type=\"text/javascript\">\r\nvar _bdhmProtocol = ((\"https:\" == document.location.protocol) ? \" https://\" : \" http://\");\r\ndocument.write(unescape(\"%3Cscript src=\'\" + _bdhmProtocol + \"hm.baidu.com/h.js%3F301bf48ccd2d928584a1c7750415a859\' type=\'text/javascript\'%3E%3C/script%3E\"));\r\n</script>', '0', '流量统计代码', '统计代码'), ('6', '11', 'header_html', '', '0', 'header 额外html代码', '在整站head标签内可以自己添加一些html代码，比如meta或是js等等'), ('7', '11', 'footer_after_html', '', '0', '</body>之前html代码', '在整站</body>标签之前可以自己添加一些html代码，比如js等等'), ('8', '11', 'footer_before_html', '', '0', '版权信息之前html代码', '在版本信息上面可以添加额外的代码，比如一个通栏广告代码'), ('9', '11', 'urlFormat', 'get', '0', 'URL 格式', 'get|path，如果设置为path，需要在web服务端设置rewrite重定向'), ('10', '11', 'site_keywords', 'IT资讯,IT新闻,IT业界资讯,手机资讯,智能手机资讯,iPhone资讯,Android安卓资讯,数码产品资讯,新品发布资讯,互联网业界资讯,htc智能手机,三星智能手机,摩托罗拉moto智能手机', '0', '首页关键词', null), ('11', '11', 'site_description', '24Beta.com贝塔资讯为您提供最新最快IT业界资讯,报导立场公正中立,网友讨论气氛浓厚.创造出最适合目标人群阅读的新闻、评论、观点和专访。紧随科技前沿，追踪科技新品发布，让您第一时间了解最新最酷的科技产品。', '0', '首页description', null), ('14', '22', 'filterKeywordReplacement', '文明用语', '0', '敏感关键词通用替换词', null), ('15', '22', 'postCountOfPage', '12', '0', '概述列表显示方式每页显示的文章数量', null), ('16', '22', 'postCountOfTitleListPage', '25', '0', '标题显示列表每页显示的文章数量', null), ('17', '22', 'commentCountOfPage', '20', '0', '每页显示的评论数量', null), ('18', '22', 'hotCommentCountOfPage', '15', '0', '每页显示的热门评论数量', null), ('19', '22', 'upNumsOfCommentIsHot', '10', '0', '支持数达到多少才认为是热门评论', null), ('20', '22', 'commentMinLength', '5', '0', '评论内容最短长度', null), ('21', '22', 'recommendPostsCount', '10', '0', '编辑推荐文章显示数量', null), ('22', '22', 'recommendCommentsCount', '15', '0', '编辑推荐评论显示数量', null), ('23', '11', 'defaultNewCommentState', '1', '0', '发表评论是否直接显示', '1直接显示，0需要审核'), ('24', '11', 'defaultPostShowHomePage', '1', '0', '默认发布的文章是否直接显示在首页', '1直接显示在首页，2需要管理员审核'), ('25', '22', 'subSummaryLen', '300', '0', '概述列表方式下概述内容最大长度', null), ('26', '22', 'summaryHtmlTags', '<b><strong><img><p>', '0', '简述中可以使用的html标签', null), ('28', '11', 'autoLoginDuration', '604800', '0', '记住用户登录状态的cookie时间', '用户登录时选择记住状态时cookie保存的时间，单位为秒'), ('29', '21', 'theme', null, '0', '当前使用的模板', '如果使用默认模板请留空'), ('30', '22', 'enable_lazyload_img', '1', '0', '启用lazyload方式载入列表图片', null), (31, '22', 'post_list_show_topic_icon', '0', '0', '首页文章列表是否显示主题图片', null);

INSERT INTO `cd_config` VALUES (null, '11', 'user_required_admin_verfiy', '1', '0', '用户注册是否需要管理员审核', '用户注册是否需要管理审核'), (null, '11', 'user_required_email_verfiy', '0', '0', '用户注册是否需要邮件审核', '用户注册是否需要邮件审核'), (null, '22', 'post_list_type', '0', '0', '分类文章列表方式', '0 为跟首页一样显示概述\r\n1 为标题列表方式');
INSERT INTO `cd_adcode` VALUES ('1', '1', '<script type=\"text/javascript\"><!--\n    google_ad_client = \"ca-pub-9725980429199769\";\n    /* beta_336x280 */\n    google_ad_slot = \"9661689878\";\n    google_ad_width = 336;\n    google_ad_height = 280;\n    //-->\n</script>\n<script type=\"text/javascript\" src=\"http://pagead2.googlesyndication.com/pagead/show_ads.js\"></script>', 'google adsense', '1'), ('2', '2', '<script type=\"text/javascript\"><!--\n    google_ad_client = \"ca-pub-9725980429199769\";\n    /* beta_336x280 */\n    google_ad_slot = \"9661689878\";\n    google_ad_width = 336;\n    google_ad_height = 280;\n    //-->\n</script>\n<script type=\"text/javascript\" src=\"http://pagead2.googlesyndication.com/pagead/show_ads.js\"></script>', 'google adsense', '1'), ('3', '5', '<script type=\"text/javascript\"><!--\n    google_ad_client = \"ca-pub-9725980429199769\";\n    /* beta_336x280 */\n    google_ad_slot = \"9661689878\";\n    google_ad_width = 336;\n    google_ad_height = 280;\n    //-->\n</script>\n<script type=\"text/javascript\" src=\"http://pagead2.googlesyndication.com/pagead/show_ads.js\"></script>', 'google adsense', '1'), ('4', '3', '<script type=\"text/javascript\"><!--\n    google_ad_client = \"ca-pub-9725980429199769\";\n    /* beta_336x280 */\n    google_ad_slot = \"9661689878\";\n    google_ad_width = 336;\n    google_ad_height = 280;\n    //-->\n</script>\n<script type=\"text/javascript\" src=\"http://pagead2.googlesyndication.com/pagead/show_ads.js\"></script>', 'google adsense', '1'), ('5', '4', '<script type=\"text/javascript\"><!--\n    google_ad_client = \"ca-pub-9725980429199769\";\n    /* beta_336x280 */\n    google_ad_slot = \"9661689878\";\n    google_ad_width = 336;\n    google_ad_height = 280;\n    //-->\n</script>\n<script type=\"text/javascript\" src=\"http://pagead2.googlesyndication.com/pagead/show_ads.js\"></script>', 'google adsense', '1');
INSERT INTO `cd_advert` VALUES ('1', '首页侧边栏第一个广告位', 'home_sidebar_ad_01', '位于侧边栏最顶部', '1'), ('2', '首页侧边栏第二个广告位', 'home_sidebar_ad_02', '位于最具人气排行下方', '1'), ('3', '详情页侧边栏第一个广告位', 'post_detail_sidebar_ad_01', '侧边栏热门评论下方', '1'), ('4', '其它页面侧边栏广告位', 'sidebar_ad_01', '分类文章、主题文章等其它页面侧边栏广告位', '1'), ('5', '首页侧边栏第三个广告位', 'home_sidebar_ad_03', '位于编辑推荐下方', '1');

INSERT INTO `cd_config` VALUES (null, '14', 'auto_remote_image_local', '0', '0', '图片本地化', '后台发表修改文章的时候自动将内容中的图片本地化，0为关闭，1为开启');
INSERT INTO `cd_config` VALUES (null, '22', 'mobile_post_list_page_count', '8', '0', '手机网站每页显示文章数量', '手机网站每页显示文章数量');
INSERT INTO `cd_config` VALUES (null, '22', 'mobileSummaryHtmlTags', '<img>', '0', '手机网站概述中允许使用的html标签', '手机网站概述中允许使用的html标签，可以自行添加，如：<b><img>');
INSERT INTO `cd_post` VALUES (null, '0', '0', '0', '24blog 正式更名为24beta，做最专业的轻cms系统', '1356937385', '60.216.87.146', '0', '0', '0', '1', '0', '0', '1', 'admin', 'http://www.24beta.com', '', '1', '0', '0', '0', '0', '1', '', '0', '', '', '', '<p>\r\n	24blog正式更名为24beta，做最专业的轻cms系统。\r\n</p>\r\n<p>\r\n	2012年12月31日，终于在2012年的最后一天发布了1.4版本，主要升级功能有两个，一是添加了相对完整的用户中心；二是添加了与用户有关的收藏功能。\r\n</p>\r\n<p>\r\n	还有大量的bug及功能改进不再一一细说，此版本程序和模板有不少改动，如果您自己修改过模板的话，升级的时候需要注意一下。\r\n</p>', '<p>\r\n	24blog正式更名为24beta，做最专业的轻cms系统。\r\n</p>\r\n<p>\r\n	2012年12月31日，终于在2012年的最后一天发布了1.4版本，主要升级功能有两个，一是添加了相对完整的用户中心；二是添加了与用户有关的收藏功能。\r\n</p>\r\n<p>\r\n	还有大量的bug及功能改进不再一一细说，此版本程序和模板有不少改动，如果您自己修改过模板的话，升级的时候需要注意一下。\r\n</p>');
COMMIT;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
