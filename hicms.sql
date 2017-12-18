/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : hicms

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2017-05-31 08:57:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for hi_ad
-- ----------------------------
DROP TABLE IF EXISTS `hi_ad`;
CREATE TABLE `hi_ad` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '广告名称',
  `pos` smallint(3) NOT NULL COMMENT '广告位置',
  `image` mediumint(8) NOT NULL,
  `url` varchar(100) NOT NULL COMMENT '广告链接',
  `enddate` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `extend` varchar(255) NOT NULL DEFAULT '' COMMENT '广告扩展参数',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  `hits` mediumint(8) NOT NULL DEFAULT '0' COMMENT '点击数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告表';

-- ----------------------------
-- Records of hi_ad
-- ----------------------------
INSERT INTO `hi_ad` VALUES ('4', '标题', '1', '1', 'http://www.allship.cn/Weixin', '1501084800', '', '0', '1', '0');

-- ----------------------------
-- Table structure for hi_adpos
-- ----------------------------
DROP TABLE IF EXISTS `hi_adpos`;
CREATE TABLE `hi_adpos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '广告位置名称',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '广告类型:1,图片 2,FLASH 3,文字',
  `width` mediumint(5) NOT NULL COMMENT '广告位置宽度',
  `height` mediumint(5) NOT NULL COMMENT '广告位置高度',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  `tpl` varchar(20) NOT NULL,
  `sort` tinyint(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告位置表';

-- ----------------------------
-- Records of hi_adpos
-- ----------------------------
INSERT INTO `hi_adpos` VALUES ('1', '首页横幅', '1', '1000', '200', '1', '', '0');

-- ----------------------------
-- Table structure for hi_article
-- ----------------------------
DROP TABLE IF EXISTS `hi_article`;
CREATE TABLE `hi_article` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '栏目ID',
  `title` varchar(160) NOT NULL DEFAULT '' COMMENT '文章标题',
  `style` char(7) NOT NULL DEFAULT '' COMMENT '字体样式',
  `thumb` mediumint(8) unsigned NOT NULL COMMENT '缩略图',
  `tags` varchar(255) NOT NULL DEFAULT '' COMMENT '标签',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键词',
  `description` mediumtext COMMENT '简介',
  `url` char(100) NOT NULL DEFAULT '' COMMENT '跳转链接',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 -1:删除 0:禁用 1:正常 2:审核',
  `uid` mediumint(10) NOT NULL COMMENT '用户ID',
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `views` int(11) NOT NULL DEFAULT '0' COMMENT '点击总数',
  `islink` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否跳转链接 1:跳转 0:否',
  `iscomment` tinyint(1) NOT NULL COMMENT '是否允许评论 1:允许 0:禁止',
  `ispos` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`sort`,`id`),
  KEY `listorder` (`catid`,`status`,`sort`,`id`),
  KEY `catid` (`catid`,`views`,`status`,`id`),
  KEY `thumb` (`thumb`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='文章资讯表';

-- ----------------------------
-- Records of hi_article
-- ----------------------------
INSERT INTO `hi_article` VALUES ('1', '88', '阿斯蒂芬', '', '0', '摘要 关键', '', '', '', '0', '1', '1', '1492397366', '1492397366', '0', '0', '1', '0');
INSERT INTO `hi_article` VALUES ('2', '28', '大事发生地方', '', '0', '', '', '', '', '0', '1', '1', '1492398323', '1492398323', '0', '0', '1', '0');
INSERT INTO `hi_article` VALUES ('3', '73', '大事发生地方1', '', '0', '', '', '', '', '0', '1', '1', '1492398371', '1492398371', '0', '0', '1', '0');
INSERT INTO `hi_article` VALUES ('4', '84', '大事发生地方12', '', '0', '', '', '', '', '0', '1', '1', '1492398739', '1492398739', '0', '0', '1', '0');
INSERT INTO `hi_article` VALUES ('5', '65', '大事发生地方123', '', '0', '', '', '', '', '0', '1', '1', '1492398825', '1492398825', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('6', '29', '大事发生地方1233', '', '0', '', '', '', '', '0', '1', '1', '1492398911', '1492398911', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('7', '197', '顶起', '', '0', '文章 标题', '', '文章标题', '', '0', '1', '1', '1492399437', '1492399437', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('8', '81', '顶起1', '', '0', '文章 标题', '', '文章标题', '', '0', '1', '1', '1492399504', '1492399504', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('9', '81', '顶起11', '', '8', '文章 标题', '顶起11', '文章标题', '', '0', '1', '1', '1492399500', '1493298772', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('10', '81', '顶起111', '', '0', '文章 标题', '', '文章标题', '', '0', '1', '1', '1492399560', '1492399560', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('11', '81', '文章标题1', '', '6', '关键 或者', '文章标题1', '', '', '0', '1', '1', '1492839218', '1492839218', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('12', '81', '文章标题1111', '', '1', '', '文章标题1111', '', '', '0', '1', '1', '1492838940', '1493298741', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('13', '81', '文章标题11111', '', '2', '', '文章标题11111', '', '', '0', '0', '1', '1492839531', '1492839531', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('14', '81', '文章标题111111', '', '0', '12 12', '', '', '', '0', '0', '1', '1492399766', '1492399766', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('15', '81', '文章标题23213123', '', '0', '12 12', '文章标题1111111', '11', '', '0', '0', '1', '1492839000', '1495682368', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('16', '81', '文章标题2', '', '0', '12 12', '文章标题2', '', '', '0', '0', '1', '1492786620', '1494986920', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('17', '81', '文章标题21', '', '0', 'NB 他们 标签', '文章标题21', '', '', '0', '0', '1', '1492782275', '1492782275', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('18', '27', '文章标题211', '', '0', 'women 他们', '', '', '', '0', '-1', '1', '1492399850', '1492399850', '0', '0', '1', '0');
INSERT INTO `hi_article` VALUES ('19', '82', '文章标题2111', '', '0', 'women 他们', '', '', '', '0', '0', '1', '1492399912', '1492399912', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('20', '89', '文章标题21111', '', '0', 'women 他们', '', '', '', '0', '0', '1', '1492399953', '1492399953', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('21', '69', '测试文章发布', '', '0', '他们 你们', '', '', '', '99', '0', '1', '1492401339', '1492401339', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('22', '27', '文章标题111211', '', '0', '文章 标题', '文章标题111211', '文章标题文章标题文章标题文章标题文章标题文章标题文章标题文章标题', '', '0', '0', '1', '1492675920', '1493388064', '111', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('23', '27', '文章标题名称，还可输入 80 个字符', '#a2a600', '0', '文章 标题 名称 出处', '文章标题名称，还可输入 80 个字符', '', '', '0', '0', '1', '1492782420', '1493973815', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('25', '31', '文章标题名称', '', '8', '文章 标题', '文章标题名称', '', '', '0', '0', '1', '1493260982', '1493260982', '0', '0', '1', '1');
INSERT INTO `hi_article` VALUES ('26', '27', '撒大发撒旦法师打发斯蒂芬', '', '1', '', '撒大发撒旦法师打发斯蒂芬', '', '', '0', '0', '1', '1493973900', '1493973980', '0', '0', '1', '1');

-- ----------------------------
-- Table structure for hi_article_data
-- ----------------------------
DROP TABLE IF EXISTS `hi_article_data`;
CREATE TABLE `hi_article_data` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `content` mediumtext COMMENT '文章内容',
  `paginationtype` tinyint(1) NOT NULL DEFAULT '0',
  `maxcharperpage` mediumint(6) NOT NULL DEFAULT '0',
  `template` varchar(30) NOT NULL DEFAULT '' COMMENT '模板',
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allow_comment` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否评论',
  `relation` varchar(255) NOT NULL DEFAULT '',
  `copyfrom` varchar(255) NOT NULL DEFAULT '' COMMENT '来源',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章资讯副表';

-- ----------------------------
-- Records of hi_article_data
-- ----------------------------
INSERT INTO `hi_article_data` VALUES ('1', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">&nbsp;多个标签,空格或者“,”或者“|”分割</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">&nbsp;多个标签,空格或者“,”或者“|”分割</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">&nbsp;多个标签,空格或者“,”或者“|”分割</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">&nbsp;多个标签,空格或者“,”或者“|”分割</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">&nbsp;多个标签,空格或者“,”或者“|”分割</span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('2', '<p>撒打发斯蒂芬</p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('3', '<p>撒打发斯蒂芬</p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('4', '<p>撒打发斯蒂芬</p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('5', '<p>撒打发斯蒂芬</p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('7', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('8', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('9', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('10', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('13', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('14', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('15', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题11111</span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('16', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('17', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('18', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('19', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('20', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('21', '<p>撒旦法撒打发斯蒂芬</p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('22', '<p><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文11章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题</span><span style=\"color: rgb(115, 115, 115); font-family: Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\">文章标题<img src=\"/Uploads/Editor/image/20170428/59034b1ee03a1.jpg\" title=\"59034b1ee03a1.jpg\" alt=\"timg (9).jpg\"/></span></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('23', '<p class=\"otitle\" style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">（<img src=\"/Uploads/Editor/image/20170505/590c30061bb74.jpg\" title=\"590c30061bb74.jpg\" alt=\"timg (3).jpg\"/>原标题：凌晨更新微博的市长，一天之后就被组织审查）</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">“五一”放假前的最后一个工作日，政知君的手机上，新闻弹窗不断。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">上海“首虎”艾宝俊、宁夏“首虎”白雪山、广西“第二虎”余远辉3名省部级落马官员获刑的同日，广东省的一名厅官也落了马。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">4月28日下午17时20分，中央纪委官网更新了这样一条消息：“经广东省委批准，江门市委副书记、市长邓伟根因涉嫌严重违纪，正在接受组织审查。”</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">政知圈注意到，邓伟根还是名微博达人，他的微博更新止于27日凌晨。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \"><strong>“学而优则仕”</strong></p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">邓伟根是名“60后”的广东本地官员，今年55岁。进入仕途前，邓伟根长期在暨南大学任教，最终“学而优则仕”。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">1981年9月，邓伟根进入暨南大学企业管理系工业经济专业学习，此后又接连读了硕士和博士。1988年12月，他成为该校企业管理系教师。1991年至1995年，他经历了从讲师、副教授、教授、校长助理到产业办主任等多个身份的转变。</p><p class=\"f_center\" style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; font-stretch: normal; line-height: 32px; font-family: \"><img alt=\"凌晨更新微博的市长 一天之后就被组织审查\" class=\" \" src=\"/Uploads/Editor/image/20170428/590348c41f23b.png\"/></p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">佛山人邓伟根到江门，是在2014年9月。此前其仕途长期在家乡佛山，历任佛山顺德市市长、顺德市纪委书记、高明区委书记、佛山副市长等职务。2010年6月，邓伟根跻身市委常委，任南海区委书记。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">2014年9月，他从佛山市委常委、南海区委书记任上转赴江门，任江门市委副书记、代市长，并于2015年2月转正。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">2014年5月，他成立了南海区数据统筹局，借此打破部门之间信息互通的行政壁垒，实现数据统筹共享，这是全国首个数据统筹局。在江门，他致力于打造“侨都”，2015年两会上，还曾专程拜访了国务院侨务办公室和中华全国归国华侨联合会。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">相关人士告诉政知圈，邓伟根把江门当做他人生中的一个归宿。邓伟根的家乡与江门在地域上非常接近。邓伟根称，他曾有很多次机会可以在官场上更进一步，但最终选择了距离其家乡很近的江门，要为江门做些实实在在的事情。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">相关人士表示，邓伟根“不贪功、不冒进”。对于他在江门市长位子上落马，不少人觉得意外。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \"><strong>落马前一天凌晨微博还更新</strong></p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">邓伟根是“微博达人”。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">根据《南方都市报》2014年的报道，他的微博名为@樵山潮人，认证信息并没有使用政治身份，而是“暨南大学产业经济研究院教授、经济学博士”。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">政知圈注意到，该微博于4月27日14时19分曾点赞了@大邑环保的微博。而最新的一次微博更新是在27日凌晨5点27分，内容是“江门北站定名”，截图如下：</p><p class=\"f_center\" style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; font-stretch: normal; line-height: 32px; font-family: \"><img alt=\"凌晨更新微博的市长 一天之后就被组织审查\" class=\" \" src=\"/Uploads/Editor/image/20170428/590348c430840.png\"/></p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">邓伟根是个更新微博很勤的人，@樵山潮人几乎每日都有更新，而且不少微博都是更新于早上5点、6点左右。微博的内容也会涉及到他的一些感悟和生活状态。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">比如2011年7月16日，他发布一则微博，“听儿子弹钢琴：春江花月夜；女儿弹古筝：战台风；享受极其幸福的天伦之乐。”再比如2013年2月23日，该微博称“乡村篮球场，陪儿子玩一下，感觉有点力不从心了，毕竟运动太猛，还是不行，有点感慨……”</p><p class=\"f_center\" style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; font-stretch: normal; line-height: 32px; font-family: \"><img alt=\"凌晨更新微博的市长 一天之后就被组织审查\" class=\" \" src=\"/Uploads/Editor/image/20170428/590348c43b915.png\"/></p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">2014年2月的时候媒体报道称，时任南海区委书记的他将置顶微博换成了关于南海四风问题的内容，“四风问题查摆是作风建设的牛鼻子……小伙伴们，请多拍砖灌水，帮助查摆四风上问题，以作风正，事业兴，推动改革重深化，南海再出发。”</p><p class=\"f_center\" style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; font-stretch: normal; line-height: 32px; font-family: \"><img alt=\"凌晨更新微博的市长 一天之后就被组织审查\" class=\" \" src=\"/Uploads/Editor/image/20170428/590348c44a122.png\"/></p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">随着职务的调整，置顶微博也已经更换。目前，该微博的置顶内容如下：</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">“一切归零，尽早融入。抓紧调研，邑地广阔，潜力巨大，日前工作已排得满满的，想休息一下都几难。樵人仍樵人，邑话开新题，至于称谓嘛，根叔显太老，叫哥似年轻，还是邓sir好，永远的邓sir！请教各位，邑地再出发，如何后发制胜？ ”</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">值得注意的是，邓伟根还有自己的微信公众号平台“樵山潮人”，不定期更新。</p><p class=\"f_center\" style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; font-stretch: normal; line-height: 32px; font-family: \"><img alt=\"凌晨更新微博的市长 一天之后就被组织审查\" class=\" \" src=\"/Uploads/Editor/image/20170428/590348c4579e9.png\"/></p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \"><strong style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important;\">爱好曲艺 会唱粤曲</strong></p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">邓伟根算是“明星官员”，多次出现在媒体笔下。值得一提的是，他“爱好曲艺，会唱粤曲”。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">在2014年的一场慈善晚会上，邓伟根与粤剧名伶郭凤女合唱了粤剧《家·南海》。</p><p class=\"f_center\" style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; font-stretch: normal; line-height: 32px; font-family: \"><img alt=\"凌晨更新微博的市长 一天之后就被组织审查\" class=\" \" src=\"/Uploads/Editor/image/20170428/590348c461ca4.png\"/></p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">据《南方都市报》报道，当时现场一些企业纷纷解囊，据后台统计，整场晚会共筹得善款830多万元，其中，在邓伟根唱曲的时间里，有多个企业募捐了50万元，一个企业募捐了30万元，整首曲子演唱期间，募捐善款超过200万元。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">“我印象最深刻的是2012年，邓伟根书记来曲艺社参观，当时他和郭凤女合唱了一首《花田错会》，不过那时候他唱得很一般”，有人曾这样对媒体表示，不过2014年3月，当邓再次来到曲艺社时，“粤剧进步好大，唱得非常好。”</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \"><strong>前搭档今年2月被“双开”</strong></p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">“江门市长”的职务，邓伟根两次当选。只不过，第一次的搭档毛荣楷，已经落马。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">2015年2月，邓伟根第一次当选为江门市长，当时的江门市委书记是毛荣楷。毛荣楷自2015年1月从广东省纪委副书记任上转赴江门，担任江门市委书记，今年2月，毛荣楷“双开”的消息被公开。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">毛荣楷何时落马，官方并未披露，其江门市委书记的职务于2016年6月被林应武取代。直到2017年2月17日，广东省纪委才首次对外披露其案情，“涉嫌受贿移送司法”。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">还要提到一个人——王积俊。2015年8月，在当选全国优秀县委书记1个月后，王积俊跻身江门市委常委班子，位列副厅。但2016年4月即被免职。当时，王积俊何去何从也曾在坊间引发议论。一直到2016年10月，官方才披露王积俊被逮捕的消息。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \"><strong>江门政坛的注脚</strong></p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">邓伟根落马，为漩涡中的江门政坛再添一注脚。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">2015年10月，时任江门市人大常委会副主任聂党权涉嫌严重违纪，接受组织调查，成为十八大以来江门首名被查厅官。2016年5月，毛荣楷副手江门市委原副书记、政法委原书记邹家军落马；2016年10月，王积俊被官方证实“被逮捕”，今年2月，“江门一把手”毛荣楷也被官方坐实“涉嫌受贿移送司法”。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \"><br/></p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">“江门窝案”也被指牵涉省级层面。2016年7月，广东省委第六巡视组组长刘志伟落马。财新网报道直陈，刘案发与江门腐败窝案有关，江门部分曾经受到刘志伟庇护的官员被抓，供出曾向刘志伟行贿。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">如今，江门市长邓伟根，也接受组织审查。就在4月22日，他还主持召开市政府常务会议和市长办公会议，审议通过了一系列议题。</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">“来到江门担任市长，我会在这几年就把未来江门的格局奠定下来，自信来自基层的磨炼。不是我很聪明，不是我擅长总结，我相信多听各方意见，就会少走弯路。我要将我20年的工作经验、教训用到江门市的发展中，我希望力争用最短的时间让江门更上一层楼。”</p><p style=\"margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: \">以上这番话是邓伟根第一次当选江门市长时说的。</p><p><br/></p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('24', '<p>是打发士大夫</p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('25', '<p>文章 标题 名称文章 标题 名称文章 标题 名称</p>', '0', '0', '', '0', '1', '', '');
INSERT INTO `hi_article_data` VALUES ('26', '<p>大事发生大发撒的发到付</p><p><img src=\"/Uploads/Editor/image/20170505/590c3bb2b1ec3.jpg\" title=\"590c3bb2b1ec3.jpg\" alt=\"timg.jpg\"/></p>', '0', '0', '', '0', '1', '', '');

-- ----------------------------
-- Table structure for hi_attachment
-- ----------------------------
DROP TABLE IF EXISTS `hi_attachment`;
CREATE TABLE `hi_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `name` varchar(30) NOT NULL COMMENT '原文件名称',
  `size` int(10) NOT NULL COMMENT '文件大小',
  `ext` char(4) NOT NULL COMMENT '文件后缀',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `mime` char(40) NOT NULL COMMENT '文件mime类型',
  `savename` char(17) NOT NULL COMMENT '保存文件名',
  `savepath` char(11) NOT NULL COMMENT '保存目录',
  `uid` int(10) NOT NULL COMMENT '上传用户ID',
  `ip` bigint(20) NOT NULL COMMENT '上传IP',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `isadmin` tinyint(1) NOT NULL COMMENT '是否后台上传',
  `usetimes` smallint(5) NOT NULL COMMENT '使用次数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='图片表';

-- ----------------------------
-- Records of hi_attachment
-- ----------------------------
INSERT INTO `hi_attachment` VALUES ('1', '/Uploads/Picture/2017-05-03/5909d5b8d957f.jpg', '', 'timg (9).jpg', '104792', 'jpg', 'bf30a85f89283a60a79d69b7cff40e72', '984c5c68ca1f23728927d0bedfd59594a95a08e2', 'image/jpeg', '5909d5b8d957f.jpg', '2017-05-03/', '1', '0', '1', '1493816760', '1', '2');
INSERT INTO `hi_attachment` VALUES ('2', '/Uploads/Picture/2017-05-03/5909d5e57303f.jpg', '', 'timg (10).jpg', '170689', 'jpg', '7a16e6d6ed80a1b278b4ac0cd8b6c895', '0c9927f242202ab9d8c6dbb0087cb2288bdd3e3b', 'image/jpeg', '5909d5e57303f.jpg', '2017-05-03/', '1', '0', '1', '1493816805', '1', '1');
INSERT INTO `hi_attachment` VALUES ('3', '/Uploads/Picture/2017-05-05/590c3baaa54e6.jpg', '', 'timg (2).jpg', '113800', 'jpg', '2b4768a2b462f8df7863b977b181729f', '5e6d7701450b51f26624aed03e0bba13df89f072', 'image/jpeg', '590c3baaa54e6.jpg', '2017-05-05/', '1', '0', '1', '1493973930', '1', '0');
INSERT INTO `hi_attachment` VALUES ('4', '/Uploads/Download/2017-05-17/591c0f9d2ebe0.jpg', '', 'timg (8).jpg', '163482', 'jpg', '5fc082eae41c1a949d0cb8daa431a21f', '73448e48994b7f4e148aa285c5a19d02629e0eb6', 'image/jpeg', '591c0f9d2ebe0.jpg', '2017-05-17/', '1', '0', '1', '1495011229', '1', '0');
INSERT INTO `hi_attachment` VALUES ('5', '/Uploads/Download/2017-05-17/591c105a929f4.docx', '', '网站合同书.docx', '16150', 'docx', '45682eee8ccd0ed4d5c09cb0fc2a84b9', '6e506a8864e09f62e11172ee5fdeea447d6c4c6c', 'application/zip', '591c105a929f4.doc', '2017-05-17/', '1', '0', '1', '1495011418', '1', '0');
INSERT INTO `hi_attachment` VALUES ('6', '/Uploads/Download/2017-05-17/591c112073276.docx', '', '技术研发中心2016.04.01会议纪要.docx', '21756', 'docx', 'b8e588d4043330e415250b82d829d2e9', '36910aaad98a87e1a92e1556606e57e812243fdd', 'application/vnd.openxmlformats-officedoc', '591c112073276.doc', '2017-05-17/', '1', '0', '1', '1495011616', '1', '0');
INSERT INTO `hi_attachment` VALUES ('7', '/Uploads/Picture/2017-05-17/591c11cbc9a7d.jpg', '', 'timg.jpg', '98259', 'jpg', 'c7253c156d42106d93347cd7a741e556', '75d7f185785cb9cbf3739f0108383d51268ba9c2', 'image/jpeg', '591c11cbc9a7d.jpg', '2017-05-17/', '1', '0', '1', '1495011787', '1', '0');

-- ----------------------------
-- Table structure for hi_attachment_data
-- ----------------------------
DROP TABLE IF EXISTS `hi_attachment_data`;
CREATE TABLE `hi_attachment_data` (
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '附件ID',
  `contentid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '内容ID',
  `modelid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模型ID',
  `modelname` varchar(20) NOT NULL COMMENT '模型名称',
  `time` int(11) NOT NULL COMMENT '更新时间',
  KEY `attid` (`aid`),
  KEY `arcid` (`contentid`),
  KEY `modelid` (`modelid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件副表';

-- ----------------------------
-- Records of hi_attachment_data
-- ----------------------------
INSERT INTO `hi_attachment_data` VALUES ('1', '4', '0', 'ad', '1493816761');
INSERT INTO `hi_attachment_data` VALUES ('2', '16', '2', '', '1493973915');
INSERT INTO `hi_attachment_data` VALUES ('1', '26', '2', '', '1493973980');

-- ----------------------------
-- Table structure for hi_auth_extend
-- ----------------------------
DROP TABLE IF EXISTS `hi_auth_extend`;
CREATE TABLE `hi_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

-- ----------------------------
-- Records of hi_auth_extend
-- ----------------------------
INSERT INTO `hi_auth_extend` VALUES ('1', '1', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '3', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '5', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '6', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '7', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '8', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '9', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '15', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '16', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '27', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '28', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '29', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '30', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '31', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '32', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '33', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '34', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '35', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '36', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '37', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '38', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '39', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '43', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '44', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '45', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '46', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '47', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '48', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '49', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '50', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '51', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '52', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '53', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '54', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '55', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '56', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '57', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '58', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '59', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '60', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '61', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '62', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '63', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '64', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '73', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '74', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '75', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '76', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '77', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '78', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '79', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '80', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '88', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '89', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '90', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '91', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '92', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '276', '1');
INSERT INTO `hi_auth_extend` VALUES ('1', '277', '1');

-- ----------------------------
-- Table structure for hi_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `hi_auth_group`;
CREATE TABLE `hi_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户组';

-- ----------------------------
-- Records of hi_auth_group
-- ----------------------------
INSERT INTO `hi_auth_group` VALUES ('1', 'admin', '1', '平台管理员', '拥有大部分权限1', '1', '1,2,5,6,7,10,11,12,13,14,15,16,18,19,20,21');

-- ----------------------------
-- Table structure for hi_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `hi_auth_group_access`;
CREATE TABLE `hi_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户权限表';

-- ----------------------------
-- Records of hi_auth_group_access
-- ----------------------------
INSERT INTO `hi_auth_group_access` VALUES ('1', '1');
INSERT INTO `hi_auth_group_access` VALUES ('2', '1');

-- ----------------------------
-- Table structure for hi_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `hi_auth_rule`;
CREATE TABLE `hi_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `pid` mediumint(8) NOT NULL,
  `mid` mediumint(8) NOT NULL,
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='权限规则表';

-- ----------------------------
-- Records of hi_auth_rule
-- ----------------------------
INSERT INTO `hi_auth_rule` VALUES ('1', '1', '4', 'admin', '1', 'Admin/index/index', '欢迎页', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('2', '2', '5', 'admin', '1', 'Admin/menu/index', '菜单管理', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('3', '2', '6', 'admin', '1', 'Admin/config/group', '网站设置', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('4', '2', '7', 'admin', '1', 'Admin/config/index', '系统设置', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('5', '3', '8', 'admin', '1', 'Admin/member/index', '用户列表', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('6', '5', '9', 'admin', '1', 'Admin/menu/add', '添加', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('7', '5', '11', 'admin', '1', 'Admin/menu/edit', '编辑', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('8', '2', '10', 'admin', '1', 'Admin/module/index', '模块管理', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('9', '2', '12', 'admin', '1', 'Admin/auth/index', '权限管理', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('10', '0', '1', 'admin', '2', 'Admin/index/index', '首页', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('11', '0', '2', 'admin', '2', 'Admin/config/index', '设置', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('12', '0', '3', 'admin', '2', 'Admin/member/index', '会员', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('13', '1', '13', 'admin', '1', 'Admin/my/password', '修改密码', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('14', '1', '14', 'admin', '1', 'Admin/my/info', '个人信息', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('15', '2', '15', 'admin', '1', 'Admin/category/index', '文章分类', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('16', '15', '16', 'admin', '1', 'Admin/category/add', '添加菜单', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('17', '2', '17', 'admin', '1', 'Admin/picture/index', '图片管理', '-1', '');
INSERT INTO `hi_auth_rule` VALUES ('18', '1', '18', 'admin', '1', 'Admin/my/avatar', '我的头像', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('19', '2', '19', 'admin', '1', 'Admin/log/index', '操作日志', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('20', '2', '20', 'admin', '1', 'Admin/log/login', '登陆日志', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('21', '0', '21', 'admin', '2', 'Admin/article/index', '文章', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('22', '21', '22', 'admin', '1', 'Admin/article/index', '文章管理', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('23', '22', '23', 'admin', '1', 'Admin/article/add', '添加', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('24', '24', '31', 'admin', '1', 'Admin/ad/index', '广告管理', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('25', '26', '27', 'admin', '1', 'Admin/linkage/add', '添加', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('26', '26', '28', 'admin', '1', 'Admin/linkage/edit', '编辑', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('27', '2', '30', 'admin', '1', 'Admin/model/index', '模型管理', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('28', '31', '32', 'admin', '1', 'Admin/ad/pos', '添加广告位', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('29', '31', '33', 'admin', '1', 'Admin/ad/postion', '广告列表', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('30', '31', '34', 'admin', '1', 'Admin/ad/add', '添加广告', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('31', '31', '35', 'admin', '1', 'Admin/ad/editpos', '编辑广告位', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('32', '31', '36', 'admin', '1', 'Admin/ad/edit', '编辑广告', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('33', '2', '37', 'admin', '1', 'Admin/cron/index', '定时任务', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('34', '2', '38', 'admin', '1', 'Admin/position/index', '推荐位管理', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('35', '7', '39', 'admin', '1', 'Admin/config/add', '添加', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('36', '7', '40', 'admin', '1', 'Admin/config/edit', '编辑', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('37', '10', '41', 'admin', '1', 'Admin/module/add', '添加模块', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('38', '10', '42', 'admin', '1', 'Admin/module/edit', '编辑模块', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('39', '12', '43', 'admin', '1', 'Admin/auth/createGroup', '添加用户组', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('40', '12', '44', 'admin', '1', 'Admin/auth/editGroup', '编辑用户组', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('41', '24', '29', 'admin', '1', 'Admin/link/index', '友情链接', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('42', '24', '17', 'admin', '1', 'Admin/attachment/index', '附件管理', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('43', '24', '25', 'admin', '1', 'Admin/tags/index', '标签管理', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('44', '24', '26', 'admin', '1', 'Admin/linkage/index', '联动菜单', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('45', '0', '24', 'admin', '2', 'Admin/ad/index', '模块', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('46', '12', '45', 'admin', '1', 'Admin/auth/access', '访问授权', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('47', '12', '46', 'admin', '1', 'Admin/Auth/category', '栏目授权', '1', '');
INSERT INTO `hi_auth_rule` VALUES ('48', '12', '47', 'admin', '1', 'Admin/auth/user', '成员授权', '1', '');

-- ----------------------------
-- Table structure for hi_avatar
-- ----------------------------
DROP TABLE IF EXISTS `hi_avatar`;
CREATE TABLE `hi_avatar` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `uid` int(10) NOT NULL,
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `md5` char(32) NOT NULL,
  `sha1` char(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='图片表';

-- ----------------------------
-- Records of hi_avatar
-- ----------------------------
INSERT INTO `hi_avatar` VALUES ('1', '1', '/Uploads/Avatar/1/5909d6af7ff9c.jpg', '1', '1493817007', '4bb615653e8cd6079b89a6a5bb3fde60', '864e2fc53a2f6da8a204300ea53f1e8f2338eb10');

-- ----------------------------
-- Table structure for hi_block
-- ----------------------------
DROP TABLE IF EXISTS `hi_block`;
CREATE TABLE `hi_block` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '碎片名称',
  `name` char(20) NOT NULL COMMENT '碎片标识',
  `content` text NOT NULL COMMENT '碎片内容',
  `type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '碎片类型',
  `status` tinyint(1) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='碎片表';

-- ----------------------------
-- Records of hi_block
-- ----------------------------
INSERT INTO `hi_block` VALUES ('3', '首页底部导航', 'nav', '打发是大发是打发啥大发撒旦法师打发斯蒂芬123123123', '1', '1');

-- ----------------------------
-- Table structure for hi_category
-- ----------------------------
DROP TABLE IF EXISTS `hi_category`;
CREATE TABLE `hi_category` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '栏目ID',
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT '栏目名称',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '栏目目录',
  `modelid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模型ID',
  `meta_title` varchar(255) NOT NULL COMMENT '栏目标题',
  `keywords` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL COMMENT '栏目描述',
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `arrparentid` varchar(255) NOT NULL DEFAULT '' COMMENT '所有父ID',
  `child` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否存在子栏目，1存在',
  `arrchildid` mediumtext COMMENT '所有子栏目ID',
  `status` tinyint(1) NOT NULL,
  `icon` char(20) NOT NULL DEFAULT '' COMMENT '栏目图标',
  `url` varchar(100) NOT NULL DEFAULT '' COMMENT '链接地址',
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `tpl_list` char(20) NOT NULL,
  `tpl_show` char(20) NOT NULL,
  `ispost` tinyint(1) unsigned NOT NULL COMMENT '是否投稿',
  `ischeck` tinyint(1) unsigned NOT NULL COMMENT '是否审核',
  `ishtml` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否生成静态',
  `letter` varchar(255) DEFAULT '' COMMENT '栏目拼音',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=284 DEFAULT CHARSET=utf8 COMMENT='栏目表';

-- ----------------------------
-- Records of hi_category
-- ----------------------------
INSERT INTO `hi_category` VALUES ('1', '船舶设备', 'chuanboshebei', '2', '', '', '', '0', '1', '1', '5,6,7,8,9,27,28,29,30,31,32,33,34,35,36,37,38,39,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,276,277', '1', '', '', '0', '', '', '0', '0', '0', 'chuanboshebei');
INSERT INTO `hi_category` VALUES ('2', '船厂设备', 'chuanchangshebei', '2', '', '', '', '0', '2', '1', '10,11,12,13,14,40,41,42,65,66,67,68,69,71,72,81,82,83,84,85,86,87,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,265,278,279,280,281,282,283', '1', '', '', '0', '', '', '0', '0', '0', 'chuanchangshebei');
INSERT INTO `hi_category` VALUES ('3', '原材料', 'yuancailiao', '2', '', '', '', '0', '3', '1', '15,16,73,74,75,76,77,78,79,80,88,89,90,91,92', '1', '', '', '0', '', '', '0', '0', '0', 'yuancailiao');
INSERT INTO `hi_category` VALUES ('4', '船舶', 'chuanbo', '2', '', '', '', '0', '4', '1', '17,18,19,20,21,22,23,24,26,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264', '1', '', '', '0', '', '', '0', '0', '0', 'chuanbo');
INSERT INTO `hi_category` VALUES ('5', '轮机系统', 'lunjixitong', '2', '', '', '', '1', '1,5', '1', '27,28,29,30,31,32,33,34,35,276', '1', '', '', '0', '', '', '0', '0', '0', 'lunjixitong');
INSERT INTO `hi_category` VALUES ('6', '管装系统', 'guanzhuangxitong', '2', '', '', '', '1', '1,6', '1', '36,37,38,39', '1', '', '', '0', '', '', '0', '0', '0', 'guanzhuangxitong');
INSERT INTO `hi_category` VALUES ('7', '电装系统', 'dianzhuangxitong', '2', '', '', '', '1', '1,7', '1', '43,44,45,46,47,48,277', '1', '', '', '0', '', '', '0', '0', '0', 'dianzhuangxitong');
INSERT INTO `hi_category` VALUES ('8', '甲装锚泊', 'jiazhuangmaobo', '2', '', '', '', '1', '1,8', '1', '49,50,51,52,53,54', '1', '', '', '0', '', '', '0', '0', '0', 'jiazhuangmaobo');
INSERT INTO `hi_category` VALUES ('9', '舾装', 'zhuang', '2', '', '', '', '1', '1,9', '1', '55,56,57,58,59,60,61,62,63,64', '1', '', '', '0', '', '', '0', '0', '0', 'zuozhuang');
INSERT INTO `hi_category` VALUES ('10', '焊割设备', 'hangeshebei', '2', '', '', '', '2', '2,10', '1', '40,41,42,278', '1', '', '', '0', '', '', '0', '0', '0', 'hangeshebei');
INSERT INTO `hi_category` VALUES ('11', '涂装设备', 'tuzhuangshebei', '2', '', '', '', '2', '2,11', '1', '65,66,67,68,69,71,72,279', '1', '', '', '0', '', '', '0', '0', '0', 'tuzhuangshebei');
INSERT INTO `hi_category` VALUES ('12', '起重设备', 'qizhongshebei', '2', '', '', '', '2', '2,12', '1', '81,82,83,84,85,86,87,280', '1', '', '', '0', '', '', '0', '0', '0', 'qizhongshebei');
INSERT INTO `hi_category` VALUES ('13', '加工设备', 'jiagongshebei', '2', '', '', '', '2', '2,13', '1', '93,94,95,96,97,98,99,100,101,102,103,104,281', '1', '', '', '0', '', '', '0', '0', '0', 'jiagongshebei');
INSERT INTO `hi_category` VALUES ('14', '检测设备', 'jianceshebei', '2', '', '', '', '2', '2,14', '1', '105,106,107,282,283', '1', '', '', '0', '', '', '0', '0', '0', 'jianceshebei');
INSERT INTO `hi_category` VALUES ('15', '金属材料', 'jinshucailiao', '2', '', '', '', '3', '3,15', '1', '73,74,75,76,77,78,79,80', '1', '', '', '0', '', '', '0', '0', '0', 'jinshucailiao');
INSERT INTO `hi_category` VALUES ('16', '非金属材料', 'feijinshucailiao', '2', '', '', '', '3', '3,16', '1', '88,89,90,91,92', '1', '', '', '0', '', '', '0', '0', '0', 'feijinshucailiao');
INSERT INTO `hi_category` VALUES ('17', '客滚船', 'kegunchuan', '2', '', '', '', '4', '4,17', '1', '108,109,110,111,112,113,114,115,116,117,118,119,120,121', '1', '', '', '0', '', '', '0', '0', '0', 'kegunchuan');
INSERT INTO `hi_category` VALUES ('18', '干货船', 'ganhuochuan', '2', '', '', '', '4', '4,18', '1', '122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147', '1', '', '', '0', '', '', '0', '0', '0', 'ganhuochuan');
INSERT INTO `hi_category` VALUES ('19', '液货船', 'yehuochuan', '2', '', '', '', '4', '4,19', '1', '148,149,150,151,152,153,154,155', '1', '', '', '0', '', '', '0', '0', '0', 'yehuochuan');
INSERT INTO `hi_category` VALUES ('20', '工程船', 'gongchengchuan', '2', '', '', '', '4', '4,20', '1', '156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175', '1', '', '', '0', '', '', '0', '0', '0', 'gongchengchuan');
INSERT INTO `hi_category` VALUES ('21', '工作船', 'gongzuochuan', '2', '', '', '', '4', '4,21', '1', '176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194', '1', '', '', '0', '', '', '0', '0', '0', 'gongzuochuan');
INSERT INTO `hi_category` VALUES ('22', '公务船', 'gongwuchuan', '2', '', '', '', '4', '4,22', '1', '195,196,197,198,199,200,201,202,203,204,205,206,207', '1', '', '', '0', '', '', '0', '0', '0', 'gongwuchuan');
INSERT INTO `hi_category` VALUES ('23', '渔船', 'yuchuan', '2', '', '', '', '4', '4,23', '1', '208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223', '1', '', '', '0', '', '', '0', '0', '0', 'yuchuan');
INSERT INTO `hi_category` VALUES ('24', '特种船', 'tezhongchuan', '2', '', '', '', '4', '4,24', '1', '224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240', '1', '', '', '0', '', '', '0', '0', '0', 'tezhongchuan');
INSERT INTO `hi_category` VALUES ('26', '海工船舶', 'haigongchuanbo', '2', '', '', '', '4', '4,26', '1', '249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264', '1', '', '', '0', '', '', '0', '0', '0', 'haigongchuanbo');
INSERT INTO `hi_category` VALUES ('27', '主机', 'zhuji', '2', '', '', '', '5', '1,5,27', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zhuji');
INSERT INTO `hi_category` VALUES ('28', '发电设备', 'fadianshebei', '2', '', '', '', '5', '1,5,28', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'fadianshebei');
INSERT INTO `hi_category` VALUES ('29', '轴舵系', 'zhouduoxi', '2', '', '', '', '5', '1,5,29', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zhouduoxi');
INSERT INTO `hi_category` VALUES ('30', '辅助设备', 'fuzhushebei', '2', '', '', '', '5', '1,5,30', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'fuzhushebei');
INSERT INTO `hi_category` VALUES ('31', '压力容器', 'yalirongqi', '2', '', '', '', '5', '1,5,31', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yalirongqi');
INSERT INTO `hi_category` VALUES ('32', '空调冷藏通风设备', 'kongdiaolengcangtongfengshebei', '2', '', '', '', '5', '1,5,32', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'kongdiaolengcangtongfengshebei');
INSERT INTO `hi_category` VALUES ('33', '泵', 'beng', '2', '', '', '', '5', '1,5,33', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'beng');
INSERT INTO `hi_category` VALUES ('34', '压载水处理系统', 'yazaishuichulixitong', '2', '', '', '', '5', '1,5,34', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yazaishuichulixitong');
INSERT INTO `hi_category` VALUES ('35', '其它', 'qita', '2', '', '', '', '5', '1,5,35', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qita');
INSERT INTO `hi_category` VALUES ('36', '阀门', 'famen', '2', '', '', '', '6', '1,6,36', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'famen');
INSERT INTO `hi_category` VALUES ('37', '管路附件', 'guanlufujian', '2', '', '', '', '6', '1,6,37', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'guanlufujian');
INSERT INTO `hi_category` VALUES ('38', '五金工具仪表', 'wujingongjuyibiao', '2', '', '', '', '6', '1,6,38', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'wujingongjuyibiao');
INSERT INTO `hi_category` VALUES ('39', '其它', 'qita', '2', '', '', '', '6', '1,6,39', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qita');
INSERT INTO `hi_category` VALUES ('40', '焊接设备', 'hanjieshebei', '2', '', '', '', '10', '2,10,40', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'hanjieshebei');
INSERT INTO `hi_category` VALUES ('41', '切割设备', 'qiegeshebei', '2', '', '', '', '10', '2,10,41', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qiegeshebei');
INSERT INTO `hi_category` VALUES ('42', '其它', 'qita', '2', '', '', '', '10', '2,10,42', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qita');
INSERT INTO `hi_category` VALUES ('43', '供配电系统', 'gongpeidianxitong', '2', '', '', '', '7', '1,7,43', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'gongpeidianxitong');
INSERT INTO `hi_category` VALUES ('44', '通讯导航', 'tongxundaohang', '2', '', '', '', '7', '1,7,44', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'tongxundaohang');
INSERT INTO `hi_category` VALUES ('45', '电器设备', 'dianqishebei', '2', '', '', '', '7', '1,7,45', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'dianqishebei');
INSERT INTO `hi_category` VALUES ('46', '电缆照明', 'dianlanzhaoming', '2', '', '', '', '7', '1,7,46', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'dianlanzhaoming');
INSERT INTO `hi_category` VALUES ('47', '电器附件', 'dianqifujian', '2', '', '', '', '7', '1,7,47', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'dianqifujian');
INSERT INTO `hi_category` VALUES ('48', '其它', 'qita', '2', '', '', '', '7', '1,7,48', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qita');
INSERT INTO `hi_category` VALUES ('49', '锚系设备', 'maoxishebei', '2', '', '', '', '8', '1,8,49', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'maoxishebei');
INSERT INTO `hi_category` VALUES ('50', '泊系设备', 'boxishebei', '2', '', '', '', '8', '1,8,50', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'boxishebei');
INSERT INTO `hi_category` VALUES ('51', '舱口盖系统', 'cangkougaixitong', '2', '', '', '', '8', '1,8,51', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'cangkougaixitong');
INSERT INTO `hi_category` VALUES ('52', '起重设备', 'qizhongshebei', '2', '', '', '', '8', '1,8,52', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qizhongshebei');
INSERT INTO `hi_category` VALUES ('53', '特种机械设备', 'tezhongjixieshebei', '2', '', '', '', '8', '1,8,53', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'tezhongjixieshebei');
INSERT INTO `hi_category` VALUES ('54', '其它', 'qita', '2', '', '', '', '8', '1,8,54', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qita');
INSERT INTO `hi_category` VALUES ('55', '门窗盖梯', 'menchuanggaiti', '2', '', '', '', '9', '1,9,55', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'menchuanggaiti');
INSERT INTO `hi_category` VALUES ('56', '救生消防', 'jiushengxiaofang', '2', '', '', '', '9', '1,9,56', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jiushengxiaofang');
INSERT INTO `hi_category` VALUES ('57', '绑扎系统', 'bangzhaxitong', '2', '', '', '', '9', '1,9,57', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'bangzhaxitong');
INSERT INTO `hi_category` VALUES ('58', '缆绳', 'lansheng', '2', '', '', '', '9', '1,9,58', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'lansheng');
INSERT INTO `hi_category` VALUES ('59', '厨房洗衣设备', 'chufangxiyishebei', '2', '', '', '', '9', '1,9,59', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'chufangxiyishebei');
INSERT INTO `hi_category` VALUES ('60', '卫生设备', 'weishengshebei', '2', '', '', '', '9', '1,9,60', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'weishengshebei');
INSERT INTO `hi_category` VALUES ('61', '船用家具', 'chuanyongjiaju', '2', '', '', '', '9', '1,9,61', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'chuanyongjiaju');
INSERT INTO `hi_category` VALUES ('62', '装潢材料', 'zhuangcailiao', '2', '', '', '', '9', '1,9,62', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zhuangzuocailiao');
INSERT INTO `hi_category` VALUES ('63', '劳保用品', 'laobaoyongpin', '2', '', '', '', '9', '1,9,63', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'laobaoyongpin');
INSERT INTO `hi_category` VALUES ('64', '其它', 'qita', '2', '', '', '', '9', '1,9,64', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qita');
INSERT INTO `hi_category` VALUES ('65', '除尘设备', 'chuchenshebei', '2', '', '', '', '11', '2,11,65', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'chuchenshebei');
INSERT INTO `hi_category` VALUES ('66', '预处理设备', 'yuchulishebei', '2', '', '', '', '11', '2,11,66', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yuchulishebei');
INSERT INTO `hi_category` VALUES ('67', '喷涂设备', 'pentushebei', '2', '', '', '', '11', '2,11,67', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'pentushebei');
INSERT INTO `hi_category` VALUES ('68', '烘干设备', 'hongganshebei', '2', '', '', '', '11', '2,11,68', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'hongganshebei');
INSERT INTO `hi_category` VALUES ('69', '清洗设备', 'qingxishebei', '2', '', '', '', '11', '2,11,69', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qingxishebei');
INSERT INTO `hi_category` VALUES ('276', '配件', 'peijian', '2', '', '', '', '5', '1,5,276', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'peijian');
INSERT INTO `hi_category` VALUES ('71', '通风设备', 'tongfengshebei', '2', '', '', '', '11', '2,11,71', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'tongfengshebei');
INSERT INTO `hi_category` VALUES ('72', '其它', 'qita', '2', '', '', '', '11', '2,11,72', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qita');
INSERT INTO `hi_category` VALUES ('73', '钢板', 'gangban', '2', '', '', '', '15', '3,15,73', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'gangban');
INSERT INTO `hi_category` VALUES ('74', '型钢', 'xinggang', '2', '', '', '', '15', '3,15,74', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'xinggang');
INSERT INTO `hi_category` VALUES ('75', '钢管', 'gangguan', '2', '', '', '', '15', '3,15,75', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'gangguan');
INSERT INTO `hi_category` VALUES ('76', '铸锻件', 'zhuduanjian', '2', '', '', '', '15', '3,15,76', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zhuduanjian');
INSERT INTO `hi_category` VALUES ('77', '钢丝绳', 'gangsisheng', '2', '', '', '', '15', '3,15,77', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'gangsisheng');
INSERT INTO `hi_category` VALUES ('78', '有色金属', 'yousejinshu', '2', '', '', '', '15', '3,15,78', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yousejinshu');
INSERT INTO `hi_category` VALUES ('79', '焊接材料', 'hanjiecailiao', '2', '', '', '', '15', '3,15,79', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'hanjiecailiao');
INSERT INTO `hi_category` VALUES ('80', '其它', 'qita', '2', '', '', '', '15', '3,15,80', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qita');
INSERT INTO `hi_category` VALUES ('81', '起重机', 'qizhongji', '2', '', '', '', '12', '2,12,81', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qizhongji');
INSERT INTO `hi_category` VALUES ('82', '叉车', 'chache', '2', '', '', '', '12', '2,12,82', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'chache');
INSERT INTO `hi_category` VALUES ('83', '千斤顶', 'qianjinding', '2', '', '', '', '12', '2,12,83', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qianjinding');
INSERT INTO `hi_category` VALUES ('84', '升降机', 'shengjiangji', '2', '', '', '', '12', '2,12,84', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'shengjiangji');
INSERT INTO `hi_category` VALUES ('85', '卷扬机', 'juanyangji', '2', '', '', '', '12', '2,12,85', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'juanyangji');
INSERT INTO `hi_category` VALUES ('86', '吊索具', 'diaosuoju', '2', '', '', '', '12', '2,12,86', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'diaosuoju');
INSERT INTO `hi_category` VALUES ('87', '其它', 'qita', '2', '', '', '', '12', '2,12,87', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qita');
INSERT INTO `hi_category` VALUES ('88', '涂料', 'tuliao', '2', '', '', '', '16', '3,16,88', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'tuliao');
INSERT INTO `hi_category` VALUES ('89', '油料', 'youliao', '2', '', '', '', '16', '3,16,89', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'youliao');
INSERT INTO `hi_category` VALUES ('90', '气', 'qi', '2', '', '', '', '16', '3,16,90', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qi');
INSERT INTO `hi_category` VALUES ('91', '化工材料', 'huagongcailiao', '2', '', '', '', '16', '3,16,91', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'huagongcailiao');
INSERT INTO `hi_category` VALUES ('92', '其它', 'qita', '2', '', '', '', '16', '3,16,92', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qita');
INSERT INTO `hi_category` VALUES ('93', '机床', 'jichuang', '2', '', '', '', '13', '2,13,93', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jichuang');
INSERT INTO `hi_category` VALUES ('94', '卷板机', 'juanbanji', '2', '', '', '', '13', '2,13,94', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'juanbanji');
INSERT INTO `hi_category` VALUES ('95', '冷弯机', 'lengwanji', '2', '', '', '', '13', '2,13,95', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'lengwanji');
INSERT INTO `hi_category` VALUES ('96', '弯管机', 'wanguanji', '2', '', '', '', '13', '2,13,96', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'wanguanji');
INSERT INTO `hi_category` VALUES ('97', '风机', 'fengji', '2', '', '', '', '13', '2,13,97', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'fengji');
INSERT INTO `hi_category` VALUES ('98', '坡割机', 'pogeji', '2', '', '', '', '13', '2,13,98', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'pogeji');
INSERT INTO `hi_category` VALUES ('99', '矮平机', 'aipingji', '2', '', '', '', '13', '2,13,99', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'aipingji');
INSERT INTO `hi_category` VALUES ('100', '剪板机', 'jianbanji', '2', '', '', '', '13', '2,13,100', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jianbanji');
INSERT INTO `hi_category` VALUES ('101', '折弯机', 'zhewanji', '2', '', '', '', '13', '2,13,101', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zhewanji');
INSERT INTO `hi_category` VALUES ('102', '液压机', 'yeyaji', '2', '', '', '', '13', '2,13,102', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yeyaji');
INSERT INTO `hi_category` VALUES ('103', '清洗机', 'qingxiji', '2', '', '', '', '13', '2,13,103', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qingxiji');
INSERT INTO `hi_category` VALUES ('104', '其它', 'qita', '2', '', '', '', '13', '2,13,104', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qita');
INSERT INTO `hi_category` VALUES ('105', '探伤设备', 'tanshangshebei', '2', '', '', '', '14', '2,14,105', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'tanshangshebei');
INSERT INTO `hi_category` VALUES ('106', '测厚设备', 'cehoushebei', '2', '', '', '', '14', '2,14,106', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'cehoushebei');
INSERT INTO `hi_category` VALUES ('107', '气体探测设备', 'qititanceshebei', '2', '', '', '', '14', '2,14,107', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qititanceshebei');
INSERT INTO `hi_category` VALUES ('108', '客船', 'kechuan', '2', '', '', '', '17', '4,17,108', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'kechuan');
INSERT INTO `hi_category` VALUES ('109', '客货船', 'kehuochuan', '2', '', '', '', '17', '4,17,109', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'kehuochuan');
INSERT INTO `hi_category` VALUES ('110', '客渡船', 'keduchuan', '2', '', '', '', '17', '4,17,110', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'keduchuan');
INSERT INTO `hi_category` VALUES ('111', '车客渡船', 'chekeduchuan', '2', '', '', '', '17', '4,17,111', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'chekeduchuan');
INSERT INTO `hi_category` VALUES ('112', '游船', 'youchuan', '2', '', '', '', '17', '4,17,112', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'youchuan');
INSERT INTO `hi_category` VALUES ('113', '高速客船', 'gaosukechuan', '2', '', '', '', '17', '4,17,113', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'gaosukechuan');
INSERT INTO `hi_category` VALUES ('114', '客驳船', 'kebochuan', '2', '', '', '', '17', '4,17,114', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'kebochuan');
INSERT INTO `hi_category` VALUES ('115', '滚装客船', 'gunzhuangkechuan', '2', '', '', '', '17', '4,17,115', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'gunzhuangkechuan');
INSERT INTO `hi_category` VALUES ('116', '客箱船', 'kexiangchuan', '2', '', '', '', '17', '4,17,116', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'kexiangchuan');
INSERT INTO `hi_category` VALUES ('117', '火车渡船', 'huocheduchuan', '2', '', '', '', '17', '4,17,117', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'huocheduchuan');
INSERT INTO `hi_category` VALUES ('118', '接待船', 'jiedaichuan', '2', '', '', '', '17', '4,17,118', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jiedaichuan');
INSERT INTO `hi_category` VALUES ('119', '住宿船', 'zhusuchuan', '2', '', '', '', '17', '4,17,119', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zhusuchuan');
INSERT INTO `hi_category` VALUES ('120', '游艇', 'youting', '2', '', '', '', '17', '4,17,120', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'youting');
INSERT INTO `hi_category` VALUES ('121', '其它客船', 'qitakechuan', '2', '', '', '', '17', '4,17,121', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qitakechuan');
INSERT INTO `hi_category` VALUES ('122', '杂货船', 'zahuochuan', '2', '', '', '', '18', '4,18,122', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zahuochuan');
INSERT INTO `hi_category` VALUES ('123', '散货船', 'sanhuochuan', '2', '', '', '', '18', '4,18,123', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'sanhuochuan');
INSERT INTO `hi_category` VALUES ('124', '水泥运输船', 'shuiniyunshuchuan', '2', '', '', '', '18', '4,18,124', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'shuiniyunshuchuan');
INSERT INTO `hi_category` VALUES ('125', '集装箱船', 'jizhuangxiangchuan', '2', '', '', '', '18', '4,18,125', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jizhuangxiangchuan');
INSERT INTO `hi_category` VALUES ('126', '滚装船', 'gunzhuangchuan', '2', '', '', '', '18', '4,18,126', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'gunzhuangchuan');
INSERT INTO `hi_category` VALUES ('127', '多用途货船', 'duoyongtuhuochuan', '2', '', '', '', '18', '4,18,127', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'duoyongtuhuochuan');
INSERT INTO `hi_category` VALUES ('128', '木材船', 'mucaichuan', '2', '', '', '', '18', '4,18,128', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'mucaichuan');
INSERT INTO `hi_category` VALUES ('129', '水产品运输船', 'shuichanpinyunshuchuan', '2', '', '', '', '18', '4,18,129', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'shuichanpinyunshuchuan');
INSERT INTO `hi_category` VALUES ('130', '重大件运输船', 'zhongdajianyunshuchuan', '2', '', '', '', '18', '4,18,130', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zhongdajianyunshuchuan');
INSERT INTO `hi_category` VALUES ('131', '干货驳', 'ganhuobo', '2', '', '', '', '18', '4,18,131', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'ganhuobo');
INSERT INTO `hi_category` VALUES ('132', '汽车渡船', 'qicheduchuan', '2', '', '', '', '18', '4,18,132', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qicheduchuan');
INSERT INTO `hi_category` VALUES ('133', '挂浆机船', 'guajiangjichuan', '2', '', '', '', '18', '4,18,133', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'guajiangjichuan');
INSERT INTO `hi_category` VALUES ('134', '冷藏船', 'lengcangchuan', '2', '', '', '', '18', '4,18,134', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'lengcangchuan');
INSERT INTO `hi_category` VALUES ('135', '矿散油船', 'kuangsanyouchuan', '2', '', '', '', '18', '4,18,135', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'kuangsanyouchuan');
INSERT INTO `hi_category` VALUES ('136', '半潜船', 'banqianchuan', '2', '', '', '', '18', '4,18,136', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'banqianchuan');
INSERT INTO `hi_category` VALUES ('137', '矿砂船', 'kuangshachuan', '2', '', '', '', '18', '4,18,137', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'kuangshachuan');
INSERT INTO `hi_category` VALUES ('138', '汽车运输船', 'qicheyunshuchuan', '2', '', '', '', '18', '4,18,138', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qicheyunshuchuan');
INSERT INTO `hi_category` VALUES ('139', '运粮船', 'yunliangchuan', '2', '', '', '', '18', '4,18,139', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yunliangchuan');
INSERT INTO `hi_category` VALUES ('140', '运煤船', 'yunmeichuan', '2', '', '', '', '18', '4,18,140', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yunmeichuan');
INSERT INTO `hi_category` VALUES ('141', '运畜船', 'yunxuchuan', '2', '', '', '', '18', '4,18,141', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yunxuchuan');
INSERT INTO `hi_category` VALUES ('142', '载驳船', 'zaibochuan', '2', '', '', '', '18', '4,18,142', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zaibochuan');
INSERT INTO `hi_category` VALUES ('143', '集装箱驳', 'jizhuangxiangbo', '2', '', '', '', '18', '4,18,143', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jizhuangxiangbo');
INSERT INTO `hi_category` VALUES ('144', '自卸船', 'zixiechuan', '2', '', '', '', '18', '4,18,144', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zixiechuan');
INSERT INTO `hi_category` VALUES ('145', '重吊船', 'zhongdiaochuan', '2', '', '', '', '18', '4,18,145', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zhongdiaochuan');
INSERT INTO `hi_category` VALUES ('146', '钢板运输船', 'gangbanyunshuchuan', '2', '', '', '', '18', '4,18,146', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'gangbanyunshuchuan');
INSERT INTO `hi_category` VALUES ('147', '其它干货船', 'qitaganhuochuan', '2', '', '', '', '18', '4,18,147', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qitaganhuochuan');
INSERT INTO `hi_category` VALUES ('148', '油船', 'youchuan', '2', '', '', '', '19', '4,19,148', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'youchuan');
INSERT INTO `hi_category` VALUES ('149', '化学品船', 'huaxuepinchuan', '2', '', '', '', '19', '4,19,149', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'huaxuepinchuan');
INSERT INTO `hi_category` VALUES ('150', '液化气船', 'yehuaqichuan', '2', '', '', '', '19', '4,19,150', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yehuaqichuan');
INSERT INTO `hi_category` VALUES ('151', '沥青船', 'liqingchuan', '2', '', '', '', '19', '4,19,151', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'liqingchuan');
INSERT INTO `hi_category` VALUES ('152', '油驳', 'youbo', '2', '', '', '', '19', '4,19,152', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'youbo');
INSERT INTO `hi_category` VALUES ('153', '成品油船', 'chengpinyouchuan', '2', '', '', '', '19', '4,19,153', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'chengpinyouchuan');
INSERT INTO `hi_category` VALUES ('154', '泥驳', 'nibo', '2', '', '', '', '19', '4,19,154', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'nibo');
INSERT INTO `hi_category` VALUES ('155', '其它液货船', 'qitayehuochuan', '2', '', '', '', '19', '4,19,155', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qitayehuochuan');
INSERT INTO `hi_category` VALUES ('156', '采砂船', 'caishachuan', '2', '', '', '', '20', '4,20,156', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'caishachuan');
INSERT INTO `hi_category` VALUES ('157', '挖泥船', 'wanichuan', '2', '', '', '', '20', '4,20,157', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'wanichuan');
INSERT INTO `hi_category` VALUES ('158', '疏浚船', 'shujunchuan', '2', '', '', '', '20', '4,20,158', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'shujunchuan');
INSERT INTO `hi_category` VALUES ('159', '打捞船', 'dalaochuan', '2', '', '', '', '20', '4,20,159', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'dalaochuan');
INSERT INTO `hi_category` VALUES ('160', '打桩船', 'dazhuangchuan', '2', '', '', '', '20', '4,20,160', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'dazhuangchuan');
INSERT INTO `hi_category` VALUES ('161', '起重船', 'qizhongchuan', '2', '', '', '', '20', '4,20,161', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qizhongchuan');
INSERT INTO `hi_category` VALUES ('162', '搅拌船', 'jiaobanchuan', '2', '', '', '', '20', '4,20,162', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jiaobanchuan');
INSERT INTO `hi_category` VALUES ('163', '布缆船', 'bulanchuan', '2', '', '', '', '20', '4,20,163', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'bulanchuan');
INSERT INTO `hi_category` VALUES ('164', '吹泥船', 'chuinichuan', '2', '', '', '', '20', '4,20,164', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'chuinichuan');
INSERT INTO `hi_category` VALUES ('165', '工程驳', 'gongchengbo', '2', '', '', '', '20', '4,20,165', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'gongchengbo');
INSERT INTO `hi_category` VALUES ('166', '铺管船', 'puguanchuan', '2', '', '', '', '20', '4,20,166', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'puguanchuan');
INSERT INTO `hi_category` VALUES ('167', '下水驳', 'xiashuibo', '2', '', '', '', '20', '4,20,167', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'xiashuibo');
INSERT INTO `hi_category` VALUES ('168', '甲板驳', 'jiabanbo', '2', '', '', '', '20', '4,20,168', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jiabanbo');
INSERT INTO `hi_category` VALUES ('169', '叉装船', 'chazhuangchuan', '2', '', '', '', '20', '4,20,169', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'chazhuangchuan');
INSERT INTO `hi_category` VALUES ('170', '抛石船', 'paoshichuan', '2', '', '', '', '20', '4,20,170', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'paoshichuan');
INSERT INTO `hi_category` VALUES ('171', '铺排船', 'pupaichuan', '2', '', '', '', '20', '4,20,171', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'pupaichuan');
INSERT INTO `hi_category` VALUES ('172', '钻爆船', 'zuanbaochuan', '2', '', '', '', '20', '4,20,172', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zuanbaochuan');
INSERT INTO `hi_category` VALUES ('173', '自航驳', 'zihangbo', '2', '', '', '', '20', '4,20,173', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zihangbo');
INSERT INTO `hi_category` VALUES ('174', '采金船', 'caijinchuan', '2', '', '', '', '20', '4,20,174', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'caijinchuan');
INSERT INTO `hi_category` VALUES ('175', '其它工程船', 'qitagongchengchuan', '2', '', '', '', '20', '4,20,175', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qitagongchengchuan');
INSERT INTO `hi_category` VALUES ('176', '破冰船', 'pobingchuan', '2', '', '', '', '21', '4,21,176', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'pobingchuan');
INSERT INTO `hi_category` VALUES ('177', '航标船', 'hangbiaochuan', '2', '', '', '', '21', '4,21,177', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'hangbiaochuan');
INSERT INTO `hi_category` VALUES ('178', '油污水处理船', 'youwushuichulichuan', '2', '', '', '', '21', '4,21,178', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'youwushuichulichuan');
INSERT INTO `hi_category` VALUES ('179', '供应船', 'gongyingchuan', '2', '', '', '', '21', '4,21,179', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'gongyingchuan');
INSERT INTO `hi_category` VALUES ('180', '垃圾处理船', 'lajichulichuan', '2', '', '', '', '21', '4,21,180', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'lajichulichuan');
INSERT INTO `hi_category` VALUES ('181', '溢油回收船', 'yiyouhuishouchuan', '2', '', '', '', '21', '4,21,181', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yiyouhuishouchuan');
INSERT INTO `hi_category` VALUES ('182', '拖船', 'tuochuan', '2', '', '', '', '21', '4,21,182', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'tuochuan');
INSERT INTO `hi_category` VALUES ('183', '推船', 'tuichuan', '2', '', '', '', '21', '4,21,183', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'tuichuan');
INSERT INTO `hi_category` VALUES ('184', '救助船', 'jiuzhuchuan', '2', '', '', '', '21', '4,21,184', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jiuzhuchuan');
INSERT INTO `hi_category` VALUES ('185', '交通船', 'jiaotongchuan', '2', '', '', '', '21', '4,21,185', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jiaotongchuan');
INSERT INTO `hi_category` VALUES ('186', '修理船', 'xiulichuan', '2', '', '', '', '21', '4,21,186', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'xiulichuan');
INSERT INTO `hi_category` VALUES ('187', '带缆船', 'dailanchuan', '2', '', '', '', '21', '4,21,187', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'dailanchuan');
INSERT INTO `hi_category` VALUES ('188', '供水船', 'gongshuichuan', '2', '', '', '', '21', '4,21,188', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'gongshuichuan');
INSERT INTO `hi_category` VALUES ('189', '供油船', 'gongyouchuan', '2', '', '', '', '21', '4,21,189', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'gongyouchuan');
INSERT INTO `hi_category` VALUES ('190', '消防船', 'xiaofangchuan', '2', '', '', '', '21', '4,21,190', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'xiaofangchuan');
INSERT INTO `hi_category` VALUES ('191', '引航船', 'yinhangchuan', '2', '', '', '', '21', '4,21,191', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yinhangchuan');
INSERT INTO `hi_category` VALUES ('192', '复氧船', 'fuyangchuan', '2', '', '', '', '21', '4,21,192', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'fuyangchuan');
INSERT INTO `hi_category` VALUES ('193', '操锚船', 'caomaochuan', '2', '', '', '', '21', '4,21,193', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'caomaochuan');
INSERT INTO `hi_category` VALUES ('194', '其它工作船', 'qitagongzuochuan', '2', '', '', '', '21', '4,21,194', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qitagongzuochuan');
INSERT INTO `hi_category` VALUES ('195', '监察船', 'jianchachuan', '2', '', '', '', '22', '4,22,195', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jianchachuan');
INSERT INTO `hi_category` VALUES ('196', '检疫船', 'jianyichuan', '2', '', '', '', '22', '4,22,196', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jianyichuan');
INSERT INTO `hi_category` VALUES ('197', '缉私船', 'jisichuan', '2', '', '', '', '22', '4,22,197', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jisichuan');
INSERT INTO `hi_category` VALUES ('198', '执法船', 'zhifachuan', '2', '', '', '', '22', '4,22,198', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zhifachuan');
INSERT INTO `hi_category` VALUES ('199', '航政船', 'hangzhengchuan', '2', '', '', '', '22', '4,22,199', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'hangzhengchuan');
INSERT INTO `hi_category` VALUES ('200', '联检船', 'lianjianchuan', '2', '', '', '', '22', '4,22,200', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'lianjianchuan');
INSERT INTO `hi_category` VALUES ('201', '渔政船', 'yuzhengchuan', '2', '', '', '', '22', '4,22,201', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yuzhengchuan');
INSERT INTO `hi_category` VALUES ('202', '巡逻船', 'xunluochuan', '2', '', '', '', '22', '4,22,202', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'xunluochuan');
INSERT INTO `hi_category` VALUES ('203', '指挥船', 'zhihuichuan', '2', '', '', '', '22', '4,22,203', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zhihuichuan');
INSERT INTO `hi_category` VALUES ('204', '税务艇', 'shuiwuting', '2', '', '', '', '22', '4,22,204', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'shuiwuting');
INSERT INTO `hi_category` VALUES ('205', '公安艇', 'gonganting', '2', '', '', '', '22', '4,22,205', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'gonganting');
INSERT INTO `hi_category` VALUES ('206', '海防艇', 'haifangting', '2', '', '', '', '22', '4,22,206', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'haifangting');
INSERT INTO `hi_category` VALUES ('207', '其它公务船', 'qitagongwuchuan', '2', '', '', '', '22', '4,22,207', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qitagongwuchuan');
INSERT INTO `hi_category` VALUES ('208', '围网渔船', 'weiwangyuchuan', '2', '', '', '', '23', '4,23,208', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'weiwangyuchuan');
INSERT INTO `hi_category` VALUES ('209', '拖网渔船', 'tuowangyuchuan', '2', '', '', '', '23', '4,23,209', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'tuowangyuchuan');
INSERT INTO `hi_category` VALUES ('210', '刺网渔船', 'ciwangyuchuan', '2', '', '', '', '23', '4,23,210', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'ciwangyuchuan');
INSERT INTO `hi_category` VALUES ('211', '延绳钓渔船', 'yanshengdiaoyuchuan', '2', '', '', '', '23', '4,23,211', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yanshengdiaoyuchuan');
INSERT INTO `hi_category` VALUES ('212', '捕虾船', 'boxiachuan', '2', '', '', '', '23', '4,23,212', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'boxiachuan');
INSERT INTO `hi_category` VALUES ('213', '捕鲸船', 'bojingchuan', '2', '', '', '', '23', '4,23,213', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'bojingchuan');
INSERT INTO `hi_category` VALUES ('214', '水产品加工船', 'shuichanpinjiagongchuan', '2', '', '', '', '23', '4,23,214', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'shuichanpinjiagongchuan');
INSERT INTO `hi_category` VALUES ('215', '采蜊壳船', 'caikechuan', '2', '', '', '', '23', '4,23,215', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'caizuokechuan');
INSERT INTO `hi_category` VALUES ('216', '金枪渔船', 'jinqiangyuchuan', '2', '', '', '', '23', '4,23,216', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'jinqiangyuchuan');
INSERT INTO `hi_category` VALUES ('217', '远洋渔船', 'yuanyangyuchuan', '2', '', '', '', '23', '4,23,217', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yuanyangyuchuan');
INSERT INTO `hi_category` VALUES ('218', '活鱼舱船', 'huoyucangchuan', '2', '', '', '', '23', '4,23,218', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'huoyucangchuan');
INSERT INTO `hi_category` VALUES ('219', '休闲渔船', 'xiuxianyuchuan', '2', '', '', '', '23', '4,23,219', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'xiuxianyuchuan');
INSERT INTO `hi_category` VALUES ('220', '冷藏渔船', 'lengcangyuchuan', '2', '', '', '', '23', '4,23,220', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'lengcangyuchuan');
INSERT INTO `hi_category` VALUES ('221', '收鲜船', 'shouxianchuan', '2', '', '', '', '23', '4,23,221', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'shouxianchuan');
INSERT INTO `hi_category` VALUES ('222', '鱿鱼钓船', 'yudiaochuan', '2', '', '', '', '23', '4,23,222', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zuoyudiaochuan');
INSERT INTO `hi_category` VALUES ('223', '其它渔船', 'qitayuchuan', '2', '', '', '', '23', '4,23,223', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qitayuchuan');
INSERT INTO `hi_category` VALUES ('224', '科研船', 'keyanchuan', '2', '', '', '', '24', '4,24,224', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'keyanchuan');
INSERT INTO `hi_category` VALUES ('225', '浮船坞', 'fuchuanwu', '2', '', '', '', '24', '4,24,225', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'fuchuanwu');
INSERT INTO `hi_category` VALUES ('226', '摩托艇', 'motuoting', '2', '', '', '', '24', '4,24,226', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'motuoting');
INSERT INTO `hi_category` VALUES ('227', '帆船', 'fanchuan', '2', '', '', '', '24', '4,24,227', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'fanchuan');
INSERT INTO `hi_category` VALUES ('228', '趸船', 'chuan', '2', '', '', '', '24', '4,24,228', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zuochuan');
INSERT INTO `hi_category` VALUES ('229', '调查船', 'diaochachuan', '2', '', '', '', '24', '4,24,229', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'diaochachuan');
INSERT INTO `hi_category` VALUES ('230', '勘探船', 'kantanchuan', '2', '', '', '', '24', '4,24,230', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'kantanchuan');
INSERT INTO `hi_category` VALUES ('231', '科考船', 'kekaochuan', '2', '', '', '', '24', '4,24,231', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'kekaochuan');
INSERT INTO `hi_category` VALUES ('232', '医院船', 'yiyuanchuan', '2', '', '', '', '24', '4,24,232', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'yiyuanchuan');
INSERT INTO `hi_category` VALUES ('233', '实习船', 'shixichuan', '2', '', '', '', '24', '4,24,233', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'shixichuan');
INSERT INTO `hi_category` VALUES ('234', '潜水船', 'qianshuichuan', '2', '', '', '', '24', '4,24,234', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qianshuichuan');
INSERT INTO `hi_category` VALUES ('235', '气象船', 'qixiangchuan', '2', '', '', '', '24', '4,24,235', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qixiangchuan');
INSERT INTO `hi_category` VALUES ('236', '地效翼船', 'dixiaoyichuan', '2', '', '', '', '24', '4,24,236', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'dixiaoyichuan');
INSERT INTO `hi_category` VALUES ('237', '测量船', 'celiangchuan', '2', '', '', '', '24', '4,24,237', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'celiangchuan');
INSERT INTO `hi_category` VALUES ('238', '水翼船', 'shuiyichuan', '2', '', '', '', '24', '4,24,238', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'shuiyichuan');
INSERT INTO `hi_category` VALUES ('239', '餐饮船', 'canyinchuan', '2', '', '', '', '24', '4,24,239', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'canyinchuan');
INSERT INTO `hi_category` VALUES ('240', '其它特种船', 'qitatezhongchuan', '2', '', '', '', '24', '4,24,240', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qitatezhongchuan');
INSERT INTO `hi_category` VALUES ('241', '其它船舶', 'qitachuanbo', '2', '', '', '', '4', '4,241', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qitachuanbo');
INSERT INTO `hi_category` VALUES ('249', '浮式生产储油船', 'fushishengchanchuyouchuan', '2', '', '', '', '26', '4,26,249', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'fushishengchanchuyouchuan');
INSERT INTO `hi_category` VALUES ('250', '平台供应船', 'pingtaigongyingchuan', '2', '', '', '', '26', '4,26,250', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'pingtaigongyingchuan');
INSERT INTO `hi_category` VALUES ('251', '钻井船', 'zuanjingchuan', '2', '', '', '', '26', '4,26,251', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zuanjingchuan');
INSERT INTO `hi_category` VALUES ('252', '油田守护船', 'youtianshouhuchuan', '2', '', '', '', '26', '4,26,252', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'youtianshouhuchuan');
INSERT INTO `hi_category` VALUES ('253', '风电安装船', 'fengdiananzhuangchuan', '2', '', '', '', '26', '4,26,253', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'fengdiananzhuangchuan');
INSERT INTO `hi_category` VALUES ('254', '潜水工作船', 'qianshuigongzuochuan', '2', '', '', '', '26', '4,26,254', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qianshuigongzuochuan');
INSERT INTO `hi_category` VALUES ('255', '三用工作船', 'sanyonggongzuochuan', '2', '', '', '', '26', '4,26,255', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'sanyonggongzuochuan');
INSERT INTO `hi_category` VALUES ('256', '定位船', 'dingweichuan', '2', '', '', '', '26', '4,26,256', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'dingweichuan');
INSERT INTO `hi_category` VALUES ('257', '钻井驳', 'zuanjingbo', '2', '', '', '', '26', '4,26,257', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zuanjingbo');
INSERT INTO `hi_category` VALUES ('258', '修井驳', 'xiujingbo', '2', '', '', '', '26', '4,26,258', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'xiujingbo');
INSERT INTO `hi_category` VALUES ('259', '铺管船', 'puguanchuan', '2', '', '', '', '26', '4,26,259', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'puguanchuan');
INSERT INTO `hi_category` VALUES ('260', '铺石船', 'pushichuan', '2', '', '', '', '26', '4,26,260', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'pushichuan');
INSERT INTO `hi_category` VALUES ('261', '过驳平台船', 'guobopingtaichuan', '2', '', '', '', '26', '4,26,261', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'guobopingtaichuan');
INSERT INTO `hi_category` VALUES ('262', '海洋工程辅助船', 'haiyanggongchengfuzhuchuan', '2', '', '', '', '26', '4,26,262', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'haiyanggongchengfuzhuchuan');
INSERT INTO `hi_category` VALUES ('263', '多用途工程船', 'duoyongtugongchengchuan', '2', '', '', '', '26', '4,26,263', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'duoyongtugongchengchuan');
INSERT INTO `hi_category` VALUES ('264', '其它海洋工程船', 'qitahaiyanggongchengchuan', '2', '', '', '', '26', '4,26,264', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qitahaiyanggongchengchuan');
INSERT INTO `hi_category` VALUES ('265', '其它设备', 'qitashebei', '2', '', '', '', '2', '2,265', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qitashebei');
INSERT INTO `hi_category` VALUES ('266', '海洋工程', 'haiyanggongcheng', '2', '', '', '', '0', '266', '1', '267,268,269,270,271,272,273,274,275', '1', '', '', '0', '', '', '0', '0', '0', 'haiyanggongcheng');
INSERT INTO `hi_category` VALUES ('267', '海工平台', 'haigongpingtai', '2', '', '', '', '266', '266,267', '1', '269,270,271,272,273,274,275', '1', '', '', '0', '', '', '0', '0', '0', 'haigongpingtai');
INSERT INTO `hi_category` VALUES ('268', '海工设备', 'haigongshebei', '1', '', '', '', '266', '266,268', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'haigongshebei');
INSERT INTO `hi_category` VALUES ('269', '钻井平台', 'zuanjingpingtai', '2', '', '', '', '267', '266,267,269', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'zuanjingpingtai');
INSERT INTO `hi_category` VALUES ('270', '储油平台', 'chuyoupingtai', '2', '', '', '', '267', '266,267,270', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'chuyoupingtai');
INSERT INTO `hi_category` VALUES ('271', '修井平台', 'xiujingpingtai', '2', '', '', '', '267', '266,267,271', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'xiujingpingtai');
INSERT INTO `hi_category` VALUES ('272', '生活平台', 'shenghuopingtai', '2', '', '', '', '267', '266,267,272', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'shenghuopingtai');
INSERT INTO `hi_category` VALUES ('273', '过驳平台', 'guobopingtai', '2', '', '', '', '267', '266,267,273', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'guobopingtai');
INSERT INTO `hi_category` VALUES ('274', '半潜式海洋平台', 'banqianshihaiyangpingtai', '2', '', '', '', '267', '266,267,274', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'banqianshihaiyangpingtai');
INSERT INTO `hi_category` VALUES ('275', '其它平台', 'qitapingtai', '2', '', '', '', '267', '266,267,275', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qitapingtai');
INSERT INTO `hi_category` VALUES ('277', '配件', 'peijian', '2', '', '', '', '7', '1,7,277', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'peijian');
INSERT INTO `hi_category` VALUES ('278', '配件', 'peijian', '2', '', '', '', '10', '2,10,278', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'peijian');
INSERT INTO `hi_category` VALUES ('279', '配件', 'peijian', '2', '', '', '', '11', '2,11,279', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'peijian');
INSERT INTO `hi_category` VALUES ('280', '配件', 'peijian', '2', '', '', '', '12', '2,12,280', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'peijian');
INSERT INTO `hi_category` VALUES ('281', '配件', 'peijian', '2', '', '', '', '13', '2,13,281', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'peijian');
INSERT INTO `hi_category` VALUES ('282', '配件', 'peijian', '2', '', '', '', '14', '2,14,282', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'peijian');
INSERT INTO `hi_category` VALUES ('283', '其它', 'qita', '2', '', '', '', '14', '2,14,283', '0', '', '1', '', '', '0', '', '', '0', '0', '0', 'qita');

-- ----------------------------
-- Table structure for hi_config
-- ----------------------------
DROP TABLE IF EXISTS `hi_config`;
CREATE TABLE `hi_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- ----------------------------
-- Records of hi_config
-- ----------------------------
INSERT INTO `hi_config` VALUES ('1', 'WEB_SITE_TITLE', '1', '网站标题', '1', '', '网站标题前台显示标题', '1378898976', '1490579763', '1', 'HICMS', '1');
INSERT INTO `hi_config` VALUES ('2', 'WEB_SITE_KEYWORD', '2', '网站关键字', '1', '', '网站搜索引擎关键字，多个关键字用“,”分割', '1378898976', '1492669818', '1', '这里是网站关键字', '3');
INSERT INTO `hi_config` VALUES ('3', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '0', '', '主要用于数据解析和页面表单的生成', '1378898976', '1492666524', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举\r\n5:密码\r\n6:图片\r\n7:开关', '2');
INSERT INTO `hi_config` VALUES ('4', 'CONFIG_GROUP_LIST', '3', '配置分组', '0', '', '配置分组', '1379228036', '1492665356', '1', '1:网站\r\n2:内容\r\n3:用户\r\n4:系统\r\n5:上传\r\n6:安全', '4');
INSERT INTO `hi_config` VALUES ('5', 'HOOKS_TYPE', '3', '钩子的类型', '0', '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', '1379313397', '1488938754', '1', '1:视图\r\n2:控制器', '6');
INSERT INTO `hi_config` VALUES ('6', 'AUTH_CONFIG', '3', 'Auth配置', '0', '', '自定义Auth.class.php类配置', '1379409310', '1488938763', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '8');
INSERT INTO `hi_config` VALUES ('7', 'LIST_ADMIN_ROWS', '0', '后台每页记录数', '2', '', '后台数据每页显示记录数', '1379503896', '1493284208', '1', '10', '10');
INSERT INTO `hi_config` VALUES ('8', 'DEVELOP_MODE', '4', '开启开发者模式', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1383291877', '1', '1', '11');
INSERT INTO `hi_config` VALUES ('9', 'ALLOW_VISIT', '3', '不受限控制器方法', '0', '', '', '1386644047', '1492158536', '1', '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', '0');
INSERT INTO `hi_config` VALUES ('10', 'DENY_VISIT', '3', '超管专限控制器方法', '0', '', '仅超级管理员可访问的控制器方法', '1386644141', '1386644659', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '0');
INSERT INTO `hi_config` VALUES ('11', 'ADMIN_ALLOW_IP', '0', '后台允许访问IP', '2', '', '多个用|分隔，如果不配置表示不限制IP访问', '1387165454', '1490617282', '1', '', '12');
INSERT INTO `hi_config` VALUES ('12', 'SHOW_PAGE_TRACESSSS', '4', '是否显示页面Trace', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1493971202', '1', '0', '1');
INSERT INTO `hi_config` VALUES ('13', 'VERIFY_TYPE', '4', '验证码类型', '6', '1:中文\r\n2:英文\r\n3:数字\r\n4:英文+数字', '验证码类型', '1454510487', '1492664778', '1', '3', '0');
INSERT INTO `hi_config` VALUES ('14', 'WEB_SITE_LOGO', '6', '网站LOGO', '1', '', '网站显示的LOGO', '1489065495', '1492666538', '1', '9', '2');
INSERT INTO `hi_config` VALUES ('15', 'UPLOAD_DOWNLOAD_MAXSIZE', '0', '附件上传大小', '5', '', '附件上传大小单位：MB', '1488869731', '1492666302', '1', '20', '0');
INSERT INTO `hi_config` VALUES ('16', 'UPLOAD_PICTURE_MAXSIZE', '0', '图片上传大小', '5', '', '图片上传大小单位：MB', '1488870533', '1492667183', '1', '2', '2');
INSERT INTO `hi_config` VALUES ('17', 'DENY_MEMBER', '2', '禁止注册的用户名', '3', '', '禁止注册的用户名，用“|”分割', '1490618416', '1492668728', '1', 'jiangzheming|hujintao|xijinping|maozedong', '0');
INSERT INTO `hi_config` VALUES ('18', 'AUTH_KEY', '1', '数据加密KEY', '0', '', '', '1490622210', '1491006580', '1', 'O#aG&kdNqArBD0E;LK*Y7zn{9?$,PiR6mys!JM~v', '0');
INSERT INTO `hi_config` VALUES ('19', 'MEMBER_REG_CHECK', '4', '会员注册审核', '3', '0:关闭审核\r\n1:开启审核', '是否开启会员注册审核', '1490623999', '1492668721', '1', '1', '0');
INSERT INTO `hi_config` VALUES ('20', 'URL_ADMIN', '1', '后台管理页面', '4', '', '', '1490933675', '1490933675', '1', 'abc', '0');
INSERT INTO `hi_config` VALUES ('21', 'LOGIN_FAILED_TIMES', '0', '登陆失败次数', '6', '', '超过最大登陆失败次数，将一定时间内禁止登陆后台', '1492664961', '1492664974', '1', '5', '0');
INSERT INTO `hi_config` VALUES ('22', 'UPLOAD_FILE_EXTS', '1', '允许上传的文件后缀', '5', '', '允许上传的文件后缀名，如doc,xlsx等，用“,”分割', '1492665706', '1492692549', '1', 'jpg,gif,png,jpeg,zip,rar,tar,gz,7z,doc,docx,txt,xml', '1');
INSERT INTO `hi_config` VALUES ('23', 'UPLOAD_IMAGE_EXTS', '1', '允许上传的图片后缀', '5', '', '允许上传的图片后缀名，如jpg,bmp，用“,”分割', '1492665901', '1492692541', '1', 'jpg,gif,png,jpeg', '3');
INSERT INTO `hi_config` VALUES ('24', 'WEB_SITE_DESCRIPTION', '2', '网站描述', '1', '', '用于概括或描述页面内容，一两句话或一个简短的段落即可', '1492669745', '1492669745', '1', '', '4');
INSERT INTO `hi_config` VALUES ('25', 'WEB_SITE_ICP', '1', 'ICP备案', '1', '', '如：浙ICP备 00000001号', '1492670049', '1492670049', '1', '', '5');

-- ----------------------------
-- Table structure for hi_cron
-- ----------------------------
DROP TABLE IF EXISTS `hi_cron`;
CREATE TABLE `hi_cron` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(20) NOT NULL,
  `cron` varchar(20) NOT NULL DEFAULT '' COMMENT '任务文件',
  `intervals` int(10) unsigned NOT NULL DEFAULT '3600' COMMENT '任务执行间隔时间',
  `runtime` int(10) NOT NULL DEFAULT '0' COMMENT '初始执行时间',
  `lastruntime` int(10) unsigned NOT NULL COMMENT '上次执行时间',
  `config` text COMMENT '扩展信息',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行次数',
  `icon` varchar(20) NOT NULL DEFAULT '' COMMENT '图标类',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '说明',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '99' COMMENT '排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='定时任务表';

-- ----------------------------
-- Records of hi_cron
-- ----------------------------
INSERT INTO `hi_cron` VALUES ('1', '测试定时', 'test', '60', '1493908680', '1496190514', null, '919', 'fa-bell-slash-o', '定时任务名称', '1494382917', '1493905839', '0', '1');
INSERT INTO `hi_cron` VALUES ('2', '自动清空一个月前的操作记录', 'autoCleanLog', '2592000', '1493568000', '1494379662', null, '8', 'fa-newspaper-o', '自动清空一个月前的操作记录，避免日志表过于臃肿', '1493949702', '1493949702', '0', '1');

-- ----------------------------
-- Table structure for hi_link
-- ----------------------------
DROP TABLE IF EXISTS `hi_link`;
CREATE TABLE `hi_link` (
  `id` smallint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT '站点名称',
  `url` varchar(140) NOT NULL DEFAULT '' COMMENT '链接地址',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '站点描述',
  `sort` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `nofollow` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否追踪',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型分组',
  `logo` mediumint(8) unsigned NOT NULL COMMENT 'LOGO图片',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='友情链接表';

-- ----------------------------
-- Records of hi_link
-- ----------------------------
INSERT INTO `hi_link` VALUES ('1', '中船通', 'http://www.allship.cn', '', '0', '0', '0', '10', '1', '1493302351');

-- ----------------------------
-- Table structure for hi_linkage
-- ----------------------------
DROP TABLE IF EXISTS `hi_linkage`;
CREATE TABLE `hi_linkage` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '联动ID',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `name` varchar(20) NOT NULL COMMENT '配置名称英文',
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '上级联动ID',
  `value` mediumint(6) unsigned NOT NULL DEFAULT '0' COMMENT '配置值',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态显示 1:正常 0:禁止',
  `sort` tinyint(3) NOT NULL DEFAULT '0' COMMENT '排序',
  `type` tinyint(1) NOT NULL COMMENT '类别',
  `islock` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否锁定 0:非 1:是',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='联动菜单表';

-- ----------------------------
-- Records of hi_linkage
-- ----------------------------
INSERT INTO `hi_linkage` VALUES ('1', '联动分组', 'TYPE', '0', '0', '1', '0', '1', '1');
INSERT INTO `hi_linkage` VALUES ('2', '类别', '', '1', '1', '1', '0', '1', '0');
INSERT INTO `hi_linkage` VALUES ('3', '其他', '', '1', '2', '1', '0', '1', '0');
INSERT INTO `hi_linkage` VALUES ('4', '友情链接', 'LINK', '0', '0', '1', '0', '1', '1');
INSERT INTO `hi_linkage` VALUES ('5', '政府', '', '4', '1', '1', '0', '1', '0');
INSERT INTO `hi_linkage` VALUES ('6', '企业', '', '4', '2', '1', '0', '1', '0');
INSERT INTO `hi_linkage` VALUES ('7', '碎片类型', 'BLOCK', '0', '0', '1', '0', '1', '1');
INSERT INTO `hi_linkage` VALUES ('8', 'HTML文本', '', '7', '1', '1', '0', '2', '0');
INSERT INTO `hi_linkage` VALUES ('9', '富文本', '', '7', '2', '1', '0', '2', '0');
INSERT INTO `hi_linkage` VALUES ('10', '模型分组', 'MODEL', '0', '0', '1', '0', '1', '1');
INSERT INTO `hi_linkage` VALUES ('11', '文章', '', '10', '1', '1', '0', '1', '0');
INSERT INTO `hi_linkage` VALUES ('12', '产品', '', '10', '2', '1', '0', '1', '0');
INSERT INTO `hi_linkage` VALUES ('13', '会员', '', '10', '3', '1', '0', '1', '0');
INSERT INTO `hi_linkage` VALUES ('14', '其他', '', '10', '4', '1', '0', '1', '0');

-- ----------------------------
-- Table structure for hi_log_admin
-- ----------------------------
DROP TABLE IF EXISTS `hi_log_admin`;
CREATE TABLE `hi_log_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `uid` smallint(6) NOT NULL DEFAULT '0' COMMENT '操作帐号ID',
  `time` int(10) NOT NULL DEFAULT '0' COMMENT '操作时间',
  `ip` bigint(20) NOT NULL COMMENT 'IP',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态,0错误提示，1为正确提示',
  `info` text COMMENT '其他说明',
  `get` varchar(255) NOT NULL DEFAULT '' COMMENT 'get数据',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `username` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=1858 DEFAULT CHARSET=utf8 COMMENT='后台操作日志表';

-- ----------------------------
-- Records of hi_log_admin
-- ----------------------------
INSERT INTO `hi_log_admin` VALUES ('1848', '1', '1495870558', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Link,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/link/index.html');
INSERT INTO `hi_log_admin` VALUES ('1847', '1', '1495870462', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/model/index.html');
INSERT INTO `hi_log_admin` VALUES ('1846', '1', '1495870461', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/model/index.html');
INSERT INTO `hi_log_admin` VALUES ('1845', '1', '1495870437', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/1.html');
INSERT INTO `hi_log_admin` VALUES ('1844', '1', '1495870434', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/1.html');
INSERT INTO `hi_log_admin` VALUES ('1843', '1', '1495870432', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/1.html');
INSERT INTO `hi_log_admin` VALUES ('1842', '1', '1495870429', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/1.html');
INSERT INTO `hi_log_admin` VALUES ('1841', '1', '1495870404', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/1.html');
INSERT INTO `hi_log_admin` VALUES ('1840', '1', '1495870402', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/1.html');
INSERT INTO `hi_log_admin` VALUES ('1839', '1', '1495870356', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Menu,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/menu/index.html');
INSERT INTO `hi_log_admin` VALUES ('1834', '1', '1495870131', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1838', '1', '1495870350', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Menu,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/menu/index.html');
INSERT INTO `hi_log_admin` VALUES ('1837', '1', '1495870281', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Config,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/config/index.html');
INSERT INTO `hi_log_admin` VALUES ('1836', '1', '1495870277', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Config,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/config/index.html');
INSERT INTO `hi_log_admin` VALUES ('1835', '1', '1495870134', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1833', '1', '1495870129', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1832', '1', '1495870127', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1831', '1', '1495870123', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1830', '1', '1495870122', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1829', '1', '1495870119', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1828', '1', '1495869941', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Linkage,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/linkage/index.html');
INSERT INTO `hi_log_admin` VALUES ('1827', '1', '1495869940', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Linkage,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/linkage/index.html');
INSERT INTO `hi_log_admin` VALUES ('1826', '1', '1495869939', '0', '0', '提示：不允许对该联动执行该操作!<br/>模块：Admin,控制器：Linkage,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/linkage/index.html');
INSERT INTO `hi_log_admin` VALUES ('1825', '1', '1495869938', '0', '0', '提示：不允许对该联动执行该操作!<br/>模块：Admin,控制器：Linkage,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/linkage/index.html');
INSERT INTO `hi_log_admin` VALUES ('1824', '1', '1495869716', '0', '0', '提示：不允许对此会员组执行该操作!<br/>模块：Admin,控制器：Auth,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Auth/index/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1823', '1', '1495869712', '0', '0', '提示：不允许对此会员组执行该操作!<br/>模块：Admin,控制器：Auth,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Auth/index/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1822', '1', '1495868501', '0', '0', '提示：不允许对此会员组执行该操作!<br/>模块：Admin,控制器：Auth,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/auth/index.html');
INSERT INTO `hi_log_admin` VALUES ('1821', '1', '1495868498', '0', '0', '提示：不允许对此会员组执行该操作!<br/>模块：Admin,控制器：Auth,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/auth/index.html');
INSERT INTO `hi_log_admin` VALUES ('1820', '1', '1495868474', '0', '0', '提示：不允许对超级管理员执行该操作!<br/>模块：Admin,控制器：Auth,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/auth/index.html');
INSERT INTO `hi_log_admin` VALUES ('1819', '1', '1495868473', '0', '0', '提示：不允许对超级管理员执行该操作!<br/>模块：Admin,控制器：Auth,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/auth/index.html');
INSERT INTO `hi_log_admin` VALUES ('1818', '1', '1495867640', '0', '0', '提示：不允许对超级管理员执行该操作!<br/>模块：Admin,控制器：Member,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1817', '1', '1495867638', '0', '0', '提示：不允许对超级管理员执行该操作!<br/>模块：Admin,控制器：Member,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1816', '1', '1495867543', '0', '0', '提示：<br/>模块：Admin,控制器：Member,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1815', '1', '1495867427', '0', '0', '提示：<br/>模块：Admin,控制器：Member,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1814', '1', '1495867242', '0', '0', '提示：<br/>模块：Admin,控制器：Member,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1812', '1', '1495867080', '0', '0', '提示：', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1813', '1', '1495867084', '0', '0', '提示：', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1810', '1', '1495867075', '0', '0', '提示：', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1811', '1', '1495867076', '0', '0', '提示：', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1809', '1', '1495866979', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Member,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1808', '1', '1495866977', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Member,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1807', '1', '1495866742', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Member,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1806', '1', '1495866738', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Member,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1805', '0', '1495866729', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Member,方法：index<br/>请求方式：GET', 'http://localhost/Admin/Block/index.html');
INSERT INTO `hi_log_admin` VALUES ('1804', '1', '1495855493', '0', '1', '提示：碎片编辑成功<br/>模块：Admin,控制器：Block,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Block/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1803', '1', '1495855392', '0', '1', '提示：碎片编辑成功<br/>模块：Admin,控制器：Block,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Block/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1802', '1', '1495855348', '0', '1', '提示：碎片编辑成功<br/>模块：Admin,控制器：Block,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Block/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1801', '1', '1495855332', '0', '1', '提示：碎片编辑成功<br/>模块：Admin,控制器：Block,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Block/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1800', '1', '1495854795', '0', '1', '提示：碎片编辑成功<br/>模块：Admin,控制器：Block,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Block/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1799', '0', '1495853535', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Block,方法：edit<br/>请求方式：GET', 'http://localhost/Admin/block/index.html');
INSERT INTO `hi_log_admin` VALUES ('1798', '0', '1495849456', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1797', '1', '1495847529', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/template/index.html');
INSERT INTO `hi_log_admin` VALUES ('1796', '1', '1495787988', '0', '1', '提示：碎片编辑成功<br/>模块：Admin,控制器：Block,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Block/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1795', '0', '1495787247', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Article,方法：index<br/>请求方式：GET', 'http://localhost/Admin/Index/index.html');
INSERT INTO `hi_log_admin` VALUES ('1794', '0', '1495781161', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Block,方法：index<br/>请求方式：GET', 'http://localhost/Admin/Linkage/index/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1793', '1', '1495766214', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/9.html');
INSERT INTO `hi_log_admin` VALUES ('1792', '1', '1495766199', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/7.html');
INSERT INTO `hi_log_admin` VALUES ('1791', '1', '1495765082', '0', '1', '提示：碎片编辑成功<br/>模块：Admin,控制器：Block,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Block/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1790', '1', '1495764970', '0', '1', '提示：碎片编辑成功<br/>模块：Admin,控制器：Block,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Block/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1789', '1', '1495764594', '0', '1', '提示：碎片编辑成功<br/>模块：Admin,控制器：Block,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Block/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1788', '1', '1495764516', '0', '1', '提示：碎片编辑成功<br/>模块：Admin,控制器：Block,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Block/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1787', '1', '1495764212', '0', '1', '提示：添加碎片成功<br/>模块：Admin,控制器：Block,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Block/add.html');
INSERT INTO `hi_log_admin` VALUES ('1786', '1', '1495763367', '0', '0', '提示：碎片内容不能为空<br/>模块：Admin,控制器：Block,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Block/add.html');
INSERT INTO `hi_log_admin` VALUES ('1785', '1', '1495763243', '0', '0', '提示：请填写内容<br/>模块：Admin,控制器：Block,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Block/add.html');
INSERT INTO `hi_log_admin` VALUES ('1784', '1', '1495763240', '0', '0', '提示：碎片名称不能为空<br/>模块：Admin,控制器：Block,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Block/add.html');
INSERT INTO `hi_log_admin` VALUES ('1783', '1', '1495763193', '0', '1', '提示：添加碎片成功<br/>模块：Admin,控制器：Block,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Block/add.html');
INSERT INTO `hi_log_admin` VALUES ('1782', '1', '1495761126', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/65.html');
INSERT INTO `hi_log_admin` VALUES ('1781', '1', '1495761101', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/65.html');
INSERT INTO `hi_log_admin` VALUES ('1780', '1', '1495761093', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/62/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1779', '1', '1495761061', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/62/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1778', '1', '1495760954', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/62/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1777', '0', '1495700786', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Block,方法：index<br/>请求方式：GET', 'http://localhost/Admin/block/index.html');
INSERT INTO `hi_log_admin` VALUES ('1776', '1', '1495698315', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/24/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1775', '1', '1495698130', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/10.html');
INSERT INTO `hi_log_admin` VALUES ('1774', '1', '1495698124', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/7.html');
INSERT INTO `hi_log_admin` VALUES ('1773', '1', '1495698118', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1772', '1', '1495698095', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/8.html');
INSERT INTO `hi_log_admin` VALUES ('1771', '1', '1495698088', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/8.html');
INSERT INTO `hi_log_admin` VALUES ('1770', '1', '1495698069', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/8.html');
INSERT INTO `hi_log_admin` VALUES ('1769', '1', '1495698059', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/9.html');
INSERT INTO `hi_log_admin` VALUES ('1768', '1', '1495697635', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/8.html');
INSERT INTO `hi_log_admin` VALUES ('1767', '1', '1495697541', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/7.html');
INSERT INTO `hi_log_admin` VALUES ('1766', '1', '1495697504', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/7.html');
INSERT INTO `hi_log_admin` VALUES ('1765', '1', '1495697356', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1764', '1', '1495697334', '0', '0', '提示：菜单名称已经存在<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1763', '0', '1495697311', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：GET', 'http://localhost/Admin/Linkage/index/pid/1/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1762', '0', '1495697309', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1761', '0', '1495697304', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1760', '0', '1495697295', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1759', '0', '1495697289', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1758', '1', '1495695060', '0', '0', '提示：菜单名称已经存在<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1757', '1', '1495695056', '0', '0', '提示：菜单名称已经存在<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1756', '1', '1495694909', '0', '1', '提示：联动菜单添加成功<br/>模块：Admin,控制器：Linkage,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/add/pid/0/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1755', '1', '1495694887', '0', '1', '提示：联动菜单添加成功<br/>模块：Admin,控制器：Linkage,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/add/pid/0/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1754', '1', '1495694105', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Linkage,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/linkage/index.html');
INSERT INTO `hi_log_admin` VALUES ('1753', '1', '1495694104', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Linkage,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/linkage/index.html');
INSERT INTO `hi_log_admin` VALUES ('1752', '0', '1495694081', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Article,方法：index<br/>请求方式：GET', 'http://localhost/Admin/Menu/add/pid/0/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1751', '1', '1495682368', '0', '1', '提示：文章文章标题23213123编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('1750', '1', '1495682358', '0', '1', '提示：文章文章标题1111111编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('1749', '1', '1495681609', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/57/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1748', '1', '1495681599', '0', '0', '提示：请选择图标<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/57/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1747', '1', '1495681575', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/57/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1746', '1', '1495681508', '0', '1', '提示：Home/lists/list.html模板文件还原成功!<br/>模块：Admin,控制器：Template,方法：restore<br/>请求方式：Ajax', 'http://localhost/Admin/Template/history/module/home/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1745', '1', '1495681313', '0', '1', '提示：保存成功!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/edit/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1744', '1', '1495681267', '0', '1', '提示：{$info[\"file\"]}模板文件还原成功!<br/>模块：Admin,控制器：Template,方法：restore<br/>请求方式：Ajax', 'http://localhost/Admin/Template/history/module/home/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1743', '1', '1495681153', '0', '1', '提示：{$info[\"file\"]}模板文件还原成功!<br/>模块：Admin,控制器：Template,方法：restore<br/>请求方式：Ajax', 'http://localhost/Admin/Template/history/module/home/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1742', '1', '1495681128', '0', '1', '提示：保存成功!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/edit/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1741', '1', '1495681062', '0', '1', '提示：{$info[\"file\"]}模板文件还原成功!<br/>模块：Admin,控制器：Template,方法：restore<br/>请求方式：Ajax', 'http://localhost/Admin/Template/history/module/home/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1740', '1', '1495680991', '0', '1', '提示：保存成功!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/edit/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1739', '1', '1495680523', '0', '1', '提示：保存成功!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/edit/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1738', '1', '1495680462', '0', '1', '提示：{$info[\"file\"]}模板文件还原成功!<br/>模块：Admin,控制器：Template,方法：restore<br/>请求方式：Ajax', 'http://localhost/Admin/Template/history/module/home/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1737', '1', '1495680373', '0', '1', '提示：{$info[\"file\"]}模板文件还原成功!<br/>模块：Admin,控制器：Template,方法：restore<br/>请求方式：Ajax', 'http://localhost/Admin/Template/history/module/home/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1736', '1', '1495679520', '0', '0', '提示：还原{$file}失败!<br/>模块：Admin,控制器：Template,方法：restore<br/>请求方式：Ajax', 'http://localhost/Admin/Template/history/module/home/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1735', '1', '1495679357', '0', '0', '提示：还原{$file}失败!<br/>模块：Admin,控制器：Template,方法：restore<br/>请求方式：Ajax', 'http://localhost/Admin/Template/history/module/home/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1734', '1', '1495679290', '0', '0', '提示：读取文件失败<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/history/module/home/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1733', '1', '1495679268', '0', '0', '提示：读取文件失败<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/history/module/home/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1732', '0', '1495679227', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Template,方法：history<br/>请求方式：GET', 'http://localhost/Admin/Template/index/module/home/dir/lists.html');
INSERT INTO `hi_log_admin` VALUES ('1731', '1', '1495676323', '0', '0', '提示：读取文件失败<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：GET', 'http://localhost/Admin/Template/history/module/home/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1730', '1', '1495674952', '0', '1', '提示：保存成功!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/edit/file/SG9tZXxsaXN0c3xsaXN0X3Bob3RvLmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1729', '1', '1495674189', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home/dir/lists.html');
INSERT INTO `hi_log_admin` VALUES ('1728', '1', '1495674183', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1727', '1', '1495674156', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1726', '1', '1495674117', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1725', '1', '1495674082', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1724', '1', '1495673972', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1723', '1', '1495673892', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1722', '1', '1495673882', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1721', '1', '1495673806', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1720', '1', '1495673784', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1719', '1', '1495673755', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1718', '1', '1495673710', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1717', '1', '1495673621', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1716', '1', '1495673611', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1715', '1', '1495617885', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1714', '1', '1495617879', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1713', '1', '1495617767', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1712', '1', '1495617763', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1711', '1', '1495617744', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1710', '1', '1495617726', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1709', '1', '1495617715', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1708', '1', '1495617686', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1707', '1', '1495617160', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1706', '1', '1495614271', '0', '1', '提示：保存成功!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/edit/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1705', '1', '1495611991', '0', '1', '提示：保存成功!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/edit/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1704', '1', '1495611838', '0', '1', '提示：保存成功!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/edit/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1703', '0', '1495609736', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Ad,方法：index<br/>请求方式：GET', 'http://localhost/Admin/Template/edit/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1702', '0', '1495609732', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/edit/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1701', '1', '1495607310', '0', '1', '提示：保存成功!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/edit/file/SG9tZXxsaXN0c3xsaXN0Lmh0bWw%3D.html');
INSERT INTO `hi_log_admin` VALUES ('1700', '1', '1495607298', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home/dir/lists.html');
INSERT INTO `hi_log_admin` VALUES ('1699', '0', '1495604134', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：GET', 'http://localhost/Admin/Template/index/module/home/dir/lists.html');
INSERT INTO `hi_log_admin` VALUES ('1698', '1', '1495595633', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/u.html');
INSERT INTO `hi_log_admin` VALUES ('1697', '1', '1495595564', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin.html');
INSERT INTO `hi_log_admin` VALUES ('1696', '1', '1495595543', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin.html');
INSERT INTO `hi_log_admin` VALUES ('1695', '1', '1495595261', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin.html');
INSERT INTO `hi_log_admin` VALUES ('1694', '1', '1495594712', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin.html');
INSERT INTO `hi_log_admin` VALUES ('1693', '1', '1495594608', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin.html');
INSERT INTO `hi_log_admin` VALUES ('1692', '1', '1495594590', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1691', '1', '1495594440', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin.html');
INSERT INTO `hi_log_admin` VALUES ('1690', '1', '1495594414', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin.html');
INSERT INTO `hi_log_admin` VALUES ('1689', '1', '1495594375', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1688', '1', '1495594330', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1687', '1', '1495594309', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1686', '1', '1495594275', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1685', '1', '1495594226', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1684', '1', '1495549605', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin.html');
INSERT INTO `hi_log_admin` VALUES ('1683', '1', '1495549598', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin.html');
INSERT INTO `hi_log_admin` VALUES ('1682', '1', '1495549578', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1681', '1', '1495549544', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/home.html');
INSERT INTO `hi_log_admin` VALUES ('1680', '1', '1495549463', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/template/index.html');
INSERT INTO `hi_log_admin` VALUES ('1679', '1', '1495549382', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin/dir/Login.html');
INSERT INTO `hi_log_admin` VALUES ('1678', '1', '1495549001', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/dir/Ad.html');
INSERT INTO `hi_log_admin` VALUES ('1677', '1', '1495548956', '0', '1', '提示：保存成功!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/edit/file/QWRtaW58QWR8ZWRpdC5odG1s.html');
INSERT INTO `hi_log_admin` VALUES ('1676', '1', '1495548855', '0', '1', '提示：保存成功!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/edit/file/QWRtaW58QWR8ZWRpdC5odG1s.html');
INSERT INTO `hi_log_admin` VALUES ('1675', '1', '1495548638', '0', '0', '提示：保存文件失败，请重试!<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Template/edit/file/QWRtaW58QWR8ZWRpdC5odG1s.html');
INSERT INTO `hi_log_admin` VALUES ('1674', '1', '1495547939', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/57/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1673', '1', '1495547918', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/57/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1672', '1', '1495529868', '0', '0', '提示：文件不存在<br/>模块：Admin,控制器：Template,方法：edit<br/>请求方式：GET', 'http://localhost/Admin/Template/index/module/admin/dir/Model.html');
INSERT INTO `hi_log_admin` VALUES ('1671', '1', '1495528716', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin/dir/Model.html');
INSERT INTO `hi_log_admin` VALUES ('1670', '1', '1495528709', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin/dir/Model.html');
INSERT INTO `hi_log_admin` VALUES ('1669', '1', '1495528695', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin/dir/Attachment.html');
INSERT INTO `hi_log_admin` VALUES ('1668', '1', '1495528552', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/dir/Ajax.html');
INSERT INTO `hi_log_admin` VALUES ('1667', '1', '1495528506', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/dir/Ad.html');
INSERT INTO `hi_log_admin` VALUES ('1666', '1', '1495528163', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Template/index/module/admin.html');
INSERT INTO `hi_log_admin` VALUES ('1665', '1', '1495527600', '0', '0', '提示：配置文件不可写!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', 'http://localhost/Admin/Template/index/module/admin.html');
INSERT INTO `hi_log_admin` VALUES ('1664', '1', '1495527393', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/template/index.html');
INSERT INTO `hi_log_admin` VALUES ('1663', '1', '1495527236', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/template/index.html');
INSERT INTO `hi_log_admin` VALUES ('1662', '1', '1495523236', '0', '0', '提示：配置文件不可写!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', 'http://localhost/Admin/Template/index/module/admin.html');
INSERT INTO `hi_log_admin` VALUES ('1661', '1', '1495523232', '0', '0', '提示：配置文件不可写!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', 'http://localhost/Admin/Template/index/module/admin.html');
INSERT INTO `hi_log_admin` VALUES ('1660', '0', '1495521461', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1659', '0', '1495516241', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', 'http://localhost/Admin/template/index.html');
INSERT INTO `hi_log_admin` VALUES ('1658', '1', '1495503943', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/template/index.html');
INSERT INTO `hi_log_admin` VALUES ('1657', '1', '1495503917', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/template/index.html');
INSERT INTO `hi_log_admin` VALUES ('1656', '1', '1495503915', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/template/index.html');
INSERT INTO `hi_log_admin` VALUES ('1655', '1', '1495503912', '0', '1', '提示：模板配置信息更新成功！<br/>模块：Admin,控制器：Template,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/template/index.html');
INSERT INTO `hi_log_admin` VALUES ('1654', '1', '1495502040', '0', '0', '提示：配置文件不可写!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1653', '1', '1495502039', '0', '0', '提示：配置文件不可写!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1652', '1', '1495501988', '0', '0', '提示：配置文件不可写!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1651', '1', '1495501979', '0', '0', '提示：配置文件不可写!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1650', '1', '1495501925', '0', '0', '提示：配置文件不可写!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1649', '1', '1495501764', '0', '0', '提示：配置文件不可写!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1648', '1', '1495440453', '0', '1', '提示：模块编辑成功<br/>模块：Admin,控制器：Module,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Module/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1647', '1', '1495440435', '0', '1', '提示：模块编辑成功<br/>模块：Admin,控制器：Module,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Module/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1646', '0', '1495439676', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', '/Admin/Template/');
INSERT INTO `hi_log_admin` VALUES ('1645', '1', '1495434486', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/24/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1644', '0', '1495430864', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Template,方法：index<br/>请求方式：GET', '/Admin/template');
INSERT INTO `hi_log_admin` VALUES ('1643', '0', '1495421874', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Ad,方法：index<br/>请求方式：GET', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1642', '0', '1495259211', '1270', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Index,方法：index<br/>请求方式：GET', '/admin.php');
INSERT INTO `hi_log_admin` VALUES ('1641', '0', '1495205343', '1270', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Article,方法：add<br/>请求方式：GET', 'http://0580.com/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1640', '0', '1495184222', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Article,方法：index<br/>请求方式：GET', 'http://localhost/Admin/Index/index.html');
INSERT INTO `hi_log_admin` VALUES ('1639', '0', '1495179009', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Model,方法：index<br/>请求方式：GET', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1638', '1', '1495173629', '0', '1', '提示：生成模型成功！<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/3.html');
INSERT INTO `hi_log_admin` VALUES ('1637', '1', '1495173274', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/37.html');
INSERT INTO `hi_log_admin` VALUES ('1636', '1', '1495172955', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/38.html');
INSERT INTO `hi_log_admin` VALUES ('1635', '1', '1495172798', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/25.html');
INSERT INTO `hi_log_admin` VALUES ('1634', '1', '1495172790', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/26.html');
INSERT INTO `hi_log_admin` VALUES ('1633', '1', '1495172780', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/17.html');
INSERT INTO `hi_log_admin` VALUES ('1632', '1', '1495172771', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/29.html');
INSERT INTO `hi_log_admin` VALUES ('1631', '1', '1495172762', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/31.html');
INSERT INTO `hi_log_admin` VALUES ('1630', '1', '1495172755', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/37.html');
INSERT INTO `hi_log_admin` VALUES ('1629', '1', '1495172713', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/37.html');
INSERT INTO `hi_log_admin` VALUES ('1628', '0', '1495172356', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Config,方法：index<br/>请求方式：GET', 'http://localhost/Admin/Menu/edit/id/31.html');
INSERT INTO `hi_log_admin` VALUES ('1627', '0', '1495172351', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/31.html');
INSERT INTO `hi_log_admin` VALUES ('1626', '0', '1495172335', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/31.html');
INSERT INTO `hi_log_admin` VALUES ('1625', '0', '1495172329', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/31.html');
INSERT INTO `hi_log_admin` VALUES ('1624', '0', '1495172320', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/31.html');
INSERT INTO `hi_log_admin` VALUES ('1623', '0', '1495172316', '0', '0', '提示：登陆已过期,请重新登陆!<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/31.html');
INSERT INTO `hi_log_admin` VALUES ('1622', '1', '1495164651', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1621', '1', '1494999513', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1620', '1', '1494998768', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1619', '1', '1494998621', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1618', '1', '1494998582', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1617', '1', '1494998544', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1616', '1', '1494998536', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1615', '1', '1494988042', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Article/index/p/1.html');
INSERT INTO `hi_log_admin` VALUES ('1614', '1', '1494988038', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Article/index/p/1.html');
INSERT INTO `hi_log_admin` VALUES ('1613', '1', '1494987554', '0', '1', '提示：推荐位信息移除成功！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/5.html');
INSERT INTO `hi_log_admin` VALUES ('1612', '1', '1494987540', '0', '1', '提示：推荐位信息移除成功！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/6.html');
INSERT INTO `hi_log_admin` VALUES ('1611', '1', '1494987525', '0', '1', '提示：推荐位信息移除成功！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1610', '1', '1494986941', '0', '1', '提示：文章文章标题1111111编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('1609', '1', '1494986920', '0', '1', '提示：文章文章标题2编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('1608', '1', '1494985624', '0', '1', '提示：文章文章标题1111111编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('1607', '1', '1494922106', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Position,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Position/index.html');
INSERT INTO `hi_log_admin` VALUES ('1606', '1', '1494922102', '0', '0', '提示：推荐位名称必须填写<br/>模块：Admin,控制器：Position,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Position/add.html');
INSERT INTO `hi_log_admin` VALUES ('1605', '1', '1494922099', '0', '0', '提示：推荐位名称必须填写<br/>模块：Admin,控制器：Position,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Position/add.html');
INSERT INTO `hi_log_admin` VALUES ('1604', '1', '1494921984', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1603', '1', '1494920901', '0', '1', '提示：推荐位信息移除成功！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/5.html');
INSERT INTO `hi_log_admin` VALUES ('1602', '1', '1494920868', '0', '1', '提示：推荐位信息移除成功！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/5.html');
INSERT INTO `hi_log_admin` VALUES ('1601', '1', '1494920783', '0', '1', '提示：推荐位信息移除成功！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/5.html');
INSERT INTO `hi_log_admin` VALUES ('1600', '1', '1494913080', '0', '1', '提示：编辑首页头条成功<br/>模块：Admin,控制器：Position,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Position/edit/id/5.html');
INSERT INTO `hi_log_admin` VALUES ('1599', '1', '1494913022', '0', '1', '提示：推荐位首页栏目推荐编辑成功<br/>模块：Admin,控制器：Position,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Position/edit/id/7.html');
INSERT INTO `hi_log_admin` VALUES ('1598', '1', '1494913015', '0', '1', '提示：推荐位首页头条编辑成功<br/>模块：Admin,控制器：Position,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Position/edit/id/5.html');
INSERT INTO `hi_log_admin` VALUES ('1597', '1', '1494912501', '0', '0', '提示：广告位名称不能为空<br/>模块：Admin,控制器：Ad,方法：pos<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/pos.html');
INSERT INTO `hi_log_admin` VALUES ('1596', '1', '1494905160', '0', '1', '提示：移除成功！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1595', '1', '1494905153', '0', '1', '提示：移除成功！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1594', '1', '1494902687', '0', '1', '提示：移除成功！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1593', '1', '1494902638', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/38/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1592', '1', '1494902536', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1591', '1', '1494902493', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1590', '1', '1494902465', '0', '1', '提示：移除成功！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1589', '1', '1494902461', '0', '1', '提示：移除成功！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1588', '1', '1494902454', '0', '1', '提示：移除成功！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1587', '1', '1494901317', '0', '1', '提示：移除成功<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1586', '1', '1494901286', '0', '1', '提示：移除成功<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1585', '1', '1494901219', '0', '0', '提示：移除失败，请稍后重试！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1584', '1', '1494901143', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1583', '1', '1494901080', '0', '0', '提示：移除失败，请稍后重试！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1582', '1', '1494901072', '0', '0', '提示：移除失败，请稍后重试！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1581', '1', '1494901043', '0', '0', '提示：移除失败，请稍后重试！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1580', '1', '1494901030', '0', '0', '提示：移除失败，请稍后重试！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1579', '1', '1494901008', '0', '0', '提示：移除失败，请稍后重试！<br/>模块：Admin,控制器：Position,方法：remove<br/>请求方式：Ajax', 'http://localhost/Admin/Position/content/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1578', '1', '1494897418', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1577', '1', '1494897149', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1576', '1', '1494897130', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1575', '1', '1494897111', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1574', '1', '1494853727', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1573', '1', '1494850415', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1572', '1', '1494850382', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1571', '1', '1494850197', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1570', '1', '1494850181', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1569', '1', '1494849841', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1568', '1', '1494839888', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1567', '1', '1494839851', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1566', '1', '1494839820', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1565', '1', '1494839811', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1564', '1', '1494839783', '0', '1', '提示：推送到推荐位成功！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1563', '1', '1494836015', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1562', '1', '1494835999', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1561', '1', '1494835981', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1560', '1', '1494835815', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1559', '1', '1494835675', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1558', '1', '1494835598', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1557', '1', '1494835566', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1556', '1', '1494835115', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1555', '1', '1494834883', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1554', '1', '1494834593', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1553', '1', '1494834535', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1552', '1', '1494834392', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1551', '1', '1494834364', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1550', '1', '1494831062', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1549', '1', '1494831007', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1548', '1', '1494830921', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1547', '1', '1494830898', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1546', '1', '1494830896', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1545', '1', '1494830894', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1544', '1', '1494830892', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1543', '1', '1494830805', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1542', '1', '1494830698', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1541', '1', '1494830681', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1540', '1', '1494830678', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1539', '1', '1494830569', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1538', '1', '1494830558', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1537', '1', '1494830550', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1536', '1', '1494830549', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1535', '1', '1494830435', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1534', '1', '1494830429', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1533', '1', '1494830351', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1532', '1', '1494830351', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1531', '1', '1494830351', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1530', '1', '1494830350', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1529', '1', '1494830350', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1528', '1', '1494830350', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1527', '1', '1494830350', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1526', '1', '1494830349', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1525', '1', '1494830348', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1524', '1', '1494830348', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1523', '1', '1494830348', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1522', '1', '1494830347', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1521', '1', '1494830346', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1520', '1', '1494830342', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1519', '1', '1494830337', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1518', '1', '1494830332', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1517', '1', '1494830332', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1516', '1', '1494830331', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1515', '1', '1494830327', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1514', '1', '1494830326', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1513', '1', '1494830325', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1512', '1', '1494830324', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1511', '1', '1494830324', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1510', '1', '1494830323', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1509', '1', '1494830323', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1508', '1', '1494830323', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1507', '1', '1494830322', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1506', '1', '1494830322', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1505', '1', '1494830321', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1504', '1', '1494830313', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1503', '1', '1494830221', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1502', '1', '1494830216', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1501', '1', '1494830207', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1500', '1', '1494830205', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1499', '1', '1494830198', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1498', '1', '1494830194', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1497', '1', '1494830194', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1496', '1', '1494830194', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1495', '1', '1494830193', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1494', '1', '1494830188', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1493', '1', '1494830187', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1492', '1', '1494830127', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1491', '1', '1494830122', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1490', '1', '1494830121', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1489', '1', '1494830121', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1488', '1', '1494830121', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1487', '1', '1494830119', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1486', '1', '1494829725', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1485', '1', '1494829683', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1484', '1', '1494829640', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1483', '1', '1494829541', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1482', '1', '1494829432', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1481', '1', '1494829406', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1480', '1', '1494829351', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1479', '1', '1494829320', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1478', '1', '1494829295', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1477', '1', '1494816203', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1476', '1', '1494816199', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1475', '1', '1494816190', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1474', '1', '1494816183', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1473', '1', '1494816176', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1472', '1', '1494815668', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1471', '1', '1494815663', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1470', '1', '1494815660', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1469', '1', '1494815632', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1468', '1', '1494814941', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1467', '1', '1494814660', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/38/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1466', '1', '1494814626', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/38/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1465', '1', '1494813876', '0', '1', '提示：启用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1464', '1', '1494813871', '0', '1', '提示：禁用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1463', '1', '1494813859', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1462', '1', '1494813858', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1461', '1', '1494813854', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1460', '1', '1494813854', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1459', '1', '1494813811', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Config,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/config/index.html');
INSERT INTO `hi_log_admin` VALUES ('1458', '1', '1494813810', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Config,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/config/index.html');
INSERT INTO `hi_log_admin` VALUES ('1457', '1', '1494813806', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1456', '1', '1494813802', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1455', '1', '1494813795', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1454', '1', '1494813789', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1453', '1', '1494813780', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1452', '1', '1494813134', '0', '1', '提示：生成模型成功！<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1451', '1', '1494813110', '0', '1', '提示：生成模型成功！<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1450', '1', '1494813048', '0', '1', '提示：删除成功！<br/>模块：Admin,控制器：Model,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/model/index.html');
INSERT INTO `hi_log_admin` VALUES ('1449', '1', '1494812989', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/37/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1448', '1', '1494812963', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/37/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1447', '1', '1494812907', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/30/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1446', '1', '1494812847', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/30/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1445', '1', '1494812812', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/30/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1444', '1', '1494812758', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/30/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1443', '1', '1494812685', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/12/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1442', '1', '1494812656', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/12/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1441', '1', '1494812618', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/12/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1440', '1', '1494812615', '0', '0', '提示：链接地址必须填写<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/12/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1439', '1', '1494812549', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/12/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1438', '1', '1494812522', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/12/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1437', '1', '1494812514', '0', '0', '提示：请选择图标<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/12/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1436', '1', '1494812446', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/10/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1435', '1', '1494812437', '0', '0', '提示：请选择图标<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/10/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1434', '1', '1494812419', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/41.html');
INSERT INTO `hi_log_admin` VALUES ('1433', '1', '1494812410', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/41.html');
INSERT INTO `hi_log_admin` VALUES ('1432', '1', '1494812397', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/10/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1431', '1', '1494812345', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/7/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1430', '1', '1494812341', '0', '0', '提示：链接地址必须填写<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/7/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1429', '1', '1494812290', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/7/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1428', '1', '1494812004', '0', '1', '提示：新增成功<br/>模块：Admin,控制器：Model,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/model/1.html');
INSERT INTO `hi_log_admin` VALUES ('1427', '1', '1494809923', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Model,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1426', '1', '1494809895', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Model,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1425', '1', '1494809790', '0', '0', '提示：非法数据对象！<br/>模块：Admin,控制器：Model,方法：update<br/>请求方式：GET', '/Admin/Model/update.html');
INSERT INTO `hi_log_admin` VALUES ('1424', '1', '1494809707', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Model,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('1423', '1', '1494750952', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Model,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/8.html');
INSERT INTO `hi_log_admin` VALUES ('1422', '1', '1494750905', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Model,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/8.html');
INSERT INTO `hi_log_admin` VALUES ('1421', '1', '1494750814', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Model,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('1420', '1', '1494750401', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Model,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('1419', '1', '1494750375', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Model,方法：update<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('1418', '1', '1494750062', '0', '1', '提示：字段编辑成功<br/>模块：Admin,控制器：Model,方法：field<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('1417', '1', '1494750016', '0', '1', '提示：字段编辑成功<br/>模块：Admin,控制器：Model,方法：field<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('1416', '1', '1494749892', '0', '1', '提示：字段编辑成功<br/>模块：Admin,控制器：Model,方法：field<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('1415', '1', '1494749812', '0', '1', '提示：字段编辑成功<br/>模块：Admin,控制器：Model,方法：field<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/8.html');
INSERT INTO `hi_log_admin` VALUES ('1414', '1', '1494749615', '0', '1', '提示：字段编辑成功<br/>模块：Admin,控制器：Model,方法：field<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1413', '1', '1494568137', '0', '1', '提示：字段编辑成功<br/>模块：Admin,控制器：Model,方法：field<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1412', '1', '1494568072', '0', '1', '提示：字段编辑成功<br/>模块：Admin,控制器：Model,方法：field<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1411', '1', '1494567989', '0', '1', '提示：字段编辑成功<br/>模块：Admin,控制器：Model,方法：field<br/>请求方式：Ajax', 'http://localhost/Admin/Model/field/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('1410', '1', '1494558202', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Article/index/p/3.html');
INSERT INTO `hi_log_admin` VALUES ('1409', '1', '1494558188', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1408', '1', '1494558181', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1407', '1', '1494558174', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1406', '1', '1494558169', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1405', '1', '1494558165', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1404', '1', '1494556776', '0', '1', '提示：栏目修改成功！<br/>模块：Admin,控制器：Category,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Category/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1403', '1', '1494556769', '0', '1', '提示：栏目修改成功！<br/>模块：Admin,控制器：Category,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Category/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1402', '1', '1494556765', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1401', '1', '1494556764', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1400', '1', '1494556759', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1399', '1', '1494556758', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1398', '1', '1494556758', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1397', '1', '1494556756', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1396', '1', '1494490715', '0', '1', '提示：生成模型成功！<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1395', '1', '1494490563', '0', '0', '提示：<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1394', '1', '1494490545', '0', '0', '提示：<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1393', '1', '1494424211', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/1.html');
INSERT INTO `hi_log_admin` VALUES ('1392', '1', '1494424211', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/1.html');
INSERT INTO `hi_log_admin` VALUES ('1391', '1', '1494424211', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/1.html');
INSERT INTO `hi_log_admin` VALUES ('1390', '1', '1494424210', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/1.html');
INSERT INTO `hi_log_admin` VALUES ('1389', '1', '1494424209', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Model,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Model/fields/model/1.html');
INSERT INTO `hi_log_admin` VALUES ('1388', '1', '1494421774', '0', '1', '提示：模型编辑成功<br/>模块：Admin,控制器：Model,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Model/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1387', '1', '1494405072', '0', '0', '提示：<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1386', '1', '1494405048', '0', '0', '提示：<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1385', '1', '1494404923', '0', '0', '提示：<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1384', '1', '1494404921', '0', '0', '提示：模型名称已经存在<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1383', '1', '1494404622', '0', '1', '提示：生成模型成功！<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1382', '1', '1494404618', '0', '0', '提示：模型数据表已经存在<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1381', '1', '1494404531', '0', '1', '提示：生成模型成功！<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1380', '1', '1494404506', '0', '1', '提示：模型编辑成功<br/>模块：Admin,控制器：Model,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Model/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1379', '1', '1494403396', '0', '1', '提示：模型编辑成功<br/>模块：Admin,控制器：Model,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Model/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1378', '1', '1494403341', '0', '1', '提示：生成模型成功！<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1377', '1', '1494403247', '0', '1', '提示：生成模型成功！<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1376', '1', '1494402990', '0', '1', '提示：生成模型成功！<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1375', '1', '1494402959', '0', '0', '提示：<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1374', '1', '1494402949', '0', '0', '提示：<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1373', '1', '1494395304', '0', '0', '提示：<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1372', '1', '1494395259', '0', '0', '提示：<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1371', '1', '1494395211', '0', '0', '提示：<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1370', '1', '1494395188', '0', '0', '提示：<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1369', '1', '1494395176', '0', '0', '提示：<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1368', '1', '1494395154', '0', '0', '提示：<br/>模块：Admin,控制器：Model,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Model/build/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1367', '1', '1494315161', '0', '1', '提示：模型编辑成功<br/>模块：Admin,控制器：Model,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Model/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1366', '1', '1494314139', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1365', '1', '1494314004', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1364', '1', '1494313872', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1363', '1', '1494313847', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1362', '1', '1494313830', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1361', '1', '1494313742', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1360', '1', '1494313685', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1359', '1', '1494313668', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1358', '1', '1494313611', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1357', '1', '1494313578', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1356', '1', '1494313531', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1355', '1', '1494311586', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1354', '1', '1494311534', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1353', '1', '1494311469', '0', '0', '提示：请选择推荐位！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1352', '1', '1494311328', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1351', '1', '1494311306', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1350', '1', '1494311187', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1349', '1', '1494311159', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1348', '1', '1494311116', '0', '0', '提示：信息推荐失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：position<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/position.html');
INSERT INTO `hi_log_admin` VALUES ('1347', '1', '1494307532', '0', '1', '提示：添加推荐位成功<br/>模块：Admin,控制器：Position,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Position/add.html');
INSERT INTO `hi_log_admin` VALUES ('1346', '1', '1494307498', '0', '1', '提示：添加推荐位成功<br/>模块：Admin,控制器：Position,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Position/add.html');
INSERT INTO `hi_log_admin` VALUES ('1345', '1', '1494307468', '0', '1', '提示：推荐位编辑成功<br/>模块：Admin,控制器：Position,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Position/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1344', '1', '1494307450', '0', '1', '提示：添加推荐位成功<br/>模块：Admin,控制器：Position,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Position/add.html');
INSERT INTO `hi_log_admin` VALUES ('1343', '1', '1494249722', '0', '1', '提示：用户已强退！<br/>模块：Admin,控制器：Ajax,方法：kickuser<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1342', '1', '1494249586', '0', '1', '提示：用户已强退！<br/>模块：Admin,控制器：Ajax,方法：kickuser<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1341', '1', '1494249475', '0', '1', '提示：用户已强退！<br/>模块：Admin,控制器：Ajax,方法：kickuser<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1340', '1', '1494249403', '0', '1', '提示：用户已强退！<br/>模块：Admin,控制器：Ajax,方法：kickuser<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1339', '1', '1494249359', '0', '1', '提示：用户已强退！<br/>模块：Admin,控制器：Ajax,方法：kickuser<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1338', '1', '1494249353', '0', '0', '提示：用户强退失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：kickuser<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1337', '1', '1494249350', '0', '0', '提示：用户强退失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：kickuser<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1336', '1', '1494249343', '0', '0', '提示：用户强退失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：kickuser<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1335', '1', '1494249329', '0', '0', '提示：用户强退失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：kickuser<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1334', '1', '1494249328', '0', '0', '提示：用户强退失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：kickuser<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1333', '1', '1494248412', '0', '0', '提示：点错了！<br/>模块：Admin,控制器：Member,方法：getout<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1332', '1', '1494245448', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1331', '1', '1494245307', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1330', '1', '1494245303', '0', '0', '提示：请选择栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1329', '1', '1494245191', '0', '0', '提示：信息移动失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1328', '1', '1494244820', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1327', '1', '1494235749', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1326', '1', '1494235746', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1325', '1', '1494235745', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1324', '1', '1494235744', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1323', '1', '1494235741', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1322', '1', '1494235739', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1321', '1', '1494235736', '0', '0', '提示：请选择栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1320', '1', '1494235410', '0', '1', '提示：删除成功！<br/>模块：Admin,控制器：Article,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1319', '1', '1494235341', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1318', '1', '1494235318', '0', '0', '提示：请输入原密码<br/>模块：Admin,控制器：My,方法：password<br/>请求方式：Ajax', 'http://localhost/Admin/my/password.html');
INSERT INTO `hi_log_admin` VALUES ('1317', '1', '1494235313', '0', '0', '提示：请输入原密码<br/>模块：Admin,控制器：My,方法：password<br/>请求方式：Ajax', 'http://localhost/Admin/my/password.html');
INSERT INTO `hi_log_admin` VALUES ('1316', '1', '1494235307', '0', '0', '提示：请输入原密码<br/>模块：Admin,控制器：My,方法：password<br/>请求方式：Ajax', 'http://localhost/Admin/my/password.html');
INSERT INTO `hi_log_admin` VALUES ('1315', '1', '1494235078', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1314', '1', '1494235004', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1313', '1', '1494234764', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1312', '1', '1494234729', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1311', '1', '1494234683', '0', '0', '提示：移动的栏目和当前文章模型不一致！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1310', '1', '1494234676', '0', '0', '提示：移动的栏目和当前文章模型不一致！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1309', '1', '1494234674', '0', '0', '提示：移动的栏目和当前文章模型不一致！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1308', '1', '1494234672', '0', '0', '提示：移动的栏目和当前文章模型不一致！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1307', '1', '1494234670', '0', '0', '提示：移动的栏目和当前文章模型不一致！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1306', '1', '1494234602', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1305', '1', '1494234566', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1304', '1', '1494234565', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1303', '1', '1494234562', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1302', '1', '1494234502', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1301', '1', '1494234485', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1300', '1', '1494234467', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1299', '1', '1494234464', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1298', '1', '1494234463', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1297', '1', '1494234460', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1296', '1', '1494234456', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1295', '1', '1494234446', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1294', '1', '1494234222', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1293', '1', '1494233866', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1292', '1', '1494233817', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1291', '1', '1494233162', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1290', '1', '1494233159', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1289', '1', '1494232534', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1288', '1', '1494232532', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1287', '1', '1494232518', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1286', '1', '1494232513', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1285', '1', '1494232504', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1284', '1', '1494232235', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1283', '1', '1494232233', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1282', '1', '1494232218', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1281', '1', '1494231924', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1280', '1', '1494231920', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1279', '1', '1494231917', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1278', '1', '1494229427', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1277', '1', '1494229304', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1276', '1', '1494228306', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1275', '1', '1494223232', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1274', '1', '1494223204', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1273', '1', '1494223201', '0', '0', '提示：信息移动失败,请稍后再试！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1272', '1', '1494223142', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1271', '1', '1494223030', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1270', '1', '1494222941', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1269', '1', '1494222579', '0', '1', '提示：信息移动成功！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1268', '1', '1494222549', '0', '0', '提示：移动的栏目和当前文章模型不一致！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1267', '1', '1494222525', '0', '0', '提示：移动的栏目和当前文章模型不一致！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1266', '1', '1494222521', '0', '0', '提示：移动的栏目和当前文章模型不一致！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1265', '1', '1494222518', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1264', '1', '1494222452', '0', '0', '提示：当前栏目不允许发布当前信息<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1263', '1', '1494222401', '0', '0', '提示：移动的栏目和当前文章模型不一致！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1262', '1', '1494222399', '0', '0', '提示：移动的栏目和当前文章模型不一致！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1261', '1', '1494222397', '0', '0', '提示：移动的栏目和当前文章模型不一致！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1260', '1', '1494222378', '0', '0', '提示：移动的栏目和当前文章模型不一致！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1259', '1', '1494222344', '0', '0', '提示：移动的栏目和当前文章模型不一致！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1258', '1', '1494221618', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1257', '1', '1494221605', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1256', '1', '1494221603', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1255', '1', '1494221595', '0', '0', '提示：请选择栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1254', '1', '1494221206', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1253', '1', '1494221201', '0', '0', '提示：请选择栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1252', '1', '1494221148', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1251', '1', '1494221097', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1250', '1', '1494221095', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1249', '1', '1494221090', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1248', '1', '1494220631', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1247', '1', '1494220629', '0', '0', '提示：请选择子栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1246', '1', '1494220626', '0', '0', '提示：请选择栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1245', '1', '1494220605', '0', '0', '提示：请选择栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1244', '1', '1494220603', '0', '0', '提示：请选择栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1243', '1', '1494220575', '0', '0', '提示：请选择栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1242', '1', '1494220461', '0', '0', '提示：请选择栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1241', '1', '1494220338', '0', '0', '提示：请选择栏目！<br/>模块：Admin,控制器：Ajax,方法：move<br/>请求方式：POST', 'http://localhost/Admin/ajax/move.html');
INSERT INTO `hi_log_admin` VALUES ('1240', '1', '1494143900', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1239', '1', '1494143888', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1238', '1', '1494143822', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1237', '1', '1494143753', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1236', '1', '1494143734', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1235', '1', '1494143673', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1234', '1', '1494143460', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1233', '1', '1494143435', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1232', '1', '1494140079', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1231', '1', '1494139861', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1230', '1', '1494139832', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1229', '1', '1494139816', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1228', '1', '1494139645', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1227', '1', '1494139627', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1226', '1', '1494139107', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1225', '1', '1494133934', '0', '0', '提示：请选择要移动的文档！<br/>模块：Admin,控制器：Article,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1224', '1', '1494124341', '0', '1', '提示：操作成功！<br/>模块：Admin,控制器：Position,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/position/index.html');
INSERT INTO `hi_log_admin` VALUES ('1223', '1', '1494079192', '0', '1', '提示：启用成功<br/>模块：Admin,控制器：Article,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Article/index/p/2.html');
INSERT INTO `hi_log_admin` VALUES ('1222', '1', '1494079159', '0', '0', '提示：请选择要移动的文档！<br/>模块：Admin,控制器：Article,方法：move<br/>请求方式：Ajax', 'http://localhost/Admin/Article/index/p/2.html');
INSERT INTO `hi_log_admin` VALUES ('1221', '1', '1494079050', '0', '0', '提示：请选择要操作的数据<br/>模块：Admin,控制器：Article,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Article/index/p/2.html');
INSERT INTO `hi_log_admin` VALUES ('1220', '1', '1494079025', '0', '0', '提示：请选择要操作的数据<br/>模块：Admin,控制器：Article,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Article/index/p/2.html');
INSERT INTO `hi_log_admin` VALUES ('1219', '1', '1494079018', '0', '0', '提示：请选择要操作的数据<br/>模块：Admin,控制器：Article,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Article/index/p/2.html');
INSERT INTO `hi_log_admin` VALUES ('1218', '1', '1494078906', '0', '1', '提示：启用成功<br/>模块：Admin,控制器：Article,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1217', '1', '1494078896', '0', '0', '提示：请选择要操作的数据<br/>模块：Admin,控制器：Article,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1216', '1', '1494078865', '0', '0', '提示：请选择要操作的数据<br/>模块：Admin,控制器：Article,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1215', '1', '1494078759', '0', '0', '提示：请选择要操作的数据<br/>模块：Admin,控制器：Article,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1214', '1', '1494078753', '0', '0', '提示：请选择要操作的数据<br/>模块：Admin,控制器：Article,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1213', '1', '1494077353', '0', '1', '提示：操作成功！<br/>模块：Admin,控制器：Position,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Position/index.html');
INSERT INTO `hi_log_admin` VALUES ('1212', '1', '1494077346', '0', '1', '提示：操作成功！<br/>模块：Admin,控制器：Position,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Position/index.html');
INSERT INTO `hi_log_admin` VALUES ('1211', '1', '1494076955', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Position,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Position/index/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1210', '1', '1494076951', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Position,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Position/index/model/2.html');
INSERT INTO `hi_log_admin` VALUES ('1209', '1', '1494076718', '0', '1', '提示：推荐位编辑成功<br/>模块：Admin,控制器：Position,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Position/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1208', '1', '1494075848', '0', '1', '提示：添加推荐位成功<br/>模块：Admin,控制器：Position,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Position/add.html');
INSERT INTO `hi_log_admin` VALUES ('1207', '1', '1494075531', '0', '0', '提示：请选择模型<br/>模块：Admin,控制器：Position,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Position/add.html');
INSERT INTO `hi_log_admin` VALUES ('1206', '1', '1494075525', '0', '0', '提示：请选择模型<br/>模块：Admin,控制器：Position,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Position/add.html');
INSERT INTO `hi_log_admin` VALUES ('1205', '1', '1494075507', '0', '0', '提示：请选择模型<br/>模块：Admin,控制器：Position,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Position/add.html');
INSERT INTO `hi_log_admin` VALUES ('1204', '1', '1494075497', '0', '0', '提示：推荐位名称必须填写<br/>模块：Admin,控制器：Position,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Position/add.html');
INSERT INTO `hi_log_admin` VALUES ('1203', '1', '1494075469', '0', '0', '提示：文章标题不能为空<br/>模块：Admin,控制器：Position,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Position/add.html');
INSERT INTO `hi_log_admin` VALUES ('1202', '1', '1493990035', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/38.html');
INSERT INTO `hi_log_admin` VALUES ('1201', '1', '1493989569', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/2/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1200', '1', '1493974626', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Linkage,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/linkage/index.html');
INSERT INTO `hi_log_admin` VALUES ('1199', '1', '1493974625', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Linkage,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/linkage/index.html');
INSERT INTO `hi_log_admin` VALUES ('1198', '1', '1493974426', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1197', '1', '1493973980', '0', '1', '提示：文章撒大发撒旦法师打发斯蒂芬编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/26.html');
INSERT INTO `hi_log_admin` VALUES ('1196', '1', '1493973940', '0', '1', '提示：文章撒大发撒旦法师打发斯蒂芬发布成功<br/>模块：Admin,控制器：Article,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Article/add/catid/27.html');
INSERT INTO `hi_log_admin` VALUES ('1195', '1', '1493973915', '0', '1', '提示：文章文章标题2编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('1194', '1', '1493973873', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('1193', '1', '1493973815', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/23.html');
INSERT INTO `hi_log_admin` VALUES ('1192', '1', '1493973039', '0', '0', '提示：更新失败<br/>模块：Admin,控制器：Article,方法：page<br/>请求方式：Ajax', 'http://localhost/Admin/article/index/catid/268.html');
INSERT INTO `hi_log_admin` VALUES ('1191', '1', '1493973034', '0', '0', '提示：更新失败<br/>模块：Admin,控制器：Article,方法：page<br/>请求方式：Ajax', 'http://localhost/Admin/article/index/catid/268.html');
INSERT INTO `hi_log_admin` VALUES ('1190', '1', '1493971202', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/12.html');
INSERT INTO `hi_log_admin` VALUES ('1189', '1', '1493971182', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Config,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Config/index/group/4.html');
INSERT INTO `hi_log_admin` VALUES ('1188', '1', '1493971177', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/12.html');
INSERT INTO `hi_log_admin` VALUES ('1187', '1', '1493971063', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Config,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Config/index/group/4.html');
INSERT INTO `hi_log_admin` VALUES ('1186', '1', '1493970955', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/23.html');
INSERT INTO `hi_log_admin` VALUES ('1185', '1', '1493970240', '0', '1', '提示：更新海工设备成功<br/>模块：Admin,控制器：Article,方法：page<br/>请求方式：Ajax', 'http://localhost/Admin/article/index/catid/268.html');
INSERT INTO `hi_log_admin` VALUES ('1184', '1', '1493970218', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1183', '1', '1493967222', '0', '1', '提示：定时任务生成成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1182', '1', '1493967204', '0', '1', '提示：定时任务生成成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1181', '1', '1493967070', '0', '1', '提示：定时任务生成成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1180', '1', '1493966862', '0', '1', '提示：定时任务生成成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1179', '1', '1493966814', '0', '1', '提示：定时任务生成成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1178', '1', '1493966810', '0', '1', '提示：定时任务生成成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1177', '1', '1493966277', '0', '1', '提示：更新海工设备成功<br/>模块：Admin,控制器：Article,方法：page<br/>请求方式：Ajax', 'http://localhost/Admin/article/index/catid/268.html');
INSERT INTO `hi_log_admin` VALUES ('1176', '1', '1493966201', '0', '1', '提示：更新海工设备成功<br/>模块：Admin,控制器：Article,方法：page<br/>请求方式：Ajax', 'http://localhost/Admin/article/index/catid/268.html');
INSERT INTO `hi_log_admin` VALUES ('1175', '1', '1493964134', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('1174', '1', '1493964123', '0', '1', '提示：栏目修改成功！<br/>模块：Admin,控制器：Category,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Category/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('788', '1', '1492658999', '0', '1', '提示：联动菜单添加成功<br/>模块：Admin,控制器：Linkage,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/add/pid/0/type/2.html');
INSERT INTO `hi_log_admin` VALUES ('789', '1', '1492659023', '0', '1', '提示：联动菜单添加成功<br/>模块：Admin,控制器：Linkage,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/add/pid/7/type/2.html');
INSERT INTO `hi_log_admin` VALUES ('790', '1', '1492659036', '0', '1', '提示：联动菜单添加成功<br/>模块：Admin,控制器：Linkage,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/add/pid/7/type/2.html');
INSERT INTO `hi_log_admin` VALUES ('791', '1', '1492664697', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('792', '1', '1492664778', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/13.html');
INSERT INTO `hi_log_admin` VALUES ('793', '1', '1492664961', '0', '1', '提示：配置添加成功<br/>模块：Admin,控制器：Config,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Config/add.html');
INSERT INTO `hi_log_admin` VALUES ('794', '1', '1492664974', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/21.html');
INSERT INTO `hi_log_admin` VALUES ('795', '1', '1492665275', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('796', '1', '1492665356', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('797', '1', '1492665574', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('798', '1', '1492665584', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('799', '1', '1492665706', '0', '1', '提示：配置添加成功<br/>模块：Admin,控制器：Config,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Config/add.html');
INSERT INTO `hi_log_admin` VALUES ('800', '1', '1492665756', '0', '1', '提示：操作成功！<br/>模块：Admin,控制器：Config,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Config/index/group/5.html');
INSERT INTO `hi_log_admin` VALUES ('801', '1', '1492665767', '0', '1', '提示：操作成功！<br/>模块：Admin,控制器：Config,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Config/index/group/5.html');
INSERT INTO `hi_log_admin` VALUES ('802', '1', '1492665778', '0', '1', '提示：操作成功！<br/>模块：Admin,控制器：Config,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Config/index/group/5.html');
INSERT INTO `hi_log_admin` VALUES ('803', '1', '1492665901', '0', '1', '提示：配置添加成功<br/>模块：Admin,控制器：Config,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Config/add.html');
INSERT INTO `hi_log_admin` VALUES ('804', '1', '1492665972', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/22.html');
INSERT INTO `hi_log_admin` VALUES ('805', '1', '1492666266', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('806', '1', '1492666303', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('807', '1', '1492666524', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('808', '1', '1492666538', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/14.html');
INSERT INTO `hi_log_admin` VALUES ('809', '1', '1492666848', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('810', '1', '1492666853', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('811', '1', '1492666860', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('812', '1', '1492666870', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('813', '1', '1492667027', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('814', '1', '1492667068', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('815', '1', '1492667081', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('816', '1', '1492667101', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('817', '1', '1492667151', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('818', '1', '1492667161', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/5.html');
INSERT INTO `hi_log_admin` VALUES ('819', '1', '1492667183', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('820', '1', '1492667216', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/5.html');
INSERT INTO `hi_log_admin` VALUES ('821', '1', '1492667873', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/19.html');
INSERT INTO `hi_log_admin` VALUES ('822', '1', '1492667942', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('823', '1', '1492668005', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('824', '1', '1492668134', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('825', '1', '1492668292', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('826', '1', '1492668334', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('827', '1', '1492668385', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('828', '1', '1492668394', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('829', '1', '1492668440', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('830', '1', '1492668468', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('831', '1', '1492668606', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('832', '1', '1492668721', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/19.html');
INSERT INTO `hi_log_admin` VALUES ('833', '1', '1492668728', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/17.html');
INSERT INTO `hi_log_admin` VALUES ('834', '1', '1492668795', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/config/group.html');
INSERT INTO `hi_log_admin` VALUES ('835', '1', '1492668803', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/config/group.html');
INSERT INTO `hi_log_admin` VALUES ('836', '1', '1492668833', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/config/group.html');
INSERT INTO `hi_log_admin` VALUES ('837', '1', '1492668839', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/config/group.html');
INSERT INTO `hi_log_admin` VALUES ('838', '1', '1492668887', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/config/group.html');
INSERT INTO `hi_log_admin` VALUES ('839', '1', '1492668965', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/config/group.html');
INSERT INTO `hi_log_admin` VALUES ('840', '1', '1492668998', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/config/group.html');
INSERT INTO `hi_log_admin` VALUES ('841', '1', '1492669493', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/config/group.html');
INSERT INTO `hi_log_admin` VALUES ('842', '1', '1492669745', '0', '1', '提示：配置添加成功<br/>模块：Admin,控制器：Config,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Config/add.html');
INSERT INTO `hi_log_admin` VALUES ('843', '1', '1492669760', '0', '1', '提示：操作成功！<br/>模块：Admin,控制器：Config,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Config/index/group/1.html');
INSERT INTO `hi_log_admin` VALUES ('844', '1', '1492669763', '0', '1', '提示：操作成功！<br/>模块：Admin,控制器：Config,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Config/index/group/1.html');
INSERT INTO `hi_log_admin` VALUES ('845', '1', '1492669799', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('846', '1', '1492669818', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('847', '1', '1492670049', '0', '1', '提示：配置添加成功<br/>模块：Admin,控制器：Config,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Config/add.html');
INSERT INTO `hi_log_admin` VALUES ('848', '1', '1492674428', '0', '0', '提示：参数有误！<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：GET', 'http://localhost/Admin/article/index/catid/27.html');
INSERT INTO `hi_log_admin` VALUES ('849', '1', '1492674828', '0', '0', '提示：参数有误！<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：GET', '/Admin/Article/edit/id/sdfasdf.html');
INSERT INTO `hi_log_admin` VALUES ('850', '1', '1492675849', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/22.html');
INSERT INTO `hi_log_admin` VALUES ('851', '1', '1492675864', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/22.html');
INSERT INTO `hi_log_admin` VALUES ('852', '1', '1492675915', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/22.html');
INSERT INTO `hi_log_admin` VALUES ('853', '1', '1492675949', '0', '0', '提示：标题已经存在<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/22.html');
INSERT INTO `hi_log_admin` VALUES ('854', '1', '1492675954', '0', '0', '提示：标题已经存在<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/22.html');
INSERT INTO `hi_log_admin` VALUES ('855', '1', '1492675959', '0', '0', '提示：标题已经存在<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/22.html');
INSERT INTO `hi_log_admin` VALUES ('856', '1', '1492675962', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/22.html');
INSERT INTO `hi_log_admin` VALUES ('857', '1', '1492691184', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('858', '1', '1492691185', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('859', '1', '1492691192', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('860', '1', '1492691193', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('861', '1', '1492691495', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('862', '1', '1492691496', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('863', '1', '1492691929', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('864', '1', '1492691930', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Category,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('865', '1', '1492692541', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/23.html');
INSERT INTO `hi_log_admin` VALUES ('866', '1', '1492692549', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/22.html');
INSERT INTO `hi_log_admin` VALUES ('867', '1', '1492694154', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/5.html');
INSERT INTO `hi_log_admin` VALUES ('868', '1', '1492694557', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/5.html');
INSERT INTO `hi_log_admin` VALUES ('869', '1', '1492739037', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('870', '1', '1492751888', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/0/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('871', '1', '1492751951', '0', '1', '提示：联动菜单添加成功<br/>模块：Admin,控制器：Linkage,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/add/pid/0/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('872', '1', '1492751964', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/10.html');
INSERT INTO `hi_log_admin` VALUES ('873', '1', '1492752078', '0', '1', '提示：联动菜单添加成功<br/>模块：Admin,控制器：Linkage,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/add/pid/10/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('874', '1', '1492752088', '0', '1', '提示：联动菜单添加成功<br/>模块：Admin,控制器：Linkage,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/add/pid/10/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('875', '1', '1492752946', '0', '1', '提示：禁用成功<br/>模块：Admin,控制器：Model,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Model/index/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('876', '1', '1492752950', '0', '1', '提示：启用成功<br/>模块：Admin,控制器：Model,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Model/index/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('877', '1', '1492754762', '0', '1', '提示：模型编辑成功<br/>模块：Admin,控制器：Model,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Model/edit/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('878', '1', '1492754769', '0', '1', '提示：模型编辑成功<br/>模块：Admin,控制器：Model,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Model/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('879', '1', '1492754776', '0', '1', '提示：模型编辑成功<br/>模块：Admin,控制器：Model,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Model/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('880', '1', '1492756267', '0', '1', '提示：添加模型成功<br/>模块：Admin,控制器：Model,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Model/add/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('881', '1', '1492756687', '0', '1', '提示：栏目修改成功！<br/>模块：Admin,控制器：Category,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Category/edit/id/268.html');
INSERT INTO `hi_log_admin` VALUES ('882', '1', '1492761011', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/12.html');
INSERT INTO `hi_log_admin` VALUES ('883', '1', '1492761021', '0', '1', '提示：联动菜单添加成功<br/>模块：Admin,控制器：Linkage,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/add/pid/10/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('884', '1', '1492761044', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/10.html');
INSERT INTO `hi_log_admin` VALUES ('885', '1', '1492762261', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('886', '1', '1492782232', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/17.html');
INSERT INTO `hi_log_admin` VALUES ('887', '1', '1492782275', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/17.html');
INSERT INTO `hi_log_admin` VALUES ('888', '1', '1492782366', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/23.html');
INSERT INTO `hi_log_admin` VALUES ('889', '1', '1492782384', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/23.html');
INSERT INTO `hi_log_admin` VALUES ('890', '1', '1492782452', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/23.html');
INSERT INTO `hi_log_admin` VALUES ('891', '1', '1492782595', '0', '0', '提示：栏目不能为空<br/>模块：Admin,控制器：Article,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Article/add.html');
INSERT INTO `hi_log_admin` VALUES ('892', '1', '1492782600', '0', '1', '提示：文章发布成功<br/>模块：Admin,控制器：Article,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Article/add.html');
INSERT INTO `hi_log_admin` VALUES ('893', '1', '1492782677', '0', '1', '提示：文章发布成功<br/>模块：Admin,控制器：Article,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Article/add.html');
INSERT INTO `hi_log_admin` VALUES ('894', '1', '1492782708', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/25.html');
INSERT INTO `hi_log_admin` VALUES ('895', '1', '1492782803', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/25.html');
INSERT INTO `hi_log_admin` VALUES ('896', '1', '1492783971', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/25.html');
INSERT INTO `hi_log_admin` VALUES ('897', '1', '1492784132', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/25.html');
INSERT INTO `hi_log_admin` VALUES ('898', '1', '1492784243', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('899', '1', '1492784258', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('900', '1', '1492784479', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('901', '1', '1492784690', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/25.html');
INSERT INTO `hi_log_admin` VALUES ('902', '1', '1492786603', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/25.html');
INSERT INTO `hi_log_admin` VALUES ('903', '1', '1492786617', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('904', '1', '1492786654', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('905', '1', '1492838322', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/25.html');
INSERT INTO `hi_log_admin` VALUES ('906', '1', '1492838378', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/11.html');
INSERT INTO `hi_log_admin` VALUES ('907', '1', '1492838426', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/25.html');
INSERT INTO `hi_log_admin` VALUES ('908', '1', '1492838960', '0', '0', '提示：文章内容不能为空<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/12.html');
INSERT INTO `hi_log_admin` VALUES ('909', '1', '1492838968', '0', '0', '提示：文章内容不能为空<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/12.html');
INSERT INTO `hi_log_admin` VALUES ('910', '1', '1492838970', '0', '0', '提示：文章内容不能为空<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/12.html');
INSERT INTO `hi_log_admin` VALUES ('911', '1', '1492838974', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/12.html');
INSERT INTO `hi_log_admin` VALUES ('912', '1', '1492839027', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('913', '1', '1492839111', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/11.html');
INSERT INTO `hi_log_admin` VALUES ('914', '1', '1492839179', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/11.html');
INSERT INTO `hi_log_admin` VALUES ('915', '1', '1492839218', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/11.html');
INSERT INTO `hi_log_admin` VALUES ('916', '1', '1492839329', '0', '1', '提示：栏目数据更新成功！<br/>模块：Admin,控制器：Category,方法：dorepair<br/>请求方式：Ajax', 'http://localhost/Admin/category/index.html');
INSERT INTO `hi_log_admin` VALUES ('917', '1', '1492839531', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/13.html');
INSERT INTO `hi_log_admin` VALUES ('918', '1', '1492840146', '0', '1', '提示：操作成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('919', '1', '1492840462', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('920', '1', '1492840463', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('921', '1', '1492841025', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('922', '1', '1492841042', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('923', '1', '1492841356', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/17.html');
INSERT INTO `hi_log_admin` VALUES ('924', '1', '1492841418', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('925', '1', '1492842570', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('926', '1', '1492842902', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('927', '1', '1492842962', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('928', '1', '1492843061', '0', '0', '提示：该栏目不允许发布内容<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('929', '1', '1492843086', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('930', '1', '1492843158', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('931', '1', '1492843263', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('932', '1', '1492843265', '0', '0', '提示：链接地址格式不正确<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('933', '1', '1492843272', '0', '0', '提示：链接地址格式不正确<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('934', '1', '1492843275', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('935', '1', '1492850398', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/23.html');
INSERT INTO `hi_log_admin` VALUES ('936', '1', '1492850404', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/23.html');
INSERT INTO `hi_log_admin` VALUES ('937', '1', '1492850462', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/23.html');
INSERT INTO `hi_log_admin` VALUES ('938', '1', '1492850471', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/25.html');
INSERT INTO `hi_log_admin` VALUES ('939', '1', '1492850492', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/25.html');
INSERT INTO `hi_log_admin` VALUES ('940', '1', '1492850515', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/25.html');
INSERT INTO `hi_log_admin` VALUES ('941', '1', '1493125627', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/21.html');
INSERT INTO `hi_log_admin` VALUES ('942', '1', '1493125634', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('943', '1', '1493125723', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/24/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('944', '1', '1493125756', '0', '1', '提示：操作成功！<br/>模块：Admin,控制器：Menu,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/index/pid/24/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('945', '1', '1493125765', '0', '1', '提示：操作成功！<br/>模块：Admin,控制器：Menu,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/index/pid/24/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('946', '1', '1493125771', '0', '1', '提示：操作成功！<br/>模块：Admin,控制器：Menu,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/index/pid/24/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('947', '1', '1493125775', '0', '1', '提示：操作成功！<br/>模块：Admin,控制器：Menu,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/index/pid/24/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('948', '1', '1493125798', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('949', '1', '1493127185', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/31/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('950', '1', '1493127200', '0', '0', '提示：请输入广告链接！<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add.html');
INSERT INTO `hi_log_admin` VALUES ('951', '1', '1493127202', '0', '0', '提示：请输入广告链接！<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add.html');
INSERT INTO `hi_log_admin` VALUES ('952', '1', '1493127313', '0', '0', '提示：请输入广告链接！<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add.html');
INSERT INTO `hi_log_admin` VALUES ('953', '1', '1493127472', '0', '0', '提示：广告位名称不能为空<br/>模块：Admin,控制器：Ad,方法：pos<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/pos.html');
INSERT INTO `hi_log_admin` VALUES ('954', '1', '1493127581', '0', '0', '提示：广告位名称不能为空<br/>模块：Admin,控制器：Ad,方法：pos<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/pos.html');
INSERT INTO `hi_log_admin` VALUES ('955', '1', '1493127655', '0', '0', '提示：请选择要操作的数据!<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('956', '1', '1493127692', '0', '0', '提示：广告位名称不能为空<br/>模块：Admin,控制器：Ad,方法：pos<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/pos.html');
INSERT INTO `hi_log_admin` VALUES ('957', '1', '1493127720', '0', '0', '提示：广告位名称不能为空<br/>模块：Admin,控制器：Ad,方法：pos<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/pos.html');
INSERT INTO `hi_log_admin` VALUES ('958', '1', '1493127747', '0', '1', '提示：菜单更新成功<br/>模块：Admin,控制器：Menu,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/edit/id/32.html');
INSERT INTO `hi_log_admin` VALUES ('959', '1', '1493128118', '0', '1', '提示：禁用成功<br/>模块：Admin,控制器：Auth,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/auth/index.html');
INSERT INTO `hi_log_admin` VALUES ('960', '1', '1493128123', '0', '1', '提示：启用成功<br/>模块：Admin,控制器：Auth,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/auth/index.html');
INSERT INTO `hi_log_admin` VALUES ('961', '1', '1493128319', '0', '1', '提示：编辑成功<br/>模块：Admin,控制器：Ad,方法：editpos<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/editpos/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('962', '1', '1493128424', '0', '1', '提示：禁用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('963', '1', '1493128524', '0', '1', '提示：禁用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('964', '1', '1493128529', '0', '1', '提示：启用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('965', '1', '1493128537', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('966', '1', '1493209889', '0', '1', '提示：广告位编辑成功<br/>模块：Admin,控制器：Ad,方法：editpos<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/editpos/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('967', '1', '1493210668', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/31/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('968', '1', '1493213587', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/31/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('969', '1', '1493213620', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/31/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('970', '1', '1493213642', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/31/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('971', '1', '1493213653', '0', '0', '提示：请输入广告链接！<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/2.html');
INSERT INTO `hi_log_admin` VALUES ('972', '1', '1493214916', '0', '0', '提示：请输入广告链接！<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('973', '1', '1493256041', '0', '0', '提示：请输入广告链接！<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('974', '1', '1493256103', '0', '0', '提示：广告位名称不能为空<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('975', '1', '1493256847', '0', '0', '提示：广告位名称不能为空<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('976', '1', '1493256851', '0', '0', '提示：网站链接格式不正确<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('977', '1', '1493256893', '0', '0', '提示：广告链接格式不正确<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('978', '1', '1493257960', '0', '0', '提示：广告链接格式不正确<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('979', '1', '1493258135', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('980', '1', '1493258144', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('981', '1', '1493258206', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('982', '1', '1493258527', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('983', '1', '1493258532', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('984', '1', '1493258542', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('985', '1', '1493258553', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('986', '1', '1493258580', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('987', '1', '1493258713', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('988', '1', '1493258756', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('989', '1', '1493258791', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('990', '1', '1493258803', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('991', '1', '1493258941', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('992', '1', '1493258946', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('993', '1', '1493259125', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('994', '1', '1493259128', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('995', '1', '1493259149', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('996', '1', '1493259151', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('997', '1', '1493259172', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('998', '1', '1493259203', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('999', '1', '1493259305', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1000', '1', '1493259360', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1001', '1', '1493259391', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1002', '1', '1493259408', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1003', '1', '1493259463', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1004', '1', '1493259530', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1005', '1', '1493259535', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1006', '1', '1493259964', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1007', '1', '1493259967', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1008', '1', '1493259973', '0', '0', '提示：链接地址格式不正确<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1009', '1', '1493259978', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1010', '1', '1493260192', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1011', '1', '1493260206', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1012', '1', '1493260209', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1013', '1', '1493260634', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1014', '1', '1493260816', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1015', '1', '1493260826', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1016', '1', '1493260832', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1017', '1', '1493260922', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1018', '1', '1493260924', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1019', '1', '1493260982', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/25.html');
INSERT INTO `hi_log_admin` VALUES ('1020', '1', '1493272576', '0', '0', '提示：请填写URL地址<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1021', '1', '1493272581', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/24.html');
INSERT INTO `hi_log_admin` VALUES ('1022', '1', '1493274165', '0', '0', '提示：广告位名称不能为空<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('1023', '1', '1493274268', '0', '0', '提示：广告位名称不能为空<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('1024', '1', '1493274432', '0', '0', '提示：广告名称不能为空<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('1025', '1', '1493274971', '0', '1', '提示：联动菜单添加成功<br/>模块：Admin,控制器：Linkage,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/add/pid/10/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1026', '1', '1493275051', '0', '1', '提示：添加模型成功<br/>模块：Admin,控制器：Model,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Model/add/type/3.html');
INSERT INTO `hi_log_admin` VALUES ('1027', '1', '1493275071', '0', '1', '提示：联动菜单编辑成功<br/>模块：Admin,控制器：Linkage,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Linkage/edit/id/10.html');
INSERT INTO `hi_log_admin` VALUES ('1028', '1', '1493275174', '0', '0', '提示：模型名称必须填写<br/>模块：Admin,控制器：Model,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Model/add/type/4.html');
INSERT INTO `hi_log_admin` VALUES ('1029', '1', '1493275225', '0', '1', '提示：模型编辑成功<br/>模块：Admin,控制器：Model,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Model/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1030', '1', '1493275264', '0', '0', '提示：广告名称不能为空<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('1031', '1', '1493275406', '0', '0', '提示：广告位名称不能为空<br/>模块：Admin,控制器：Ad,方法：pos<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/pos.html');
INSERT INTO `hi_log_admin` VALUES ('1032', '1', '1493275425', '0', '1', '提示：新增成功<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('1033', '1', '1493275608', '0', '1', '提示：添加广告成功<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('1034', '1', '1493284208', '0', '1', '提示：配置更新成功<br/>模块：Admin,控制器：Config,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Config/edit/id/7.html');
INSERT INTO `hi_log_admin` VALUES ('1035', '1', '1493294386', '0', '1', '提示：禁用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1036', '1', '1493294391', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1037', '1', '1493294393', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1038', '1', '1493294393', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1039', '1', '1493294782', '0', '1', '提示：编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1040', '1', '1493294798', '0', '0', '提示：请上传图片<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1041', '1', '1493294807', '0', '1', '提示：编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1042', '1', '1493294943', '0', '1', '提示：编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1043', '1', '1493294989', '0', '1', '提示：编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1044', '1', '1493295114', '0', '0', '提示：请选择要操作的数据<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1045', '1', '1493295353', '0', '1', '提示：编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1046', '1', '1493295554', '0', '0', '提示：请输入原密码<br/>模块：Admin,控制器：My,方法：password<br/>请求方式：Ajax', 'http://localhost/Admin/my/password.html');
INSERT INTO `hi_log_admin` VALUES ('1047', '1', '1493295863', '0', '0', '提示：请输入原密码<br/>模块：Admin,控制器：My,方法：password<br/>请求方式：Ajax', 'http://localhost/Admin/my/password.html');
INSERT INTO `hi_log_admin` VALUES ('1048', '1', '1493296024', '0', '1', '提示：编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1049', '1', '1493296044', '0', '1', '提示：编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1050', '1', '1493296069', '0', '0', '提示：请选择要操作的数据!<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1051', '1', '1493296141', '0', '1', '提示：禁用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1052', '1', '1493296156', '0', '1', '提示：启用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1053', '1', '1493296220', '0', '1', '提示：禁用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1054', '1', '1493296226', '0', '1', '提示：启用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1055', '1', '1493296266', '0', '0', '提示：请选择要操作的数据!<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1056', '1', '1493296364', '0', '0', '提示：请选择要操作的数据!<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1057', '1', '1493296367', '0', '0', '提示：请选择要操作的数据!<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1058', '1', '1493296397', '0', '0', '提示：请选择要操作的数据!<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1059', '1', '1493296432', '0', '1', '提示：删除成功！<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1060', '1', '1493296433', '0', '0', '提示：删除失败！<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1061', '1', '1493296439', '0', '0', '提示：删除失败！<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1062', '1', '1493296441', '0', '0', '提示：删除失败！<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1063', '1', '1493296442', '0', '0', '提示：删除失败！<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1064', '1', '1493296462', '0', '1', '提示：删除成功！<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1065', '1', '1493296549', '0', '1', '提示：Tag标签编辑成功<br/>模块：Admin,控制器：Tags,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Tags/edit/id/10.html');
INSERT INTO `hi_log_admin` VALUES ('1066', '1', '1493296574', '0', '0', '提示：删除失败！<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1067', '1', '1493296662', '0', '1', '提示：删除成功！<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1068', '1', '1493296719', '0', '1', '提示：启用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1069', '1', '1493296724', '0', '0', '提示：请选择要操作的数据<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1070', '1', '1493296730', '0', '1', '提示：启用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1071', '1', '1493296738', '0', '1', '提示：禁用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1072', '1', '1493296743', '0', '1', '提示：启用成功<br/>模块：Admin,控制器：Ad,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1073', '1', '1493296798', '0', '0', '提示：广告名称不能为空<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('1074', '1', '1493296848', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1075', '1', '1493296852', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1076', '1', '1493296858', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1077', '1', '1493296876', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1078', '1', '1493297163', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1079', '1', '1493297525', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1080', '1', '1493297530', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1081', '1', '1493297531', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1082', '1', '1493297551', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1083', '1', '1493297553', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1084', '1', '1493297631', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1085', '1', '1493297635', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1086', '1', '1493297643', '0', '0', '提示：操作失败！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1087', '1', '1493297712', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1088', '1', '1493297716', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Ad,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/ad/index.html');
INSERT INTO `hi_log_admin` VALUES ('1089', '1', '1493297723', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1090', '1', '1493297751', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1091', '1', '1493297759', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1092', '1', '1493297771', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/Article/index/p/3.html');
INSERT INTO `hi_log_admin` VALUES ('1093', '1', '1493298075', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Config,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/config/index.html');
INSERT INTO `hi_log_admin` VALUES ('1094', '1', '1493298079', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Config,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/config/index.html');
INSERT INTO `hi_log_admin` VALUES ('1095', '1', '1493298489', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('1096', '1', '1493298738', '0', '0', '提示：文章内容不能为空<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/12.html');
INSERT INTO `hi_log_admin` VALUES ('1097', '1', '1493298741', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/12.html');
INSERT INTO `hi_log_admin` VALUES ('1098', '1', '1493298760', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/9.html');
INSERT INTO `hi_log_admin` VALUES ('1099', '1', '1493298772', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/9.html');
INSERT INTO `hi_log_admin` VALUES ('1100', '1', '1493299245', '0', '1', '提示：添加广告成功<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('1101', '1', '1493299250', '0', '1', '提示：编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1102', '1', '1493299616', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1103', '1', '1493299658', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1104', '1', '1493299761', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1105', '1', '1493299810', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1106', '1', '1493300545', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1107', '1', '1493300556', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1108', '1', '1493300567', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1109', '1', '1493300855', '0', '1', '提示：添加广告成功<br/>模块：Admin,控制器：Ad,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/add/pos/1.html');
INSERT INTO `hi_log_admin` VALUES ('1110', '1', '1493300869', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1111', '1', '1493300884', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1112', '1', '1493301268', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1113', '1', '1493301283', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1114', '1', '1493301299', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1115', '1', '1493301363', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1116', '1', '1493301567', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1117', '1', '1493301589', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1118', '1', '1493301605', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/3.html');
INSERT INTO `hi_log_admin` VALUES ('1119', '1', '1493301622', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('1120', '1', '1493301683', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('1121', '1', '1493301799', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('1122', '1', '1493301820', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('1123', '1', '1493301903', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('1124', '1', '1493302149', '0', '0', '提示：图片展示方式必须上传logo<br/>模块：Admin,控制器：Link,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Link/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1125', '1', '1493302156', '0', '0', '提示：图片展示方式必须上传logo<br/>模块：Admin,控制器：Link,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Link/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1126', '1', '1493302164', '0', '0', '提示：图片展示方式必须上传logo<br/>模块：Admin,控制器：Link,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Link/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1127', '1', '1493302328', '0', '1', '提示：友情链接编辑成功<br/>模块：Admin,控制器：Link,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Link/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1128', '1', '1493302351', '0', '1', '提示：友情链接编辑成功<br/>模块：Admin,控制器：Link,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Link/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1129', '1', '1493302542', '0', '1', '提示：删除成功！<br/>模块：Admin,控制器：Tags,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/tags/index.html');
INSERT INTO `hi_log_admin` VALUES ('1130', '1', '1493369537', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/22.html');
INSERT INTO `hi_log_admin` VALUES ('1131', '1', '1493369565', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/23.html');
INSERT INTO `hi_log_admin` VALUES ('1132', '1', '1493369640', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/23.html');
INSERT INTO `hi_log_admin` VALUES ('1133', '1', '1493369660', '0', '1', '提示：删除成功！<br/>模块：Admin,控制器：Ad,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/postion/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1134', '1', '1493387468', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/23.html');
INSERT INTO `hi_log_admin` VALUES ('1135', '1', '1493388064', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/22.html');
INSERT INTO `hi_log_admin` VALUES ('1136', '1', '1493388113', '0', '1', '提示：标题可使用<br/>模块：Admin,控制器：Article,方法：unique<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/22.html');
INSERT INTO `hi_log_admin` VALUES ('1137', '1', '1493816761', '0', '1', '提示：广告编辑成功<br/>模块：Admin,控制器：Ad,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Ad/edit/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1138', '1', '1493816806', '0', '1', '提示：文章编辑成功<br/>模块：Admin,控制器：Article,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Article/edit/id/16.html');
INSERT INTO `hi_log_admin` VALUES ('1139', '1', '1493880354', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/Config/group/id/4.html');
INSERT INTO `hi_log_admin` VALUES ('1140', '1', '1493888389', '0', '1', '提示：菜单添加成功<br/>模块：Admin,控制器：Menu,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Menu/add/pid/2/type/1.html');
INSERT INTO `hi_log_admin` VALUES ('1141', '1', '1493904136', '0', '1', '提示：定时任务编辑成功<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/14.html');
INSERT INTO `hi_log_admin` VALUES ('1142', '1', '1493904578', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1143', '1', '1493904932', '0', '1', '提示：禁用成功<br/>模块：Admin,控制器：Cron,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1144', '1', '1493904936', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1145', '1', '1493904947', '0', '1', '提示：启用成功<br/>模块：Admin,控制器：Cron,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1146', '1', '1493904948', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1147', '1', '1493904960', '0', '1', '提示：禁用成功<br/>模块：Admin,控制器：Cron,方法：setStatus<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1148', '1', '1493905378', '0', '0', '提示：删除失败！<br/>模块：Admin,控制器：Cron,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1149', '1', '1493905409', '0', '1', '提示：删除成功！<br/>模块：Admin,控制器：Cron,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1150', '1', '1493905839', '0', '1', '提示：新增定时任务成功<br/>模块：Admin,控制器：Cron,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/add.html');
INSERT INTO `hi_log_admin` VALUES ('1151', '1', '1493905867', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1152', '1', '1493906144', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1153', '1', '1493908541', '0', '1', '提示：定时任务编辑成功<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('1154', '1', '1493908570', '0', '1', '提示：定时任务编辑成功<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('1155', '1', '1493908684', '0', '1', '提示：定时任务编辑成功<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('1156', '1', '1493908692', '0', '1', '提示：定时任务编辑成功<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('1157', '1', '1493948248', '0', '1', '提示：定时任务编辑成功<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/15.html');
INSERT INTO `hi_log_admin` VALUES ('1158', '1', '1493948253', '0', '1', '提示：更新成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1159', '1', '1493949172', '0', '1', '提示：生成定时任务成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1160', '1', '1493949186', '0', '1', '提示：定时任务生成成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1161', '1', '1493949308', '0', '1', '提示：定时任务生成成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1162', '1', '1493949391', '0', '1', '提示：定时任务生成成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1163', '1', '1493949702', '0', '1', '提示：添加定时任务成功<br/>模块：Admin,控制器：Cron,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/add.html');
INSERT INTO `hi_log_admin` VALUES ('1164', '1', '1493950228', '0', '0', '提示：任务文件不存在<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('1165', '1', '1493950230', '0', '0', '提示：任务文件不存在<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('1166', '1', '1493950236', '0', '0', '提示：任务文件不存在<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('1167', '1', '1493950250', '0', '1', '提示：定时任务编辑成功<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1168', '1', '1493950256', '0', '0', '提示：任务文件不存在<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1169', '1', '1493950388', '0', '1', '提示：定时任务编辑成功<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1170', '1', '1493950568', '0', '0', '提示：任务文件不存在<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1171', '1', '1493950572', '0', '1', '提示：定时任务编辑成功<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/1.html');
INSERT INTO `hi_log_admin` VALUES ('1172', '1', '1493952075', '0', '0', '提示：任务文件不存在<br/>模块：Admin,控制器：Cron,方法：edit<br/>请求方式：Ajax', 'http://localhost/Admin/Cron/edit/id/2.html');
INSERT INTO `hi_log_admin` VALUES ('1173', '1', '1493954214', '0', '1', '提示：定时任务生成成功<br/>模块：Admin,控制器：Cron,方法：build<br/>请求方式：Ajax', 'http://localhost/Admin/cron/index.html');
INSERT INTO `hi_log_admin` VALUES ('1849', '1', '1495870559', '0', '1', '提示：启用成功！<br/>模块：Admin,控制器：Link,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/link/index.html');
INSERT INTO `hi_log_admin` VALUES ('1850', '1', '1496149101', '0', '0', '提示：推荐位名称必须填写<br/>模块：Admin,控制器：Position,方法：add<br/>请求方式：Ajax', 'http://localhost/Admin/Position/add.html');
INSERT INTO `hi_log_admin` VALUES ('1851', '1', '1496149861', '0', '1', '提示：网站设置成功！<br/>模块：Admin,控制器：Config,方法：save<br/>请求方式：Ajax', 'http://localhost/Admin/config/group.html');
INSERT INTO `hi_log_admin` VALUES ('1852', '1', '1496150416', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1853', '1', '1496150422', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1854', '1', '1496150425', '0', '1', '提示：禁用成功！<br/>模块：Admin,控制器：Article,方法：quick<br/>请求方式：Ajax', 'http://localhost/Admin/article/index.html');
INSERT INTO `hi_log_admin` VALUES ('1855', '1', '1496150469', '0', '1', '提示：用户已强退！<br/>模块：Admin,控制器：Ajax,方法：kickuser<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1856', '1', '1496150495', '0', '1', '提示：用户已强退！<br/>模块：Admin,控制器：Ajax,方法：kickuser<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');
INSERT INTO `hi_log_admin` VALUES ('1857', '1', '1496150800', '0', '1', '提示：删除成功！<br/>模块：Admin,控制器：Member,方法：del<br/>请求方式：Ajax', 'http://localhost/Admin/member/index.html');

-- ----------------------------
-- Table structure for hi_log_login
-- ----------------------------
DROP TABLE IF EXISTS `hi_log_login`;
CREATE TABLE `hi_log_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `username` char(30) NOT NULL DEFAULT '' COMMENT '登录帐号',
  `time` int(10) NOT NULL DEFAULT '0' COMMENT '登录时间戳',
  `ip` char(20) NOT NULL DEFAULT '' COMMENT '登录IP',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态,1为登录成功，0为登录失败',
  `password` varchar(30) NOT NULL DEFAULT '' COMMENT '尝试错误密码',
  `logtype` char(6) NOT NULL COMMENT '登陆方式',
  `code` varchar(30) NOT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=315 DEFAULT CHARSET=utf8 COMMENT='后台登陆日志表';

-- ----------------------------
-- Records of hi_log_login
-- ----------------------------
INSERT INTO `hi_log_login` VALUES ('1', 'hicol', '1491978142', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('2', '1890580706', '1491978198', '0.0.0.0', '0', '1111111', '用户名', '用户不存在或被禁用！');
INSERT INTO `hi_log_login` VALUES ('3', 'hicolor', '1491978245', '0.0.0.0', '1', '******', '用户名', '登陆成功');
INSERT INTO `hi_log_login` VALUES ('4', '18905807060', '1491978661', '0.0.0.0', '0', '111111', '手机', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('5', '18905808888', '1491978683', '0.0.0.0', '1', '******', '手机', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('6', 'hicolor', '1491982297', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('7', 'hicolor', '1491986994', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('8', 'hicolor', '1491998547', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('9', 'hicolor', '1492000579', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('10', 'hicolor', '1492004344', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('11', 'hicolor', '1492045564', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('12', 'hicolor', '1492046068', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('13', 'hicolor', '1492060636', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('14', 'hicolor', '1492064300', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('15', 'hicolor', '1492067994', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('16', 'hicolor', '1492072834', '0.0.0.0', '0', '111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('17', 'hicolor', '1492072837', '0.0.0.0', '0', '111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('18', 'hicolor', '1492072843', '0.0.0.0', '0', '111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('19', 'hicolor', '1492072954', '0.0.0.0', '0', 'nFwMT5', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('20', 'hicolor', '1492072957', '0.0.0.0', '0', 'nFwMT5', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('21', 'hicolor1', '1492072969', '0.0.0.0', '0', 'nFwMT5', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('22', 'hicolor', '1492073027', '0.0.0.0', '0', '111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('23', 'hicolor', '1492073071', '0.0.0.0', '0', 'C2PefD', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('24', 'hicolor', '1492073079', '0.0.0.0', '0', 'C2PefD', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('25', '18905807060', '1492073084', '0.0.0.0', '0', 'C2PefD', '手机', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('26', 'hicolor', '1492073195', '0.0.0.0', '0', 'C2PefD', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('27', 'hicolor', '1492073243', '0.0.0.0', '0', '111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('28', 'hicolor', '1492073390', '0.0.0.0', '0', '111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('29', 'hicolor', '1492073411', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('30', 'hicolor', '1492073425', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('31', 'hicolor', '1492073463', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('32', 'hicolor1', '1492073593', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('33', 'hicolor', '1492073627', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('34', 'hicolor1', '1492073657', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('35', 'hicolor', '1492074209', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('36', 'hicolor', '1492085938', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('37', 'hicolor', '1492086116', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('38', 'hicolor1', '1492092482', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('39', 'hicolor', '1492131185', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('40', 'hicolor', '1492133045', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('41', 'hicolor', '1492172625', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('42', 'hicolor', '1492323280', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('43', 'hicolor', '1492328922', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('44', 'hicolor', '1492340970', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('45', 'hicolor', '1492350635', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('46', 'hicolor', '1492394114', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('47', 'hicolor', '1492409629', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('48', 'hicolor', '1492429737', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('49', 'hicolor', '1492431791', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('50', 'hicolor', '1492475856', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('51', 'hicolor', '1492480309', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('52', 'hicolor', '1492481349', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('53', 'hicolor', '1492481356', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('54', 'hicolor', '1492482073', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('55', 'hicolor', '1492484535', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('56', 'hicolor', '1492484569', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('57', 'hicolor', '1492485600', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('58', 'hicolor', '1492485603', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('59', 'hicolor', '1492485606', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('60', 'hicolor', '1492485608', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('61', 'hicolor', '1492485610', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('62', 'hicolor', '1492486418', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('63', 'hicolor', '1492493010', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('64', 'hicolor', '1492493020', '0.0.0.0', '0', '111111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('65', 'hicolor', '1492493021', '0.0.0.0', '0', '111111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('66', 'hicolor', '1492493022', '0.0.0.0', '0', '111111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('67', 'hicolor', '1492493022', '0.0.0.0', '0', '111111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('68', 'hicolor', '1492493023', '0.0.0.0', '0', '111111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('69', 'hicolor', '1492493023', '0.0.0.0', '0', '111111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('70', 'hicolor', '1492493038', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('71', 'hicolor', '1492493043', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('72', 'hicolor', '1492493044', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('73', 'hicolor', '1492493044', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('74', 'hicolor', '1492493044', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('75', 'hicolor', '1492493045', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('76', 'hicolor', '1492493046', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('77', 'hicolor', '1492494385', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('78', 'hicolor', '1492494387', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('79', 'hicolor', '1492494387', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('80', 'hicolor', '1492494387', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('81', 'hicolor', '1492495439', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('82', 'hicolor', '1492498061', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('83', 'hicolor', '1492498464', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('84', 'hicolor', '1492498466', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('85', 'hicolor', '1492498470', '0.0.0.0', '0', '1111111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('86', 'hicolor', '1492498474', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('87', 'hicolor', '1492498476', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('88', 'hicolor', '1492498553', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('89', 'hicolor', '1492498556', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('90', 'hicolor', '1492498682', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('91', 'hicolor', '1492498684', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('92', 'hicolor', '1492498684', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('93', 'hicolor', '1492498684', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('94', 'hicolor', '1492498730', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('95', 'hicolor', '1492498825', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('96', 'hicolor', '1492498826', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('97', 'hicolor', '1492498829', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('98', 'hicolor', '1492498837', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('99', 'hicolor', '1492498837', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('100', 'hicolor', '1492498837', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('101', 'hicolor', '1492498838', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('102', 'hicolor', '1492498838', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('103', 'hicolor', '1492498839', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('104', 'hicolor', '1492498841', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('105', 'hicolor', '1492498841', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('106', 'hicolor', '1492498842', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('107', 'hicolor', '1492498842', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('108', 'hicolor', '1492498843', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('109', 'hicolor', '1492498843', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('110', 'hicolor', '1492498844', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('111', 'hicolor', '1492498845', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('112', 'hicolor', '1492498845', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('113', 'hicolor', '1492498847', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('114', 'hicolor', '1492498851', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('115', 'hicolor', '1492498898', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('116', 'hicolor', '1492498898', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('117', 'hicolor', '1492498899', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('118', 'hicolor', '1492498899', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('119', 'hicolor', '1492498900', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('120', 'hicolor', '1492498900', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('121', 'hicolor', '1492498906', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('122', 'hicolor', '1492498945', '0.0.0.0', '0', '111111q', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('123', 'hicolor', '1492498946', '0.0.0.0', '0', '111111q', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('124', 'hicolor', '1492498949', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('125', 'hicolor', '1492499097', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('126', 'hicolor', '1492499099', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('127', 'hicolor', '1492499100', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('128', 'hicolor', '1492499100', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('129', 'hicolor', '1492499100', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('130', 'hicolor', '1492499100', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('131', 'hicolor', '1492499101', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('132', 'hicolor', '1492499101', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('133', 'hicolor', '1492499105', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('134', 'hicolor', '1492500401', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('135', 'hicolor', '1492503820', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('136', 'hicolor', '1492503822', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('137', 'hicolor', '1492503868', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('138', 'hicolor', '1492503886', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('139', 'hicolor', '1492503889', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('140', 'hicolor', '1492503962', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('141', 'hicolor', '1492503968', '0.0.0.0', '0', '11111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('142', 'hicolor', '1492503996', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('143', 'hicolor', '1492504004', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('144', 'hicolor', '1492504040', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('145', 'hicolor', '1492504046', '0.0.0.0', '0', '11111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('146', 'hicolor', '1492504212', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('147', 'hicolor', '1492504286', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('148', 'hicolor', '1492504291', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('149', 'hicolor', '1492504568', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('150', 'hicolor', '1492504573', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('151', 'hicolor', '1492504575', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('152', 'hicolor', '1492505389', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('153', 'hicolor', '1492505390', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('154', 'hicolor', '1492505391', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('155', 'hicolor', '1492505396', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('156', 'hicolor', '1492505398', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('157', 'hicolor', '1492505459', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('158', 'hicolor', '1492505524', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('159', 'hicolor', '1492505525', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('160', 'hicolor', '1492505526', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('161', 'hicolor', '1492505526', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('162', 'hicolor', '1492505526', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('163', 'hicolor', '1492505627', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('164', 'hicolor', '1492505637', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('165', 'hicolor', '1492505641', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('166', 'hicolor', '1492505641', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('167', 'hicolor', '1492505642', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('168', 'hicolor', '1492505712', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('169', 'hicolor', '1492505719', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('170', 'hicolor', '1492505719', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('171', 'hicolor', '1492505720', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('172', 'hicolor', '1492505724', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('173', 'hicolor', '1492505739', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('174', 'hicolor', '1492505749', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('175', 'hicolor', '1492505841', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('176', 'hicolor', '1492505844', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('177', 'hicolor', '1492505845', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('178', 'hicolor', '1492505845', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('179', 'hicolor', '1492505845', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('180', 'hicolor', '1492505906', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('181', 'hicolor', '1492506008', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('182', 'hicolor', '1492506010', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('183', 'hicolor', '1492506010', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('184', 'hicolor', '1492506010', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('185', 'hicolor', '1492506010', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('186', 'hicolor', '1492506049', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('187', 'hicolor', '1492506050', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('188', 'hicolor', '1492506051', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('189', 'hicolor', '1492506060', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('190', 'hicolor', '1492506305', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('191', 'hicolor', '1492506312', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('192', 'hicolor', '1492506317', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('193', 'hicolor', '1492506867', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('194', 'hicolor', '1492506883', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('195', 'hicolor', '1492506887', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('196', 'hicolor', '1492507306', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('197', 'hicolor', '1492521547', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('198', 'hicolor', '1492562556', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('199', 'hicolor', '1492602087', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('200', 'hicolor', '1492650711', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('201', 'hicolor', '1492671802', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('202', 'hicolor', '1492671802', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('203', 'hicolor', '1492671803', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('204', 'hicolor', '1492671804', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('205', 'hicolor', '1492671805', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('206', 'hicolor', '1492689833', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('207', 'hicolor', '1492736118', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('208', 'hicolor', '1492776436', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('209', 'hicolor', '1492837935', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('210', 'hicolor', '1492839437', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('211', 'hicolor', '1492841231', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('212', 'hicolor', '1492841244', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('213', 'hicolor', '1492949788', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('214', 'hicolor', '1492953891', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('215', 'hicolor', '1493034756', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('216', 'hicolor', '1493120700', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('217', 'hicolor', '1493209871', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('218', 'hicolor', '1493256031', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('219', 'hicolor', '1493293637', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('220', 'hicolor', '1493295088', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('221', 'hicolor', '1493341144', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('222', 'hicolor', '1493382899', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('223', 'hicolor', '1493811816', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('224', 'hicolor', '1493876561', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('225', 'hicolor', '1493900974', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('226', 'hicolor', '1493944602', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('227', 'hicolor', '1493986609', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('228', 'hicolor', '1494072672', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('229', 'hicolor', '1494124169', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('230', 'hicolor', '1494139089', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('231', 'hicolor', '1494205802', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('232', 'hicolor', '1494235299', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('233', 'hicolor', '1494244787', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('234', 'hicolor', '1494247866', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('235', 'hicolor', '1494248308', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('236', 'hicolor', '1494249507', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('237', 'hicolor1', '1494249571', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('238', 'hicolor', '1494249681', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('239', 'hicolor', '1494307351', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('240', 'hicolor', '1494311105', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('241', 'hicolor', '1494313514', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('242', 'hicolor', '1494398731', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('243', 'hicolor', '1494402150', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('244', 'hicolor', '1494421695', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('245', 'hicolor', '1494464217', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('246', 'hicolor', '1494466580', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('247', 'hicolor', '1494490409', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('248', 'hicolor', '1494552032', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('249', 'hicolor', '1494555727', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('250', 'hicolor', '1494564251', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('251', 'hicolor', '1494566850', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('252', 'hicolor', '1494749554', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('253', 'hicolor', '1494809658', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('254', 'hicolor', '1494811965', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('255', 'hicolor', '1494825861', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('256', 'hicolor', '1494834353', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('257', 'hicolor', '1494849610', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('258', 'hicolor', '1494896154', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('259', 'hicolor', '1494900561', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('260', 'hicolor', '1494912137', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('261', 'hicolor', '1494912587', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('262', 'hicolor', '1494912597', '0.0.0.0', '0', '1111111', '用户名', '密码错误！');
INSERT INTO `hi_log_login` VALUES ('263', 'hicolor', '1494917299', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('264', 'hicolor', '1494926958', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('265', 'hicolor', '1494934196', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('266', 'hicolor', '1494984883', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('267', 'hicolor', '1494990911', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('268', 'hicolor', '1494998273', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('269', 'hicolor', '1495007822', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('270', 'hicolor', '1495010704', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('271', 'hicolor', '1495070828', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('272', 'hicolor', '1495110909', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('273', 'hicolor', '1495115540', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('274', 'hicolor', '1495164633', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('275', 'hicolor', '1495172362', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('276', 'hicolor', '1495179013', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('277', 'hicolor', '1495179045', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('278', 'hicolor', '1495179097', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('279', 'hicolor', '1495179210', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('280', 'hicolor', '1495179302', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('281', 'hicolor', '1495179316', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('282', 'hicolor', '1495179364', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('283', 'hicolor', '1495179588', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('284', 'hicolor', '1495180125', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('285', 'hicolor', '1495184227', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('286', 'hicolor', '1495199080', '127.0.0.1', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('287', 'hicolor', '1495259220', '127.0.0.1', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('288', 'hicolor', '1495371094', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('289', 'hicolor', '1495417481', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('290', 'hicolor', '1495421876', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('291', 'hicolor', '1495430868', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('292', 'hicolor', '1495439681', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('293', 'hicolor', '1495457199', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('294', 'hicolor', '1495501753', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('295', 'hicolor', '1495516244', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('296', 'hicolor', '1495521464', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('297', 'hicolor', '1495544266', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('298', 'hicolor', '1495586968', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('299', 'hicolor', '1495593466', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('300', 'hicolor', '1495604138', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('301', 'hicolor', '1495609740', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('302', 'hicolor', '1495672990', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('303', 'hicolor', '1495679231', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('304', 'hicolor', '1495694084', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('305', 'hicolor', '1495697314', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('306', 'hicolor', '1495700791', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('307', 'hicolor', '1495759659', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('308', 'hicolor', '1495781164', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('309', 'hicolor', '1495787251', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('310', 'hicolor', '1495847492', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('311', 'hicolor', '1495849459', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('312', 'hicolor', '1495853540', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('313', 'hicolor', '1495866732', '0.0.0.0', '1', '******', '用户名', '登陆成功!');
INSERT INTO `hi_log_login` VALUES ('314', 'hicolor', '1496149082', '0.0.0.0', '1', '******', '用户名', '登陆成功!');

-- ----------------------------
-- Table structure for hi_member
-- ----------------------------
DROP TABLE IF EXISTS `hi_member`;
CREATE TABLE `hi_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(11) NOT NULL COMMENT '用户手机',
  `last_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态',
  `logins` mediumint(7) NOT NULL COMMENT '登陆次数',
  `session_id` char(26) NOT NULL COMMENT 'session_id',
  `modelid` tinyint(1) NOT NULL COMMENT '会员模型ID',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '积分',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_member
-- ----------------------------
INSERT INTO `hi_member` VALUES ('1', 'hicolor', 'edfa439ce8867023265c13f9d67cd081', '', '18905808888', '1496149082', '0', '1', '392', 'n71h6tvakduahm8miusvgmkml6', '3', '0');
INSERT INTO `hi_member` VALUES ('2', 'hicolor1', 'edfa439ce8867023265c13f9d67cd081', '', '', '1494249571', '0', '1', '4', 'bva5qb17kqpec05l8dqgtej8d5', '3', '0');
INSERT INTO `hi_member` VALUES ('3', 'admin', 'ca40b5ba3125ff1887c6285a50ea766c', '', '', '1490764694', '0', '1', '5', 'mrbj1r30p654h46eu7m80qjkj1', '3', '0');

-- ----------------------------
-- Table structure for hi_member_copy
-- ----------------------------
DROP TABLE IF EXISTS `hi_member_copy`;
CREATE TABLE `hi_member_copy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(11) NOT NULL COMMENT '用户手机',
  `last_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态',
  `logins` mediumint(7) NOT NULL COMMENT '登陆次数',
  `session_id` char(26) NOT NULL COMMENT 'session_id',
  `modelid` tinyint(1) NOT NULL COMMENT '会员模型ID',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '积分',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_member_copy
-- ----------------------------
INSERT INTO `hi_member_copy` VALUES ('1', 'hicolor', 'edfa439ce8867023265c13f9d67cd081', '', '18905808888', '1495853540', '0', '1', '390', '0u8dm6vt8m635b7gc0hp57rvd7', '3', '0');
INSERT INTO `hi_member_copy` VALUES ('2', 'hicolor1', 'edfa439ce8867023265c13f9d67cd081', '', '', '1494249571', '0', '1', '4', 'bva5qb17kqpec05l8dqgtej8d5', '3', '0');
INSERT INTO `hi_member_copy` VALUES ('3', 'admin', 'ca40b5ba3125ff1887c6285a50ea766c', '', '', '1490764694', '0', '1', '5', 'mrbj1r30p654h46eu7m80qjkj1', '3', '0');
INSERT INTO `hi_member_copy` VALUES ('5', '', 'fc911ed21a73a1eaec48c25db451d01e', '', '18905807060', '1490755005', '0', '1', '2', 'mrbj1r30p654h46eu7m80qjkj1', '3', '0');

-- ----------------------------
-- Table structure for hi_member_person
-- ----------------------------
DROP TABLE IF EXISTS `hi_member_person`;
CREATE TABLE `hi_member_person` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `nickname` varchar(16) NOT NULL COMMENT '昵称',
  `sex` tinyint(1) NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_member_person
-- ----------------------------
INSERT INTO `hi_member_person` VALUES ('1', 'hicolor', '0');

-- ----------------------------
-- Table structure for hi_menu
-- ----------------------------
DROP TABLE IF EXISTS `hi_menu`;
CREATE TABLE `hi_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `is_hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `module` char(10) NOT NULL COMMENT '所属模块',
  `icon` varchar(32) NOT NULL COMMENT '图标',
  `type` smallint(1) unsigned zerofill NOT NULL COMMENT '菜单类型',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='菜单';

-- ----------------------------
-- Records of hi_menu
-- ----------------------------
INSERT INTO `hi_menu` VALUES ('1', '首页', '0', '1', 'index/index', '0', '', '', '0', '1', 'admin', 'fa-home', '1');
INSERT INTO `hi_menu` VALUES ('2', '设置', '0', '2', 'config/index', '0', '', '', '0', '1', 'admin', 'fa-gear', '1');
INSERT INTO `hi_menu` VALUES ('3', '会员', '0', '4', 'member/index', '0', '', '', '0', '1', 'admin', 'fa-group', '1');
INSERT INTO `hi_menu` VALUES ('4', '欢迎页', '1', '0', 'index/index', '0', '', '我的面板', '0', '1', 'admin', 'fa-tachometer', '1');
INSERT INTO `hi_menu` VALUES ('5', '菜单管理', '2', '0', 'menu/index', '0', '', '系统设置', '0', '1', 'admin', 'fa-navicon', '1');
INSERT INTO `hi_menu` VALUES ('6', '网站设置', '2', '0', 'config/group', '0', '', '系统设置', '0', '1', 'admin', 'fa-sitemap', '1');
INSERT INTO `hi_menu` VALUES ('7', '系统设置', '2', '0', 'config/index', '0', '', '系统设置', '0', '1', 'admin', 'fa-gear', '1');
INSERT INTO `hi_menu` VALUES ('8', '用户列表', '3', '0', 'member/index', '0', '', '会员中心', '0', '1', 'admin', 'fa-user', '1');
INSERT INTO `hi_menu` VALUES ('9', '添加', '5', '0', 'menu/add', '0', '', '', '0', '1', 'admin', 'fa-plus-square', '0');
INSERT INTO `hi_menu` VALUES ('11', '编辑', '5', '0', 'menu/edit', '0', '', '', '0', '1', 'admin', 'fa-pencil-square', '1');
INSERT INTO `hi_menu` VALUES ('10', '模块管理', '2', '0', 'module/index', '0', '', '系统设置', '0', '1', 'admin', 'fa-barcode', '1');
INSERT INTO `hi_menu` VALUES ('12', '权限管理', '2', '0', 'auth/index', '0', '', '系统设置', '0', '1', 'admin', 'fa-key', '1');
INSERT INTO `hi_menu` VALUES ('13', '修改密码', '1', '0', 'my/password', '0', '', '我的面板', '0', '1', 'admin', 'fa-lock', '1');
INSERT INTO `hi_menu` VALUES ('14', '个人信息', '1', '0', 'my/info', '0', '', '我的面板', '0', '1', 'admin', 'fa-user', '1');
INSERT INTO `hi_menu` VALUES ('15', '文章分类', '2', '0', 'category/index', '0', '', '类别设置', '0', '1', 'admin', 'fa-list-ol', '1');
INSERT INTO `hi_menu` VALUES ('16', '添加菜单', '15', '0', 'category/add', '0', '', '', '0', '1', 'admin', 'fa-plus-square', '0');
INSERT INTO `hi_menu` VALUES ('17', '附件管理', '24', '2', 'attachment/index', '0', '', '扩展功能', '0', '1', 'admin', 'fa-picture-o', '1');
INSERT INTO `hi_menu` VALUES ('18', '我的头像', '1', '0', 'my/avatar', '0', '', '我的面板', '0', '1', 'admin', 'fa-image', '1');
INSERT INTO `hi_menu` VALUES ('19', '操作日志', '2', '0', 'log/index', '0', '', '日志管理', '0', '1', 'admin', 'fa-newspaper-o', '1');
INSERT INTO `hi_menu` VALUES ('20', '登陆日志', '2', '0', 'log/login', '0', '', '日志管理', '0', '1', 'admin', 'fa-newspaper-o', '1');
INSERT INTO `hi_menu` VALUES ('21', '文章', '0', '3', 'article/index', '0', '', '', '0', '1', 'admin', 'fa-newspaper-o', '1');
INSERT INTO `hi_menu` VALUES ('22', '文章管理', '21', '0', 'article/index', '0', '', '文章资讯', '0', '1', 'admin', 'fa-list-alt', '1');
INSERT INTO `hi_menu` VALUES ('23', '添加', '22', '0', 'article/add', '0', '', '', '0', '1', 'admin', 'fa-plus', '1');
INSERT INTO `hi_menu` VALUES ('24', '扩展', '0', '5', 'ad/index', '0', '', '', '0', '1', 'admin', 'fa-th-large', '1');
INSERT INTO `hi_menu` VALUES ('31', '广告管理', '24', '0', 'ad/index', '0', '', '扩展功能', '0', '1', 'admin', 'fa-adn', '1');
INSERT INTO `hi_menu` VALUES ('25', '标签管理', '24', '3', 'tags/index', '0', '', '扩展功能', '0', '1', 'admin', 'fa-tags', '1');
INSERT INTO `hi_menu` VALUES ('26', '联动菜单', '24', '4', 'linkage/index', '0', '', '扩展功能', '0', '1', 'admin', 'fa-link', '1');
INSERT INTO `hi_menu` VALUES ('27', '添加', '26', '0', 'linkage/add', '0', '添加菜单', '', '0', '1', 'admin', 'fa-plus', '1');
INSERT INTO `hi_menu` VALUES ('28', '编辑', '26', '0', 'linkage/edit', '0', '', '', '0', '1', 'admin', 'fa-pencil-square-o', '1');
INSERT INTO `hi_menu` VALUES ('29', '友情链接', '24', '1', 'link/index', '0', '', '扩展功能', '0', '1', 'admin', 'fa-unlink', '1');
INSERT INTO `hi_menu` VALUES ('30', '模型管理', '2', '0', 'model/index', '0', '', '系统设置', '0', '1', 'admin', 'fa-table', '1');
INSERT INTO `hi_menu` VALUES ('32', '添加广告位', '31', '0', 'ad/pos', '0', '', '', '0', '1', 'admin', 'fa-plus', '1');
INSERT INTO `hi_menu` VALUES ('33', '广告列表', '31', '0', 'ad/postion', '0', '', '', '0', '1', 'admin', 'fa-th-list', '1');
INSERT INTO `hi_menu` VALUES ('34', '添加广告', '31', '0', 'ad/add', '0', '', '', '0', '1', 'admin', 'fa-adn', '1');
INSERT INTO `hi_menu` VALUES ('35', '编辑广告位', '31', '0', 'ad/editpos', '0', '', '', '0', '1', 'admin', 'fa-bolt', '1');
INSERT INTO `hi_menu` VALUES ('36', '编辑广告', '31', '0', 'ad/edit', '0', '', '', '0', '1', 'admin', 'fa-adn', '1');
INSERT INTO `hi_menu` VALUES ('37', '定时任务', '2', '0', 'cron/index', '0', '', '系统设置', '0', '1', 'admin', 'fa-clock-o', '1');
INSERT INTO `hi_menu` VALUES ('38', '推荐位管理', '24', '0', 'position/index', '0', '', '扩展功能', '0', '1', 'admin', 'fa-location-arrow', '1');
INSERT INTO `hi_menu` VALUES ('39', '添加', '7', '0', 'config/add', '0', '', '', '0', '1', 'admin', 'fa-plus', '1');
INSERT INTO `hi_menu` VALUES ('40', '编辑', '7', '0', 'config/edit', '0', '', '', '0', '1', 'admin', 'fa-pencil-square-o', '1');
INSERT INTO `hi_menu` VALUES ('41', '添加模块', '10', '0', 'module/add', '0', '', '', '0', '1', 'admin', 'fa-pencil-square-o', '1');
INSERT INTO `hi_menu` VALUES ('42', '编辑模块', '10', '0', 'module/edit', '0', '', '', '0', '1', 'admin', 'fa-pencil-square-o', '1');
INSERT INTO `hi_menu` VALUES ('43', '添加用户组', '12', '0', 'auth/createGroup', '0', '', '', '0', '1', 'admin', 'fa-plus', '1');
INSERT INTO `hi_menu` VALUES ('44', '编辑用户组', '12', '0', 'auth/editGroup', '0', '', '', '0', '1', 'admin', 'fa-pencil-square-o', '1');
INSERT INTO `hi_menu` VALUES ('45', '访问授权', '12', '0', 'auth/access', '0', '', '', '0', '1', 'admin', 'fa-key', '1');
INSERT INTO `hi_menu` VALUES ('46', '栏目授权', '12', '0', 'Auth/category', '0', '', '', '0', '1', 'admin', 'fa-key', '1');
INSERT INTO `hi_menu` VALUES ('47', '成员授权', '12', '0', 'auth/user', '0', '', '', '0', '1', 'admin', 'fa-key', '1');
INSERT INTO `hi_menu` VALUES ('48', '添加模型', '30', '0', 'model/add', '0', '', '', '0', '1', 'admin', 'fa-plus', '1');
INSERT INTO `hi_menu` VALUES ('49', '编辑模型', '30', '0', 'model/edit', '0', '', '', '0', '1', 'admin', 'fa-pencil-square-o', '1');
INSERT INTO `hi_menu` VALUES ('50', '字段管理', '30', '0', 'model/fields', '0', '', '', '0', '1', 'admin', 'fa-th-list', '1');
INSERT INTO `hi_menu` VALUES ('51', '字段编辑', '30', '0', 'model/field', '0', '', '', '0', '1', 'admin', 'fa-pencil-square-o', '1');
INSERT INTO `hi_menu` VALUES ('52', '添加定时任务', '37', '0', 'cron/add', '0', '', '', '0', '1', 'admin', 'fa-plus', '1');
INSERT INTO `hi_menu` VALUES ('53', '编辑定时任务', '37', '0', 'cron/edit', '0', '', '', '0', '1', 'admin', 'fa-pencil-square-o', '1');
INSERT INTO `hi_menu` VALUES ('54', '添加推荐位', '38', '0', 'position/add', '0', '', '', '0', '1', 'admin', 'fa-plus', '1');
INSERT INTO `hi_menu` VALUES ('55', '编辑推荐位', '38', '0', 'position/edit', '0', '', '', '0', '1', 'admin', 'fa-pencil-square-o', '1');
INSERT INTO `hi_menu` VALUES ('56', '推荐信息管理', '38', '0', 'position/content', '0', '', '', '0', '1', 'admin', 'fa-angellist', '1');
INSERT INTO `hi_menu` VALUES ('57', '模板管理', '24', '0', 'template/index', '0', '', '扩展功能', '0', '1', 'admin', 'fa-adjust', '1');
INSERT INTO `hi_menu` VALUES ('58', '模板列表', '57', '0', 'template/index', '0', '', '', '0', '1', 'admin', 'fa-adjust', '1');
INSERT INTO `hi_menu` VALUES ('59', '编辑模板', '57', '0', 'template/edit', '0', '', '', '0', '1', 'admin', 'fa-adjust', '1');
INSERT INTO `hi_menu` VALUES ('60', '历史版本', '57', '0', 'template/history', '0', '', '', '0', '1', 'admin', 'fa-history', '1');
INSERT INTO `hi_menu` VALUES ('61', '还原模板', '57', '0', 'template/restore', '0', '', '', '0', '1', 'admin', 'fa-history', '1');
INSERT INTO `hi_menu` VALUES ('62', '碎片管理', '24', '0', 'block/index', '0', '', '扩展功能', '0', '1', 'admin', 'fa-cube', '1');
INSERT INTO `hi_menu` VALUES ('63', '碎片管理', '62', '0', 'block/index', '0', '', '', '0', '1', 'admin', 'fa-cube', '1');
INSERT INTO `hi_menu` VALUES ('64', '添加碎片', '62', '0', 'block/add', '0', '', '', '0', '1', 'admin', 'fa-plus', '1');
INSERT INTO `hi_menu` VALUES ('65', '编辑碎片', '62', '0', 'block/edit', '0', '', '', '0', '1', 'admin', 'fa-pencil', '1');

-- ----------------------------
-- Table structure for hi_model
-- ----------------------------
DROP TABLE IF EXISTS `hi_model`;
CREATE TABLE `hi_model` (
  `id` smallint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `title` char(16) NOT NULL DEFAULT '' COMMENT '模型标题',
  `name` varchar(20) NOT NULL,
  `tablename` char(20) NOT NULL DEFAULT '' COMMENT '数据表',
  `icon` varchar(20) NOT NULL DEFAULT '' COMMENT '图标',
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `type` tinyint(1) NOT NULL COMMENT '分组 1:CMS 2:会员',
  `tpl_list` varchar(20) NOT NULL COMMENT '列表模板',
  `tpl_show` varchar(20) NOT NULL COMMENT '内容模板',
  `tpl_publish` varchar(20) NOT NULL COMMENT '内容发布模板',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

-- ----------------------------
-- Records of hi_model
-- ----------------------------
INSERT INTO `hi_model` VALUES ('1', '单页', 'Page', 'page', '', '1494813110', '1494813110', '0', '1', '1', '', '', '');
INSERT INTO `hi_model` VALUES ('2', '文章', 'Article', 'article', '', '1494813134', '1494813134', '0', '1', '1', '', '', '');
INSERT INTO `hi_model` VALUES ('3', '个人会员', 'MemberPerson', 'member_person', '', '1495173628', '1495173628', '0', '1', '3', '', '', '');

-- ----------------------------
-- Table structure for hi_model_field
-- ----------------------------
DROP TABLE IF EXISTS `hi_model_field`;
CREATE TABLE `hi_model_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `tips` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `options` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `modelid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `isshow` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `ismust` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `isposition` tinyint(1) NOT NULL COMMENT '是否推荐',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `inputtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `updatetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `modelid` (`modelid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

-- ----------------------------
-- Records of hi_model_field
-- ----------------------------
INSERT INTO `hi_model_field` VALUES ('1', 'catid', '栏目ID', 'smallint(5) unsigned NOT NULL ', 'string', '0', '', '', '1', '0', '0', '0', '1', '1494813110', '0', '1494813110');
INSERT INTO `hi_model_field` VALUES ('2', 'title', '标题', 'varchar(160) NOT NULL ', 'string', '', '', '', '1', '0', '0', '0', '1', '1494813110', '0', '1494813110');
INSERT INTO `hi_model_field` VALUES ('3', 'keywords', '关键字', 'varchar(40) NOT NULL ', 'string', '', '', '', '1', '0', '0', '0', '1', '1494813110', '0', '1494813110');
INSERT INTO `hi_model_field` VALUES ('4', 'content', '内容', 'text NULL ', 'string', '', '', '', '1', '0', '0', '0', '1', '1494813110', '0', '1494813110');
INSERT INTO `hi_model_field` VALUES ('5', 'template', '', 'varchar(30) NOT NULL ', 'string', '', '', '', '1', '0', '0', '0', '1', '1494813110', '0', '1494813110');
INSERT INTO `hi_model_field` VALUES ('6', 'updatetime', '更新时间', 'int(10) unsigned NOT NULL ', 'string', '0', '', '', '1', '0', '0', '0', '1', '1494813110', '0', '1494813110');
INSERT INTO `hi_model_field` VALUES ('7', 'catid', '栏目ID', 'smallint(5) unsigned NOT NULL ', 'string', '0', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('8', 'title', '文章标题', 'varchar(160) NOT NULL ', 'string', '', '', '', '2', '0', '0', '1', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('9', 'style', '字体样式', 'char(7) NOT NULL ', 'string', '', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('10', 'thumb', '缩略图', 'mediumint(8) unsigned NOT NULL ', 'string', '', '', '', '2', '0', '0', '1', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('11', 'keywords', '关键词', 'varchar(40) NOT NULL ', 'string', '', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('12', 'description', '简介', 'mediumtext NULL ', 'string', '', '', '', '2', '0', '0', '1', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('13', 'url', '跳转链接', 'char(100) NOT NULL ', 'string', '', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('14', 'sort', '排序', 'tinyint(3) unsigned NOT NULL ', 'string', '0', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('15', 'status', '状态 -1:删除 0:禁用 1:正常 2:审核', 'tinyint(1) NOT NULL ', 'string', '0', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('16', 'uid', '用户ID', 'mediumint(10) NOT NULL ', 'string', '', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('17', 'inputtime', '发布时间', 'int(10) unsigned NOT NULL ', 'string', '0', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('18', 'updatetime', '更新时间', 'int(10) unsigned NOT NULL ', 'string', '0', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('19', 'posid', '推荐位', 'tinyint(3) unsigned NOT NULL ', 'string', '0', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('20', 'tags', '标签', 'varchar(255) NOT NULL ', 'string', '', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('21', 'views', '点击总数', 'int(11) NOT NULL ', 'string', '0', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('22', 'islink', '是否跳转链接 1:跳转 0:否', 'tinyint(1) unsigned NOT NULL ', 'string', '0', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('23', 'iscomment', '是否允许评论 1:允许 0:禁止', 'tinyint(1) NOT NULL ', 'string', '', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('24', 'isposition', '是否推荐', 'tinyint(1) NOT NULL ', 'string', '0', '', '', '2', '0', '0', '0', '1', '1494813134', '0', '1494813134');
INSERT INTO `hi_model_field` VALUES ('25', 'uid', '用户ID', 'int(10) unsigned NOT NULL ', 'string', '', '', '', '3', '0', '0', '0', '1', '1495173629', '0', '1495173629');
INSERT INTO `hi_model_field` VALUES ('26', 'nickname', '昵称', 'varchar(16) NOT NULL ', 'string', '', '', '', '3', '0', '0', '0', '1', '1495173629', '0', '1495173629');
INSERT INTO `hi_model_field` VALUES ('27', 'avatar', '头像', 'char(50) NOT NULL ', 'string', '', '', '', '3', '0', '0', '0', '1', '1495173629', '0', '1495173629');
INSERT INTO `hi_model_field` VALUES ('28', 'sex', '', 'tinyint(1) NOT NULL ', 'string', '', '', '', '3', '0', '0', '0', '1', '1495173629', '0', '1495173629');

-- ----------------------------
-- Table structure for hi_module
-- ----------------------------
DROP TABLE IF EXISTS `hi_module`;
CREATE TABLE `hi_module` (
  `id` tinyint(1) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL COMMENT '名称',
  `name` varchar(10) NOT NULL COMMENT '模块',
  `html_cache_on` tinyint(1) NOT NULL DEFAULT '0' COMMENT '静态缓存',
  `html_cache_time` smallint(3) NOT NULL DEFAULT '0' COMMENT '静态缓存时间',
  `html_file_suffix` char(5) DEFAULT NULL COMMENT '缓存文件后缀',
  `url_router_on` tinyint(1) NOT NULL DEFAULT '0' COMMENT '路由配置',
  `list_rows` tinyint(2) NOT NULL DEFAULT '0' COMMENT '分页数',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `isauth` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否加入权限控制',
  `sort` smallint(3) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='模块配置表';

-- ----------------------------
-- Records of hi_module
-- ----------------------------
INSERT INTO `hi_module` VALUES ('1', '系统后台', 'admin', '0', '6', 'html', '0', '20', '1', '1', '0');
INSERT INTO `hi_module` VALUES ('2', '会员中心', 'u', '1', '1', 'html', '0', '20', '1', '1', '0');
INSERT INTO `hi_module` VALUES ('3', '平台首页', 'home', '0', '12', 'html', '0', '20', '1', '0', '0');

-- ----------------------------
-- Table structure for hi_page
-- ----------------------------
DROP TABLE IF EXISTS `hi_page`;
CREATE TABLE `hi_page` (
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '栏目ID',
  `title` varchar(160) NOT NULL DEFAULT '' COMMENT '标题',
  `keywords` varchar(40) NOT NULL DEFAULT '' COMMENT '关键字',
  `content` text COMMENT '内容',
  `template` varchar(30) NOT NULL DEFAULT '',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`catid`),
  KEY `catid` (`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='单页内容表';

-- ----------------------------
-- Records of hi_page
-- ----------------------------
INSERT INTO `hi_page` VALUES ('268', '海工设备', '', '<p>sdafsdfsa11111</p>', '', '0');

-- ----------------------------
-- Table structure for hi_position
-- ----------------------------
DROP TABLE IF EXISTS `hi_position`;
CREATE TABLE `hi_position` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '推荐位id',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '推荐位名称',
  `modelid` char(20) NOT NULL COMMENT '模型id',
  `maxnum` tinyint(3) NOT NULL DEFAULT '20' COMMENT '最大存储数据量',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='推荐位';

-- ----------------------------
-- Records of hi_position
-- ----------------------------
INSERT INTO `hi_position` VALUES ('4', '首页滚动', '1,2,3', '20', '1', '1');
INSERT INTO `hi_position` VALUES ('5', '首页头条', '2', '5', '0', '1');
INSERT INTO `hi_position` VALUES ('6', '首页幻灯片', '2,3', '20', '0', '1');
INSERT INTO `hi_position` VALUES ('7', '首页栏目推荐', '2', '20', '0', '1');

-- ----------------------------
-- Table structure for hi_position_data
-- ----------------------------
DROP TABLE IF EXISTS `hi_position_data`;
CREATE TABLE `hi_position_data` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'ID',
  `posid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位ID',
  `catid` smallint(5) NOT NULL COMMENT '栏目ID',
  `modelid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '模型ID',
  `thumb` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有缩略图',
  `data` text COMMENT '数据信息',
  `sort` mediumint(8) NOT NULL DEFAULT '0' COMMENT '排序',
  KEY `posid` (`posid`),
  KEY `listorder` (`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='推荐位数据表';

-- ----------------------------
-- Records of hi_position_data
-- ----------------------------
INSERT INTO `hi_position_data` VALUES ('17', '6', '81', '2', '0', 'a:3:{s:5:\"title\";s:14:\"文章标题21\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('16', '6', '81', '2', '0', 'a:3:{s:5:\"title\";s:13:\"文章标题2\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('19', '6', '82', '2', '0', 'a:3:{s:5:\"title\";s:16:\"文章标题2111\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('20', '6', '89', '2', '0', 'a:3:{s:5:\"title\";s:17:\"文章标题21111\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('22', '6', '27', '2', '0', 'a:3:{s:5:\"title\";s:18:\"文章标题111211\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:96:\"文章标题文章标题文章标题文章标题文章标题文章标题文章标题文章标题\";}', '0');
INSERT INTO `hi_position_data` VALUES ('21', '6', '69', '2', '0', 'a:3:{s:5:\"title\";s:18:\"测试文章发布\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('26', '6', '27', '2', '1', 'a:3:{s:5:\"title\";s:36:\"撒大发撒旦法师打发斯蒂芬\";s:5:\"thumb\";s:1:\"1\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('25', '6', '31', '2', '8', 'a:3:{s:5:\"title\";s:18:\"文章标题名称\";s:5:\"thumb\";s:1:\"8\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('23', '6', '27', '2', '0', 'a:3:{s:5:\"title\";s:46:\"文章标题名称，还可输入 80 个字符\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('17', '5', '81', '2', '0', 'a:3:{s:5:\"title\";s:14:\"文章标题21\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('7', '6', '197', '2', '0', 'a:3:{s:5:\"title\";s:6:\"顶起\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:12:\"文章标题\";}', '0');
INSERT INTO `hi_position_data` VALUES ('9', '6', '81', '2', '8', 'a:3:{s:5:\"title\";s:8:\"顶起11\";s:5:\"thumb\";s:1:\"8\";s:11:\"description\";s:12:\"文章标题\";}', '0');
INSERT INTO `hi_position_data` VALUES ('8', '6', '81', '2', '0', 'a:3:{s:5:\"title\";s:7:\"顶起1\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:12:\"文章标题\";}', '0');
INSERT INTO `hi_position_data` VALUES ('15', '6', '81', '2', '0', 'a:3:{s:5:\"title\";s:19:\"文章标题1111111\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('14', '6', '81', '2', '0', 'a:3:{s:5:\"title\";s:18:\"文章标题111111\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('13', '6', '81', '2', '2', 'a:3:{s:5:\"title\";s:17:\"文章标题11111\";s:5:\"thumb\";s:1:\"2\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('12', '6', '81', '2', '1', 'a:3:{s:5:\"title\";s:16:\"文章标题1111\";s:5:\"thumb\";s:1:\"1\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('11', '6', '81', '2', '6', 'a:3:{s:5:\"title\";s:13:\"文章标题1\";s:5:\"thumb\";s:1:\"6\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('10', '6', '81', '2', '0', 'a:3:{s:5:\"title\";s:9:\"顶起111\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:12:\"文章标题\";}', '0');
INSERT INTO `hi_position_data` VALUES ('5', '6', '65', '2', '0', 'a:3:{s:5:\"title\";s:21:\"大事发生地方123\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:0:\"\";}', '0');
INSERT INTO `hi_position_data` VALUES ('6', '6', '29', '2', '0', 'a:3:{s:5:\"title\";s:22:\"大事发生地方1233\";s:5:\"thumb\";s:1:\"0\";s:11:\"description\";s:0:\"\";}', '0');

-- ----------------------------
-- Table structure for hi_region
-- ----------------------------
DROP TABLE IF EXISTS `hi_region`;
CREATE TABLE `hi_region` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `pid` smallint(5) unsigned NOT NULL,
  `code` mediumint(8) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=3193 DEFAULT CHARSET=utf8 COMMENT='中国行政区域表';

-- ----------------------------
-- Records of hi_region
-- ----------------------------
INSERT INTO `hi_region` VALUES ('1', '0', '110000', '北京市');
INSERT INTO `hi_region` VALUES ('2', '1', '110000', '北京市');
INSERT INTO `hi_region` VALUES ('3', '2', '110101', '东城区');
INSERT INTO `hi_region` VALUES ('4', '2', '110102', '西城区');
INSERT INTO `hi_region` VALUES ('5', '2', '110105', '朝阳区');
INSERT INTO `hi_region` VALUES ('6', '2', '110106', '丰台区');
INSERT INTO `hi_region` VALUES ('7', '2', '110107', '石景山区');
INSERT INTO `hi_region` VALUES ('8', '2', '110108', '海淀区');
INSERT INTO `hi_region` VALUES ('9', '2', '110109', '门头沟区');
INSERT INTO `hi_region` VALUES ('10', '2', '110111', '房山区');
INSERT INTO `hi_region` VALUES ('11', '2', '110112', '通州区');
INSERT INTO `hi_region` VALUES ('12', '2', '110113', '顺义区');
INSERT INTO `hi_region` VALUES ('13', '2', '110114', '昌平区');
INSERT INTO `hi_region` VALUES ('14', '2', '110115', '大兴区');
INSERT INTO `hi_region` VALUES ('15', '2', '110116', '怀柔区');
INSERT INTO `hi_region` VALUES ('16', '2', '110117', '平谷区');
INSERT INTO `hi_region` VALUES ('17', '2', '110118', '密云区');
INSERT INTO `hi_region` VALUES ('18', '2', '110119', '延庆区');
INSERT INTO `hi_region` VALUES ('19', '0', '120000', '天津市');
INSERT INTO `hi_region` VALUES ('20', '19', '120000', '天津市');
INSERT INTO `hi_region` VALUES ('21', '20', '120101', '和平区');
INSERT INTO `hi_region` VALUES ('22', '20', '120102', '河东区');
INSERT INTO `hi_region` VALUES ('23', '20', '120103', '河西区');
INSERT INTO `hi_region` VALUES ('24', '20', '120104', '南开区');
INSERT INTO `hi_region` VALUES ('25', '20', '120105', '河北区');
INSERT INTO `hi_region` VALUES ('26', '20', '120106', '红桥区');
INSERT INTO `hi_region` VALUES ('27', '20', '120110', '东丽区');
INSERT INTO `hi_region` VALUES ('28', '20', '120111', '西青区');
INSERT INTO `hi_region` VALUES ('29', '20', '120112', '津南区');
INSERT INTO `hi_region` VALUES ('30', '20', '120113', '北辰区');
INSERT INTO `hi_region` VALUES ('31', '20', '120114', '武清区');
INSERT INTO `hi_region` VALUES ('32', '20', '120115', '宝坻区');
INSERT INTO `hi_region` VALUES ('33', '20', '120116', '滨海新区');
INSERT INTO `hi_region` VALUES ('34', '20', '120117', '宁河区');
INSERT INTO `hi_region` VALUES ('35', '20', '120118', '静海区');
INSERT INTO `hi_region` VALUES ('36', '20', '120119', '蓟州区');
INSERT INTO `hi_region` VALUES ('37', '0', '130000', '河北省');
INSERT INTO `hi_region` VALUES ('38', '37', '130100', '石家庄市');
INSERT INTO `hi_region` VALUES ('39', '38', '130102', '长安区');
INSERT INTO `hi_region` VALUES ('40', '38', '130104', '桥西区');
INSERT INTO `hi_region` VALUES ('41', '38', '130105', '新华区');
INSERT INTO `hi_region` VALUES ('42', '38', '130107', '井陉矿区');
INSERT INTO `hi_region` VALUES ('43', '38', '130108', '裕华区');
INSERT INTO `hi_region` VALUES ('44', '38', '130109', '藁城区');
INSERT INTO `hi_region` VALUES ('45', '38', '130110', '鹿泉区');
INSERT INTO `hi_region` VALUES ('46', '38', '130111', '栾城区');
INSERT INTO `hi_region` VALUES ('47', '38', '130121', '井陉县');
INSERT INTO `hi_region` VALUES ('48', '38', '130123', '正定县');
INSERT INTO `hi_region` VALUES ('49', '38', '130125', '行唐县');
INSERT INTO `hi_region` VALUES ('50', '38', '130126', '灵寿县');
INSERT INTO `hi_region` VALUES ('51', '38', '130127', '高邑县');
INSERT INTO `hi_region` VALUES ('52', '38', '130128', '深泽县');
INSERT INTO `hi_region` VALUES ('53', '38', '130129', '赞皇县');
INSERT INTO `hi_region` VALUES ('54', '38', '130130', '无极县');
INSERT INTO `hi_region` VALUES ('55', '38', '130131', '平山县');
INSERT INTO `hi_region` VALUES ('56', '38', '130132', '元氏县');
INSERT INTO `hi_region` VALUES ('57', '38', '130133', '赵县');
INSERT INTO `hi_region` VALUES ('58', '38', '130181', '辛集市');
INSERT INTO `hi_region` VALUES ('59', '38', '130183', '晋州市');
INSERT INTO `hi_region` VALUES ('60', '38', '130184', '新乐市');
INSERT INTO `hi_region` VALUES ('61', '37', '130200', '唐山市');
INSERT INTO `hi_region` VALUES ('62', '61', '130202', '路南区');
INSERT INTO `hi_region` VALUES ('63', '61', '130203', '路北区');
INSERT INTO `hi_region` VALUES ('64', '61', '130204', '古冶区');
INSERT INTO `hi_region` VALUES ('65', '61', '130205', '开平区');
INSERT INTO `hi_region` VALUES ('66', '61', '130207', '丰南区');
INSERT INTO `hi_region` VALUES ('67', '61', '130208', '丰润区');
INSERT INTO `hi_region` VALUES ('68', '61', '130209', '曹妃甸区');
INSERT INTO `hi_region` VALUES ('69', '61', '130223', '滦县');
INSERT INTO `hi_region` VALUES ('70', '61', '130224', '滦南县');
INSERT INTO `hi_region` VALUES ('71', '61', '130225', '乐亭县');
INSERT INTO `hi_region` VALUES ('72', '61', '130227', '迁西县');
INSERT INTO `hi_region` VALUES ('73', '61', '130229', '玉田县');
INSERT INTO `hi_region` VALUES ('74', '61', '130281', '遵化市');
INSERT INTO `hi_region` VALUES ('75', '61', '130283', '迁安市');
INSERT INTO `hi_region` VALUES ('76', '37', '130300', '秦皇岛市');
INSERT INTO `hi_region` VALUES ('77', '76', '130302', '海港区');
INSERT INTO `hi_region` VALUES ('78', '76', '130303', '山海关区');
INSERT INTO `hi_region` VALUES ('79', '76', '130304', '北戴河区');
INSERT INTO `hi_region` VALUES ('80', '76', '130306', '抚宁区');
INSERT INTO `hi_region` VALUES ('81', '76', '130321', '青龙满族自治县');
INSERT INTO `hi_region` VALUES ('82', '76', '130322', '昌黎县');
INSERT INTO `hi_region` VALUES ('83', '76', '130324', '卢龙县');
INSERT INTO `hi_region` VALUES ('84', '37', '130400', '邯郸市');
INSERT INTO `hi_region` VALUES ('85', '84', '130402', '邯山区');
INSERT INTO `hi_region` VALUES ('86', '84', '130403', '丛台区');
INSERT INTO `hi_region` VALUES ('87', '84', '130404', '复兴区');
INSERT INTO `hi_region` VALUES ('88', '84', '130406', '峰峰矿区');
INSERT INTO `hi_region` VALUES ('89', '84', '130407', '肥乡区');
INSERT INTO `hi_region` VALUES ('90', '84', '130408', '永年区');
INSERT INTO `hi_region` VALUES ('91', '84', '130423', '临漳县');
INSERT INTO `hi_region` VALUES ('92', '84', '130424', '成安县');
INSERT INTO `hi_region` VALUES ('93', '84', '130425', '大名县');
INSERT INTO `hi_region` VALUES ('94', '84', '130426', '涉县');
INSERT INTO `hi_region` VALUES ('95', '84', '130427', '磁县');
INSERT INTO `hi_region` VALUES ('96', '84', '130430', '邱县');
INSERT INTO `hi_region` VALUES ('97', '84', '130431', '鸡泽县');
INSERT INTO `hi_region` VALUES ('98', '84', '130432', '广平县');
INSERT INTO `hi_region` VALUES ('99', '84', '130433', '馆陶县');
INSERT INTO `hi_region` VALUES ('100', '84', '130434', '魏县');
INSERT INTO `hi_region` VALUES ('101', '84', '130435', '曲周县');
INSERT INTO `hi_region` VALUES ('102', '84', '130481', '武安市');
INSERT INTO `hi_region` VALUES ('103', '37', '130500', '邢台市');
INSERT INTO `hi_region` VALUES ('104', '103', '130502', '桥东区');
INSERT INTO `hi_region` VALUES ('105', '103', '130503', '桥西区');
INSERT INTO `hi_region` VALUES ('106', '103', '130521', '邢台县');
INSERT INTO `hi_region` VALUES ('107', '103', '130522', '临城县');
INSERT INTO `hi_region` VALUES ('108', '103', '130523', '内丘县');
INSERT INTO `hi_region` VALUES ('109', '103', '130524', '柏乡县');
INSERT INTO `hi_region` VALUES ('110', '103', '130525', '隆尧县');
INSERT INTO `hi_region` VALUES ('111', '103', '130526', '任县');
INSERT INTO `hi_region` VALUES ('112', '103', '130527', '南和县');
INSERT INTO `hi_region` VALUES ('113', '103', '130528', '宁晋县');
INSERT INTO `hi_region` VALUES ('114', '103', '130529', '巨鹿县');
INSERT INTO `hi_region` VALUES ('115', '103', '130530', '新河县');
INSERT INTO `hi_region` VALUES ('116', '103', '130531', '广宗县');
INSERT INTO `hi_region` VALUES ('117', '103', '130532', '平乡县');
INSERT INTO `hi_region` VALUES ('118', '103', '130533', '威县');
INSERT INTO `hi_region` VALUES ('119', '103', '130534', '清河县');
INSERT INTO `hi_region` VALUES ('120', '103', '130535', '临西县');
INSERT INTO `hi_region` VALUES ('121', '103', '130581', '南宫市');
INSERT INTO `hi_region` VALUES ('122', '103', '130582', '沙河市');
INSERT INTO `hi_region` VALUES ('123', '37', '130600', '保定市');
INSERT INTO `hi_region` VALUES ('124', '123', '130602', '竞秀区');
INSERT INTO `hi_region` VALUES ('125', '123', '130604', '南市区');
INSERT INTO `hi_region` VALUES ('126', '123', '130606', '莲池区');
INSERT INTO `hi_region` VALUES ('127', '123', '130607', '满城区');
INSERT INTO `hi_region` VALUES ('128', '123', '130608', '清苑区');
INSERT INTO `hi_region` VALUES ('129', '123', '130609', '徐水区');
INSERT INTO `hi_region` VALUES ('130', '123', '130623', '涞水县');
INSERT INTO `hi_region` VALUES ('131', '123', '130624', '阜平县');
INSERT INTO `hi_region` VALUES ('132', '123', '130626', '定兴县');
INSERT INTO `hi_region` VALUES ('133', '123', '130627', '唐县');
INSERT INTO `hi_region` VALUES ('134', '123', '130628', '高阳县');
INSERT INTO `hi_region` VALUES ('135', '123', '130629', '容城县');
INSERT INTO `hi_region` VALUES ('136', '123', '130630', '涞源县');
INSERT INTO `hi_region` VALUES ('137', '123', '130631', '望都县');
INSERT INTO `hi_region` VALUES ('138', '123', '130632', '安新县');
INSERT INTO `hi_region` VALUES ('139', '123', '130633', '易县');
INSERT INTO `hi_region` VALUES ('140', '123', '130634', '曲阳县');
INSERT INTO `hi_region` VALUES ('141', '123', '130635', '蠡县');
INSERT INTO `hi_region` VALUES ('142', '123', '130636', '顺平县');
INSERT INTO `hi_region` VALUES ('143', '123', '130637', '博野县');
INSERT INTO `hi_region` VALUES ('144', '123', '130638', '雄县');
INSERT INTO `hi_region` VALUES ('145', '123', '130681', '涿州市');
INSERT INTO `hi_region` VALUES ('146', '123', '130682', '定州市');
INSERT INTO `hi_region` VALUES ('147', '123', '130683', '安国市');
INSERT INTO `hi_region` VALUES ('148', '123', '130684', '高碑店市');
INSERT INTO `hi_region` VALUES ('149', '37', '130700', '张家口市');
INSERT INTO `hi_region` VALUES ('150', '149', '130702', '桥东区');
INSERT INTO `hi_region` VALUES ('151', '149', '130703', '桥西区');
INSERT INTO `hi_region` VALUES ('152', '149', '130705', '宣化区');
INSERT INTO `hi_region` VALUES ('153', '149', '130706', '下花园区');
INSERT INTO `hi_region` VALUES ('154', '149', '130708', '万全区');
INSERT INTO `hi_region` VALUES ('155', '149', '130709', '崇礼区');
INSERT INTO `hi_region` VALUES ('156', '149', '130722', '张北县');
INSERT INTO `hi_region` VALUES ('157', '149', '130723', '康保县');
INSERT INTO `hi_region` VALUES ('158', '149', '130724', '沽源县');
INSERT INTO `hi_region` VALUES ('159', '149', '130725', '尚义县');
INSERT INTO `hi_region` VALUES ('160', '149', '130726', '蔚县');
INSERT INTO `hi_region` VALUES ('161', '149', '130727', '阳原县');
INSERT INTO `hi_region` VALUES ('162', '149', '130728', '怀安县');
INSERT INTO `hi_region` VALUES ('163', '149', '130730', '怀来县');
INSERT INTO `hi_region` VALUES ('164', '149', '130731', '涿鹿县');
INSERT INTO `hi_region` VALUES ('165', '149', '130732', '赤城县');
INSERT INTO `hi_region` VALUES ('166', '37', '130800', '承德市');
INSERT INTO `hi_region` VALUES ('167', '166', '130802', '双桥区');
INSERT INTO `hi_region` VALUES ('168', '166', '130803', '双滦区');
INSERT INTO `hi_region` VALUES ('169', '166', '130804', '鹰手营子矿区');
INSERT INTO `hi_region` VALUES ('170', '166', '130821', '承德县');
INSERT INTO `hi_region` VALUES ('171', '166', '130822', '兴隆县');
INSERT INTO `hi_region` VALUES ('172', '166', '130823', '平泉县');
INSERT INTO `hi_region` VALUES ('173', '166', '130824', '滦平县');
INSERT INTO `hi_region` VALUES ('174', '166', '130825', '隆化县');
INSERT INTO `hi_region` VALUES ('175', '166', '130826', '丰宁满族自治县');
INSERT INTO `hi_region` VALUES ('176', '166', '130827', '宽城满族自治县');
INSERT INTO `hi_region` VALUES ('177', '166', '130828', '围场满族蒙古族自治县');
INSERT INTO `hi_region` VALUES ('178', '37', '130900', '沧州市');
INSERT INTO `hi_region` VALUES ('179', '178', '130902', '新华区');
INSERT INTO `hi_region` VALUES ('180', '178', '130903', '运河区');
INSERT INTO `hi_region` VALUES ('181', '178', '130921', '沧县');
INSERT INTO `hi_region` VALUES ('182', '178', '130922', '青县');
INSERT INTO `hi_region` VALUES ('183', '178', '130923', '东光县');
INSERT INTO `hi_region` VALUES ('184', '178', '130924', '海兴县');
INSERT INTO `hi_region` VALUES ('185', '178', '130925', '盐山县');
INSERT INTO `hi_region` VALUES ('186', '178', '130926', '肃宁县');
INSERT INTO `hi_region` VALUES ('187', '178', '130927', '南皮县');
INSERT INTO `hi_region` VALUES ('188', '178', '130928', '吴桥县');
INSERT INTO `hi_region` VALUES ('189', '178', '130929', '献县');
INSERT INTO `hi_region` VALUES ('190', '178', '130930', '孟村回族自治县');
INSERT INTO `hi_region` VALUES ('191', '178', '130981', '泊头市');
INSERT INTO `hi_region` VALUES ('192', '178', '130982', '任丘市');
INSERT INTO `hi_region` VALUES ('193', '178', '130983', '黄骅市');
INSERT INTO `hi_region` VALUES ('194', '178', '130984', '河间市');
INSERT INTO `hi_region` VALUES ('195', '37', '131000', '廊坊市');
INSERT INTO `hi_region` VALUES ('196', '195', '131002', '安次区');
INSERT INTO `hi_region` VALUES ('197', '195', '131003', '广阳区');
INSERT INTO `hi_region` VALUES ('198', '195', '131022', '固安县');
INSERT INTO `hi_region` VALUES ('199', '195', '131023', '永清县');
INSERT INTO `hi_region` VALUES ('200', '195', '131024', '香河县');
INSERT INTO `hi_region` VALUES ('201', '195', '131025', '大城县');
INSERT INTO `hi_region` VALUES ('202', '195', '131026', '文安县');
INSERT INTO `hi_region` VALUES ('203', '195', '131028', '大厂回族自治县');
INSERT INTO `hi_region` VALUES ('204', '195', '131081', '霸州市');
INSERT INTO `hi_region` VALUES ('205', '195', '131082', '三河市');
INSERT INTO `hi_region` VALUES ('206', '37', '131100', '衡水市');
INSERT INTO `hi_region` VALUES ('207', '206', '131102', '桃城区');
INSERT INTO `hi_region` VALUES ('208', '206', '131103', '冀州区');
INSERT INTO `hi_region` VALUES ('209', '206', '131121', '枣强县');
INSERT INTO `hi_region` VALUES ('210', '206', '131122', '武邑县');
INSERT INTO `hi_region` VALUES ('211', '206', '131123', '武强县');
INSERT INTO `hi_region` VALUES ('212', '206', '131124', '饶阳县');
INSERT INTO `hi_region` VALUES ('213', '206', '131125', '安平县');
INSERT INTO `hi_region` VALUES ('214', '206', '131126', '故城县');
INSERT INTO `hi_region` VALUES ('215', '206', '131127', '景县');
INSERT INTO `hi_region` VALUES ('216', '206', '131128', '阜城县');
INSERT INTO `hi_region` VALUES ('217', '206', '131182', '深州市');
INSERT INTO `hi_region` VALUES ('218', '0', '140000', '山西省');
INSERT INTO `hi_region` VALUES ('219', '218', '140100', '太原市');
INSERT INTO `hi_region` VALUES ('220', '219', '140105', '小店区');
INSERT INTO `hi_region` VALUES ('221', '219', '140106', '迎泽区');
INSERT INTO `hi_region` VALUES ('222', '219', '140107', '杏花岭区');
INSERT INTO `hi_region` VALUES ('223', '219', '140108', '尖草坪区');
INSERT INTO `hi_region` VALUES ('224', '219', '140109', '万柏林区');
INSERT INTO `hi_region` VALUES ('225', '219', '140110', '晋源区');
INSERT INTO `hi_region` VALUES ('226', '219', '140121', '清徐县');
INSERT INTO `hi_region` VALUES ('227', '219', '140122', '阳曲县');
INSERT INTO `hi_region` VALUES ('228', '219', '140123', '娄烦县');
INSERT INTO `hi_region` VALUES ('229', '219', '140181', '古交市');
INSERT INTO `hi_region` VALUES ('230', '218', '140200', '大同市');
INSERT INTO `hi_region` VALUES ('231', '230', '140202', '城区');
INSERT INTO `hi_region` VALUES ('232', '230', '140203', '矿区');
INSERT INTO `hi_region` VALUES ('233', '230', '140211', '南郊区');
INSERT INTO `hi_region` VALUES ('234', '230', '140212', '新荣区');
INSERT INTO `hi_region` VALUES ('235', '230', '140221', '阳高县');
INSERT INTO `hi_region` VALUES ('236', '230', '140222', '天镇县');
INSERT INTO `hi_region` VALUES ('237', '230', '140223', '广灵县');
INSERT INTO `hi_region` VALUES ('238', '230', '140224', '灵丘县');
INSERT INTO `hi_region` VALUES ('239', '230', '140225', '浑源县');
INSERT INTO `hi_region` VALUES ('240', '230', '140226', '左云县');
INSERT INTO `hi_region` VALUES ('241', '230', '140227', '大同县');
INSERT INTO `hi_region` VALUES ('242', '218', '140300', '阳泉市');
INSERT INTO `hi_region` VALUES ('243', '242', '140302', '城区');
INSERT INTO `hi_region` VALUES ('244', '242', '140303', '矿区');
INSERT INTO `hi_region` VALUES ('245', '242', '140311', '郊区');
INSERT INTO `hi_region` VALUES ('246', '242', '140321', '平定县');
INSERT INTO `hi_region` VALUES ('247', '242', '140322', '盂县');
INSERT INTO `hi_region` VALUES ('248', '218', '140400', '长治市');
INSERT INTO `hi_region` VALUES ('249', '248', '140402', '城区');
INSERT INTO `hi_region` VALUES ('250', '248', '140411', '郊区');
INSERT INTO `hi_region` VALUES ('251', '248', '140421', '长治县');
INSERT INTO `hi_region` VALUES ('252', '248', '140423', '襄垣县');
INSERT INTO `hi_region` VALUES ('253', '248', '140424', '屯留县');
INSERT INTO `hi_region` VALUES ('254', '248', '140425', '平顺县');
INSERT INTO `hi_region` VALUES ('255', '248', '140426', '黎城县');
INSERT INTO `hi_region` VALUES ('256', '248', '140427', '壶关县');
INSERT INTO `hi_region` VALUES ('257', '248', '140428', '长子县');
INSERT INTO `hi_region` VALUES ('258', '248', '140429', '武乡县');
INSERT INTO `hi_region` VALUES ('259', '248', '140430', '沁县');
INSERT INTO `hi_region` VALUES ('260', '248', '140431', '沁源县');
INSERT INTO `hi_region` VALUES ('261', '248', '140481', '潞城市');
INSERT INTO `hi_region` VALUES ('262', '218', '140500', '晋城市');
INSERT INTO `hi_region` VALUES ('263', '262', '140502', '城区');
INSERT INTO `hi_region` VALUES ('264', '262', '140521', '沁水县');
INSERT INTO `hi_region` VALUES ('265', '262', '140522', '阳城县');
INSERT INTO `hi_region` VALUES ('266', '262', '140524', '陵川县');
INSERT INTO `hi_region` VALUES ('267', '262', '140525', '泽州县');
INSERT INTO `hi_region` VALUES ('268', '262', '140581', '高平市');
INSERT INTO `hi_region` VALUES ('269', '218', '140600', '朔州市');
INSERT INTO `hi_region` VALUES ('270', '269', '140602', '朔城区');
INSERT INTO `hi_region` VALUES ('271', '269', '140603', '平鲁区');
INSERT INTO `hi_region` VALUES ('272', '269', '140621', '山阴县');
INSERT INTO `hi_region` VALUES ('273', '269', '140622', '应县');
INSERT INTO `hi_region` VALUES ('274', '269', '140623', '右玉县');
INSERT INTO `hi_region` VALUES ('275', '269', '140624', '怀仁县');
INSERT INTO `hi_region` VALUES ('276', '218', '140700', '晋中市');
INSERT INTO `hi_region` VALUES ('277', '276', '140702', '榆次区');
INSERT INTO `hi_region` VALUES ('278', '276', '140721', '榆社县');
INSERT INTO `hi_region` VALUES ('279', '276', '140722', '左权县');
INSERT INTO `hi_region` VALUES ('280', '276', '140723', '和顺县');
INSERT INTO `hi_region` VALUES ('281', '276', '140724', '昔阳县');
INSERT INTO `hi_region` VALUES ('282', '276', '140725', '寿阳县');
INSERT INTO `hi_region` VALUES ('283', '276', '140726', '太谷县');
INSERT INTO `hi_region` VALUES ('284', '276', '140727', '祁县');
INSERT INTO `hi_region` VALUES ('285', '276', '140728', '平遥县');
INSERT INTO `hi_region` VALUES ('286', '276', '140729', '灵石县');
INSERT INTO `hi_region` VALUES ('287', '276', '140781', '介休市');
INSERT INTO `hi_region` VALUES ('288', '218', '140800', '运城市');
INSERT INTO `hi_region` VALUES ('289', '288', '140802', '盐湖区');
INSERT INTO `hi_region` VALUES ('290', '288', '140821', '临猗县');
INSERT INTO `hi_region` VALUES ('291', '288', '140822', '万荣县');
INSERT INTO `hi_region` VALUES ('292', '288', '140823', '闻喜县');
INSERT INTO `hi_region` VALUES ('293', '288', '140824', '稷山县');
INSERT INTO `hi_region` VALUES ('294', '288', '140825', '新绛县');
INSERT INTO `hi_region` VALUES ('295', '288', '140826', '绛县');
INSERT INTO `hi_region` VALUES ('296', '288', '140827', '垣曲县');
INSERT INTO `hi_region` VALUES ('297', '288', '140828', '夏县');
INSERT INTO `hi_region` VALUES ('298', '288', '140829', '平陆县');
INSERT INTO `hi_region` VALUES ('299', '288', '140830', '芮城县');
INSERT INTO `hi_region` VALUES ('300', '288', '140881', '永济市');
INSERT INTO `hi_region` VALUES ('301', '288', '140882', '河津市');
INSERT INTO `hi_region` VALUES ('302', '218', '140900', '忻州市');
INSERT INTO `hi_region` VALUES ('303', '302', '140902', '忻府区');
INSERT INTO `hi_region` VALUES ('304', '302', '140921', '定襄县');
INSERT INTO `hi_region` VALUES ('305', '302', '140922', '五台县');
INSERT INTO `hi_region` VALUES ('306', '302', '140923', '代县');
INSERT INTO `hi_region` VALUES ('307', '302', '140924', '繁峙县');
INSERT INTO `hi_region` VALUES ('308', '302', '140925', '宁武县');
INSERT INTO `hi_region` VALUES ('309', '302', '140926', '静乐县');
INSERT INTO `hi_region` VALUES ('310', '302', '140927', '神池县');
INSERT INTO `hi_region` VALUES ('311', '302', '140928', '五寨县');
INSERT INTO `hi_region` VALUES ('312', '302', '140929', '岢岚县');
INSERT INTO `hi_region` VALUES ('313', '302', '140930', '河曲县');
INSERT INTO `hi_region` VALUES ('314', '302', '140931', '保德县');
INSERT INTO `hi_region` VALUES ('315', '302', '140932', '偏关县');
INSERT INTO `hi_region` VALUES ('316', '302', '140981', '原平市');
INSERT INTO `hi_region` VALUES ('317', '218', '141000', '临汾市');
INSERT INTO `hi_region` VALUES ('318', '317', '141002', '尧都区');
INSERT INTO `hi_region` VALUES ('319', '317', '141021', '曲沃县');
INSERT INTO `hi_region` VALUES ('320', '317', '141022', '翼城县');
INSERT INTO `hi_region` VALUES ('321', '317', '141023', '襄汾县');
INSERT INTO `hi_region` VALUES ('322', '317', '141024', '洪洞县');
INSERT INTO `hi_region` VALUES ('323', '317', '141025', '古县');
INSERT INTO `hi_region` VALUES ('324', '317', '141026', '安泽县');
INSERT INTO `hi_region` VALUES ('325', '317', '141027', '浮山县');
INSERT INTO `hi_region` VALUES ('326', '317', '141028', '吉县');
INSERT INTO `hi_region` VALUES ('327', '317', '141029', '乡宁县');
INSERT INTO `hi_region` VALUES ('328', '317', '141030', '大宁县');
INSERT INTO `hi_region` VALUES ('329', '317', '141031', '隰县');
INSERT INTO `hi_region` VALUES ('330', '317', '141032', '永和县');
INSERT INTO `hi_region` VALUES ('331', '317', '141033', '蒲县');
INSERT INTO `hi_region` VALUES ('332', '317', '141034', '汾西县');
INSERT INTO `hi_region` VALUES ('333', '317', '141081', '侯马市');
INSERT INTO `hi_region` VALUES ('334', '317', '141082', '霍州市');
INSERT INTO `hi_region` VALUES ('335', '218', '141100', '吕梁市');
INSERT INTO `hi_region` VALUES ('336', '335', '141102', '离石区');
INSERT INTO `hi_region` VALUES ('337', '335', '141121', '文水县');
INSERT INTO `hi_region` VALUES ('338', '335', '141122', '交城县');
INSERT INTO `hi_region` VALUES ('339', '335', '141123', '兴县');
INSERT INTO `hi_region` VALUES ('340', '335', '141124', '临县');
INSERT INTO `hi_region` VALUES ('341', '335', '141125', '柳林县');
INSERT INTO `hi_region` VALUES ('342', '335', '141126', '石楼县');
INSERT INTO `hi_region` VALUES ('343', '335', '141127', '岚县');
INSERT INTO `hi_region` VALUES ('344', '335', '141128', '方山县');
INSERT INTO `hi_region` VALUES ('345', '335', '141129', '中阳县');
INSERT INTO `hi_region` VALUES ('346', '335', '141130', '交口县');
INSERT INTO `hi_region` VALUES ('347', '335', '141181', '孝义市');
INSERT INTO `hi_region` VALUES ('348', '335', '141182', '汾阳市');
INSERT INTO `hi_region` VALUES ('349', '0', '150000', '内蒙古自治区');
INSERT INTO `hi_region` VALUES ('350', '349', '150100', '呼和浩特市');
INSERT INTO `hi_region` VALUES ('351', '350', '150102', '新城区');
INSERT INTO `hi_region` VALUES ('352', '350', '150103', '回民区');
INSERT INTO `hi_region` VALUES ('353', '350', '150104', '玉泉区');
INSERT INTO `hi_region` VALUES ('354', '350', '150105', '赛罕区');
INSERT INTO `hi_region` VALUES ('355', '350', '150121', '土默特左旗');
INSERT INTO `hi_region` VALUES ('356', '350', '150122', '托克托县');
INSERT INTO `hi_region` VALUES ('357', '350', '150123', '和林格尔县');
INSERT INTO `hi_region` VALUES ('358', '350', '150124', '清水河县');
INSERT INTO `hi_region` VALUES ('359', '350', '150125', '武川县');
INSERT INTO `hi_region` VALUES ('360', '349', '150200', '包头市');
INSERT INTO `hi_region` VALUES ('361', '360', '150202', '东河区');
INSERT INTO `hi_region` VALUES ('362', '360', '150203', '昆都仑区');
INSERT INTO `hi_region` VALUES ('363', '360', '150204', '青山区');
INSERT INTO `hi_region` VALUES ('364', '360', '150205', '石拐区');
INSERT INTO `hi_region` VALUES ('365', '360', '150206', '白云鄂博矿区');
INSERT INTO `hi_region` VALUES ('366', '360', '150207', '九原区');
INSERT INTO `hi_region` VALUES ('367', '360', '150221', '土默特右旗');
INSERT INTO `hi_region` VALUES ('368', '360', '150222', '固阳县');
INSERT INTO `hi_region` VALUES ('369', '360', '150223', '达尔罕茂明安联合旗');
INSERT INTO `hi_region` VALUES ('370', '349', '150300', '乌海市');
INSERT INTO `hi_region` VALUES ('371', '370', '150302', '海勃湾区');
INSERT INTO `hi_region` VALUES ('372', '370', '150303', '海南区');
INSERT INTO `hi_region` VALUES ('373', '370', '150304', '乌达区');
INSERT INTO `hi_region` VALUES ('374', '349', '150400', '赤峰市');
INSERT INTO `hi_region` VALUES ('375', '374', '150402', '红山区');
INSERT INTO `hi_region` VALUES ('376', '374', '150403', '元宝山区');
INSERT INTO `hi_region` VALUES ('377', '374', '150404', '松山区');
INSERT INTO `hi_region` VALUES ('378', '374', '150421', '阿鲁科尔沁旗');
INSERT INTO `hi_region` VALUES ('379', '374', '150422', '巴林左旗');
INSERT INTO `hi_region` VALUES ('380', '374', '150423', '巴林右旗');
INSERT INTO `hi_region` VALUES ('381', '374', '150424', '林西县');
INSERT INTO `hi_region` VALUES ('382', '374', '150425', '克什克腾旗');
INSERT INTO `hi_region` VALUES ('383', '374', '150426', '翁牛特旗');
INSERT INTO `hi_region` VALUES ('384', '374', '150428', '喀喇沁旗');
INSERT INTO `hi_region` VALUES ('385', '374', '150429', '宁城县');
INSERT INTO `hi_region` VALUES ('386', '374', '150430', '敖汉旗');
INSERT INTO `hi_region` VALUES ('387', '349', '150500', '通辽市');
INSERT INTO `hi_region` VALUES ('388', '387', '150502', '科尔沁区');
INSERT INTO `hi_region` VALUES ('389', '387', '150521', '科尔沁左翼中旗');
INSERT INTO `hi_region` VALUES ('390', '387', '150522', '科尔沁左翼后旗');
INSERT INTO `hi_region` VALUES ('391', '387', '150523', '开鲁县');
INSERT INTO `hi_region` VALUES ('392', '387', '150524', '库伦旗');
INSERT INTO `hi_region` VALUES ('393', '387', '150525', '奈曼旗');
INSERT INTO `hi_region` VALUES ('394', '387', '150526', '扎鲁特旗');
INSERT INTO `hi_region` VALUES ('395', '387', '150581', '霍林郭勒市');
INSERT INTO `hi_region` VALUES ('396', '349', '150600', '鄂尔多斯市');
INSERT INTO `hi_region` VALUES ('397', '396', '150602', '东胜区');
INSERT INTO `hi_region` VALUES ('398', '396', '150603', '康巴什区');
INSERT INTO `hi_region` VALUES ('399', '396', '150621', '达拉特旗');
INSERT INTO `hi_region` VALUES ('400', '396', '150622', '准格尔旗');
INSERT INTO `hi_region` VALUES ('401', '396', '150623', '鄂托克前旗');
INSERT INTO `hi_region` VALUES ('402', '396', '150624', '鄂托克旗');
INSERT INTO `hi_region` VALUES ('403', '396', '150625', '杭锦旗');
INSERT INTO `hi_region` VALUES ('404', '396', '150626', '乌审旗');
INSERT INTO `hi_region` VALUES ('405', '396', '150627', '伊金霍洛旗');
INSERT INTO `hi_region` VALUES ('406', '349', '150700', '呼伦贝尔市');
INSERT INTO `hi_region` VALUES ('407', '406', '150702', '海拉尔区');
INSERT INTO `hi_region` VALUES ('408', '406', '150703', '扎赉诺尔区');
INSERT INTO `hi_region` VALUES ('409', '406', '150721', '阿荣旗');
INSERT INTO `hi_region` VALUES ('410', '406', '150722', '莫力达瓦达斡尔族自治旗');
INSERT INTO `hi_region` VALUES ('411', '406', '150723', '鄂伦春自治旗');
INSERT INTO `hi_region` VALUES ('412', '406', '150724', '鄂温克族自治旗');
INSERT INTO `hi_region` VALUES ('413', '406', '150725', '陈巴尔虎旗');
INSERT INTO `hi_region` VALUES ('414', '406', '150726', '新巴尔虎左旗');
INSERT INTO `hi_region` VALUES ('415', '406', '150727', '新巴尔虎右旗');
INSERT INTO `hi_region` VALUES ('416', '406', '150781', '满洲里市');
INSERT INTO `hi_region` VALUES ('417', '406', '150782', '牙克石市');
INSERT INTO `hi_region` VALUES ('418', '406', '150783', '扎兰屯市');
INSERT INTO `hi_region` VALUES ('419', '406', '150784', '额尔古纳市');
INSERT INTO `hi_region` VALUES ('420', '406', '150785', '根河市');
INSERT INTO `hi_region` VALUES ('421', '349', '150800', '巴彦淖尔市');
INSERT INTO `hi_region` VALUES ('422', '421', '150802', '临河区');
INSERT INTO `hi_region` VALUES ('423', '421', '150821', '五原县');
INSERT INTO `hi_region` VALUES ('424', '421', '150822', '磴口县');
INSERT INTO `hi_region` VALUES ('425', '421', '150823', '乌拉特前旗');
INSERT INTO `hi_region` VALUES ('426', '421', '150824', '乌拉特中旗');
INSERT INTO `hi_region` VALUES ('427', '421', '150825', '乌拉特后旗');
INSERT INTO `hi_region` VALUES ('428', '421', '150826', '杭锦后旗');
INSERT INTO `hi_region` VALUES ('429', '349', '150900', '乌兰察布市');
INSERT INTO `hi_region` VALUES ('430', '429', '150902', '集宁区');
INSERT INTO `hi_region` VALUES ('431', '429', '150921', '卓资县');
INSERT INTO `hi_region` VALUES ('432', '429', '150922', '化德县');
INSERT INTO `hi_region` VALUES ('433', '429', '150923', '商都县');
INSERT INTO `hi_region` VALUES ('434', '429', '150924', '兴和县');
INSERT INTO `hi_region` VALUES ('435', '429', '150925', '凉城县');
INSERT INTO `hi_region` VALUES ('436', '429', '150926', '察哈尔右翼前旗');
INSERT INTO `hi_region` VALUES ('437', '429', '150927', '察哈尔右翼中旗');
INSERT INTO `hi_region` VALUES ('438', '429', '150928', '察哈尔右翼后旗');
INSERT INTO `hi_region` VALUES ('439', '429', '150929', '四子王旗');
INSERT INTO `hi_region` VALUES ('440', '429', '150981', '丰镇市');
INSERT INTO `hi_region` VALUES ('441', '349', '152200', '兴安盟');
INSERT INTO `hi_region` VALUES ('442', '441', '152201', '乌兰浩特市');
INSERT INTO `hi_region` VALUES ('443', '441', '152202', '阿尔山市');
INSERT INTO `hi_region` VALUES ('444', '441', '152221', '科尔沁右翼前旗');
INSERT INTO `hi_region` VALUES ('445', '441', '152222', '科尔沁右翼中旗');
INSERT INTO `hi_region` VALUES ('446', '441', '152223', '扎赉特旗');
INSERT INTO `hi_region` VALUES ('447', '441', '152224', '突泉县');
INSERT INTO `hi_region` VALUES ('448', '349', '152500', '锡林郭勒盟');
INSERT INTO `hi_region` VALUES ('449', '448', '152501', '二连浩特市');
INSERT INTO `hi_region` VALUES ('450', '448', '152502', '锡林浩特市');
INSERT INTO `hi_region` VALUES ('451', '448', '152522', '阿巴嘎旗');
INSERT INTO `hi_region` VALUES ('452', '448', '152523', '苏尼特左旗');
INSERT INTO `hi_region` VALUES ('453', '448', '152524', '苏尼特右旗');
INSERT INTO `hi_region` VALUES ('454', '448', '152525', '东乌珠穆沁旗');
INSERT INTO `hi_region` VALUES ('455', '448', '152526', '西乌珠穆沁旗');
INSERT INTO `hi_region` VALUES ('456', '448', '152527', '太仆寺旗');
INSERT INTO `hi_region` VALUES ('457', '448', '152528', '镶黄旗');
INSERT INTO `hi_region` VALUES ('458', '448', '152529', '正镶白旗');
INSERT INTO `hi_region` VALUES ('459', '448', '152530', '正蓝旗');
INSERT INTO `hi_region` VALUES ('460', '448', '152531', '多伦县');
INSERT INTO `hi_region` VALUES ('461', '349', '152900', '阿拉善盟');
INSERT INTO `hi_region` VALUES ('462', '461', '152921', '阿拉善左旗');
INSERT INTO `hi_region` VALUES ('463', '461', '152922', '阿拉善右旗');
INSERT INTO `hi_region` VALUES ('464', '461', '152923', '额济纳旗');
INSERT INTO `hi_region` VALUES ('465', '0', '210000', '辽宁省');
INSERT INTO `hi_region` VALUES ('466', '465', '210100', '沈阳市');
INSERT INTO `hi_region` VALUES ('467', '466', '210102', '和平区');
INSERT INTO `hi_region` VALUES ('468', '466', '210103', '沈河区');
INSERT INTO `hi_region` VALUES ('469', '466', '210104', '大东区');
INSERT INTO `hi_region` VALUES ('470', '466', '210105', '皇姑区');
INSERT INTO `hi_region` VALUES ('471', '466', '210106', '铁西区');
INSERT INTO `hi_region` VALUES ('472', '466', '210111', '苏家屯区');
INSERT INTO `hi_region` VALUES ('473', '466', '210112', '浑南区');
INSERT INTO `hi_region` VALUES ('474', '466', '210113', '沈北新区');
INSERT INTO `hi_region` VALUES ('475', '466', '210114', '于洪区');
INSERT INTO `hi_region` VALUES ('476', '466', '210115', '辽中区');
INSERT INTO `hi_region` VALUES ('477', '466', '210123', '康平县');
INSERT INTO `hi_region` VALUES ('478', '466', '210124', '法库县');
INSERT INTO `hi_region` VALUES ('479', '466', '210181', '新民市');
INSERT INTO `hi_region` VALUES ('480', '465', '210200', '大连市');
INSERT INTO `hi_region` VALUES ('481', '480', '210202', '中山区');
INSERT INTO `hi_region` VALUES ('482', '480', '210203', '西岗区');
INSERT INTO `hi_region` VALUES ('483', '480', '210204', '沙河口区');
INSERT INTO `hi_region` VALUES ('484', '480', '210211', '甘井子区');
INSERT INTO `hi_region` VALUES ('485', '480', '210212', '旅顺口区');
INSERT INTO `hi_region` VALUES ('486', '480', '210213', '金州区');
INSERT INTO `hi_region` VALUES ('487', '480', '210224', '长海县');
INSERT INTO `hi_region` VALUES ('488', '480', '210281', '瓦房店市');
INSERT INTO `hi_region` VALUES ('489', '480', '210214', '普兰店区');
INSERT INTO `hi_region` VALUES ('490', '480', '210283', '庄河市');
INSERT INTO `hi_region` VALUES ('491', '465', '210300', '鞍山市');
INSERT INTO `hi_region` VALUES ('492', '491', '210302', '铁东区');
INSERT INTO `hi_region` VALUES ('493', '491', '210303', '铁西区');
INSERT INTO `hi_region` VALUES ('494', '491', '210304', '立山区');
INSERT INTO `hi_region` VALUES ('495', '491', '210311', '千山区');
INSERT INTO `hi_region` VALUES ('496', '491', '210321', '台安县');
INSERT INTO `hi_region` VALUES ('497', '491', '210323', '岫岩满族自治县');
INSERT INTO `hi_region` VALUES ('498', '491', '210381', '海城市');
INSERT INTO `hi_region` VALUES ('499', '465', '210400', '抚顺市');
INSERT INTO `hi_region` VALUES ('500', '499', '210402', '新抚区');
INSERT INTO `hi_region` VALUES ('501', '499', '210403', '东洲区');
INSERT INTO `hi_region` VALUES ('502', '499', '210404', '望花区');
INSERT INTO `hi_region` VALUES ('503', '499', '210411', '顺城区');
INSERT INTO `hi_region` VALUES ('504', '499', '210421', '抚顺县');
INSERT INTO `hi_region` VALUES ('505', '499', '210422', '新宾满族自治县');
INSERT INTO `hi_region` VALUES ('506', '499', '210423', '清原满族自治县');
INSERT INTO `hi_region` VALUES ('507', '465', '210500', '本溪市');
INSERT INTO `hi_region` VALUES ('508', '507', '210502', '平山区');
INSERT INTO `hi_region` VALUES ('509', '507', '210503', '溪湖区');
INSERT INTO `hi_region` VALUES ('510', '507', '210504', '明山区');
INSERT INTO `hi_region` VALUES ('511', '507', '210505', '南芬区');
INSERT INTO `hi_region` VALUES ('512', '507', '210521', '本溪满族自治县');
INSERT INTO `hi_region` VALUES ('513', '507', '210522', '桓仁满族自治县');
INSERT INTO `hi_region` VALUES ('514', '465', '210600', '丹东市');
INSERT INTO `hi_region` VALUES ('515', '514', '210602', '元宝区');
INSERT INTO `hi_region` VALUES ('516', '514', '210603', '振兴区');
INSERT INTO `hi_region` VALUES ('517', '514', '210604', '振安区');
INSERT INTO `hi_region` VALUES ('518', '514', '210624', '宽甸满族自治县');
INSERT INTO `hi_region` VALUES ('519', '514', '210681', '东港市');
INSERT INTO `hi_region` VALUES ('520', '514', '210682', '凤城市');
INSERT INTO `hi_region` VALUES ('521', '465', '210700', '锦州市');
INSERT INTO `hi_region` VALUES ('522', '521', '210702', '古塔区');
INSERT INTO `hi_region` VALUES ('523', '521', '210703', '凌河区');
INSERT INTO `hi_region` VALUES ('524', '521', '210711', '太和区');
INSERT INTO `hi_region` VALUES ('525', '521', '210726', '黑山县');
INSERT INTO `hi_region` VALUES ('526', '521', '210727', '义县');
INSERT INTO `hi_region` VALUES ('527', '521', '210781', '凌海市');
INSERT INTO `hi_region` VALUES ('528', '521', '210782', '北镇市');
INSERT INTO `hi_region` VALUES ('529', '465', '210800', '营口市');
INSERT INTO `hi_region` VALUES ('530', '529', '210802', '站前区');
INSERT INTO `hi_region` VALUES ('531', '529', '210803', '西市区');
INSERT INTO `hi_region` VALUES ('532', '529', '210804', '鲅鱼圈区');
INSERT INTO `hi_region` VALUES ('533', '529', '210811', '老边区');
INSERT INTO `hi_region` VALUES ('534', '529', '210881', '盖州市');
INSERT INTO `hi_region` VALUES ('535', '529', '210882', '大石桥市');
INSERT INTO `hi_region` VALUES ('536', '465', '210900', '阜新市');
INSERT INTO `hi_region` VALUES ('537', '536', '210902', '海州区');
INSERT INTO `hi_region` VALUES ('538', '536', '210903', '新邱区');
INSERT INTO `hi_region` VALUES ('539', '536', '210904', '太平区');
INSERT INTO `hi_region` VALUES ('540', '536', '210905', '清河门区');
INSERT INTO `hi_region` VALUES ('541', '536', '210911', '细河区');
INSERT INTO `hi_region` VALUES ('542', '536', '210921', '阜新蒙古族自治县');
INSERT INTO `hi_region` VALUES ('543', '536', '210922', '彰武县');
INSERT INTO `hi_region` VALUES ('544', '465', '211000', '辽阳市');
INSERT INTO `hi_region` VALUES ('545', '544', '211002', '白塔区');
INSERT INTO `hi_region` VALUES ('546', '544', '211003', '文圣区');
INSERT INTO `hi_region` VALUES ('547', '544', '211004', '宏伟区');
INSERT INTO `hi_region` VALUES ('548', '544', '211005', '弓长岭区');
INSERT INTO `hi_region` VALUES ('549', '544', '211011', '太子河区');
INSERT INTO `hi_region` VALUES ('550', '544', '211021', '辽阳县');
INSERT INTO `hi_region` VALUES ('551', '544', '211081', '灯塔市');
INSERT INTO `hi_region` VALUES ('552', '465', '211100', '盘锦市');
INSERT INTO `hi_region` VALUES ('553', '552', '211102', '双台子区');
INSERT INTO `hi_region` VALUES ('554', '552', '211103', '兴隆台区');
INSERT INTO `hi_region` VALUES ('555', '552', '211104', '大洼区');
INSERT INTO `hi_region` VALUES ('556', '552', '211122', '盘山县');
INSERT INTO `hi_region` VALUES ('557', '465', '211200', '铁岭市');
INSERT INTO `hi_region` VALUES ('558', '557', '211202', '银州区');
INSERT INTO `hi_region` VALUES ('559', '557', '211204', '清河区');
INSERT INTO `hi_region` VALUES ('560', '557', '211221', '铁岭县');
INSERT INTO `hi_region` VALUES ('561', '557', '211223', '西丰县');
INSERT INTO `hi_region` VALUES ('562', '557', '211224', '昌图县');
INSERT INTO `hi_region` VALUES ('563', '557', '211281', '调兵山市');
INSERT INTO `hi_region` VALUES ('564', '557', '211282', '开原市');
INSERT INTO `hi_region` VALUES ('565', '465', '211300', '朝阳市');
INSERT INTO `hi_region` VALUES ('566', '565', '211302', '双塔区');
INSERT INTO `hi_region` VALUES ('567', '565', '211303', '龙城区');
INSERT INTO `hi_region` VALUES ('568', '565', '211321', '朝阳县');
INSERT INTO `hi_region` VALUES ('569', '565', '211322', '建平县');
INSERT INTO `hi_region` VALUES ('570', '565', '211324', '喀喇沁左翼蒙古族自治县');
INSERT INTO `hi_region` VALUES ('571', '565', '211381', '北票市');
INSERT INTO `hi_region` VALUES ('572', '565', '211382', '凌源市');
INSERT INTO `hi_region` VALUES ('573', '465', '211400', '葫芦岛市');
INSERT INTO `hi_region` VALUES ('574', '573', '211402', '连山区');
INSERT INTO `hi_region` VALUES ('575', '573', '211403', '龙港区');
INSERT INTO `hi_region` VALUES ('576', '573', '211404', '南票区');
INSERT INTO `hi_region` VALUES ('577', '573', '211421', '绥中县');
INSERT INTO `hi_region` VALUES ('578', '573', '211422', '建昌县');
INSERT INTO `hi_region` VALUES ('579', '573', '211481', '兴城市');
INSERT INTO `hi_region` VALUES ('580', '0', '220000', '吉林省');
INSERT INTO `hi_region` VALUES ('581', '580', '220100', '长春市');
INSERT INTO `hi_region` VALUES ('582', '581', '220102', '南关区');
INSERT INTO `hi_region` VALUES ('583', '581', '220103', '宽城区');
INSERT INTO `hi_region` VALUES ('584', '581', '220104', '朝阳区');
INSERT INTO `hi_region` VALUES ('585', '581', '220105', '二道区');
INSERT INTO `hi_region` VALUES ('586', '581', '220106', '绿园区');
INSERT INTO `hi_region` VALUES ('587', '581', '220112', '双阳区');
INSERT INTO `hi_region` VALUES ('588', '581', '220113', '九台区');
INSERT INTO `hi_region` VALUES ('589', '581', '220122', '农安县');
INSERT INTO `hi_region` VALUES ('590', '581', '220182', '榆树市');
INSERT INTO `hi_region` VALUES ('591', '581', '220183', '德惠市');
INSERT INTO `hi_region` VALUES ('592', '580', '220200', '吉林市');
INSERT INTO `hi_region` VALUES ('593', '592', '220202', '昌邑区');
INSERT INTO `hi_region` VALUES ('594', '592', '220203', '龙潭区');
INSERT INTO `hi_region` VALUES ('595', '592', '220204', '船营区');
INSERT INTO `hi_region` VALUES ('596', '592', '220211', '丰满区');
INSERT INTO `hi_region` VALUES ('597', '592', '220221', '永吉县');
INSERT INTO `hi_region` VALUES ('598', '592', '220281', '蛟河市');
INSERT INTO `hi_region` VALUES ('599', '592', '220282', '桦甸市');
INSERT INTO `hi_region` VALUES ('600', '592', '220283', '舒兰市');
INSERT INTO `hi_region` VALUES ('601', '592', '220284', '磐石市');
INSERT INTO `hi_region` VALUES ('602', '580', '220300', '四平市');
INSERT INTO `hi_region` VALUES ('603', '602', '220302', '铁西区');
INSERT INTO `hi_region` VALUES ('604', '602', '220303', '铁东区');
INSERT INTO `hi_region` VALUES ('605', '602', '220322', '梨树县');
INSERT INTO `hi_region` VALUES ('606', '602', '220323', '伊通满族自治县');
INSERT INTO `hi_region` VALUES ('607', '602', '220381', '公主岭市');
INSERT INTO `hi_region` VALUES ('608', '602', '220382', '双辽市');
INSERT INTO `hi_region` VALUES ('609', '580', '220400', '辽源市');
INSERT INTO `hi_region` VALUES ('610', '609', '220402', '龙山区');
INSERT INTO `hi_region` VALUES ('611', '609', '220403', '西安区');
INSERT INTO `hi_region` VALUES ('612', '609', '220421', '东丰县');
INSERT INTO `hi_region` VALUES ('613', '609', '220422', '东辽县');
INSERT INTO `hi_region` VALUES ('614', '580', '220500', '通化市');
INSERT INTO `hi_region` VALUES ('615', '614', '220502', '东昌区');
INSERT INTO `hi_region` VALUES ('616', '614', '220503', '二道江区');
INSERT INTO `hi_region` VALUES ('617', '614', '220521', '通化县');
INSERT INTO `hi_region` VALUES ('618', '614', '220523', '辉南县');
INSERT INTO `hi_region` VALUES ('619', '614', '220524', '柳河县');
INSERT INTO `hi_region` VALUES ('620', '614', '220581', '梅河口市');
INSERT INTO `hi_region` VALUES ('621', '614', '220582', '集安市');
INSERT INTO `hi_region` VALUES ('622', '580', '220600', '白山市');
INSERT INTO `hi_region` VALUES ('623', '622', '220602', '浑江区');
INSERT INTO `hi_region` VALUES ('624', '622', '220605', '江源区');
INSERT INTO `hi_region` VALUES ('625', '622', '220621', '抚松县');
INSERT INTO `hi_region` VALUES ('626', '622', '220622', '靖宇县');
INSERT INTO `hi_region` VALUES ('627', '622', '220623', '长白朝鲜族自治县');
INSERT INTO `hi_region` VALUES ('628', '622', '220681', '临江市');
INSERT INTO `hi_region` VALUES ('629', '580', '220700', '松原市');
INSERT INTO `hi_region` VALUES ('630', '629', '220702', '宁江区');
INSERT INTO `hi_region` VALUES ('631', '629', '220721', '前郭尔罗斯蒙古族自治县');
INSERT INTO `hi_region` VALUES ('632', '629', '220722', '长岭县');
INSERT INTO `hi_region` VALUES ('633', '629', '220723', '乾安县');
INSERT INTO `hi_region` VALUES ('634', '629', '220781', '扶余市');
INSERT INTO `hi_region` VALUES ('635', '580', '220800', '白城市');
INSERT INTO `hi_region` VALUES ('636', '635', '220802', '洮北区');
INSERT INTO `hi_region` VALUES ('637', '635', '220821', '镇赉县');
INSERT INTO `hi_region` VALUES ('638', '635', '220822', '通榆县');
INSERT INTO `hi_region` VALUES ('639', '635', '220881', '洮南市');
INSERT INTO `hi_region` VALUES ('640', '635', '220882', '大安市');
INSERT INTO `hi_region` VALUES ('641', '580', '222400', '延边朝鲜族自治州');
INSERT INTO `hi_region` VALUES ('642', '641', '222401', '延吉市');
INSERT INTO `hi_region` VALUES ('643', '641', '222402', '图们市');
INSERT INTO `hi_region` VALUES ('644', '641', '222403', '敦化市');
INSERT INTO `hi_region` VALUES ('645', '641', '222404', '珲春市');
INSERT INTO `hi_region` VALUES ('646', '641', '222405', '龙井市');
INSERT INTO `hi_region` VALUES ('647', '641', '222406', '和龙市');
INSERT INTO `hi_region` VALUES ('648', '641', '222424', '汪清县');
INSERT INTO `hi_region` VALUES ('649', '641', '222426', '安图县');
INSERT INTO `hi_region` VALUES ('650', '0', '230000', '黑龙江省');
INSERT INTO `hi_region` VALUES ('651', '650', '230100', '哈尔滨市');
INSERT INTO `hi_region` VALUES ('652', '651', '230102', '道里区');
INSERT INTO `hi_region` VALUES ('653', '651', '230103', '南岗区');
INSERT INTO `hi_region` VALUES ('654', '651', '230104', '道外区');
INSERT INTO `hi_region` VALUES ('655', '651', '230108', '平房区');
INSERT INTO `hi_region` VALUES ('656', '651', '230109', '松北区');
INSERT INTO `hi_region` VALUES ('657', '651', '230110', '香坊区');
INSERT INTO `hi_region` VALUES ('658', '651', '230111', '呼兰区');
INSERT INTO `hi_region` VALUES ('659', '651', '230112', '阿城区');
INSERT INTO `hi_region` VALUES ('660', '651', '230113', '双城区');
INSERT INTO `hi_region` VALUES ('661', '651', '230123', '依兰县');
INSERT INTO `hi_region` VALUES ('662', '651', '230124', '方正县');
INSERT INTO `hi_region` VALUES ('663', '651', '230125', '宾县');
INSERT INTO `hi_region` VALUES ('664', '651', '230126', '巴彦县');
INSERT INTO `hi_region` VALUES ('665', '651', '230127', '木兰县');
INSERT INTO `hi_region` VALUES ('666', '651', '230128', '通河县');
INSERT INTO `hi_region` VALUES ('667', '651', '230129', '延寿县');
INSERT INTO `hi_region` VALUES ('668', '651', '230183', '尚志市');
INSERT INTO `hi_region` VALUES ('669', '651', '230184', '五常市');
INSERT INTO `hi_region` VALUES ('670', '650', '230200', '齐齐哈尔市');
INSERT INTO `hi_region` VALUES ('671', '670', '230202', '龙沙区');
INSERT INTO `hi_region` VALUES ('672', '670', '230203', '建华区');
INSERT INTO `hi_region` VALUES ('673', '670', '230204', '铁锋区');
INSERT INTO `hi_region` VALUES ('674', '670', '230205', '昂昂溪区');
INSERT INTO `hi_region` VALUES ('675', '670', '230206', '富拉尔基区');
INSERT INTO `hi_region` VALUES ('676', '670', '230207', '碾子山区');
INSERT INTO `hi_region` VALUES ('677', '670', '230208', '梅里斯达斡尔族区');
INSERT INTO `hi_region` VALUES ('678', '670', '230221', '龙江县');
INSERT INTO `hi_region` VALUES ('679', '670', '230223', '依安县');
INSERT INTO `hi_region` VALUES ('680', '670', '230224', '泰来县');
INSERT INTO `hi_region` VALUES ('681', '670', '230225', '甘南县');
INSERT INTO `hi_region` VALUES ('682', '670', '230227', '富裕县');
INSERT INTO `hi_region` VALUES ('683', '670', '230229', '克山县');
INSERT INTO `hi_region` VALUES ('684', '670', '230230', '克东县');
INSERT INTO `hi_region` VALUES ('685', '670', '230231', '拜泉县');
INSERT INTO `hi_region` VALUES ('686', '670', '230281', '讷河市');
INSERT INTO `hi_region` VALUES ('687', '650', '230300', '鸡西市');
INSERT INTO `hi_region` VALUES ('688', '687', '230302', '鸡冠区');
INSERT INTO `hi_region` VALUES ('689', '687', '230303', '恒山区');
INSERT INTO `hi_region` VALUES ('690', '687', '230304', '滴道区');
INSERT INTO `hi_region` VALUES ('691', '687', '230305', '梨树区');
INSERT INTO `hi_region` VALUES ('692', '687', '230306', '城子河区');
INSERT INTO `hi_region` VALUES ('693', '687', '230307', '麻山区');
INSERT INTO `hi_region` VALUES ('694', '687', '230321', '鸡东县');
INSERT INTO `hi_region` VALUES ('695', '687', '230381', '虎林市');
INSERT INTO `hi_region` VALUES ('696', '687', '230382', '密山市');
INSERT INTO `hi_region` VALUES ('697', '650', '230400', '鹤岗市');
INSERT INTO `hi_region` VALUES ('698', '697', '230402', '向阳区');
INSERT INTO `hi_region` VALUES ('699', '697', '230403', '工农区');
INSERT INTO `hi_region` VALUES ('700', '697', '230404', '南山区');
INSERT INTO `hi_region` VALUES ('701', '697', '230405', '兴安区');
INSERT INTO `hi_region` VALUES ('702', '697', '230406', '东山区');
INSERT INTO `hi_region` VALUES ('703', '697', '230407', '兴山区');
INSERT INTO `hi_region` VALUES ('704', '697', '230421', '萝北县');
INSERT INTO `hi_region` VALUES ('705', '697', '230422', '绥滨县');
INSERT INTO `hi_region` VALUES ('706', '650', '230500', '双鸭山市');
INSERT INTO `hi_region` VALUES ('707', '706', '230502', '尖山区');
INSERT INTO `hi_region` VALUES ('708', '706', '230503', '岭东区');
INSERT INTO `hi_region` VALUES ('709', '706', '230505', '四方台区');
INSERT INTO `hi_region` VALUES ('710', '706', '230506', '宝山区');
INSERT INTO `hi_region` VALUES ('711', '706', '230521', '集贤县');
INSERT INTO `hi_region` VALUES ('712', '706', '230522', '友谊县');
INSERT INTO `hi_region` VALUES ('713', '706', '230523', '宝清县');
INSERT INTO `hi_region` VALUES ('714', '706', '230524', '饶河县');
INSERT INTO `hi_region` VALUES ('715', '650', '230600', '大庆市');
INSERT INTO `hi_region` VALUES ('716', '715', '230602', '萨尔图区');
INSERT INTO `hi_region` VALUES ('717', '715', '230603', '龙凤区');
INSERT INTO `hi_region` VALUES ('718', '715', '230604', '让胡路区');
INSERT INTO `hi_region` VALUES ('719', '715', '230605', '红岗区');
INSERT INTO `hi_region` VALUES ('720', '715', '230606', '大同区');
INSERT INTO `hi_region` VALUES ('721', '715', '230621', '肇州县');
INSERT INTO `hi_region` VALUES ('722', '715', '230622', '肇源县');
INSERT INTO `hi_region` VALUES ('723', '715', '230623', '林甸县');
INSERT INTO `hi_region` VALUES ('724', '715', '230624', '杜尔伯特蒙古族自治县');
INSERT INTO `hi_region` VALUES ('725', '650', '230700', '伊春市');
INSERT INTO `hi_region` VALUES ('726', '725', '230702', '伊春区');
INSERT INTO `hi_region` VALUES ('727', '725', '230703', '南岔区');
INSERT INTO `hi_region` VALUES ('728', '725', '230704', '友好区');
INSERT INTO `hi_region` VALUES ('729', '725', '230705', '西林区');
INSERT INTO `hi_region` VALUES ('730', '725', '230706', '翠峦区');
INSERT INTO `hi_region` VALUES ('731', '725', '230707', '新青区');
INSERT INTO `hi_region` VALUES ('732', '725', '230708', '美溪区');
INSERT INTO `hi_region` VALUES ('733', '725', '230709', '金山屯区');
INSERT INTO `hi_region` VALUES ('734', '725', '230710', '五营区');
INSERT INTO `hi_region` VALUES ('735', '725', '230711', '乌马河区');
INSERT INTO `hi_region` VALUES ('736', '725', '230712', '汤旺河区');
INSERT INTO `hi_region` VALUES ('737', '725', '230713', '带岭区');
INSERT INTO `hi_region` VALUES ('738', '725', '230714', '乌伊岭区');
INSERT INTO `hi_region` VALUES ('739', '725', '230715', '红星区');
INSERT INTO `hi_region` VALUES ('740', '725', '230716', '上甘岭区');
INSERT INTO `hi_region` VALUES ('741', '725', '230722', '嘉荫县');
INSERT INTO `hi_region` VALUES ('742', '725', '230781', '铁力市');
INSERT INTO `hi_region` VALUES ('743', '650', '230800', '佳木斯市');
INSERT INTO `hi_region` VALUES ('744', '743', '230803', '向阳区');
INSERT INTO `hi_region` VALUES ('745', '743', '230804', '前进区');
INSERT INTO `hi_region` VALUES ('746', '743', '230805', '东风区');
INSERT INTO `hi_region` VALUES ('747', '743', '230811', '郊区');
INSERT INTO `hi_region` VALUES ('748', '743', '230822', '桦南县');
INSERT INTO `hi_region` VALUES ('749', '743', '230826', '桦川县');
INSERT INTO `hi_region` VALUES ('750', '743', '230828', '汤原县');
INSERT INTO `hi_region` VALUES ('751', '743', '230881', '同江市');
INSERT INTO `hi_region` VALUES ('752', '743', '230882', '富锦市');
INSERT INTO `hi_region` VALUES ('753', '743', '230883', '抚远市');
INSERT INTO `hi_region` VALUES ('754', '650', '230900', '七台河市');
INSERT INTO `hi_region` VALUES ('755', '754', '230902', '新兴区');
INSERT INTO `hi_region` VALUES ('756', '754', '230903', '桃山区');
INSERT INTO `hi_region` VALUES ('757', '754', '230904', '茄子河区');
INSERT INTO `hi_region` VALUES ('758', '754', '230921', '勃利县');
INSERT INTO `hi_region` VALUES ('759', '650', '231000', '牡丹江市');
INSERT INTO `hi_region` VALUES ('760', '759', '231002', '东安区');
INSERT INTO `hi_region` VALUES ('761', '759', '231003', '阳明区');
INSERT INTO `hi_region` VALUES ('762', '759', '231004', '爱民区');
INSERT INTO `hi_region` VALUES ('763', '759', '231005', '西安区');
INSERT INTO `hi_region` VALUES ('764', '759', '231025', '林口县');
INSERT INTO `hi_region` VALUES ('765', '759', '231081', '绥芬河市');
INSERT INTO `hi_region` VALUES ('766', '759', '231083', '海林市');
INSERT INTO `hi_region` VALUES ('767', '759', '231084', '宁安市');
INSERT INTO `hi_region` VALUES ('768', '759', '231085', '穆棱市');
INSERT INTO `hi_region` VALUES ('769', '759', '231086', '东宁市');
INSERT INTO `hi_region` VALUES ('770', '650', '231100', '黑河市');
INSERT INTO `hi_region` VALUES ('771', '770', '231102', '爱辉区');
INSERT INTO `hi_region` VALUES ('772', '770', '231121', '嫩江县');
INSERT INTO `hi_region` VALUES ('773', '770', '231123', '逊克县');
INSERT INTO `hi_region` VALUES ('774', '770', '231124', '孙吴县');
INSERT INTO `hi_region` VALUES ('775', '770', '231181', '北安市');
INSERT INTO `hi_region` VALUES ('776', '770', '231182', '五大连池市');
INSERT INTO `hi_region` VALUES ('777', '650', '231200', '绥化市');
INSERT INTO `hi_region` VALUES ('778', '777', '231202', '北林区');
INSERT INTO `hi_region` VALUES ('779', '777', '231221', '望奎县');
INSERT INTO `hi_region` VALUES ('780', '777', '231222', '兰西县');
INSERT INTO `hi_region` VALUES ('781', '777', '231223', '青冈县');
INSERT INTO `hi_region` VALUES ('782', '777', '231224', '庆安县');
INSERT INTO `hi_region` VALUES ('783', '777', '231225', '明水县');
INSERT INTO `hi_region` VALUES ('784', '777', '231226', '绥棱县');
INSERT INTO `hi_region` VALUES ('785', '777', '231281', '安达市');
INSERT INTO `hi_region` VALUES ('786', '777', '231282', '肇东市');
INSERT INTO `hi_region` VALUES ('787', '777', '231283', '海伦市');
INSERT INTO `hi_region` VALUES ('788', '650', '232700', '大兴安岭地区');
INSERT INTO `hi_region` VALUES ('789', '788', '232721', '呼玛县');
INSERT INTO `hi_region` VALUES ('790', '788', '232722', '塔河县');
INSERT INTO `hi_region` VALUES ('791', '788', '232723', '漠河县');
INSERT INTO `hi_region` VALUES ('792', '0', '310000', '上海市');
INSERT INTO `hi_region` VALUES ('793', '792', '310000', '上海市');
INSERT INTO `hi_region` VALUES ('794', '793', '310101', '黄浦区');
INSERT INTO `hi_region` VALUES ('795', '793', '310104', '徐汇区');
INSERT INTO `hi_region` VALUES ('796', '793', '310105', '长宁区');
INSERT INTO `hi_region` VALUES ('797', '793', '310106', '静安区');
INSERT INTO `hi_region` VALUES ('798', '793', '310107', '普陀区');
INSERT INTO `hi_region` VALUES ('799', '793', '310109', '虹口区');
INSERT INTO `hi_region` VALUES ('800', '793', '310110', '杨浦区');
INSERT INTO `hi_region` VALUES ('801', '793', '310112', '闵行区');
INSERT INTO `hi_region` VALUES ('802', '793', '310113', '宝山区');
INSERT INTO `hi_region` VALUES ('803', '793', '310114', '嘉定区');
INSERT INTO `hi_region` VALUES ('804', '793', '310115', '浦东新区');
INSERT INTO `hi_region` VALUES ('805', '793', '310116', '金山区');
INSERT INTO `hi_region` VALUES ('806', '793', '310117', '松江区');
INSERT INTO `hi_region` VALUES ('807', '793', '310118', '青浦区');
INSERT INTO `hi_region` VALUES ('808', '793', '310120', '奉贤区');
INSERT INTO `hi_region` VALUES ('809', '793', '310151', '崇明区');
INSERT INTO `hi_region` VALUES ('810', '0', '320000', '江苏省');
INSERT INTO `hi_region` VALUES ('811', '810', '320100', '南京市');
INSERT INTO `hi_region` VALUES ('812', '811', '320102', '玄武区');
INSERT INTO `hi_region` VALUES ('813', '811', '320104', '秦淮区');
INSERT INTO `hi_region` VALUES ('814', '811', '320105', '建邺区');
INSERT INTO `hi_region` VALUES ('815', '811', '320106', '鼓楼区');
INSERT INTO `hi_region` VALUES ('816', '811', '320111', '浦口区');
INSERT INTO `hi_region` VALUES ('817', '811', '320113', '栖霞区');
INSERT INTO `hi_region` VALUES ('818', '811', '320114', '雨花台区');
INSERT INTO `hi_region` VALUES ('819', '811', '320115', '江宁区');
INSERT INTO `hi_region` VALUES ('820', '811', '320116', '六合区');
INSERT INTO `hi_region` VALUES ('821', '811', '320117', '溧水区');
INSERT INTO `hi_region` VALUES ('822', '811', '320118', '高淳区');
INSERT INTO `hi_region` VALUES ('823', '810', '320200', '无锡市');
INSERT INTO `hi_region` VALUES ('824', '823', '320205', '锡山区');
INSERT INTO `hi_region` VALUES ('825', '823', '320206', '惠山区');
INSERT INTO `hi_region` VALUES ('826', '823', '320211', '滨湖区');
INSERT INTO `hi_region` VALUES ('827', '823', '320213', '梁溪区');
INSERT INTO `hi_region` VALUES ('828', '823', '320214', '新吴区');
INSERT INTO `hi_region` VALUES ('829', '823', '320281', '江阴市');
INSERT INTO `hi_region` VALUES ('830', '823', '320282', '宜兴市');
INSERT INTO `hi_region` VALUES ('831', '810', '320300', '徐州市');
INSERT INTO `hi_region` VALUES ('832', '831', '320302', '鼓楼区');
INSERT INTO `hi_region` VALUES ('833', '831', '320303', '云龙区');
INSERT INTO `hi_region` VALUES ('834', '831', '320305', '贾汪区');
INSERT INTO `hi_region` VALUES ('835', '831', '320311', '泉山区');
INSERT INTO `hi_region` VALUES ('836', '831', '320312', '铜山区');
INSERT INTO `hi_region` VALUES ('837', '831', '320321', '丰县');
INSERT INTO `hi_region` VALUES ('838', '831', '320322', '沛县');
INSERT INTO `hi_region` VALUES ('839', '831', '320324', '睢宁县');
INSERT INTO `hi_region` VALUES ('840', '831', '320381', '新沂市');
INSERT INTO `hi_region` VALUES ('841', '831', '320382', '邳州市');
INSERT INTO `hi_region` VALUES ('842', '810', '320400', '常州市');
INSERT INTO `hi_region` VALUES ('843', '842', '320402', '天宁区');
INSERT INTO `hi_region` VALUES ('844', '842', '320404', '钟楼区');
INSERT INTO `hi_region` VALUES ('845', '842', '320411', '新北区');
INSERT INTO `hi_region` VALUES ('846', '842', '320412', '武进区');
INSERT INTO `hi_region` VALUES ('847', '842', '320413', '金坛区');
INSERT INTO `hi_region` VALUES ('848', '842', '320481', '溧阳市');
INSERT INTO `hi_region` VALUES ('849', '810', '320500', '苏州市');
INSERT INTO `hi_region` VALUES ('850', '849', '320505', '虎丘区');
INSERT INTO `hi_region` VALUES ('851', '849', '320506', '吴中区');
INSERT INTO `hi_region` VALUES ('852', '849', '320507', '相城区');
INSERT INTO `hi_region` VALUES ('853', '849', '320508', '姑苏区');
INSERT INTO `hi_region` VALUES ('854', '849', '320509', '吴江区');
INSERT INTO `hi_region` VALUES ('855', '849', '320581', '常熟市');
INSERT INTO `hi_region` VALUES ('856', '849', '320582', '张家港市');
INSERT INTO `hi_region` VALUES ('857', '849', '320583', '昆山市');
INSERT INTO `hi_region` VALUES ('858', '849', '320585', '太仓市');
INSERT INTO `hi_region` VALUES ('859', '810', '320600', '南通市');
INSERT INTO `hi_region` VALUES ('860', '859', '320602', '崇川区');
INSERT INTO `hi_region` VALUES ('861', '859', '320611', '港闸区');
INSERT INTO `hi_region` VALUES ('862', '859', '320612', '通州区');
INSERT INTO `hi_region` VALUES ('863', '859', '320621', '海安县');
INSERT INTO `hi_region` VALUES ('864', '859', '320623', '如东县');
INSERT INTO `hi_region` VALUES ('865', '859', '320681', '启东市');
INSERT INTO `hi_region` VALUES ('866', '859', '320682', '如皋市');
INSERT INTO `hi_region` VALUES ('867', '859', '320684', '海门市');
INSERT INTO `hi_region` VALUES ('868', '810', '320700', '连云港市');
INSERT INTO `hi_region` VALUES ('869', '868', '320703', '连云区');
INSERT INTO `hi_region` VALUES ('870', '868', '320706', '海州区');
INSERT INTO `hi_region` VALUES ('871', '868', '320722', '东海县');
INSERT INTO `hi_region` VALUES ('872', '868', '320723', '灌云县');
INSERT INTO `hi_region` VALUES ('873', '868', '320724', '灌南县');
INSERT INTO `hi_region` VALUES ('874', '810', '320800', '淮安市');
INSERT INTO `hi_region` VALUES ('875', '874', '320803', '淮安区');
INSERT INTO `hi_region` VALUES ('876', '874', '320804', '淮阴区');
INSERT INTO `hi_region` VALUES ('877', '874', '320812', '清江浦区');
INSERT INTO `hi_region` VALUES ('878', '874', '320813', '洪泽区');
INSERT INTO `hi_region` VALUES ('879', '874', '320826', '涟水县');
INSERT INTO `hi_region` VALUES ('880', '874', '320830', '盱眙县');
INSERT INTO `hi_region` VALUES ('881', '874', '320831', '金湖县');
INSERT INTO `hi_region` VALUES ('882', '810', '320900', '盐城市');
INSERT INTO `hi_region` VALUES ('883', '882', '320902', '亭湖区');
INSERT INTO `hi_region` VALUES ('884', '882', '320903', '盐都区');
INSERT INTO `hi_region` VALUES ('885', '882', '320904', '大丰区');
INSERT INTO `hi_region` VALUES ('886', '882', '320921', '响水县');
INSERT INTO `hi_region` VALUES ('887', '882', '320922', '滨海县');
INSERT INTO `hi_region` VALUES ('888', '882', '320923', '阜宁县');
INSERT INTO `hi_region` VALUES ('889', '882', '320924', '射阳县');
INSERT INTO `hi_region` VALUES ('890', '882', '320925', '建湖县');
INSERT INTO `hi_region` VALUES ('891', '882', '320981', '东台市');
INSERT INTO `hi_region` VALUES ('892', '810', '321000', '扬州市');
INSERT INTO `hi_region` VALUES ('893', '892', '321002', '广陵区');
INSERT INTO `hi_region` VALUES ('894', '892', '321003', '邗江区');
INSERT INTO `hi_region` VALUES ('895', '892', '321012', '江都区');
INSERT INTO `hi_region` VALUES ('896', '892', '321023', '宝应县');
INSERT INTO `hi_region` VALUES ('897', '892', '321081', '仪征市');
INSERT INTO `hi_region` VALUES ('898', '892', '321084', '高邮市');
INSERT INTO `hi_region` VALUES ('899', '810', '321100', '镇江市');
INSERT INTO `hi_region` VALUES ('900', '899', '321102', '京口区');
INSERT INTO `hi_region` VALUES ('901', '899', '321111', '润州区');
INSERT INTO `hi_region` VALUES ('902', '899', '321112', '丹徒区');
INSERT INTO `hi_region` VALUES ('903', '899', '321181', '丹阳市');
INSERT INTO `hi_region` VALUES ('904', '899', '321182', '扬中市');
INSERT INTO `hi_region` VALUES ('905', '899', '321183', '句容市');
INSERT INTO `hi_region` VALUES ('906', '810', '321200', '泰州市');
INSERT INTO `hi_region` VALUES ('907', '906', '321202', '海陵区');
INSERT INTO `hi_region` VALUES ('908', '906', '321203', '高港区');
INSERT INTO `hi_region` VALUES ('909', '906', '321204', '姜堰区');
INSERT INTO `hi_region` VALUES ('910', '906', '321281', '兴化市');
INSERT INTO `hi_region` VALUES ('911', '906', '321282', '靖江市');
INSERT INTO `hi_region` VALUES ('912', '906', '321283', '泰兴市');
INSERT INTO `hi_region` VALUES ('913', '810', '321300', '宿迁市');
INSERT INTO `hi_region` VALUES ('914', '913', '321302', '宿城区');
INSERT INTO `hi_region` VALUES ('915', '913', '321311', '宿豫区');
INSERT INTO `hi_region` VALUES ('916', '913', '321322', '沭阳县');
INSERT INTO `hi_region` VALUES ('917', '913', '321323', '泗阳县');
INSERT INTO `hi_region` VALUES ('918', '913', '321324', '泗洪县');
INSERT INTO `hi_region` VALUES ('919', '0', '330000', '浙江省');
INSERT INTO `hi_region` VALUES ('920', '919', '330100', '杭州市');
INSERT INTO `hi_region` VALUES ('921', '920', '330102', '上城区');
INSERT INTO `hi_region` VALUES ('922', '920', '330103', '下城区');
INSERT INTO `hi_region` VALUES ('923', '920', '330104', '江干区');
INSERT INTO `hi_region` VALUES ('924', '920', '330105', '拱墅区');
INSERT INTO `hi_region` VALUES ('925', '920', '330106', '西湖区');
INSERT INTO `hi_region` VALUES ('926', '920', '330108', '滨江区');
INSERT INTO `hi_region` VALUES ('927', '920', '330109', '萧山区');
INSERT INTO `hi_region` VALUES ('928', '920', '330110', '余杭区');
INSERT INTO `hi_region` VALUES ('929', '920', '330111', '富阳区');
INSERT INTO `hi_region` VALUES ('930', '920', '330122', '桐庐县');
INSERT INTO `hi_region` VALUES ('931', '920', '330127', '淳安县');
INSERT INTO `hi_region` VALUES ('932', '920', '330182', '建德市');
INSERT INTO `hi_region` VALUES ('933', '920', '330185', '临安市');
INSERT INTO `hi_region` VALUES ('934', '919', '330200', '宁波市');
INSERT INTO `hi_region` VALUES ('935', '934', '330203', '海曙区');
INSERT INTO `hi_region` VALUES ('936', '934', '330205', '江北区');
INSERT INTO `hi_region` VALUES ('937', '934', '330206', '北仑区');
INSERT INTO `hi_region` VALUES ('938', '934', '330211', '镇海区');
INSERT INTO `hi_region` VALUES ('939', '934', '330212', '鄞州区');
INSERT INTO `hi_region` VALUES ('940', '934', '330213', '奉化区');
INSERT INTO `hi_region` VALUES ('941', '934', '330225', '象山县');
INSERT INTO `hi_region` VALUES ('942', '934', '330226', '宁海县');
INSERT INTO `hi_region` VALUES ('943', '934', '330281', '余姚市');
INSERT INTO `hi_region` VALUES ('944', '934', '330282', '慈溪市');
INSERT INTO `hi_region` VALUES ('945', '919', '330300', '温州市');
INSERT INTO `hi_region` VALUES ('946', '945', '330302', '鹿城区');
INSERT INTO `hi_region` VALUES ('947', '945', '330303', '龙湾区');
INSERT INTO `hi_region` VALUES ('948', '945', '330304', '瓯海区');
INSERT INTO `hi_region` VALUES ('949', '945', '330305', '洞头区');
INSERT INTO `hi_region` VALUES ('950', '945', '330324', '永嘉县');
INSERT INTO `hi_region` VALUES ('951', '945', '330326', '平阳县');
INSERT INTO `hi_region` VALUES ('952', '945', '330327', '苍南县');
INSERT INTO `hi_region` VALUES ('953', '945', '330328', '文成县');
INSERT INTO `hi_region` VALUES ('954', '945', '330329', '泰顺县');
INSERT INTO `hi_region` VALUES ('955', '945', '330381', '瑞安市');
INSERT INTO `hi_region` VALUES ('956', '945', '330382', '乐清市');
INSERT INTO `hi_region` VALUES ('957', '919', '330400', '嘉兴市');
INSERT INTO `hi_region` VALUES ('958', '957', '330402', '南湖区');
INSERT INTO `hi_region` VALUES ('959', '957', '330411', '秀洲区');
INSERT INTO `hi_region` VALUES ('960', '957', '330421', '嘉善县');
INSERT INTO `hi_region` VALUES ('961', '957', '330424', '海盐县');
INSERT INTO `hi_region` VALUES ('962', '957', '330481', '海宁市');
INSERT INTO `hi_region` VALUES ('963', '957', '330482', '平湖市');
INSERT INTO `hi_region` VALUES ('964', '957', '330483', '桐乡市');
INSERT INTO `hi_region` VALUES ('965', '919', '330500', '湖州市');
INSERT INTO `hi_region` VALUES ('966', '965', '330502', '吴兴区');
INSERT INTO `hi_region` VALUES ('967', '965', '330503', '南浔区');
INSERT INTO `hi_region` VALUES ('968', '965', '330521', '德清县');
INSERT INTO `hi_region` VALUES ('969', '965', '330522', '长兴县');
INSERT INTO `hi_region` VALUES ('970', '965', '330523', '安吉县');
INSERT INTO `hi_region` VALUES ('971', '919', '330600', '绍兴市');
INSERT INTO `hi_region` VALUES ('972', '971', '330602', '越城区');
INSERT INTO `hi_region` VALUES ('973', '971', '330603', '柯桥区');
INSERT INTO `hi_region` VALUES ('974', '971', '330604', '上虞区');
INSERT INTO `hi_region` VALUES ('975', '971', '330624', '新昌县');
INSERT INTO `hi_region` VALUES ('976', '971', '330681', '诸暨市');
INSERT INTO `hi_region` VALUES ('977', '971', '330683', '嵊州市');
INSERT INTO `hi_region` VALUES ('978', '919', '330700', '金华市');
INSERT INTO `hi_region` VALUES ('979', '978', '330702', '婺城区');
INSERT INTO `hi_region` VALUES ('980', '978', '330703', '金东区');
INSERT INTO `hi_region` VALUES ('981', '978', '330723', '武义县');
INSERT INTO `hi_region` VALUES ('982', '978', '330726', '浦江县');
INSERT INTO `hi_region` VALUES ('983', '978', '330727', '磐安县');
INSERT INTO `hi_region` VALUES ('984', '978', '330781', '兰溪市');
INSERT INTO `hi_region` VALUES ('985', '978', '330782', '义乌市');
INSERT INTO `hi_region` VALUES ('986', '978', '330783', '东阳市');
INSERT INTO `hi_region` VALUES ('987', '978', '330784', '永康市');
INSERT INTO `hi_region` VALUES ('988', '919', '330800', '衢州市');
INSERT INTO `hi_region` VALUES ('989', '988', '330802', '柯城区');
INSERT INTO `hi_region` VALUES ('990', '988', '330803', '衢江区');
INSERT INTO `hi_region` VALUES ('991', '988', '330822', '常山县');
INSERT INTO `hi_region` VALUES ('992', '988', '330824', '开化县');
INSERT INTO `hi_region` VALUES ('993', '988', '330825', '龙游县');
INSERT INTO `hi_region` VALUES ('994', '988', '330881', '江山市');
INSERT INTO `hi_region` VALUES ('995', '919', '330900', '舟山市');
INSERT INTO `hi_region` VALUES ('996', '995', '330902', '定海区');
INSERT INTO `hi_region` VALUES ('997', '995', '330903', '普陀区');
INSERT INTO `hi_region` VALUES ('998', '995', '330921', '岱山县');
INSERT INTO `hi_region` VALUES ('999', '995', '330922', '嵊泗县');
INSERT INTO `hi_region` VALUES ('1000', '919', '331000', '台州市');
INSERT INTO `hi_region` VALUES ('1001', '1000', '331002', '椒江区');
INSERT INTO `hi_region` VALUES ('1002', '1000', '331003', '黄岩区');
INSERT INTO `hi_region` VALUES ('1003', '1000', '331004', '路桥区');
INSERT INTO `hi_region` VALUES ('1004', '1000', '331021', '玉环县');
INSERT INTO `hi_region` VALUES ('1005', '1000', '331022', '三门县');
INSERT INTO `hi_region` VALUES ('1006', '1000', '331023', '天台县');
INSERT INTO `hi_region` VALUES ('1007', '1000', '331024', '仙居县');
INSERT INTO `hi_region` VALUES ('1008', '1000', '331081', '温岭市');
INSERT INTO `hi_region` VALUES ('1009', '1000', '331082', '临海市');
INSERT INTO `hi_region` VALUES ('1010', '919', '331100', '丽水市');
INSERT INTO `hi_region` VALUES ('1011', '1010', '331102', '莲都区');
INSERT INTO `hi_region` VALUES ('1012', '1010', '331121', '青田县');
INSERT INTO `hi_region` VALUES ('1013', '1010', '331122', '缙云县');
INSERT INTO `hi_region` VALUES ('1014', '1010', '331123', '遂昌县');
INSERT INTO `hi_region` VALUES ('1015', '1010', '331124', '松阳县');
INSERT INTO `hi_region` VALUES ('1016', '1010', '331125', '云和县');
INSERT INTO `hi_region` VALUES ('1017', '1010', '331126', '庆元县');
INSERT INTO `hi_region` VALUES ('1018', '1010', '331127', '景宁畲族自治县');
INSERT INTO `hi_region` VALUES ('1019', '1010', '331181', '龙泉市');
INSERT INTO `hi_region` VALUES ('1020', '0', '340000', '安徽省');
INSERT INTO `hi_region` VALUES ('1021', '1020', '340100', '合肥市');
INSERT INTO `hi_region` VALUES ('1022', '1021', '340102', '瑶海区');
INSERT INTO `hi_region` VALUES ('1023', '1021', '340103', '庐阳区');
INSERT INTO `hi_region` VALUES ('1024', '1021', '340104', '蜀山区');
INSERT INTO `hi_region` VALUES ('1025', '1021', '340111', '包河区');
INSERT INTO `hi_region` VALUES ('1026', '1021', '340121', '长丰县');
INSERT INTO `hi_region` VALUES ('1027', '1021', '340122', '肥东县');
INSERT INTO `hi_region` VALUES ('1028', '1021', '340123', '肥西县');
INSERT INTO `hi_region` VALUES ('1029', '1021', '340124', '庐江县');
INSERT INTO `hi_region` VALUES ('1030', '1021', '340181', '巢湖市');
INSERT INTO `hi_region` VALUES ('1031', '1020', '340200', '芜湖市');
INSERT INTO `hi_region` VALUES ('1032', '1031', '340202', '镜湖区');
INSERT INTO `hi_region` VALUES ('1033', '1031', '340203', '弋江区');
INSERT INTO `hi_region` VALUES ('1034', '1031', '340207', '鸠江区');
INSERT INTO `hi_region` VALUES ('1035', '1031', '340208', '三山区');
INSERT INTO `hi_region` VALUES ('1036', '1031', '340221', '芜湖县');
INSERT INTO `hi_region` VALUES ('1037', '1031', '340222', '繁昌县');
INSERT INTO `hi_region` VALUES ('1038', '1031', '340223', '南陵县');
INSERT INTO `hi_region` VALUES ('1039', '1031', '340225', '无为县');
INSERT INTO `hi_region` VALUES ('1040', '1020', '340300', '蚌埠市');
INSERT INTO `hi_region` VALUES ('1041', '1040', '340302', '龙子湖区');
INSERT INTO `hi_region` VALUES ('1042', '1040', '340303', '蚌山区');
INSERT INTO `hi_region` VALUES ('1043', '1040', '340304', '禹会区');
INSERT INTO `hi_region` VALUES ('1044', '1040', '340311', '淮上区');
INSERT INTO `hi_region` VALUES ('1045', '1040', '340321', '怀远县');
INSERT INTO `hi_region` VALUES ('1046', '1040', '340322', '五河县');
INSERT INTO `hi_region` VALUES ('1047', '1040', '340323', '固镇县');
INSERT INTO `hi_region` VALUES ('1048', '1020', '340400', '淮南市');
INSERT INTO `hi_region` VALUES ('1049', '1048', '340402', '大通区');
INSERT INTO `hi_region` VALUES ('1050', '1048', '340403', '田家庵区');
INSERT INTO `hi_region` VALUES ('1051', '1048', '340404', '谢家集区');
INSERT INTO `hi_region` VALUES ('1052', '1048', '340405', '八公山区');
INSERT INTO `hi_region` VALUES ('1053', '1048', '340406', '潘集区');
INSERT INTO `hi_region` VALUES ('1054', '1048', '340421', '凤台县');
INSERT INTO `hi_region` VALUES ('1055', '1048', '340422', '寿县');
INSERT INTO `hi_region` VALUES ('1056', '1020', '340500', '马鞍山市');
INSERT INTO `hi_region` VALUES ('1057', '1056', '340503', '花山区');
INSERT INTO `hi_region` VALUES ('1058', '1056', '340504', '雨山区');
INSERT INTO `hi_region` VALUES ('1059', '1056', '340506', '博望区');
INSERT INTO `hi_region` VALUES ('1060', '1056', '340521', '当涂县');
INSERT INTO `hi_region` VALUES ('1061', '1056', '340522', '含山县');
INSERT INTO `hi_region` VALUES ('1062', '1056', '340523', '和县');
INSERT INTO `hi_region` VALUES ('1063', '1020', '340600', '淮北市');
INSERT INTO `hi_region` VALUES ('1064', '1063', '340602', '杜集区');
INSERT INTO `hi_region` VALUES ('1065', '1063', '340603', '相山区');
INSERT INTO `hi_region` VALUES ('1066', '1063', '340604', '烈山区');
INSERT INTO `hi_region` VALUES ('1067', '1063', '340621', '濉溪县');
INSERT INTO `hi_region` VALUES ('1068', '1020', '340700', '铜陵市');
INSERT INTO `hi_region` VALUES ('1069', '1068', '340705', '铜官区');
INSERT INTO `hi_region` VALUES ('1070', '1068', '340706', '义安区');
INSERT INTO `hi_region` VALUES ('1071', '1068', '340711', '郊区');
INSERT INTO `hi_region` VALUES ('1072', '1068', '340722', '枞阳县');
INSERT INTO `hi_region` VALUES ('1073', '1020', '340800', '安庆市');
INSERT INTO `hi_region` VALUES ('1074', '1073', '340802', '迎江区');
INSERT INTO `hi_region` VALUES ('1075', '1073', '340803', '大观区');
INSERT INTO `hi_region` VALUES ('1076', '1073', '340811', '宜秀区');
INSERT INTO `hi_region` VALUES ('1077', '1073', '340822', '怀宁县');
INSERT INTO `hi_region` VALUES ('1078', '1073', '340824', '潜山县');
INSERT INTO `hi_region` VALUES ('1079', '1073', '340825', '太湖县');
INSERT INTO `hi_region` VALUES ('1080', '1073', '340826', '宿松县');
INSERT INTO `hi_region` VALUES ('1081', '1073', '340827', '望江县');
INSERT INTO `hi_region` VALUES ('1082', '1073', '340828', '岳西县');
INSERT INTO `hi_region` VALUES ('1083', '1073', '340881', '桐城市');
INSERT INTO `hi_region` VALUES ('1084', '1020', '341000', '黄山市');
INSERT INTO `hi_region` VALUES ('1085', '1084', '341002', '屯溪区');
INSERT INTO `hi_region` VALUES ('1086', '1084', '341003', '黄山区');
INSERT INTO `hi_region` VALUES ('1087', '1084', '341004', '徽州区');
INSERT INTO `hi_region` VALUES ('1088', '1084', '341021', '歙县');
INSERT INTO `hi_region` VALUES ('1089', '1084', '341022', '休宁县');
INSERT INTO `hi_region` VALUES ('1090', '1084', '341023', '黟县');
INSERT INTO `hi_region` VALUES ('1091', '1084', '341024', '祁门县');
INSERT INTO `hi_region` VALUES ('1092', '1020', '341100', '滁州市');
INSERT INTO `hi_region` VALUES ('1093', '1092', '341102', '琅琊区');
INSERT INTO `hi_region` VALUES ('1094', '1092', '341103', '南谯区');
INSERT INTO `hi_region` VALUES ('1095', '1092', '341122', '来安县');
INSERT INTO `hi_region` VALUES ('1096', '1092', '341124', '全椒县');
INSERT INTO `hi_region` VALUES ('1097', '1092', '341125', '定远县');
INSERT INTO `hi_region` VALUES ('1098', '1092', '341126', '凤阳县');
INSERT INTO `hi_region` VALUES ('1099', '1092', '341181', '天长市');
INSERT INTO `hi_region` VALUES ('1100', '1092', '341182', '明光市');
INSERT INTO `hi_region` VALUES ('1101', '1020', '341200', '阜阳市');
INSERT INTO `hi_region` VALUES ('1102', '1101', '341202', '颍州区');
INSERT INTO `hi_region` VALUES ('1103', '1101', '341203', '颍东区');
INSERT INTO `hi_region` VALUES ('1104', '1101', '341204', '颍泉区');
INSERT INTO `hi_region` VALUES ('1105', '1101', '341221', '临泉县');
INSERT INTO `hi_region` VALUES ('1106', '1101', '341222', '太和县');
INSERT INTO `hi_region` VALUES ('1107', '1101', '341225', '阜南县');
INSERT INTO `hi_region` VALUES ('1108', '1101', '341226', '颍上县');
INSERT INTO `hi_region` VALUES ('1109', '1101', '341282', '界首市');
INSERT INTO `hi_region` VALUES ('1110', '1020', '341300', '宿州市');
INSERT INTO `hi_region` VALUES ('1111', '1110', '341302', '埇桥区');
INSERT INTO `hi_region` VALUES ('1112', '1110', '341321', '砀山县');
INSERT INTO `hi_region` VALUES ('1113', '1110', '341322', '萧县');
INSERT INTO `hi_region` VALUES ('1114', '1110', '341323', '灵璧县');
INSERT INTO `hi_region` VALUES ('1115', '1110', '341324', '泗县');
INSERT INTO `hi_region` VALUES ('1116', '1020', '341500', '六安市');
INSERT INTO `hi_region` VALUES ('1117', '1116', '341502', '金安区');
INSERT INTO `hi_region` VALUES ('1118', '1116', '341503', '裕安区');
INSERT INTO `hi_region` VALUES ('1119', '1116', '341504', '叶集区');
INSERT INTO `hi_region` VALUES ('1120', '1116', '341522', '霍邱县');
INSERT INTO `hi_region` VALUES ('1121', '1116', '341523', '舒城县');
INSERT INTO `hi_region` VALUES ('1122', '1116', '341524', '金寨县');
INSERT INTO `hi_region` VALUES ('1123', '1116', '341525', '霍山县');
INSERT INTO `hi_region` VALUES ('1124', '1020', '341600', '亳州市');
INSERT INTO `hi_region` VALUES ('1125', '1124', '341602', '谯城区');
INSERT INTO `hi_region` VALUES ('1126', '1124', '341621', '涡阳县');
INSERT INTO `hi_region` VALUES ('1127', '1124', '341622', '蒙城县');
INSERT INTO `hi_region` VALUES ('1128', '1124', '341623', '利辛县');
INSERT INTO `hi_region` VALUES ('1129', '1020', '341700', '池州市');
INSERT INTO `hi_region` VALUES ('1130', '1129', '341702', '贵池区');
INSERT INTO `hi_region` VALUES ('1131', '1129', '341721', '东至县');
INSERT INTO `hi_region` VALUES ('1132', '1129', '341722', '石台县');
INSERT INTO `hi_region` VALUES ('1133', '1129', '341723', '青阳县');
INSERT INTO `hi_region` VALUES ('1134', '1020', '341800', '宣城市');
INSERT INTO `hi_region` VALUES ('1135', '1134', '341802', '宣州区');
INSERT INTO `hi_region` VALUES ('1136', '1134', '341821', '郎溪县');
INSERT INTO `hi_region` VALUES ('1137', '1134', '341822', '广德县');
INSERT INTO `hi_region` VALUES ('1138', '1134', '341823', '泾县');
INSERT INTO `hi_region` VALUES ('1139', '1134', '341824', '绩溪县');
INSERT INTO `hi_region` VALUES ('1140', '1134', '341825', '旌德县');
INSERT INTO `hi_region` VALUES ('1141', '1134', '341881', '宁国市');
INSERT INTO `hi_region` VALUES ('1142', '0', '350000', '福建省');
INSERT INTO `hi_region` VALUES ('1143', '1142', '350100', '福州市');
INSERT INTO `hi_region` VALUES ('1144', '1143', '350102', '鼓楼区');
INSERT INTO `hi_region` VALUES ('1145', '1143', '350103', '台江区');
INSERT INTO `hi_region` VALUES ('1146', '1143', '350104', '仓山区');
INSERT INTO `hi_region` VALUES ('1147', '1143', '350105', '马尾区');
INSERT INTO `hi_region` VALUES ('1148', '1143', '350111', '晋安区');
INSERT INTO `hi_region` VALUES ('1149', '1143', '350121', '闽侯县');
INSERT INTO `hi_region` VALUES ('1150', '1143', '350122', '连江县');
INSERT INTO `hi_region` VALUES ('1151', '1143', '350123', '罗源县');
INSERT INTO `hi_region` VALUES ('1152', '1143', '350124', '闽清县');
INSERT INTO `hi_region` VALUES ('1153', '1143', '350125', '永泰县');
INSERT INTO `hi_region` VALUES ('1154', '1143', '350128', '平潭县');
INSERT INTO `hi_region` VALUES ('1155', '1143', '350181', '福清市');
INSERT INTO `hi_region` VALUES ('1156', '1143', '350182', '长乐市');
INSERT INTO `hi_region` VALUES ('1157', '1142', '350200', '厦门市');
INSERT INTO `hi_region` VALUES ('1158', '1157', '350203', '思明区');
INSERT INTO `hi_region` VALUES ('1159', '1157', '350205', '海沧区');
INSERT INTO `hi_region` VALUES ('1160', '1157', '350206', '湖里区');
INSERT INTO `hi_region` VALUES ('1161', '1157', '350211', '集美区');
INSERT INTO `hi_region` VALUES ('1162', '1157', '350212', '同安区');
INSERT INTO `hi_region` VALUES ('1163', '1157', '350213', '翔安区');
INSERT INTO `hi_region` VALUES ('1164', '1142', '350300', '莆田市');
INSERT INTO `hi_region` VALUES ('1165', '1164', '350302', '城厢区');
INSERT INTO `hi_region` VALUES ('1166', '1164', '350303', '涵江区');
INSERT INTO `hi_region` VALUES ('1167', '1164', '350304', '荔城区');
INSERT INTO `hi_region` VALUES ('1168', '1164', '350305', '秀屿区');
INSERT INTO `hi_region` VALUES ('1169', '1164', '350322', '仙游县');
INSERT INTO `hi_region` VALUES ('1170', '1142', '350400', '三明市');
INSERT INTO `hi_region` VALUES ('1171', '1170', '350402', '梅列区');
INSERT INTO `hi_region` VALUES ('1172', '1170', '350403', '三元区');
INSERT INTO `hi_region` VALUES ('1173', '1170', '350421', '明溪县');
INSERT INTO `hi_region` VALUES ('1174', '1170', '350423', '清流县');
INSERT INTO `hi_region` VALUES ('1175', '1170', '350424', '宁化县');
INSERT INTO `hi_region` VALUES ('1176', '1170', '350425', '大田县');
INSERT INTO `hi_region` VALUES ('1177', '1170', '350426', '尤溪县');
INSERT INTO `hi_region` VALUES ('1178', '1170', '350427', '沙县');
INSERT INTO `hi_region` VALUES ('1179', '1170', '350428', '将乐县');
INSERT INTO `hi_region` VALUES ('1180', '1170', '350429', '泰宁县');
INSERT INTO `hi_region` VALUES ('1181', '1170', '350430', '建宁县');
INSERT INTO `hi_region` VALUES ('1182', '1170', '350481', '永安市');
INSERT INTO `hi_region` VALUES ('1183', '1142', '350500', '泉州市');
INSERT INTO `hi_region` VALUES ('1184', '1183', '350502', '鲤城区');
INSERT INTO `hi_region` VALUES ('1185', '1183', '350503', '丰泽区');
INSERT INTO `hi_region` VALUES ('1186', '1183', '350504', '洛江区');
INSERT INTO `hi_region` VALUES ('1187', '1183', '350505', '泉港区');
INSERT INTO `hi_region` VALUES ('1188', '1183', '350521', '惠安县');
INSERT INTO `hi_region` VALUES ('1189', '1183', '350524', '安溪县');
INSERT INTO `hi_region` VALUES ('1190', '1183', '350525', '永春县');
INSERT INTO `hi_region` VALUES ('1191', '1183', '350526', '德化县');
INSERT INTO `hi_region` VALUES ('1192', '1183', '350527', '金门县');
INSERT INTO `hi_region` VALUES ('1193', '1183', '350581', '石狮市');
INSERT INTO `hi_region` VALUES ('1194', '1183', '350582', '晋江市');
INSERT INTO `hi_region` VALUES ('1195', '1183', '350583', '南安市');
INSERT INTO `hi_region` VALUES ('1196', '1142', '350600', '漳州市');
INSERT INTO `hi_region` VALUES ('1197', '1196', '350602', '芗城区');
INSERT INTO `hi_region` VALUES ('1198', '1196', '350603', '龙文区');
INSERT INTO `hi_region` VALUES ('1199', '1196', '350622', '云霄县');
INSERT INTO `hi_region` VALUES ('1200', '1196', '350623', '漳浦县');
INSERT INTO `hi_region` VALUES ('1201', '1196', '350624', '诏安县');
INSERT INTO `hi_region` VALUES ('1202', '1196', '350625', '长泰县');
INSERT INTO `hi_region` VALUES ('1203', '1196', '350626', '东山县');
INSERT INTO `hi_region` VALUES ('1204', '1196', '350627', '南靖县');
INSERT INTO `hi_region` VALUES ('1205', '1196', '350628', '平和县');
INSERT INTO `hi_region` VALUES ('1206', '1196', '350629', '华安县');
INSERT INTO `hi_region` VALUES ('1207', '1196', '350681', '龙海市');
INSERT INTO `hi_region` VALUES ('1208', '1142', '350700', '南平市');
INSERT INTO `hi_region` VALUES ('1209', '1208', '350702', '延平区');
INSERT INTO `hi_region` VALUES ('1210', '1208', '350703', '建阳区');
INSERT INTO `hi_region` VALUES ('1211', '1208', '350721', '顺昌县');
INSERT INTO `hi_region` VALUES ('1212', '1208', '350722', '浦城县');
INSERT INTO `hi_region` VALUES ('1213', '1208', '350723', '光泽县');
INSERT INTO `hi_region` VALUES ('1214', '1208', '350724', '松溪县');
INSERT INTO `hi_region` VALUES ('1215', '1208', '350725', '政和县');
INSERT INTO `hi_region` VALUES ('1216', '1208', '350781', '邵武市');
INSERT INTO `hi_region` VALUES ('1217', '1208', '350782', '武夷山市');
INSERT INTO `hi_region` VALUES ('1218', '1208', '350783', '建瓯市');
INSERT INTO `hi_region` VALUES ('1219', '1142', '350800', '龙岩市');
INSERT INTO `hi_region` VALUES ('1220', '1219', '350802', '新罗区');
INSERT INTO `hi_region` VALUES ('1221', '1219', '350803', '永定区');
INSERT INTO `hi_region` VALUES ('1222', '1219', '350821', '长汀县');
INSERT INTO `hi_region` VALUES ('1223', '1219', '350823', '上杭县');
INSERT INTO `hi_region` VALUES ('1224', '1219', '350824', '武平县');
INSERT INTO `hi_region` VALUES ('1225', '1219', '350825', '连城县');
INSERT INTO `hi_region` VALUES ('1226', '1219', '350881', '漳平市');
INSERT INTO `hi_region` VALUES ('1227', '1142', '350900', '宁德市');
INSERT INTO `hi_region` VALUES ('1228', '1227', '350902', '蕉城区');
INSERT INTO `hi_region` VALUES ('1229', '1227', '350921', '霞浦县');
INSERT INTO `hi_region` VALUES ('1230', '1227', '350922', '古田县');
INSERT INTO `hi_region` VALUES ('1231', '1227', '350923', '屏南县');
INSERT INTO `hi_region` VALUES ('1232', '1227', '350924', '寿宁县');
INSERT INTO `hi_region` VALUES ('1233', '1227', '350925', '周宁县');
INSERT INTO `hi_region` VALUES ('1234', '1227', '350926', '柘荣县');
INSERT INTO `hi_region` VALUES ('1235', '1227', '350981', '福安市');
INSERT INTO `hi_region` VALUES ('1236', '1227', '350982', '福鼎市');
INSERT INTO `hi_region` VALUES ('1237', '0', '360000', '江西省');
INSERT INTO `hi_region` VALUES ('1238', '1237', '360100', '南昌市');
INSERT INTO `hi_region` VALUES ('1239', '1238', '360102', '东湖区');
INSERT INTO `hi_region` VALUES ('1240', '1238', '360103', '西湖区');
INSERT INTO `hi_region` VALUES ('1241', '1238', '360104', '青云谱区');
INSERT INTO `hi_region` VALUES ('1242', '1238', '360105', '湾里区');
INSERT INTO `hi_region` VALUES ('1243', '1238', '360111', '青山湖区');
INSERT INTO `hi_region` VALUES ('1244', '1238', '360112', '新建区');
INSERT INTO `hi_region` VALUES ('1245', '1238', '360121', '南昌县');
INSERT INTO `hi_region` VALUES ('1246', '1238', '360123', '安义县');
INSERT INTO `hi_region` VALUES ('1247', '1238', '360124', '进贤县');
INSERT INTO `hi_region` VALUES ('1248', '1237', '360200', '景德镇市');
INSERT INTO `hi_region` VALUES ('1249', '1248', '360202', '昌江区');
INSERT INTO `hi_region` VALUES ('1250', '1248', '360203', '珠山区');
INSERT INTO `hi_region` VALUES ('1251', '1248', '360222', '浮梁县');
INSERT INTO `hi_region` VALUES ('1252', '1248', '360281', '乐平市');
INSERT INTO `hi_region` VALUES ('1253', '1237', '360300', '萍乡市');
INSERT INTO `hi_region` VALUES ('1254', '1253', '360302', '安源区');
INSERT INTO `hi_region` VALUES ('1255', '1253', '360313', '湘东区');
INSERT INTO `hi_region` VALUES ('1256', '1253', '360321', '莲花县');
INSERT INTO `hi_region` VALUES ('1257', '1253', '360322', '上栗县');
INSERT INTO `hi_region` VALUES ('1258', '1253', '360323', '芦溪县');
INSERT INTO `hi_region` VALUES ('1259', '1237', '360400', '九江市');
INSERT INTO `hi_region` VALUES ('1260', '1259', '360402', '濂溪区');
INSERT INTO `hi_region` VALUES ('1261', '1259', '360403', '浔阳区');
INSERT INTO `hi_region` VALUES ('1262', '1259', '360421', '九江县');
INSERT INTO `hi_region` VALUES ('1263', '1259', '360423', '武宁县');
INSERT INTO `hi_region` VALUES ('1264', '1259', '360424', '修水县');
INSERT INTO `hi_region` VALUES ('1265', '1259', '360425', '永修县');
INSERT INTO `hi_region` VALUES ('1266', '1259', '360426', '德安县');
INSERT INTO `hi_region` VALUES ('1267', '1259', '360428', '都昌县');
INSERT INTO `hi_region` VALUES ('1268', '1259', '360429', '湖口县');
INSERT INTO `hi_region` VALUES ('1269', '1259', '360430', '彭泽县');
INSERT INTO `hi_region` VALUES ('1270', '1259', '360481', '瑞昌市');
INSERT INTO `hi_region` VALUES ('1271', '1259', '360482', '共青城市');
INSERT INTO `hi_region` VALUES ('1272', '1259', '360483', '庐山市');
INSERT INTO `hi_region` VALUES ('1273', '1237', '360500', '新余市');
INSERT INTO `hi_region` VALUES ('1274', '1273', '360502', '渝水区');
INSERT INTO `hi_region` VALUES ('1275', '1273', '360521', '分宜县');
INSERT INTO `hi_region` VALUES ('1276', '1237', '360600', '鹰潭市');
INSERT INTO `hi_region` VALUES ('1277', '1276', '360602', '月湖区');
INSERT INTO `hi_region` VALUES ('1278', '1276', '360622', '余江县');
INSERT INTO `hi_region` VALUES ('1279', '1276', '360681', '贵溪市');
INSERT INTO `hi_region` VALUES ('1280', '1237', '360700', '赣州市');
INSERT INTO `hi_region` VALUES ('1281', '1280', '360702', '章贡区');
INSERT INTO `hi_region` VALUES ('1282', '1280', '360703', '南康区');
INSERT INTO `hi_region` VALUES ('1283', '1280', '360704', '赣县');
INSERT INTO `hi_region` VALUES ('1284', '1280', '360722', '信丰县');
INSERT INTO `hi_region` VALUES ('1285', '1280', '360723', '大余县');
INSERT INTO `hi_region` VALUES ('1286', '1280', '360724', '上犹县');
INSERT INTO `hi_region` VALUES ('1287', '1280', '360725', '崇义县');
INSERT INTO `hi_region` VALUES ('1288', '1280', '360726', '安远县');
INSERT INTO `hi_region` VALUES ('1289', '1280', '360727', '龙南县');
INSERT INTO `hi_region` VALUES ('1290', '1280', '360728', '定南县');
INSERT INTO `hi_region` VALUES ('1291', '1280', '360729', '全南县');
INSERT INTO `hi_region` VALUES ('1292', '1280', '360730', '宁都县');
INSERT INTO `hi_region` VALUES ('1293', '1280', '360731', '于都县');
INSERT INTO `hi_region` VALUES ('1294', '1280', '360732', '兴国县');
INSERT INTO `hi_region` VALUES ('1295', '1280', '360733', '会昌县');
INSERT INTO `hi_region` VALUES ('1296', '1280', '360734', '寻乌县');
INSERT INTO `hi_region` VALUES ('1297', '1280', '360735', '石城县');
INSERT INTO `hi_region` VALUES ('1298', '1280', '360781', '瑞金市');
INSERT INTO `hi_region` VALUES ('1299', '1237', '360800', '吉安市');
INSERT INTO `hi_region` VALUES ('1300', '1299', '360802', '吉州区');
INSERT INTO `hi_region` VALUES ('1301', '1299', '360803', '青原区');
INSERT INTO `hi_region` VALUES ('1302', '1299', '360821', '吉安县');
INSERT INTO `hi_region` VALUES ('1303', '1299', '360822', '吉水县');
INSERT INTO `hi_region` VALUES ('1304', '1299', '360823', '峡江县');
INSERT INTO `hi_region` VALUES ('1305', '1299', '360824', '新干县');
INSERT INTO `hi_region` VALUES ('1306', '1299', '360825', '永丰县');
INSERT INTO `hi_region` VALUES ('1307', '1299', '360826', '泰和县');
INSERT INTO `hi_region` VALUES ('1308', '1299', '360827', '遂川县');
INSERT INTO `hi_region` VALUES ('1309', '1299', '360828', '万安县');
INSERT INTO `hi_region` VALUES ('1310', '1299', '360829', '安福县');
INSERT INTO `hi_region` VALUES ('1311', '1299', '360830', '永新县');
INSERT INTO `hi_region` VALUES ('1312', '1299', '360881', '井冈山市');
INSERT INTO `hi_region` VALUES ('1313', '1237', '360900', '宜春市');
INSERT INTO `hi_region` VALUES ('1314', '1313', '360902', '袁州区');
INSERT INTO `hi_region` VALUES ('1315', '1313', '360921', '奉新县');
INSERT INTO `hi_region` VALUES ('1316', '1313', '360922', '万载县');
INSERT INTO `hi_region` VALUES ('1317', '1313', '360923', '上高县');
INSERT INTO `hi_region` VALUES ('1318', '1313', '360924', '宜丰县');
INSERT INTO `hi_region` VALUES ('1319', '1313', '360925', '靖安县');
INSERT INTO `hi_region` VALUES ('1320', '1313', '360926', '铜鼓县');
INSERT INTO `hi_region` VALUES ('1321', '1313', '360981', '丰城市');
INSERT INTO `hi_region` VALUES ('1322', '1313', '360982', '樟树市');
INSERT INTO `hi_region` VALUES ('1323', '1313', '360983', '高安市');
INSERT INTO `hi_region` VALUES ('1324', '1237', '361000', '抚州市');
INSERT INTO `hi_region` VALUES ('1325', '1324', '361002', '临川区');
INSERT INTO `hi_region` VALUES ('1326', '1324', '361021', '南城县');
INSERT INTO `hi_region` VALUES ('1327', '1324', '361022', '黎川县');
INSERT INTO `hi_region` VALUES ('1328', '1324', '361023', '南丰县');
INSERT INTO `hi_region` VALUES ('1329', '1324', '361024', '崇仁县');
INSERT INTO `hi_region` VALUES ('1330', '1324', '361025', '乐安县');
INSERT INTO `hi_region` VALUES ('1331', '1324', '361026', '宜黄县');
INSERT INTO `hi_region` VALUES ('1332', '1324', '361027', '金溪县');
INSERT INTO `hi_region` VALUES ('1333', '1324', '361028', '资溪县');
INSERT INTO `hi_region` VALUES ('1334', '1324', '361030', '广昌县');
INSERT INTO `hi_region` VALUES ('1335', '1237', '361100', '上饶市');
INSERT INTO `hi_region` VALUES ('1336', '1335', '361102', '信州区');
INSERT INTO `hi_region` VALUES ('1337', '1335', '361121', '上饶县');
INSERT INTO `hi_region` VALUES ('1338', '1335', '361103', '广丰区');
INSERT INTO `hi_region` VALUES ('1339', '1335', '361123', '玉山县');
INSERT INTO `hi_region` VALUES ('1340', '1335', '361124', '铅山县');
INSERT INTO `hi_region` VALUES ('1341', '1335', '361125', '横峰县');
INSERT INTO `hi_region` VALUES ('1342', '1335', '361126', '弋阳县');
INSERT INTO `hi_region` VALUES ('1343', '1335', '361127', '余干县');
INSERT INTO `hi_region` VALUES ('1344', '1335', '361128', '鄱阳县');
INSERT INTO `hi_region` VALUES ('1345', '1335', '361129', '万年县');
INSERT INTO `hi_region` VALUES ('1346', '1335', '361130', '婺源县');
INSERT INTO `hi_region` VALUES ('1347', '1335', '361181', '德兴市');
INSERT INTO `hi_region` VALUES ('1348', '0', '370000', '山东省');
INSERT INTO `hi_region` VALUES ('1349', '1348', '370100', '济南市');
INSERT INTO `hi_region` VALUES ('1350', '1349', '370102', '历下区');
INSERT INTO `hi_region` VALUES ('1351', '1349', '370103', '市中区');
INSERT INTO `hi_region` VALUES ('1352', '1349', '370104', '槐荫区');
INSERT INTO `hi_region` VALUES ('1353', '1349', '370105', '天桥区');
INSERT INTO `hi_region` VALUES ('1354', '1349', '370112', '历城区');
INSERT INTO `hi_region` VALUES ('1355', '1349', '370113', '长清区');
INSERT INTO `hi_region` VALUES ('1356', '1349', '370114', '章丘区');
INSERT INTO `hi_region` VALUES ('1357', '1349', '370124', '平阴县');
INSERT INTO `hi_region` VALUES ('1358', '1349', '370125', '济阳县');
INSERT INTO `hi_region` VALUES ('1359', '1349', '370126', '商河县');
INSERT INTO `hi_region` VALUES ('1360', '1348', '370200', '青岛市');
INSERT INTO `hi_region` VALUES ('1361', '1360', '370202', '市南区');
INSERT INTO `hi_region` VALUES ('1362', '1360', '370203', '市北区');
INSERT INTO `hi_region` VALUES ('1363', '1360', '370211', '黄岛区');
INSERT INTO `hi_region` VALUES ('1364', '1360', '370212', '崂山区');
INSERT INTO `hi_region` VALUES ('1365', '1360', '370213', '李沧区');
INSERT INTO `hi_region` VALUES ('1366', '1360', '370214', '城阳区');
INSERT INTO `hi_region` VALUES ('1367', '1360', '370281', '胶州市');
INSERT INTO `hi_region` VALUES ('1368', '1360', '370282', '即墨市');
INSERT INTO `hi_region` VALUES ('1369', '1360', '370283', '平度市');
INSERT INTO `hi_region` VALUES ('1370', '1360', '370285', '莱西市');
INSERT INTO `hi_region` VALUES ('1371', '1348', '370300', '淄博市');
INSERT INTO `hi_region` VALUES ('1372', '1371', '370302', '淄川区');
INSERT INTO `hi_region` VALUES ('1373', '1371', '370303', '张店区');
INSERT INTO `hi_region` VALUES ('1374', '1371', '370304', '博山区');
INSERT INTO `hi_region` VALUES ('1375', '1371', '370305', '临淄区');
INSERT INTO `hi_region` VALUES ('1376', '1371', '370306', '周村区');
INSERT INTO `hi_region` VALUES ('1377', '1371', '370321', '桓台县');
INSERT INTO `hi_region` VALUES ('1378', '1371', '370322', '高青县');
INSERT INTO `hi_region` VALUES ('1379', '1371', '370323', '沂源县');
INSERT INTO `hi_region` VALUES ('1380', '1348', '370400', '枣庄市');
INSERT INTO `hi_region` VALUES ('1381', '1380', '370402', '市中区');
INSERT INTO `hi_region` VALUES ('1382', '1380', '370403', '薛城区');
INSERT INTO `hi_region` VALUES ('1383', '1380', '370404', '峄城区');
INSERT INTO `hi_region` VALUES ('1384', '1380', '370405', '台儿庄区');
INSERT INTO `hi_region` VALUES ('1385', '1380', '370406', '山亭区');
INSERT INTO `hi_region` VALUES ('1386', '1380', '370481', '滕州市');
INSERT INTO `hi_region` VALUES ('1387', '1348', '370500', '东营市');
INSERT INTO `hi_region` VALUES ('1388', '1387', '370502', '东营区');
INSERT INTO `hi_region` VALUES ('1389', '1387', '370503', '河口区');
INSERT INTO `hi_region` VALUES ('1390', '1387', '370522', '利津县');
INSERT INTO `hi_region` VALUES ('1391', '1387', '370523', '广饶县');
INSERT INTO `hi_region` VALUES ('1392', '1348', '370600', '烟台市');
INSERT INTO `hi_region` VALUES ('1393', '1392', '370602', '芝罘区');
INSERT INTO `hi_region` VALUES ('1394', '1392', '370611', '福山区');
INSERT INTO `hi_region` VALUES ('1395', '1392', '370612', '牟平区');
INSERT INTO `hi_region` VALUES ('1396', '1392', '370613', '莱山区');
INSERT INTO `hi_region` VALUES ('1397', '1392', '370634', '长岛县');
INSERT INTO `hi_region` VALUES ('1398', '1392', '370681', '龙口市');
INSERT INTO `hi_region` VALUES ('1399', '1392', '370682', '莱阳市');
INSERT INTO `hi_region` VALUES ('1400', '1392', '370683', '莱州市');
INSERT INTO `hi_region` VALUES ('1401', '1392', '370684', '蓬莱市');
INSERT INTO `hi_region` VALUES ('1402', '1392', '370685', '招远市');
INSERT INTO `hi_region` VALUES ('1403', '1392', '370686', '栖霞市');
INSERT INTO `hi_region` VALUES ('1404', '1392', '370687', '海阳市');
INSERT INTO `hi_region` VALUES ('1405', '1348', '370700', '潍坊市');
INSERT INTO `hi_region` VALUES ('1406', '1405', '370702', '潍城区');
INSERT INTO `hi_region` VALUES ('1407', '1405', '370703', '寒亭区');
INSERT INTO `hi_region` VALUES ('1408', '1405', '370704', '坊子区');
INSERT INTO `hi_region` VALUES ('1409', '1405', '370705', '奎文区');
INSERT INTO `hi_region` VALUES ('1410', '1405', '370724', '临朐县');
INSERT INTO `hi_region` VALUES ('1411', '1405', '370725', '昌乐县');
INSERT INTO `hi_region` VALUES ('1412', '1405', '370781', '青州市');
INSERT INTO `hi_region` VALUES ('1413', '1405', '370782', '诸城市');
INSERT INTO `hi_region` VALUES ('1414', '1405', '370783', '寿光市');
INSERT INTO `hi_region` VALUES ('1415', '1405', '370784', '安丘市');
INSERT INTO `hi_region` VALUES ('1416', '1405', '370785', '高密市');
INSERT INTO `hi_region` VALUES ('1417', '1405', '370786', '昌邑市');
INSERT INTO `hi_region` VALUES ('1418', '1348', '370800', '济宁市');
INSERT INTO `hi_region` VALUES ('1419', '1418', '370811', '任城区');
INSERT INTO `hi_region` VALUES ('1420', '1418', '370812', '兖州区');
INSERT INTO `hi_region` VALUES ('1421', '1418', '370826', '微山县');
INSERT INTO `hi_region` VALUES ('1422', '1418', '370827', '鱼台县');
INSERT INTO `hi_region` VALUES ('1423', '1418', '370828', '金乡县');
INSERT INTO `hi_region` VALUES ('1424', '1418', '370829', '嘉祥县');
INSERT INTO `hi_region` VALUES ('1425', '1418', '370830', '汶上县');
INSERT INTO `hi_region` VALUES ('1426', '1418', '370831', '泗水县');
INSERT INTO `hi_region` VALUES ('1427', '1418', '370832', '梁山县');
INSERT INTO `hi_region` VALUES ('1428', '1418', '370881', '曲阜市');
INSERT INTO `hi_region` VALUES ('1429', '1418', '370883', '邹城市');
INSERT INTO `hi_region` VALUES ('1430', '1348', '370900', '泰安市');
INSERT INTO `hi_region` VALUES ('1431', '1430', '370902', '泰山区');
INSERT INTO `hi_region` VALUES ('1432', '1430', '370911', '岱岳区');
INSERT INTO `hi_region` VALUES ('1433', '1430', '370921', '宁阳县');
INSERT INTO `hi_region` VALUES ('1434', '1430', '370923', '东平县');
INSERT INTO `hi_region` VALUES ('1435', '1430', '370982', '新泰市');
INSERT INTO `hi_region` VALUES ('1436', '1430', '370983', '肥城市');
INSERT INTO `hi_region` VALUES ('1437', '1348', '371000', '威海市');
INSERT INTO `hi_region` VALUES ('1438', '1437', '371002', '环翠区');
INSERT INTO `hi_region` VALUES ('1439', '1437', '371003', '文登区');
INSERT INTO `hi_region` VALUES ('1440', '1437', '371082', '荣成市');
INSERT INTO `hi_region` VALUES ('1441', '1437', '371083', '乳山市');
INSERT INTO `hi_region` VALUES ('1442', '1348', '371100', '日照市');
INSERT INTO `hi_region` VALUES ('1443', '1442', '371102', '东港区');
INSERT INTO `hi_region` VALUES ('1444', '1442', '371103', '岚山区');
INSERT INTO `hi_region` VALUES ('1445', '1442', '371121', '五莲县');
INSERT INTO `hi_region` VALUES ('1446', '1442', '371122', '莒县');
INSERT INTO `hi_region` VALUES ('1447', '1348', '371200', '莱芜市');
INSERT INTO `hi_region` VALUES ('1448', '1447', '371202', '莱城区');
INSERT INTO `hi_region` VALUES ('1449', '1447', '371203', '钢城区');
INSERT INTO `hi_region` VALUES ('1450', '1348', '371300', '临沂市');
INSERT INTO `hi_region` VALUES ('1451', '1450', '371302', '兰山区');
INSERT INTO `hi_region` VALUES ('1452', '1450', '371311', '罗庄区');
INSERT INTO `hi_region` VALUES ('1453', '1450', '371312', '河东区');
INSERT INTO `hi_region` VALUES ('1454', '1450', '371321', '沂南县');
INSERT INTO `hi_region` VALUES ('1455', '1450', '371322', '郯城县');
INSERT INTO `hi_region` VALUES ('1456', '1450', '371323', '沂水县');
INSERT INTO `hi_region` VALUES ('1457', '1450', '371324', '兰陵县');
INSERT INTO `hi_region` VALUES ('1458', '1450', '371325', '费县');
INSERT INTO `hi_region` VALUES ('1459', '1450', '371326', '平邑县');
INSERT INTO `hi_region` VALUES ('1460', '1450', '371327', '莒南县');
INSERT INTO `hi_region` VALUES ('1461', '1450', '371328', '蒙阴县');
INSERT INTO `hi_region` VALUES ('1462', '1450', '371329', '临沭县');
INSERT INTO `hi_region` VALUES ('1463', '1348', '371400', '德州市');
INSERT INTO `hi_region` VALUES ('1464', '1463', '371402', '德城区');
INSERT INTO `hi_region` VALUES ('1465', '1463', '371403', '陵城区');
INSERT INTO `hi_region` VALUES ('1466', '1463', '371422', '宁津县');
INSERT INTO `hi_region` VALUES ('1467', '1463', '371423', '庆云县');
INSERT INTO `hi_region` VALUES ('1468', '1463', '371424', '临邑县');
INSERT INTO `hi_region` VALUES ('1469', '1463', '371425', '齐河县');
INSERT INTO `hi_region` VALUES ('1470', '1463', '371426', '平原县');
INSERT INTO `hi_region` VALUES ('1471', '1463', '371427', '夏津县');
INSERT INTO `hi_region` VALUES ('1472', '1463', '371428', '武城县');
INSERT INTO `hi_region` VALUES ('1473', '1463', '371481', '乐陵市');
INSERT INTO `hi_region` VALUES ('1474', '1463', '371482', '禹城市');
INSERT INTO `hi_region` VALUES ('1475', '1348', '371500', '聊城市');
INSERT INTO `hi_region` VALUES ('1476', '1475', '371502', '东昌府区');
INSERT INTO `hi_region` VALUES ('1477', '1475', '371521', '阳谷县');
INSERT INTO `hi_region` VALUES ('1478', '1475', '371522', '莘县');
INSERT INTO `hi_region` VALUES ('1479', '1475', '371523', '茌平县');
INSERT INTO `hi_region` VALUES ('1480', '1475', '371524', '东阿县');
INSERT INTO `hi_region` VALUES ('1481', '1475', '371525', '冠县');
INSERT INTO `hi_region` VALUES ('1482', '1475', '371526', '高唐县');
INSERT INTO `hi_region` VALUES ('1483', '1475', '371581', '临清市');
INSERT INTO `hi_region` VALUES ('1484', '1348', '371600', '滨州市');
INSERT INTO `hi_region` VALUES ('1485', '1484', '371602', '滨城区');
INSERT INTO `hi_region` VALUES ('1486', '1484', '371603', '沾化区');
INSERT INTO `hi_region` VALUES ('1487', '1484', '371621', '惠民县');
INSERT INTO `hi_region` VALUES ('1488', '1484', '371622', '阳信县');
INSERT INTO `hi_region` VALUES ('1489', '1484', '371623', '无棣县');
INSERT INTO `hi_region` VALUES ('1490', '1484', '371625', '博兴县');
INSERT INTO `hi_region` VALUES ('1491', '1484', '371626', '邹平县');
INSERT INTO `hi_region` VALUES ('1492', '1348', '371700', '菏泽市');
INSERT INTO `hi_region` VALUES ('1493', '1492', '371702', '牡丹区');
INSERT INTO `hi_region` VALUES ('1494', '1492', '371703', '定陶区');
INSERT INTO `hi_region` VALUES ('1495', '1492', '371721', '曹县');
INSERT INTO `hi_region` VALUES ('1496', '1492', '371722', '单县');
INSERT INTO `hi_region` VALUES ('1497', '1492', '371723', '成武县');
INSERT INTO `hi_region` VALUES ('1498', '1492', '371724', '巨野县');
INSERT INTO `hi_region` VALUES ('1499', '1492', '371725', '郓城县');
INSERT INTO `hi_region` VALUES ('1500', '1492', '371726', '鄄城县');
INSERT INTO `hi_region` VALUES ('1501', '1492', '371728', '东明县');
INSERT INTO `hi_region` VALUES ('1502', '0', '410000', '河南省');
INSERT INTO `hi_region` VALUES ('1503', '1502', '410100', '郑州市');
INSERT INTO `hi_region` VALUES ('1504', '1503', '410102', '中原区');
INSERT INTO `hi_region` VALUES ('1505', '1503', '410103', '二七区');
INSERT INTO `hi_region` VALUES ('1506', '1503', '410104', '管城回族区');
INSERT INTO `hi_region` VALUES ('1507', '1503', '410105', '金水区');
INSERT INTO `hi_region` VALUES ('1508', '1503', '410106', '上街区');
INSERT INTO `hi_region` VALUES ('1509', '1503', '410108', '惠济区');
INSERT INTO `hi_region` VALUES ('1510', '1503', '410122', '中牟县');
INSERT INTO `hi_region` VALUES ('1511', '1503', '410181', '巩义市');
INSERT INTO `hi_region` VALUES ('1512', '1503', '410182', '荥阳市');
INSERT INTO `hi_region` VALUES ('1513', '1503', '410183', '新密市');
INSERT INTO `hi_region` VALUES ('1514', '1503', '410184', '新郑市');
INSERT INTO `hi_region` VALUES ('1515', '1503', '410185', '登封市');
INSERT INTO `hi_region` VALUES ('1516', '1502', '410200', '开封市');
INSERT INTO `hi_region` VALUES ('1517', '1516', '410202', '龙亭区');
INSERT INTO `hi_region` VALUES ('1518', '1516', '410203', '顺河回族区');
INSERT INTO `hi_region` VALUES ('1519', '1516', '410204', '鼓楼区');
INSERT INTO `hi_region` VALUES ('1520', '1516', '410205', '禹王台区');
INSERT INTO `hi_region` VALUES ('1521', '1516', '410212', '祥符区');
INSERT INTO `hi_region` VALUES ('1522', '1516', '410221', '杞县');
INSERT INTO `hi_region` VALUES ('1523', '1516', '410222', '通许县');
INSERT INTO `hi_region` VALUES ('1524', '1516', '410223', '尉氏县');
INSERT INTO `hi_region` VALUES ('1525', '1516', '410225', '兰考县');
INSERT INTO `hi_region` VALUES ('1526', '1502', '410300', '洛阳市');
INSERT INTO `hi_region` VALUES ('1527', '1526', '410302', '老城区');
INSERT INTO `hi_region` VALUES ('1528', '1526', '410303', '西工区');
INSERT INTO `hi_region` VALUES ('1529', '1526', '410304', '瀍河回族区');
INSERT INTO `hi_region` VALUES ('1530', '1526', '410305', '涧西区');
INSERT INTO `hi_region` VALUES ('1531', '1526', '410306', '吉利区');
INSERT INTO `hi_region` VALUES ('1532', '1526', '410311', '洛龙区');
INSERT INTO `hi_region` VALUES ('1533', '1526', '410322', '孟津县');
INSERT INTO `hi_region` VALUES ('1534', '1526', '410323', '新安县');
INSERT INTO `hi_region` VALUES ('1535', '1526', '410324', '栾川县');
INSERT INTO `hi_region` VALUES ('1536', '1526', '410325', '嵩县');
INSERT INTO `hi_region` VALUES ('1537', '1526', '410326', '汝阳县');
INSERT INTO `hi_region` VALUES ('1538', '1526', '410327', '宜阳县');
INSERT INTO `hi_region` VALUES ('1539', '1526', '410328', '洛宁县');
INSERT INTO `hi_region` VALUES ('1540', '1526', '410329', '伊川县');
INSERT INTO `hi_region` VALUES ('1541', '1526', '410381', '偃师市');
INSERT INTO `hi_region` VALUES ('1542', '1502', '410400', '平顶山市');
INSERT INTO `hi_region` VALUES ('1543', '1542', '410402', '新华区');
INSERT INTO `hi_region` VALUES ('1544', '1542', '410403', '卫东区');
INSERT INTO `hi_region` VALUES ('1545', '1542', '410404', '石龙区');
INSERT INTO `hi_region` VALUES ('1546', '1542', '410411', '湛河区');
INSERT INTO `hi_region` VALUES ('1547', '1542', '410421', '宝丰县');
INSERT INTO `hi_region` VALUES ('1548', '1542', '410422', '叶县');
INSERT INTO `hi_region` VALUES ('1549', '1542', '410423', '鲁山县');
INSERT INTO `hi_region` VALUES ('1550', '1542', '410425', '郏县');
INSERT INTO `hi_region` VALUES ('1551', '1542', '410481', '舞钢市');
INSERT INTO `hi_region` VALUES ('1552', '1542', '410482', '汝州市');
INSERT INTO `hi_region` VALUES ('1553', '1502', '410500', '安阳市');
INSERT INTO `hi_region` VALUES ('1554', '1553', '410502', '文峰区');
INSERT INTO `hi_region` VALUES ('1555', '1553', '410503', '北关区');
INSERT INTO `hi_region` VALUES ('1556', '1553', '410505', '殷都区');
INSERT INTO `hi_region` VALUES ('1557', '1553', '410506', '龙安区');
INSERT INTO `hi_region` VALUES ('1558', '1553', '410522', '安阳县');
INSERT INTO `hi_region` VALUES ('1559', '1553', '410523', '汤阴县');
INSERT INTO `hi_region` VALUES ('1560', '1553', '410526', '滑县');
INSERT INTO `hi_region` VALUES ('1561', '1553', '410527', '内黄县');
INSERT INTO `hi_region` VALUES ('1562', '1553', '410581', '林州市');
INSERT INTO `hi_region` VALUES ('1563', '1502', '410600', '鹤壁市');
INSERT INTO `hi_region` VALUES ('1564', '1563', '410602', '鹤山区');
INSERT INTO `hi_region` VALUES ('1565', '1563', '410603', '山城区');
INSERT INTO `hi_region` VALUES ('1566', '1563', '410611', '淇滨区');
INSERT INTO `hi_region` VALUES ('1567', '1563', '410621', '浚县');
INSERT INTO `hi_region` VALUES ('1568', '1563', '410622', '淇县');
INSERT INTO `hi_region` VALUES ('1569', '1502', '410700', '新乡市');
INSERT INTO `hi_region` VALUES ('1570', '1569', '410702', '红旗区');
INSERT INTO `hi_region` VALUES ('1571', '1569', '410703', '卫滨区');
INSERT INTO `hi_region` VALUES ('1572', '1569', '410704', '凤泉区');
INSERT INTO `hi_region` VALUES ('1573', '1569', '410711', '牧野区');
INSERT INTO `hi_region` VALUES ('1574', '1569', '410721', '新乡县');
INSERT INTO `hi_region` VALUES ('1575', '1569', '410724', '获嘉县');
INSERT INTO `hi_region` VALUES ('1576', '1569', '410725', '原阳县');
INSERT INTO `hi_region` VALUES ('1577', '1569', '410726', '延津县');
INSERT INTO `hi_region` VALUES ('1578', '1569', '410727', '封丘县');
INSERT INTO `hi_region` VALUES ('1579', '1569', '410728', '长垣县');
INSERT INTO `hi_region` VALUES ('1580', '1569', '410781', '卫辉市');
INSERT INTO `hi_region` VALUES ('1581', '1569', '410782', '辉县市');
INSERT INTO `hi_region` VALUES ('1582', '1502', '410800', '焦作市');
INSERT INTO `hi_region` VALUES ('1583', '1582', '410802', '解放区');
INSERT INTO `hi_region` VALUES ('1584', '1582', '410803', '中站区');
INSERT INTO `hi_region` VALUES ('1585', '1582', '410804', '马村区');
INSERT INTO `hi_region` VALUES ('1586', '1582', '410811', '山阳区');
INSERT INTO `hi_region` VALUES ('1587', '1582', '410821', '修武县');
INSERT INTO `hi_region` VALUES ('1588', '1582', '410822', '博爱县');
INSERT INTO `hi_region` VALUES ('1589', '1582', '410823', '武陟县');
INSERT INTO `hi_region` VALUES ('1590', '1582', '410825', '温县');
INSERT INTO `hi_region` VALUES ('1591', '1582', '410882', '沁阳市');
INSERT INTO `hi_region` VALUES ('1592', '1582', '410883', '孟州市');
INSERT INTO `hi_region` VALUES ('1593', '1502', '410900', '濮阳市');
INSERT INTO `hi_region` VALUES ('1594', '1593', '410902', '华龙区');
INSERT INTO `hi_region` VALUES ('1595', '1593', '410922', '清丰县');
INSERT INTO `hi_region` VALUES ('1596', '1593', '410923', '南乐县');
INSERT INTO `hi_region` VALUES ('1597', '1593', '410926', '范县');
INSERT INTO `hi_region` VALUES ('1598', '1593', '410927', '台前县');
INSERT INTO `hi_region` VALUES ('1599', '1593', '410928', '濮阳县');
INSERT INTO `hi_region` VALUES ('1600', '1502', '411000', '许昌市');
INSERT INTO `hi_region` VALUES ('1601', '1600', '411002', '魏都区');
INSERT INTO `hi_region` VALUES ('1602', '1600', '411003', '建安区');
INSERT INTO `hi_region` VALUES ('1603', '1600', '411024', '鄢陵县');
INSERT INTO `hi_region` VALUES ('1604', '1600', '411025', '襄城县');
INSERT INTO `hi_region` VALUES ('1605', '1600', '411081', '禹州市');
INSERT INTO `hi_region` VALUES ('1606', '1600', '411082', '长葛市');
INSERT INTO `hi_region` VALUES ('1607', '1502', '411100', '漯河市');
INSERT INTO `hi_region` VALUES ('1608', '1607', '411102', '源汇区');
INSERT INTO `hi_region` VALUES ('1609', '1607', '411103', '郾城区');
INSERT INTO `hi_region` VALUES ('1610', '1607', '411104', '召陵区');
INSERT INTO `hi_region` VALUES ('1611', '1607', '411121', '舞阳县');
INSERT INTO `hi_region` VALUES ('1612', '1607', '411122', '临颍县');
INSERT INTO `hi_region` VALUES ('1613', '1502', '411200', '三门峡市');
INSERT INTO `hi_region` VALUES ('1614', '1613', '411202', '湖滨区');
INSERT INTO `hi_region` VALUES ('1615', '1613', '411203', '陕州区');
INSERT INTO `hi_region` VALUES ('1616', '1613', '411221', '渑池县');
INSERT INTO `hi_region` VALUES ('1617', '1613', '411224', '卢氏县');
INSERT INTO `hi_region` VALUES ('1618', '1613', '411281', '义马市');
INSERT INTO `hi_region` VALUES ('1619', '1613', '411282', '灵宝市');
INSERT INTO `hi_region` VALUES ('1620', '1502', '411300', '南阳市');
INSERT INTO `hi_region` VALUES ('1621', '1620', '411302', '宛城区');
INSERT INTO `hi_region` VALUES ('1622', '1620', '411303', '卧龙区');
INSERT INTO `hi_region` VALUES ('1623', '1620', '411321', '南召县');
INSERT INTO `hi_region` VALUES ('1624', '1620', '411322', '方城县');
INSERT INTO `hi_region` VALUES ('1625', '1620', '411323', '西峡县');
INSERT INTO `hi_region` VALUES ('1626', '1620', '411324', '镇平县');
INSERT INTO `hi_region` VALUES ('1627', '1620', '411325', '内乡县');
INSERT INTO `hi_region` VALUES ('1628', '1620', '411326', '淅川县');
INSERT INTO `hi_region` VALUES ('1629', '1620', '411327', '社旗县');
INSERT INTO `hi_region` VALUES ('1630', '1620', '411328', '唐河县');
INSERT INTO `hi_region` VALUES ('1631', '1620', '411329', '新野县');
INSERT INTO `hi_region` VALUES ('1632', '1620', '411330', '桐柏县');
INSERT INTO `hi_region` VALUES ('1633', '1620', '411381', '邓州市');
INSERT INTO `hi_region` VALUES ('1634', '1502', '411400', '商丘市');
INSERT INTO `hi_region` VALUES ('1635', '1634', '411402', '梁园区');
INSERT INTO `hi_region` VALUES ('1636', '1634', '411403', '睢阳区');
INSERT INTO `hi_region` VALUES ('1637', '1634', '411421', '民权县');
INSERT INTO `hi_region` VALUES ('1638', '1634', '411422', '睢县');
INSERT INTO `hi_region` VALUES ('1639', '1634', '411423', '宁陵县');
INSERT INTO `hi_region` VALUES ('1640', '1634', '411424', '柘城县');
INSERT INTO `hi_region` VALUES ('1641', '1634', '411425', '虞城县');
INSERT INTO `hi_region` VALUES ('1642', '1634', '411426', '夏邑县');
INSERT INTO `hi_region` VALUES ('1643', '1634', '411481', '永城市');
INSERT INTO `hi_region` VALUES ('1644', '1502', '411500', '信阳市');
INSERT INTO `hi_region` VALUES ('1645', '1644', '411502', '浉河区');
INSERT INTO `hi_region` VALUES ('1646', '1644', '411503', '平桥区');
INSERT INTO `hi_region` VALUES ('1647', '1644', '411521', '罗山县');
INSERT INTO `hi_region` VALUES ('1648', '1644', '411522', '光山县');
INSERT INTO `hi_region` VALUES ('1649', '1644', '411523', '新县');
INSERT INTO `hi_region` VALUES ('1650', '1644', '411524', '商城县');
INSERT INTO `hi_region` VALUES ('1651', '1644', '411525', '固始县');
INSERT INTO `hi_region` VALUES ('1652', '1644', '411526', '潢川县');
INSERT INTO `hi_region` VALUES ('1653', '1644', '411527', '淮滨县');
INSERT INTO `hi_region` VALUES ('1654', '1644', '411528', '息县');
INSERT INTO `hi_region` VALUES ('1655', '1502', '411600', '周口市');
INSERT INTO `hi_region` VALUES ('1656', '1655', '411602', '川汇区');
INSERT INTO `hi_region` VALUES ('1657', '1655', '411621', '扶沟县');
INSERT INTO `hi_region` VALUES ('1658', '1655', '411622', '西华县');
INSERT INTO `hi_region` VALUES ('1659', '1655', '411623', '商水县');
INSERT INTO `hi_region` VALUES ('1660', '1655', '411624', '沈丘县');
INSERT INTO `hi_region` VALUES ('1661', '1655', '411625', '郸城县');
INSERT INTO `hi_region` VALUES ('1662', '1655', '411626', '淮阳县');
INSERT INTO `hi_region` VALUES ('1663', '1655', '411627', '太康县');
INSERT INTO `hi_region` VALUES ('1664', '1655', '411628', '鹿邑县');
INSERT INTO `hi_region` VALUES ('1665', '1655', '411681', '项城市');
INSERT INTO `hi_region` VALUES ('1666', '1502', '411700', '驻马店市');
INSERT INTO `hi_region` VALUES ('1667', '1666', '411702', '驿城区');
INSERT INTO `hi_region` VALUES ('1668', '1666', '411721', '西平县');
INSERT INTO `hi_region` VALUES ('1669', '1666', '411722', '上蔡县');
INSERT INTO `hi_region` VALUES ('1670', '1666', '411723', '平舆县');
INSERT INTO `hi_region` VALUES ('1671', '1666', '411724', '正阳县');
INSERT INTO `hi_region` VALUES ('1672', '1666', '411725', '确山县');
INSERT INTO `hi_region` VALUES ('1673', '1666', '411726', '泌阳县');
INSERT INTO `hi_region` VALUES ('1674', '1666', '411727', '汝南县');
INSERT INTO `hi_region` VALUES ('1675', '1666', '411728', '遂平县');
INSERT INTO `hi_region` VALUES ('1676', '1666', '411729', '新蔡县');
INSERT INTO `hi_region` VALUES ('1677', '0', '420000', '湖北省');
INSERT INTO `hi_region` VALUES ('1678', '1677', '420100', '武汉市');
INSERT INTO `hi_region` VALUES ('1679', '1678', '420102', '江岸区');
INSERT INTO `hi_region` VALUES ('1680', '1678', '420103', '江汉区');
INSERT INTO `hi_region` VALUES ('1681', '1678', '420104', '硚口区');
INSERT INTO `hi_region` VALUES ('1682', '1678', '420105', '汉阳区');
INSERT INTO `hi_region` VALUES ('1683', '1678', '420106', '武昌区');
INSERT INTO `hi_region` VALUES ('1684', '1678', '420107', '青山区');
INSERT INTO `hi_region` VALUES ('1685', '1678', '420111', '洪山区');
INSERT INTO `hi_region` VALUES ('1686', '1678', '420112', '东西湖区');
INSERT INTO `hi_region` VALUES ('1687', '1678', '420113', '汉南区');
INSERT INTO `hi_region` VALUES ('1688', '1678', '420114', '蔡甸区');
INSERT INTO `hi_region` VALUES ('1689', '1678', '420115', '江夏区');
INSERT INTO `hi_region` VALUES ('1690', '1678', '420116', '黄陂区');
INSERT INTO `hi_region` VALUES ('1691', '1678', '420117', '新洲区');
INSERT INTO `hi_region` VALUES ('1692', '1677', '420200', '黄石市');
INSERT INTO `hi_region` VALUES ('1693', '1692', '420202', '黄石港区');
INSERT INTO `hi_region` VALUES ('1694', '1692', '420203', '西塞山区');
INSERT INTO `hi_region` VALUES ('1695', '1692', '420204', '下陆区');
INSERT INTO `hi_region` VALUES ('1696', '1692', '420205', '铁山区');
INSERT INTO `hi_region` VALUES ('1697', '1692', '420222', '阳新县');
INSERT INTO `hi_region` VALUES ('1698', '1692', '420281', '大冶市');
INSERT INTO `hi_region` VALUES ('1699', '1677', '420300', '十堰市');
INSERT INTO `hi_region` VALUES ('1700', '1699', '420302', '茅箭区');
INSERT INTO `hi_region` VALUES ('1701', '1699', '420303', '张湾区');
INSERT INTO `hi_region` VALUES ('1702', '1699', '420304', '郧阳区');
INSERT INTO `hi_region` VALUES ('1703', '1699', '420322', '郧西县');
INSERT INTO `hi_region` VALUES ('1704', '1699', '420323', '竹山县');
INSERT INTO `hi_region` VALUES ('1705', '1699', '420324', '竹溪县');
INSERT INTO `hi_region` VALUES ('1706', '1699', '420325', '房县');
INSERT INTO `hi_region` VALUES ('1707', '1699', '420381', '丹江口市');
INSERT INTO `hi_region` VALUES ('1708', '1677', '420500', '宜昌市');
INSERT INTO `hi_region` VALUES ('1709', '1708', '420502', '西陵区');
INSERT INTO `hi_region` VALUES ('1710', '1708', '420503', '伍家岗区');
INSERT INTO `hi_region` VALUES ('1711', '1708', '420504', '点军区');
INSERT INTO `hi_region` VALUES ('1712', '1708', '420505', '猇亭区');
INSERT INTO `hi_region` VALUES ('1713', '1708', '420506', '夷陵区');
INSERT INTO `hi_region` VALUES ('1714', '1708', '420525', '远安县');
INSERT INTO `hi_region` VALUES ('1715', '1708', '420526', '兴山县');
INSERT INTO `hi_region` VALUES ('1716', '1708', '420527', '秭归县');
INSERT INTO `hi_region` VALUES ('1717', '1708', '420528', '长阳土家族自治县');
INSERT INTO `hi_region` VALUES ('1718', '1708', '420529', '五峰土家族自治县');
INSERT INTO `hi_region` VALUES ('1719', '1708', '420581', '宜都市');
INSERT INTO `hi_region` VALUES ('1720', '1708', '420582', '当阳市');
INSERT INTO `hi_region` VALUES ('1721', '1708', '420583', '枝江市');
INSERT INTO `hi_region` VALUES ('1722', '1677', '420600', '襄阳市');
INSERT INTO `hi_region` VALUES ('1723', '1722', '420602', '襄城区');
INSERT INTO `hi_region` VALUES ('1724', '1722', '420606', '樊城区');
INSERT INTO `hi_region` VALUES ('1725', '1722', '420607', '襄州区');
INSERT INTO `hi_region` VALUES ('1726', '1722', '420624', '南漳县');
INSERT INTO `hi_region` VALUES ('1727', '1722', '420625', '谷城县');
INSERT INTO `hi_region` VALUES ('1728', '1722', '420626', '保康县');
INSERT INTO `hi_region` VALUES ('1729', '1722', '420682', '老河口市');
INSERT INTO `hi_region` VALUES ('1730', '1722', '420683', '枣阳市');
INSERT INTO `hi_region` VALUES ('1731', '1722', '420684', '宜城市');
INSERT INTO `hi_region` VALUES ('1732', '1677', '420700', '鄂州市');
INSERT INTO `hi_region` VALUES ('1733', '1732', '420702', '梁子湖区');
INSERT INTO `hi_region` VALUES ('1734', '1732', '420703', '华容区');
INSERT INTO `hi_region` VALUES ('1735', '1732', '420704', '鄂城区');
INSERT INTO `hi_region` VALUES ('1736', '1677', '420800', '荆门市');
INSERT INTO `hi_region` VALUES ('1737', '1736', '420802', '东宝区');
INSERT INTO `hi_region` VALUES ('1738', '1736', '420804', '掇刀区');
INSERT INTO `hi_region` VALUES ('1739', '1736', '420821', '京山县');
INSERT INTO `hi_region` VALUES ('1740', '1736', '420822', '沙洋县');
INSERT INTO `hi_region` VALUES ('1741', '1736', '420881', '钟祥市');
INSERT INTO `hi_region` VALUES ('1742', '1677', '420900', '孝感市');
INSERT INTO `hi_region` VALUES ('1743', '1742', '420902', '孝南区');
INSERT INTO `hi_region` VALUES ('1744', '1742', '420921', '孝昌县');
INSERT INTO `hi_region` VALUES ('1745', '1742', '420922', '大悟县');
INSERT INTO `hi_region` VALUES ('1746', '1742', '420923', '云梦县');
INSERT INTO `hi_region` VALUES ('1747', '1742', '420981', '应城市');
INSERT INTO `hi_region` VALUES ('1748', '1742', '420982', '安陆市');
INSERT INTO `hi_region` VALUES ('1749', '1742', '420984', '汉川市');
INSERT INTO `hi_region` VALUES ('1750', '1677', '421000', '荆州市');
INSERT INTO `hi_region` VALUES ('1751', '1750', '421002', '沙市区');
INSERT INTO `hi_region` VALUES ('1752', '1750', '421003', '荆州区');
INSERT INTO `hi_region` VALUES ('1753', '1750', '421022', '公安县');
INSERT INTO `hi_region` VALUES ('1754', '1750', '421023', '监利县');
INSERT INTO `hi_region` VALUES ('1755', '1750', '421024', '江陵县');
INSERT INTO `hi_region` VALUES ('1756', '1750', '421081', '石首市');
INSERT INTO `hi_region` VALUES ('1757', '1750', '421083', '洪湖市');
INSERT INTO `hi_region` VALUES ('1758', '1750', '421087', '松滋市');
INSERT INTO `hi_region` VALUES ('1759', '1677', '421100', '黄冈市');
INSERT INTO `hi_region` VALUES ('1760', '1759', '421102', '黄州区');
INSERT INTO `hi_region` VALUES ('1761', '1759', '421121', '团风县');
INSERT INTO `hi_region` VALUES ('1762', '1759', '421122', '红安县');
INSERT INTO `hi_region` VALUES ('1763', '1759', '421123', '罗田县');
INSERT INTO `hi_region` VALUES ('1764', '1759', '421124', '英山县');
INSERT INTO `hi_region` VALUES ('1765', '1759', '421125', '浠水县');
INSERT INTO `hi_region` VALUES ('1766', '1759', '421126', '蕲春县');
INSERT INTO `hi_region` VALUES ('1767', '1759', '421127', '黄梅县');
INSERT INTO `hi_region` VALUES ('1768', '1759', '421181', '麻城市');
INSERT INTO `hi_region` VALUES ('1769', '1759', '421182', '武穴市');
INSERT INTO `hi_region` VALUES ('1770', '1677', '421200', '咸宁市');
INSERT INTO `hi_region` VALUES ('1771', '1770', '421202', '咸安区');
INSERT INTO `hi_region` VALUES ('1772', '1770', '421221', '嘉鱼县');
INSERT INTO `hi_region` VALUES ('1773', '1770', '421222', '通城县');
INSERT INTO `hi_region` VALUES ('1774', '1770', '421223', '崇阳县');
INSERT INTO `hi_region` VALUES ('1775', '1770', '421224', '通山县');
INSERT INTO `hi_region` VALUES ('1776', '1770', '421281', '赤壁市');
INSERT INTO `hi_region` VALUES ('1777', '1677', '421300', '随州市');
INSERT INTO `hi_region` VALUES ('1778', '1777', '421303', '曾都区');
INSERT INTO `hi_region` VALUES ('1779', '1777', '421321', '随县');
INSERT INTO `hi_region` VALUES ('1780', '1777', '421381', '广水市');
INSERT INTO `hi_region` VALUES ('1781', '1677', '422800', '恩施土家族苗族自治州');
INSERT INTO `hi_region` VALUES ('1782', '1781', '422801', '恩施市');
INSERT INTO `hi_region` VALUES ('1783', '1781', '422802', '利川市');
INSERT INTO `hi_region` VALUES ('1784', '1781', '422822', '建始县');
INSERT INTO `hi_region` VALUES ('1785', '1781', '422823', '巴东县');
INSERT INTO `hi_region` VALUES ('1786', '1781', '422825', '宣恩县');
INSERT INTO `hi_region` VALUES ('1787', '1781', '422826', '咸丰县');
INSERT INTO `hi_region` VALUES ('1788', '1781', '422827', '来凤县');
INSERT INTO `hi_region` VALUES ('1789', '1781', '422828', '鹤峰县');
INSERT INTO `hi_region` VALUES ('1790', '0', '430000', '湖南省');
INSERT INTO `hi_region` VALUES ('1791', '1790', '430100', '长沙市');
INSERT INTO `hi_region` VALUES ('1792', '1791', '430102', '芙蓉区');
INSERT INTO `hi_region` VALUES ('1793', '1791', '430103', '天心区');
INSERT INTO `hi_region` VALUES ('1794', '1791', '430104', '岳麓区');
INSERT INTO `hi_region` VALUES ('1795', '1791', '430105', '开福区');
INSERT INTO `hi_region` VALUES ('1796', '1791', '430111', '雨花区');
INSERT INTO `hi_region` VALUES ('1797', '1791', '430112', '望城区');
INSERT INTO `hi_region` VALUES ('1798', '1791', '430121', '长沙县');
INSERT INTO `hi_region` VALUES ('1799', '1791', '430124', '宁乡县');
INSERT INTO `hi_region` VALUES ('1800', '1791', '430181', '浏阳市');
INSERT INTO `hi_region` VALUES ('1801', '1790', '430200', '株洲市');
INSERT INTO `hi_region` VALUES ('1802', '1801', '430202', '荷塘区');
INSERT INTO `hi_region` VALUES ('1803', '1801', '430203', '芦淞区');
INSERT INTO `hi_region` VALUES ('1804', '1801', '430204', '石峰区');
INSERT INTO `hi_region` VALUES ('1805', '1801', '430211', '天元区');
INSERT INTO `hi_region` VALUES ('1806', '1801', '430221', '株洲县');
INSERT INTO `hi_region` VALUES ('1807', '1801', '430223', '攸县');
INSERT INTO `hi_region` VALUES ('1808', '1801', '430224', '茶陵县');
INSERT INTO `hi_region` VALUES ('1809', '1801', '430225', '炎陵县');
INSERT INTO `hi_region` VALUES ('1810', '1801', '430281', '醴陵市');
INSERT INTO `hi_region` VALUES ('1811', '1790', '430300', '湘潭市');
INSERT INTO `hi_region` VALUES ('1812', '1811', '430302', '雨湖区');
INSERT INTO `hi_region` VALUES ('1813', '1811', '430304', '岳塘区');
INSERT INTO `hi_region` VALUES ('1814', '1811', '430321', '湘潭县');
INSERT INTO `hi_region` VALUES ('1815', '1811', '430381', '湘乡市');
INSERT INTO `hi_region` VALUES ('1816', '1811', '430382', '韶山市');
INSERT INTO `hi_region` VALUES ('1817', '1790', '430400', '衡阳市');
INSERT INTO `hi_region` VALUES ('1818', '1817', '430405', '珠晖区');
INSERT INTO `hi_region` VALUES ('1819', '1817', '430406', '雁峰区');
INSERT INTO `hi_region` VALUES ('1820', '1817', '430407', '石鼓区');
INSERT INTO `hi_region` VALUES ('1821', '1817', '430408', '蒸湘区');
INSERT INTO `hi_region` VALUES ('1822', '1817', '430412', '南岳区');
INSERT INTO `hi_region` VALUES ('1823', '1817', '430421', '衡阳县');
INSERT INTO `hi_region` VALUES ('1824', '1817', '430422', '衡南县');
INSERT INTO `hi_region` VALUES ('1825', '1817', '430423', '衡山县');
INSERT INTO `hi_region` VALUES ('1826', '1817', '430424', '衡东县');
INSERT INTO `hi_region` VALUES ('1827', '1817', '430426', '祁东县');
INSERT INTO `hi_region` VALUES ('1828', '1817', '430481', '耒阳市');
INSERT INTO `hi_region` VALUES ('1829', '1817', '430482', '常宁市');
INSERT INTO `hi_region` VALUES ('1830', '1790', '430500', '邵阳市');
INSERT INTO `hi_region` VALUES ('1831', '1830', '430502', '双清区');
INSERT INTO `hi_region` VALUES ('1832', '1830', '430503', '大祥区');
INSERT INTO `hi_region` VALUES ('1833', '1830', '430511', '北塔区');
INSERT INTO `hi_region` VALUES ('1834', '1830', '430521', '邵东县');
INSERT INTO `hi_region` VALUES ('1835', '1830', '430522', '新邵县');
INSERT INTO `hi_region` VALUES ('1836', '1830', '430523', '邵阳县');
INSERT INTO `hi_region` VALUES ('1837', '1830', '430524', '隆回县');
INSERT INTO `hi_region` VALUES ('1838', '1830', '430525', '洞口县');
INSERT INTO `hi_region` VALUES ('1839', '1830', '430527', '绥宁县');
INSERT INTO `hi_region` VALUES ('1840', '1830', '430528', '新宁县');
INSERT INTO `hi_region` VALUES ('1841', '1830', '430529', '城步苗族自治县');
INSERT INTO `hi_region` VALUES ('1842', '1830', '430581', '武冈市');
INSERT INTO `hi_region` VALUES ('1843', '1790', '430600', '岳阳市');
INSERT INTO `hi_region` VALUES ('1844', '1843', '430602', '岳阳楼区');
INSERT INTO `hi_region` VALUES ('1845', '1843', '430603', '云溪区');
INSERT INTO `hi_region` VALUES ('1846', '1843', '430611', '君山区');
INSERT INTO `hi_region` VALUES ('1847', '1843', '430621', '岳阳县');
INSERT INTO `hi_region` VALUES ('1848', '1843', '430623', '华容县');
INSERT INTO `hi_region` VALUES ('1849', '1843', '430624', '湘阴县');
INSERT INTO `hi_region` VALUES ('1850', '1843', '430626', '平江县');
INSERT INTO `hi_region` VALUES ('1851', '1843', '430681', '汨罗市');
INSERT INTO `hi_region` VALUES ('1852', '1843', '430682', '临湘市');
INSERT INTO `hi_region` VALUES ('1853', '1790', '430700', '常德市');
INSERT INTO `hi_region` VALUES ('1854', '1853', '430702', '武陵区');
INSERT INTO `hi_region` VALUES ('1855', '1853', '430703', '鼎城区');
INSERT INTO `hi_region` VALUES ('1856', '1853', '430721', '安乡县');
INSERT INTO `hi_region` VALUES ('1857', '1853', '430722', '汉寿县');
INSERT INTO `hi_region` VALUES ('1858', '1853', '430723', '澧县');
INSERT INTO `hi_region` VALUES ('1859', '1853', '430724', '临澧县');
INSERT INTO `hi_region` VALUES ('1860', '1853', '430725', '桃源县');
INSERT INTO `hi_region` VALUES ('1861', '1853', '430726', '石门县');
INSERT INTO `hi_region` VALUES ('1862', '1853', '430781', '津市市');
INSERT INTO `hi_region` VALUES ('1863', '1790', '430800', '张家界市');
INSERT INTO `hi_region` VALUES ('1864', '1863', '430802', '永定区');
INSERT INTO `hi_region` VALUES ('1865', '1863', '430811', '武陵源区');
INSERT INTO `hi_region` VALUES ('1866', '1863', '430821', '慈利县');
INSERT INTO `hi_region` VALUES ('1867', '1863', '430822', '桑植县');
INSERT INTO `hi_region` VALUES ('1868', '1790', '430900', '益阳市');
INSERT INTO `hi_region` VALUES ('1869', '1868', '430902', '资阳区');
INSERT INTO `hi_region` VALUES ('1870', '1868', '430903', '赫山区');
INSERT INTO `hi_region` VALUES ('1871', '1868', '430921', '南县');
INSERT INTO `hi_region` VALUES ('1872', '1868', '430922', '桃江县');
INSERT INTO `hi_region` VALUES ('1873', '1868', '430923', '安化县');
INSERT INTO `hi_region` VALUES ('1874', '1868', '430981', '沅江市');
INSERT INTO `hi_region` VALUES ('1875', '1790', '431000', '郴州市');
INSERT INTO `hi_region` VALUES ('1876', '1875', '431002', '北湖区');
INSERT INTO `hi_region` VALUES ('1877', '1875', '431003', '苏仙区');
INSERT INTO `hi_region` VALUES ('1878', '1875', '431021', '桂阳县');
INSERT INTO `hi_region` VALUES ('1879', '1875', '431022', '宜章县');
INSERT INTO `hi_region` VALUES ('1880', '1875', '431023', '永兴县');
INSERT INTO `hi_region` VALUES ('1881', '1875', '431024', '嘉禾县');
INSERT INTO `hi_region` VALUES ('1882', '1875', '431025', '临武县');
INSERT INTO `hi_region` VALUES ('1883', '1875', '431026', '汝城县');
INSERT INTO `hi_region` VALUES ('1884', '1875', '431027', '桂东县');
INSERT INTO `hi_region` VALUES ('1885', '1875', '431028', '安仁县');
INSERT INTO `hi_region` VALUES ('1886', '1875', '431081', '资兴市');
INSERT INTO `hi_region` VALUES ('1887', '1790', '431100', '永州市');
INSERT INTO `hi_region` VALUES ('1888', '1887', '431102', '零陵区');
INSERT INTO `hi_region` VALUES ('1889', '1887', '431103', '冷水滩区');
INSERT INTO `hi_region` VALUES ('1890', '1887', '431121', '祁阳县');
INSERT INTO `hi_region` VALUES ('1891', '1887', '431122', '东安县');
INSERT INTO `hi_region` VALUES ('1892', '1887', '431123', '双牌县');
INSERT INTO `hi_region` VALUES ('1893', '1887', '431124', '道县');
INSERT INTO `hi_region` VALUES ('1894', '1887', '431125', '江永县');
INSERT INTO `hi_region` VALUES ('1895', '1887', '431126', '宁远县');
INSERT INTO `hi_region` VALUES ('1896', '1887', '431127', '蓝山县');
INSERT INTO `hi_region` VALUES ('1897', '1887', '431128', '新田县');
INSERT INTO `hi_region` VALUES ('1898', '1887', '431129', '江华瑶族自治县');
INSERT INTO `hi_region` VALUES ('1899', '1790', '431200', '怀化市');
INSERT INTO `hi_region` VALUES ('1900', '1899', '431202', '鹤城区');
INSERT INTO `hi_region` VALUES ('1901', '1899', '431221', '中方县');
INSERT INTO `hi_region` VALUES ('1902', '1899', '431222', '沅陵县');
INSERT INTO `hi_region` VALUES ('1903', '1899', '431223', '辰溪县');
INSERT INTO `hi_region` VALUES ('1904', '1899', '431224', '溆浦县');
INSERT INTO `hi_region` VALUES ('1905', '1899', '431225', '会同县');
INSERT INTO `hi_region` VALUES ('1906', '1899', '431226', '麻阳苗族自治县');
INSERT INTO `hi_region` VALUES ('1907', '1899', '431227', '新晃侗族自治县');
INSERT INTO `hi_region` VALUES ('1908', '1899', '431228', '芷江侗族自治县');
INSERT INTO `hi_region` VALUES ('1909', '1899', '431229', '靖州苗族侗族自治县');
INSERT INTO `hi_region` VALUES ('1910', '1899', '431230', '通道侗族自治县');
INSERT INTO `hi_region` VALUES ('1911', '1899', '431281', '洪江市');
INSERT INTO `hi_region` VALUES ('1912', '1790', '431300', '娄底市');
INSERT INTO `hi_region` VALUES ('1913', '1912', '431302', '娄星区');
INSERT INTO `hi_region` VALUES ('1914', '1912', '431321', '双峰县');
INSERT INTO `hi_region` VALUES ('1915', '1912', '431322', '新化县');
INSERT INTO `hi_region` VALUES ('1916', '1912', '431381', '冷水江市');
INSERT INTO `hi_region` VALUES ('1917', '1912', '431382', '涟源市');
INSERT INTO `hi_region` VALUES ('1918', '1790', '433100', '湘西土家族苗族自治州');
INSERT INTO `hi_region` VALUES ('1919', '1918', '433101', '吉首市');
INSERT INTO `hi_region` VALUES ('1920', '1918', '433122', '泸溪县');
INSERT INTO `hi_region` VALUES ('1921', '1918', '433123', '凤凰县');
INSERT INTO `hi_region` VALUES ('1922', '1918', '433124', '花垣县');
INSERT INTO `hi_region` VALUES ('1923', '1918', '433125', '保靖县');
INSERT INTO `hi_region` VALUES ('1924', '1918', '433126', '古丈县');
INSERT INTO `hi_region` VALUES ('1925', '1918', '433127', '永顺县');
INSERT INTO `hi_region` VALUES ('1926', '1918', '433130', '龙山县');
INSERT INTO `hi_region` VALUES ('1927', '0', '440000', '广东省');
INSERT INTO `hi_region` VALUES ('1928', '1927', '440100', '广州市');
INSERT INTO `hi_region` VALUES ('1929', '1928', '440103', '荔湾区');
INSERT INTO `hi_region` VALUES ('1930', '1928', '440104', '越秀区');
INSERT INTO `hi_region` VALUES ('1931', '1928', '440105', '海珠区');
INSERT INTO `hi_region` VALUES ('1932', '1928', '440106', '天河区');
INSERT INTO `hi_region` VALUES ('1933', '1928', '440111', '白云区');
INSERT INTO `hi_region` VALUES ('1934', '1928', '440112', '黄埔区');
INSERT INTO `hi_region` VALUES ('1935', '1928', '440113', '番禺区');
INSERT INTO `hi_region` VALUES ('1936', '1928', '440114', '花都区');
INSERT INTO `hi_region` VALUES ('1937', '1928', '440115', '南沙区');
INSERT INTO `hi_region` VALUES ('1938', '1928', '440117', '从化区');
INSERT INTO `hi_region` VALUES ('1939', '1928', '440118', '增城区');
INSERT INTO `hi_region` VALUES ('1940', '1927', '440200', '韶关市');
INSERT INTO `hi_region` VALUES ('1941', '1940', '440203', '武江区');
INSERT INTO `hi_region` VALUES ('1942', '1940', '440204', '浈江区');
INSERT INTO `hi_region` VALUES ('1943', '1940', '440205', '曲江区');
INSERT INTO `hi_region` VALUES ('1944', '1940', '440222', '始兴县');
INSERT INTO `hi_region` VALUES ('1945', '1940', '440224', '仁化县');
INSERT INTO `hi_region` VALUES ('1946', '1940', '440229', '翁源县');
INSERT INTO `hi_region` VALUES ('1947', '1940', '440232', '乳源瑶族自治县');
INSERT INTO `hi_region` VALUES ('1948', '1940', '440233', '新丰县');
INSERT INTO `hi_region` VALUES ('1949', '1940', '440281', '乐昌市');
INSERT INTO `hi_region` VALUES ('1950', '1940', '440282', '南雄市');
INSERT INTO `hi_region` VALUES ('1951', '1927', '440300', '深圳市');
INSERT INTO `hi_region` VALUES ('1952', '1951', '440303', '罗湖区');
INSERT INTO `hi_region` VALUES ('1953', '1951', '440304', '福田区');
INSERT INTO `hi_region` VALUES ('1954', '1951', '440305', '南山区');
INSERT INTO `hi_region` VALUES ('1955', '1951', '440306', '宝安区');
INSERT INTO `hi_region` VALUES ('1956', '1951', '440307', '龙岗区');
INSERT INTO `hi_region` VALUES ('1957', '1951', '440308', '盐田区');
INSERT INTO `hi_region` VALUES ('1958', '1951', '440309', '龙华区');
INSERT INTO `hi_region` VALUES ('1959', '1951', '440310', '坪山区');
INSERT INTO `hi_region` VALUES ('1960', '1927', '440400', '珠海市');
INSERT INTO `hi_region` VALUES ('1961', '1960', '440402', '香洲区');
INSERT INTO `hi_region` VALUES ('1962', '1960', '440403', '斗门区');
INSERT INTO `hi_region` VALUES ('1963', '1960', '440404', '金湾区');
INSERT INTO `hi_region` VALUES ('1964', '1927', '440500', '汕头市');
INSERT INTO `hi_region` VALUES ('1965', '1964', '440507', '龙湖区');
INSERT INTO `hi_region` VALUES ('1966', '1964', '440511', '金平区');
INSERT INTO `hi_region` VALUES ('1967', '1964', '440512', '濠江区');
INSERT INTO `hi_region` VALUES ('1968', '1964', '440513', '潮阳区');
INSERT INTO `hi_region` VALUES ('1969', '1964', '440514', '潮南区');
INSERT INTO `hi_region` VALUES ('1970', '1964', '440515', '澄海区');
INSERT INTO `hi_region` VALUES ('1971', '1964', '440523', '南澳县');
INSERT INTO `hi_region` VALUES ('1972', '1927', '440600', '佛山市');
INSERT INTO `hi_region` VALUES ('1973', '1972', '440604', '禅城区');
INSERT INTO `hi_region` VALUES ('1974', '1972', '440605', '南海区');
INSERT INTO `hi_region` VALUES ('1975', '1972', '440606', '顺德区');
INSERT INTO `hi_region` VALUES ('1976', '1972', '440607', '三水区');
INSERT INTO `hi_region` VALUES ('1977', '1972', '440608', '高明区');
INSERT INTO `hi_region` VALUES ('1978', '1927', '440700', '江门市');
INSERT INTO `hi_region` VALUES ('1979', '1978', '440703', '蓬江区');
INSERT INTO `hi_region` VALUES ('1980', '1978', '440704', '江海区');
INSERT INTO `hi_region` VALUES ('1981', '1978', '440705', '新会区');
INSERT INTO `hi_region` VALUES ('1982', '1978', '440781', '台山市');
INSERT INTO `hi_region` VALUES ('1983', '1978', '440783', '开平市');
INSERT INTO `hi_region` VALUES ('1984', '1978', '440784', '鹤山市');
INSERT INTO `hi_region` VALUES ('1985', '1978', '440785', '恩平市');
INSERT INTO `hi_region` VALUES ('1986', '1927', '440800', '湛江市');
INSERT INTO `hi_region` VALUES ('1987', '1986', '440802', '赤坎区');
INSERT INTO `hi_region` VALUES ('1988', '1986', '440803', '霞山区');
INSERT INTO `hi_region` VALUES ('1989', '1986', '440804', '坡头区');
INSERT INTO `hi_region` VALUES ('1990', '1986', '440811', '麻章区');
INSERT INTO `hi_region` VALUES ('1991', '1986', '440823', '遂溪县');
INSERT INTO `hi_region` VALUES ('1992', '1986', '440825', '徐闻县');
INSERT INTO `hi_region` VALUES ('1993', '1986', '440881', '廉江市');
INSERT INTO `hi_region` VALUES ('1994', '1986', '440882', '雷州市');
INSERT INTO `hi_region` VALUES ('1995', '1986', '440883', '吴川市');
INSERT INTO `hi_region` VALUES ('1996', '1927', '440900', '茂名市');
INSERT INTO `hi_region` VALUES ('1997', '1996', '440902', '茂南区');
INSERT INTO `hi_region` VALUES ('1998', '1996', '440904', '电白区');
INSERT INTO `hi_region` VALUES ('1999', '1996', '440981', '高州市');
INSERT INTO `hi_region` VALUES ('2000', '1996', '440982', '化州市');
INSERT INTO `hi_region` VALUES ('2001', '1996', '440983', '信宜市');
INSERT INTO `hi_region` VALUES ('2002', '1927', '441200', '肇庆市');
INSERT INTO `hi_region` VALUES ('2003', '2002', '441202', '端州区');
INSERT INTO `hi_region` VALUES ('2004', '2002', '441203', '鼎湖区');
INSERT INTO `hi_region` VALUES ('2005', '2002', '441204', '高要区');
INSERT INTO `hi_region` VALUES ('2006', '2002', '441223', '广宁县');
INSERT INTO `hi_region` VALUES ('2007', '2002', '441224', '怀集县');
INSERT INTO `hi_region` VALUES ('2008', '2002', '441225', '封开县');
INSERT INTO `hi_region` VALUES ('2009', '2002', '441226', '德庆县');
INSERT INTO `hi_region` VALUES ('2010', '2002', '441284', '四会市');
INSERT INTO `hi_region` VALUES ('2011', '1927', '441300', '惠州市');
INSERT INTO `hi_region` VALUES ('2012', '2011', '441302', '惠城区');
INSERT INTO `hi_region` VALUES ('2013', '2011', '441303', '惠阳区');
INSERT INTO `hi_region` VALUES ('2014', '2011', '441322', '博罗县');
INSERT INTO `hi_region` VALUES ('2015', '2011', '441323', '惠东县');
INSERT INTO `hi_region` VALUES ('2016', '2011', '441324', '龙门县');
INSERT INTO `hi_region` VALUES ('2017', '1927', '441400', '梅州市');
INSERT INTO `hi_region` VALUES ('2018', '2017', '441402', '梅江区');
INSERT INTO `hi_region` VALUES ('2019', '2017', '441403', '梅县区');
INSERT INTO `hi_region` VALUES ('2020', '2017', '441422', '大埔县');
INSERT INTO `hi_region` VALUES ('2021', '2017', '441423', '丰顺县');
INSERT INTO `hi_region` VALUES ('2022', '2017', '441424', '五华县');
INSERT INTO `hi_region` VALUES ('2023', '2017', '441426', '平远县');
INSERT INTO `hi_region` VALUES ('2024', '2017', '441427', '蕉岭县');
INSERT INTO `hi_region` VALUES ('2025', '2017', '441481', '兴宁市');
INSERT INTO `hi_region` VALUES ('2026', '1927', '441500', '汕尾市');
INSERT INTO `hi_region` VALUES ('2027', '2026', '441502', '城区');
INSERT INTO `hi_region` VALUES ('2028', '2026', '441521', '海丰县');
INSERT INTO `hi_region` VALUES ('2029', '2026', '441523', '陆河县');
INSERT INTO `hi_region` VALUES ('2030', '2026', '441581', '陆丰市');
INSERT INTO `hi_region` VALUES ('2031', '1927', '441600', '河源市');
INSERT INTO `hi_region` VALUES ('2032', '2031', '441602', '源城区');
INSERT INTO `hi_region` VALUES ('2033', '2031', '441621', '紫金县');
INSERT INTO `hi_region` VALUES ('2034', '2031', '441622', '龙川县');
INSERT INTO `hi_region` VALUES ('2035', '2031', '441623', '连平县');
INSERT INTO `hi_region` VALUES ('2036', '2031', '441624', '和平县');
INSERT INTO `hi_region` VALUES ('2037', '2031', '441625', '东源县');
INSERT INTO `hi_region` VALUES ('2038', '1927', '441700', '阳江市');
INSERT INTO `hi_region` VALUES ('2039', '2038', '441702', '江城区');
INSERT INTO `hi_region` VALUES ('2040', '2038', '441704', '阳东区');
INSERT INTO `hi_region` VALUES ('2041', '2038', '441721', '阳西县');
INSERT INTO `hi_region` VALUES ('2042', '2038', '441781', '阳春市');
INSERT INTO `hi_region` VALUES ('2043', '1927', '441800', '清远市');
INSERT INTO `hi_region` VALUES ('2044', '2043', '441802', '清城区');
INSERT INTO `hi_region` VALUES ('2045', '2043', '441803', '清新区');
INSERT INTO `hi_region` VALUES ('2046', '2043', '441821', '佛冈县');
INSERT INTO `hi_region` VALUES ('2047', '2043', '441823', '阳山县');
INSERT INTO `hi_region` VALUES ('2048', '2043', '441825', '连山壮族瑶族自治县');
INSERT INTO `hi_region` VALUES ('2049', '2043', '441826', '连南瑶族自治县');
INSERT INTO `hi_region` VALUES ('2050', '2043', '441881', '英德市');
INSERT INTO `hi_region` VALUES ('2051', '2043', '441882', '连州市');
INSERT INTO `hi_region` VALUES ('2052', '1927', '441900', '东莞市');
INSERT INTO `hi_region` VALUES ('2053', '1927', '442000', '中山市');
INSERT INTO `hi_region` VALUES ('2054', '1927', '445100', '潮州市');
INSERT INTO `hi_region` VALUES ('2055', '2054', '445102', '湘桥区');
INSERT INTO `hi_region` VALUES ('2056', '2054', '445103', '潮安区');
INSERT INTO `hi_region` VALUES ('2057', '2054', '445122', '饶平县');
INSERT INTO `hi_region` VALUES ('2058', '1927', '445200', '揭阳市');
INSERT INTO `hi_region` VALUES ('2059', '2058', '445202', '榕城区');
INSERT INTO `hi_region` VALUES ('2060', '2058', '445203', '揭东区');
INSERT INTO `hi_region` VALUES ('2061', '2058', '445222', '揭西县');
INSERT INTO `hi_region` VALUES ('2062', '2058', '445224', '惠来县');
INSERT INTO `hi_region` VALUES ('2063', '2058', '445281', '普宁市');
INSERT INTO `hi_region` VALUES ('2064', '1927', '445300', '云浮市');
INSERT INTO `hi_region` VALUES ('2065', '2064', '445302', '云城区');
INSERT INTO `hi_region` VALUES ('2066', '2064', '445303', '云安区');
INSERT INTO `hi_region` VALUES ('2067', '2064', '445321', '新兴县');
INSERT INTO `hi_region` VALUES ('2068', '2064', '445322', '郁南县');
INSERT INTO `hi_region` VALUES ('2069', '2064', '445381', '罗定市');
INSERT INTO `hi_region` VALUES ('2070', '0', '450000', '广西壮族自治区');
INSERT INTO `hi_region` VALUES ('2071', '2070', '450100', '南宁市');
INSERT INTO `hi_region` VALUES ('2072', '2071', '450102', '兴宁区');
INSERT INTO `hi_region` VALUES ('2073', '2071', '450103', '青秀区');
INSERT INTO `hi_region` VALUES ('2074', '2071', '450105', '江南区');
INSERT INTO `hi_region` VALUES ('2075', '2071', '450107', '西乡塘区');
INSERT INTO `hi_region` VALUES ('2076', '2071', '450108', '良庆区');
INSERT INTO `hi_region` VALUES ('2077', '2071', '450109', '邕宁区');
INSERT INTO `hi_region` VALUES ('2078', '2071', '450110', '武鸣区');
INSERT INTO `hi_region` VALUES ('2079', '2071', '450123', '隆安县');
INSERT INTO `hi_region` VALUES ('2080', '2071', '450124', '马山县');
INSERT INTO `hi_region` VALUES ('2081', '2071', '450125', '上林县');
INSERT INTO `hi_region` VALUES ('2082', '2071', '450126', '宾阳县');
INSERT INTO `hi_region` VALUES ('2083', '2071', '450127', '横县');
INSERT INTO `hi_region` VALUES ('2084', '2070', '450200', '柳州市');
INSERT INTO `hi_region` VALUES ('2085', '2084', '450202', '城中区');
INSERT INTO `hi_region` VALUES ('2086', '2084', '450203', '鱼峰区');
INSERT INTO `hi_region` VALUES ('2087', '2084', '450204', '柳南区');
INSERT INTO `hi_region` VALUES ('2088', '2084', '450205', '柳北区');
INSERT INTO `hi_region` VALUES ('2089', '2084', '450206', '柳江区');
INSERT INTO `hi_region` VALUES ('2090', '2084', '450222', '柳城县');
INSERT INTO `hi_region` VALUES ('2091', '2084', '450223', '鹿寨县');
INSERT INTO `hi_region` VALUES ('2092', '2084', '450224', '融安县');
INSERT INTO `hi_region` VALUES ('2093', '2084', '450225', '融水苗族自治县');
INSERT INTO `hi_region` VALUES ('2094', '2084', '450226', '三江侗族自治县');
INSERT INTO `hi_region` VALUES ('2095', '2070', '450300', '桂林市');
INSERT INTO `hi_region` VALUES ('2096', '2095', '450302', '秀峰区');
INSERT INTO `hi_region` VALUES ('2097', '2095', '450303', '叠彩区');
INSERT INTO `hi_region` VALUES ('2098', '2095', '450304', '象山区');
INSERT INTO `hi_region` VALUES ('2099', '2095', '450305', '七星区');
INSERT INTO `hi_region` VALUES ('2100', '2095', '450311', '雁山区');
INSERT INTO `hi_region` VALUES ('2101', '2095', '450312', '临桂区');
INSERT INTO `hi_region` VALUES ('2102', '2095', '450321', '阳朔县');
INSERT INTO `hi_region` VALUES ('2103', '2095', '450323', '灵川县');
INSERT INTO `hi_region` VALUES ('2104', '2095', '450324', '全州县');
INSERT INTO `hi_region` VALUES ('2105', '2095', '450325', '兴安县');
INSERT INTO `hi_region` VALUES ('2106', '2095', '450326', '永福县');
INSERT INTO `hi_region` VALUES ('2107', '2095', '450327', '灌阳县');
INSERT INTO `hi_region` VALUES ('2108', '2095', '450328', '龙胜各族自治县');
INSERT INTO `hi_region` VALUES ('2109', '2095', '450329', '资源县');
INSERT INTO `hi_region` VALUES ('2110', '2095', '450330', '平乐县');
INSERT INTO `hi_region` VALUES ('2111', '2095', '450331', '荔浦县');
INSERT INTO `hi_region` VALUES ('2112', '2095', '450332', '恭城瑶族自治县');
INSERT INTO `hi_region` VALUES ('2113', '2070', '450400', '梧州市');
INSERT INTO `hi_region` VALUES ('2114', '2113', '450403', '万秀区');
INSERT INTO `hi_region` VALUES ('2115', '2113', '450405', '长洲区');
INSERT INTO `hi_region` VALUES ('2116', '2113', '450406', '龙圩区');
INSERT INTO `hi_region` VALUES ('2117', '2113', '450421', '苍梧县');
INSERT INTO `hi_region` VALUES ('2118', '2113', '450422', '藤县');
INSERT INTO `hi_region` VALUES ('2119', '2113', '450423', '蒙山县');
INSERT INTO `hi_region` VALUES ('2120', '2113', '450481', '岑溪市');
INSERT INTO `hi_region` VALUES ('2121', '2070', '450500', '北海市');
INSERT INTO `hi_region` VALUES ('2122', '2121', '450502', '海城区');
INSERT INTO `hi_region` VALUES ('2123', '2121', '450503', '银海区');
INSERT INTO `hi_region` VALUES ('2124', '2121', '450512', '铁山港区');
INSERT INTO `hi_region` VALUES ('2125', '2121', '450521', '合浦县');
INSERT INTO `hi_region` VALUES ('2126', '2070', '450600', '防城港市');
INSERT INTO `hi_region` VALUES ('2127', '2126', '450602', '港口区');
INSERT INTO `hi_region` VALUES ('2128', '2126', '450603', '防城区');
INSERT INTO `hi_region` VALUES ('2129', '2126', '450621', '上思县');
INSERT INTO `hi_region` VALUES ('2130', '2126', '450681', '东兴市');
INSERT INTO `hi_region` VALUES ('2131', '2070', '450700', '钦州市');
INSERT INTO `hi_region` VALUES ('2132', '2131', '450702', '钦南区');
INSERT INTO `hi_region` VALUES ('2133', '2131', '450703', '钦北区');
INSERT INTO `hi_region` VALUES ('2134', '2131', '450721', '灵山县');
INSERT INTO `hi_region` VALUES ('2135', '2131', '450722', '浦北县');
INSERT INTO `hi_region` VALUES ('2136', '2070', '450800', '贵港市');
INSERT INTO `hi_region` VALUES ('2137', '2136', '450802', '港北区');
INSERT INTO `hi_region` VALUES ('2138', '2136', '450803', '港南区');
INSERT INTO `hi_region` VALUES ('2139', '2136', '450804', '覃塘区');
INSERT INTO `hi_region` VALUES ('2140', '2136', '450821', '平南县');
INSERT INTO `hi_region` VALUES ('2141', '2136', '450881', '桂平市');
INSERT INTO `hi_region` VALUES ('2142', '2070', '450900', '玉林市');
INSERT INTO `hi_region` VALUES ('2143', '2142', '450902', '玉州区');
INSERT INTO `hi_region` VALUES ('2144', '2142', '450903', '福绵区');
INSERT INTO `hi_region` VALUES ('2145', '2142', '450921', '容县');
INSERT INTO `hi_region` VALUES ('2146', '2142', '450922', '陆川县');
INSERT INTO `hi_region` VALUES ('2147', '2142', '450923', '博白县');
INSERT INTO `hi_region` VALUES ('2148', '2142', '450924', '兴业县');
INSERT INTO `hi_region` VALUES ('2149', '2142', '450981', '北流市');
INSERT INTO `hi_region` VALUES ('2150', '2070', '451000', '百色市');
INSERT INTO `hi_region` VALUES ('2151', '2150', '451002', '右江区');
INSERT INTO `hi_region` VALUES ('2152', '2150', '451021', '田阳县');
INSERT INTO `hi_region` VALUES ('2153', '2150', '451022', '田东县');
INSERT INTO `hi_region` VALUES ('2154', '2150', '451023', '平果县');
INSERT INTO `hi_region` VALUES ('2155', '2150', '451024', '德保县');
INSERT INTO `hi_region` VALUES ('2156', '2150', '451026', '那坡县');
INSERT INTO `hi_region` VALUES ('2157', '2150', '451027', '凌云县');
INSERT INTO `hi_region` VALUES ('2158', '2150', '451028', '乐业县');
INSERT INTO `hi_region` VALUES ('2159', '2150', '451029', '田林县');
INSERT INTO `hi_region` VALUES ('2160', '2150', '451030', '西林县');
INSERT INTO `hi_region` VALUES ('2161', '2150', '451031', '隆林各族自治县');
INSERT INTO `hi_region` VALUES ('2162', '2150', '451081', '靖西市');
INSERT INTO `hi_region` VALUES ('2163', '2070', '451100', '贺州市');
INSERT INTO `hi_region` VALUES ('2164', '2163', '451102', '八步区');
INSERT INTO `hi_region` VALUES ('2165', '2163', '451103', '平桂区');
INSERT INTO `hi_region` VALUES ('2166', '2163', '451121', '昭平县');
INSERT INTO `hi_region` VALUES ('2167', '2163', '451122', '钟山县');
INSERT INTO `hi_region` VALUES ('2168', '2163', '451123', '富川瑶族自治县');
INSERT INTO `hi_region` VALUES ('2169', '2070', '451200', '河池市');
INSERT INTO `hi_region` VALUES ('2170', '2169', '451202', '金城江区');
INSERT INTO `hi_region` VALUES ('2171', '2169', '451203', '宜州区');
INSERT INTO `hi_region` VALUES ('2172', '2169', '451221', '南丹县');
INSERT INTO `hi_region` VALUES ('2173', '2169', '451222', '天峨县');
INSERT INTO `hi_region` VALUES ('2174', '2169', '451223', '凤山县');
INSERT INTO `hi_region` VALUES ('2175', '2169', '451224', '东兰县');
INSERT INTO `hi_region` VALUES ('2176', '2169', '451225', '罗城仫佬族自治县');
INSERT INTO `hi_region` VALUES ('2177', '2169', '451226', '环江毛南族自治县');
INSERT INTO `hi_region` VALUES ('2178', '2169', '451227', '巴马瑶族自治县');
INSERT INTO `hi_region` VALUES ('2179', '2169', '451228', '都安瑶族自治县');
INSERT INTO `hi_region` VALUES ('2180', '2169', '451229', '大化瑶族自治县');
INSERT INTO `hi_region` VALUES ('2181', '2070', '451300', '来宾市');
INSERT INTO `hi_region` VALUES ('2182', '2181', '451302', '兴宾区');
INSERT INTO `hi_region` VALUES ('2183', '2181', '451321', '忻城县');
INSERT INTO `hi_region` VALUES ('2184', '2181', '451322', '象州县');
INSERT INTO `hi_region` VALUES ('2185', '2181', '451323', '武宣县');
INSERT INTO `hi_region` VALUES ('2186', '2181', '451324', '金秀瑶族自治县');
INSERT INTO `hi_region` VALUES ('2187', '2181', '451381', '合山市');
INSERT INTO `hi_region` VALUES ('2188', '2070', '451400', '崇左市');
INSERT INTO `hi_region` VALUES ('2189', '2188', '451402', '江州区');
INSERT INTO `hi_region` VALUES ('2190', '2188', '451421', '扶绥县');
INSERT INTO `hi_region` VALUES ('2191', '2188', '451422', '宁明县');
INSERT INTO `hi_region` VALUES ('2192', '2188', '451423', '龙州县');
INSERT INTO `hi_region` VALUES ('2193', '2188', '451424', '大新县');
INSERT INTO `hi_region` VALUES ('2194', '2188', '451425', '天等县');
INSERT INTO `hi_region` VALUES ('2195', '2188', '451481', '凭祥市');
INSERT INTO `hi_region` VALUES ('2196', '0', '460000', '海南省');
INSERT INTO `hi_region` VALUES ('2197', '2196', '460100', '海口市');
INSERT INTO `hi_region` VALUES ('2198', '2197', '460105', '秀英区');
INSERT INTO `hi_region` VALUES ('2199', '2197', '460106', '龙华区');
INSERT INTO `hi_region` VALUES ('2200', '2197', '460107', '琼山区');
INSERT INTO `hi_region` VALUES ('2201', '2197', '460108', '美兰区');
INSERT INTO `hi_region` VALUES ('2202', '2196', '460200', '三亚市');
INSERT INTO `hi_region` VALUES ('2203', '2202', '460202', '海棠区');
INSERT INTO `hi_region` VALUES ('2204', '2202', '460203', '吉阳区');
INSERT INTO `hi_region` VALUES ('2205', '2202', '460204', '天涯区');
INSERT INTO `hi_region` VALUES ('2206', '2202', '460205', '崖州区');
INSERT INTO `hi_region` VALUES ('2207', '2196', '460300', '三沙市');
INSERT INTO `hi_region` VALUES ('2208', '2196', '460400', '儋州市');
INSERT INTO `hi_region` VALUES ('2209', '0', '500000', '重庆市');
INSERT INTO `hi_region` VALUES ('2210', '2209', '500000', '重庆市');
INSERT INTO `hi_region` VALUES ('2211', '2210', '500101', '万州区');
INSERT INTO `hi_region` VALUES ('2212', '2210', '500102', '涪陵区');
INSERT INTO `hi_region` VALUES ('2213', '2210', '500103', '渝中区');
INSERT INTO `hi_region` VALUES ('2214', '2210', '500104', '大渡口区');
INSERT INTO `hi_region` VALUES ('2215', '2210', '500105', '江北区');
INSERT INTO `hi_region` VALUES ('2216', '2210', '500106', '沙坪坝区');
INSERT INTO `hi_region` VALUES ('2217', '2210', '500107', '九龙坡区');
INSERT INTO `hi_region` VALUES ('2218', '2210', '500108', '南岸区');
INSERT INTO `hi_region` VALUES ('2219', '2210', '500109', '北碚区');
INSERT INTO `hi_region` VALUES ('2220', '2210', '500110', '綦江区');
INSERT INTO `hi_region` VALUES ('2221', '2210', '500111', '大足区');
INSERT INTO `hi_region` VALUES ('2222', '2210', '500112', '渝北区');
INSERT INTO `hi_region` VALUES ('2223', '2210', '500113', '巴南区');
INSERT INTO `hi_region` VALUES ('2224', '2210', '500114', '黔江区');
INSERT INTO `hi_region` VALUES ('2225', '2210', '500115', '长寿区');
INSERT INTO `hi_region` VALUES ('2226', '2210', '500116', '江津区');
INSERT INTO `hi_region` VALUES ('2227', '2210', '500117', '合川区');
INSERT INTO `hi_region` VALUES ('2228', '2210', '500118', '永川区');
INSERT INTO `hi_region` VALUES ('2229', '2210', '500119', '南川区');
INSERT INTO `hi_region` VALUES ('2230', '2210', '500120', '璧山区');
INSERT INTO `hi_region` VALUES ('2231', '2210', '500151', '铜梁区');
INSERT INTO `hi_region` VALUES ('2232', '2210', '500152', '潼南区');
INSERT INTO `hi_region` VALUES ('2233', '2210', '500153', '荣昌区');
INSERT INTO `hi_region` VALUES ('2234', '2210', '500154', '开州区');
INSERT INTO `hi_region` VALUES ('2235', '2210', '500155', '梁平区');
INSERT INTO `hi_region` VALUES ('2236', '2210', '500156', '武隆区');
INSERT INTO `hi_region` VALUES ('2237', '2210', '500229', '城口县');
INSERT INTO `hi_region` VALUES ('2238', '2210', '500230', '丰都县');
INSERT INTO `hi_region` VALUES ('2239', '2210', '500231', '垫江县');
INSERT INTO `hi_region` VALUES ('2240', '2210', '500233', '忠县');
INSERT INTO `hi_region` VALUES ('2241', '2210', '500235', '云阳县');
INSERT INTO `hi_region` VALUES ('2242', '2210', '500236', '奉节县');
INSERT INTO `hi_region` VALUES ('2243', '2210', '500237', '巫山县');
INSERT INTO `hi_region` VALUES ('2244', '2210', '500238', '巫溪县');
INSERT INTO `hi_region` VALUES ('2245', '2210', '500240', '石柱土家族自治县');
INSERT INTO `hi_region` VALUES ('2246', '2210', '500241', '秀山土家族苗族自治县');
INSERT INTO `hi_region` VALUES ('2247', '2210', '500242', '酉阳土家族苗族自治县');
INSERT INTO `hi_region` VALUES ('2248', '2210', '500243', '彭水苗族土家族自治县');
INSERT INTO `hi_region` VALUES ('2249', '0', '510000', '四川省');
INSERT INTO `hi_region` VALUES ('2250', '2249', '510100', '成都市');
INSERT INTO `hi_region` VALUES ('2251', '2250', '510104', '锦江区');
INSERT INTO `hi_region` VALUES ('2252', '2250', '510105', '青羊区');
INSERT INTO `hi_region` VALUES ('2253', '2250', '510106', '金牛区');
INSERT INTO `hi_region` VALUES ('2254', '2250', '510107', '武侯区');
INSERT INTO `hi_region` VALUES ('2255', '2250', '510108', '成华区');
INSERT INTO `hi_region` VALUES ('2256', '2250', '510112', '龙泉驿区');
INSERT INTO `hi_region` VALUES ('2257', '2250', '510113', '青白江区');
INSERT INTO `hi_region` VALUES ('2258', '2250', '510114', '新都区');
INSERT INTO `hi_region` VALUES ('2259', '2250', '510115', '温江区');
INSERT INTO `hi_region` VALUES ('2260', '2250', '510116', '双流区');
INSERT INTO `hi_region` VALUES ('2261', '2250', '510117', '郫都区');
INSERT INTO `hi_region` VALUES ('2262', '2250', '510121', '金堂县');
INSERT INTO `hi_region` VALUES ('2263', '2250', '510129', '大邑县');
INSERT INTO `hi_region` VALUES ('2264', '2250', '510131', '蒲江县');
INSERT INTO `hi_region` VALUES ('2265', '2250', '510132', '新津县');
INSERT INTO `hi_region` VALUES ('2266', '2250', '510181', '都江堰市');
INSERT INTO `hi_region` VALUES ('2267', '2250', '510182', '彭州市');
INSERT INTO `hi_region` VALUES ('2268', '2250', '510183', '邛崃市');
INSERT INTO `hi_region` VALUES ('2269', '2250', '510184', '崇州市');
INSERT INTO `hi_region` VALUES ('2270', '2250', '510185', '简阳市');
INSERT INTO `hi_region` VALUES ('2271', '2249', '510300', '自贡市');
INSERT INTO `hi_region` VALUES ('2272', '2271', '510302', '自流井区');
INSERT INTO `hi_region` VALUES ('2273', '2271', '510303', '贡井区');
INSERT INTO `hi_region` VALUES ('2274', '2271', '510304', '大安区');
INSERT INTO `hi_region` VALUES ('2275', '2271', '510311', '沿滩区');
INSERT INTO `hi_region` VALUES ('2276', '2271', '510321', '荣县');
INSERT INTO `hi_region` VALUES ('2277', '2271', '510322', '富顺县');
INSERT INTO `hi_region` VALUES ('2278', '2249', '510400', '攀枝花市');
INSERT INTO `hi_region` VALUES ('2279', '2278', '510402', '东区');
INSERT INTO `hi_region` VALUES ('2280', '2278', '510403', '西区');
INSERT INTO `hi_region` VALUES ('2281', '2278', '510411', '仁和区');
INSERT INTO `hi_region` VALUES ('2282', '2278', '510421', '米易县');
INSERT INTO `hi_region` VALUES ('2283', '2278', '510422', '盐边县');
INSERT INTO `hi_region` VALUES ('2284', '2249', '510500', '泸州市');
INSERT INTO `hi_region` VALUES ('2285', '2284', '510502', '江阳区');
INSERT INTO `hi_region` VALUES ('2286', '2284', '510503', '纳溪区');
INSERT INTO `hi_region` VALUES ('2287', '2284', '510504', '龙马潭区');
INSERT INTO `hi_region` VALUES ('2288', '2284', '510521', '泸县');
INSERT INTO `hi_region` VALUES ('2289', '2284', '510522', '合江县');
INSERT INTO `hi_region` VALUES ('2290', '2284', '510524', '叙永县');
INSERT INTO `hi_region` VALUES ('2291', '2284', '510525', '古蔺县');
INSERT INTO `hi_region` VALUES ('2292', '2249', '510600', '德阳市');
INSERT INTO `hi_region` VALUES ('2293', '2292', '510603', '旌阳区');
INSERT INTO `hi_region` VALUES ('2294', '2292', '510623', '中江县');
INSERT INTO `hi_region` VALUES ('2295', '2292', '510626', '罗江县');
INSERT INTO `hi_region` VALUES ('2296', '2292', '510681', '广汉市');
INSERT INTO `hi_region` VALUES ('2297', '2292', '510682', '什邡市');
INSERT INTO `hi_region` VALUES ('2298', '2292', '510683', '绵竹市');
INSERT INTO `hi_region` VALUES ('2299', '2249', '510700', '绵阳市');
INSERT INTO `hi_region` VALUES ('2300', '2299', '510703', '涪城区');
INSERT INTO `hi_region` VALUES ('2301', '2299', '510704', '游仙区');
INSERT INTO `hi_region` VALUES ('2302', '2299', '510705', '安州区');
INSERT INTO `hi_region` VALUES ('2303', '2299', '510722', '三台县');
INSERT INTO `hi_region` VALUES ('2304', '2299', '510723', '盐亭县');
INSERT INTO `hi_region` VALUES ('2305', '2299', '510725', '梓潼县');
INSERT INTO `hi_region` VALUES ('2306', '2299', '510726', '北川羌族自治县');
INSERT INTO `hi_region` VALUES ('2307', '2299', '510727', '平武县');
INSERT INTO `hi_region` VALUES ('2308', '2299', '510781', '江油市');
INSERT INTO `hi_region` VALUES ('2309', '2249', '510800', '广元市');
INSERT INTO `hi_region` VALUES ('2310', '2309', '510802', '利州区');
INSERT INTO `hi_region` VALUES ('2311', '2309', '510811', '昭化区');
INSERT INTO `hi_region` VALUES ('2312', '2309', '510812', '朝天区');
INSERT INTO `hi_region` VALUES ('2313', '2309', '510821', '旺苍县');
INSERT INTO `hi_region` VALUES ('2314', '2309', '510822', '青川县');
INSERT INTO `hi_region` VALUES ('2315', '2309', '510823', '剑阁县');
INSERT INTO `hi_region` VALUES ('2316', '2309', '510824', '苍溪县');
INSERT INTO `hi_region` VALUES ('2317', '2249', '510900', '遂宁市');
INSERT INTO `hi_region` VALUES ('2318', '2317', '510903', '船山区');
INSERT INTO `hi_region` VALUES ('2319', '2317', '510904', '安居区');
INSERT INTO `hi_region` VALUES ('2320', '2317', '510921', '蓬溪县');
INSERT INTO `hi_region` VALUES ('2321', '2317', '510922', '射洪县');
INSERT INTO `hi_region` VALUES ('2322', '2317', '510923', '大英县');
INSERT INTO `hi_region` VALUES ('2323', '2249', '511000', '内江市');
INSERT INTO `hi_region` VALUES ('2324', '2323', '511002', '市中区');
INSERT INTO `hi_region` VALUES ('2325', '2323', '511011', '东兴区');
INSERT INTO `hi_region` VALUES ('2326', '2323', '511024', '威远县');
INSERT INTO `hi_region` VALUES ('2327', '2323', '511025', '资中县');
INSERT INTO `hi_region` VALUES ('2328', '2323', '511028', '隆昌县');
INSERT INTO `hi_region` VALUES ('2329', '2249', '511100', '乐山市');
INSERT INTO `hi_region` VALUES ('2330', '2329', '511102', '市中区');
INSERT INTO `hi_region` VALUES ('2331', '2329', '511111', '沙湾区');
INSERT INTO `hi_region` VALUES ('2332', '2329', '511112', '五通桥区');
INSERT INTO `hi_region` VALUES ('2333', '2329', '511113', '金口河区');
INSERT INTO `hi_region` VALUES ('2334', '2329', '511123', '犍为县');
INSERT INTO `hi_region` VALUES ('2335', '2329', '511124', '井研县');
INSERT INTO `hi_region` VALUES ('2336', '2329', '511126', '夹江县');
INSERT INTO `hi_region` VALUES ('2337', '2329', '511129', '沐川县');
INSERT INTO `hi_region` VALUES ('2338', '2329', '511132', '峨边彝族自治县');
INSERT INTO `hi_region` VALUES ('2339', '2329', '511133', '马边彝族自治县');
INSERT INTO `hi_region` VALUES ('2340', '2329', '511181', '峨眉山市');
INSERT INTO `hi_region` VALUES ('2341', '2249', '511300', '南充市');
INSERT INTO `hi_region` VALUES ('2342', '2341', '511302', '顺庆区');
INSERT INTO `hi_region` VALUES ('2343', '2341', '511303', '高坪区');
INSERT INTO `hi_region` VALUES ('2344', '2341', '511304', '嘉陵区');
INSERT INTO `hi_region` VALUES ('2345', '2341', '511321', '南部县');
INSERT INTO `hi_region` VALUES ('2346', '2341', '511322', '营山县');
INSERT INTO `hi_region` VALUES ('2347', '2341', '511323', '蓬安县');
INSERT INTO `hi_region` VALUES ('2348', '2341', '511324', '仪陇县');
INSERT INTO `hi_region` VALUES ('2349', '2341', '511325', '西充县');
INSERT INTO `hi_region` VALUES ('2350', '2341', '511381', '阆中市');
INSERT INTO `hi_region` VALUES ('2351', '2249', '511400', '眉山市');
INSERT INTO `hi_region` VALUES ('2352', '2351', '511402', '东坡区');
INSERT INTO `hi_region` VALUES ('2353', '2351', '511403', '彭山区');
INSERT INTO `hi_region` VALUES ('2354', '2351', '511421', '仁寿县');
INSERT INTO `hi_region` VALUES ('2355', '2351', '511423', '洪雅县');
INSERT INTO `hi_region` VALUES ('2356', '2351', '511424', '丹棱县');
INSERT INTO `hi_region` VALUES ('2357', '2351', '511425', '青神县');
INSERT INTO `hi_region` VALUES ('2358', '2249', '511500', '宜宾市');
INSERT INTO `hi_region` VALUES ('2359', '2358', '511502', '翠屏区');
INSERT INTO `hi_region` VALUES ('2360', '2358', '511503', '南溪区');
INSERT INTO `hi_region` VALUES ('2361', '2358', '511521', '宜宾县');
INSERT INTO `hi_region` VALUES ('2362', '2358', '511523', '江安县');
INSERT INTO `hi_region` VALUES ('2363', '2358', '511524', '长宁县');
INSERT INTO `hi_region` VALUES ('2364', '2358', '511525', '高县');
INSERT INTO `hi_region` VALUES ('2365', '2358', '511526', '珙县');
INSERT INTO `hi_region` VALUES ('2366', '2358', '511527', '筠连县');
INSERT INTO `hi_region` VALUES ('2367', '2358', '511528', '兴文县');
INSERT INTO `hi_region` VALUES ('2368', '2358', '511529', '屏山县');
INSERT INTO `hi_region` VALUES ('2369', '2249', '511600', '广安市');
INSERT INTO `hi_region` VALUES ('2370', '2369', '511602', '广安区');
INSERT INTO `hi_region` VALUES ('2371', '2369', '511603', '前锋区');
INSERT INTO `hi_region` VALUES ('2372', '2369', '511621', '岳池县');
INSERT INTO `hi_region` VALUES ('2373', '2369', '511622', '武胜县');
INSERT INTO `hi_region` VALUES ('2374', '2369', '511623', '邻水县');
INSERT INTO `hi_region` VALUES ('2375', '2369', '511681', '华蓥市');
INSERT INTO `hi_region` VALUES ('2376', '2249', '511700', '达州市');
INSERT INTO `hi_region` VALUES ('2377', '2376', '511702', '通川区');
INSERT INTO `hi_region` VALUES ('2378', '2376', '511703', '达川区');
INSERT INTO `hi_region` VALUES ('2379', '2376', '511722', '宣汉县');
INSERT INTO `hi_region` VALUES ('2380', '2376', '511723', '开江县');
INSERT INTO `hi_region` VALUES ('2381', '2376', '511724', '大竹县');
INSERT INTO `hi_region` VALUES ('2382', '2376', '511725', '渠县');
INSERT INTO `hi_region` VALUES ('2383', '2376', '511781', '万源市');
INSERT INTO `hi_region` VALUES ('2384', '2249', '511800', '雅安市');
INSERT INTO `hi_region` VALUES ('2385', '2384', '511802', '雨城区');
INSERT INTO `hi_region` VALUES ('2386', '2384', '511803', '名山区');
INSERT INTO `hi_region` VALUES ('2387', '2384', '511822', '荥经县');
INSERT INTO `hi_region` VALUES ('2388', '2384', '511823', '汉源县');
INSERT INTO `hi_region` VALUES ('2389', '2384', '511824', '石棉县');
INSERT INTO `hi_region` VALUES ('2390', '2384', '511825', '天全县');
INSERT INTO `hi_region` VALUES ('2391', '2384', '511826', '芦山县');
INSERT INTO `hi_region` VALUES ('2392', '2384', '511827', '宝兴县');
INSERT INTO `hi_region` VALUES ('2393', '2249', '511900', '巴中市');
INSERT INTO `hi_region` VALUES ('2394', '2393', '511902', '巴州区');
INSERT INTO `hi_region` VALUES ('2395', '2393', '511903', '恩阳区');
INSERT INTO `hi_region` VALUES ('2396', '2393', '511921', '通江县');
INSERT INTO `hi_region` VALUES ('2397', '2393', '511922', '南江县');
INSERT INTO `hi_region` VALUES ('2398', '2393', '511923', '平昌县');
INSERT INTO `hi_region` VALUES ('2399', '2249', '512000', '资阳市');
INSERT INTO `hi_region` VALUES ('2400', '2399', '512002', '雁江区');
INSERT INTO `hi_region` VALUES ('2401', '2399', '512021', '安岳县');
INSERT INTO `hi_region` VALUES ('2402', '2399', '512022', '乐至县');
INSERT INTO `hi_region` VALUES ('2403', '2249', '513200', '阿坝藏族羌族自治州');
INSERT INTO `hi_region` VALUES ('2404', '2403', '513201', '马尔康市');
INSERT INTO `hi_region` VALUES ('2405', '2403', '513221', '汶川县');
INSERT INTO `hi_region` VALUES ('2406', '2403', '513222', '理县');
INSERT INTO `hi_region` VALUES ('2407', '2403', '513223', '茂县');
INSERT INTO `hi_region` VALUES ('2408', '2403', '513224', '松潘县');
INSERT INTO `hi_region` VALUES ('2409', '2403', '513225', '九寨沟县');
INSERT INTO `hi_region` VALUES ('2410', '2403', '513226', '金川县');
INSERT INTO `hi_region` VALUES ('2411', '2403', '513227', '小金县');
INSERT INTO `hi_region` VALUES ('2412', '2403', '513228', '黑水县');
INSERT INTO `hi_region` VALUES ('2413', '2403', '513230', '壤塘县');
INSERT INTO `hi_region` VALUES ('2414', '2403', '513231', '阿坝县');
INSERT INTO `hi_region` VALUES ('2415', '2403', '513232', '若尔盖县');
INSERT INTO `hi_region` VALUES ('2416', '2403', '513233', '红原县');
INSERT INTO `hi_region` VALUES ('2417', '2249', '513300', '甘孜藏族自治州');
INSERT INTO `hi_region` VALUES ('2418', '2417', '513301', '康定市');
INSERT INTO `hi_region` VALUES ('2419', '2417', '513322', '泸定县');
INSERT INTO `hi_region` VALUES ('2420', '2417', '513323', '丹巴县');
INSERT INTO `hi_region` VALUES ('2421', '2417', '513324', '九龙县');
INSERT INTO `hi_region` VALUES ('2422', '2417', '513325', '雅江县');
INSERT INTO `hi_region` VALUES ('2423', '2417', '513326', '道孚县');
INSERT INTO `hi_region` VALUES ('2424', '2417', '513327', '炉霍县');
INSERT INTO `hi_region` VALUES ('2425', '2417', '513328', '甘孜县');
INSERT INTO `hi_region` VALUES ('2426', '2417', '513329', '新龙县');
INSERT INTO `hi_region` VALUES ('2427', '2417', '513330', '德格县');
INSERT INTO `hi_region` VALUES ('2428', '2417', '513331', '白玉县');
INSERT INTO `hi_region` VALUES ('2429', '2417', '513332', '石渠县');
INSERT INTO `hi_region` VALUES ('2430', '2417', '513333', '色达县');
INSERT INTO `hi_region` VALUES ('2431', '2417', '513334', '理塘县');
INSERT INTO `hi_region` VALUES ('2432', '2417', '513335', '巴塘县');
INSERT INTO `hi_region` VALUES ('2433', '2417', '513336', '乡城县');
INSERT INTO `hi_region` VALUES ('2434', '2417', '513337', '稻城县');
INSERT INTO `hi_region` VALUES ('2435', '2417', '513338', '得荣县');
INSERT INTO `hi_region` VALUES ('2436', '2249', '513400', '凉山彝族自治州');
INSERT INTO `hi_region` VALUES ('2437', '2436', '513401', '西昌市');
INSERT INTO `hi_region` VALUES ('2438', '2436', '513422', '木里藏族自治县');
INSERT INTO `hi_region` VALUES ('2439', '2436', '513423', '盐源县');
INSERT INTO `hi_region` VALUES ('2440', '2436', '513424', '德昌县');
INSERT INTO `hi_region` VALUES ('2441', '2436', '513425', '会理县');
INSERT INTO `hi_region` VALUES ('2442', '2436', '513426', '会东县');
INSERT INTO `hi_region` VALUES ('2443', '2436', '513427', '宁南县');
INSERT INTO `hi_region` VALUES ('2444', '2436', '513428', '普格县');
INSERT INTO `hi_region` VALUES ('2445', '2436', '513429', '布拖县');
INSERT INTO `hi_region` VALUES ('2446', '2436', '513430', '金阳县');
INSERT INTO `hi_region` VALUES ('2447', '2436', '513431', '昭觉县');
INSERT INTO `hi_region` VALUES ('2448', '2436', '513432', '喜德县');
INSERT INTO `hi_region` VALUES ('2449', '2436', '513433', '冕宁县');
INSERT INTO `hi_region` VALUES ('2450', '2436', '513434', '越西县');
INSERT INTO `hi_region` VALUES ('2451', '2436', '513435', '甘洛县');
INSERT INTO `hi_region` VALUES ('2452', '2436', '513436', '美姑县');
INSERT INTO `hi_region` VALUES ('2453', '2436', '513437', '雷波县');
INSERT INTO `hi_region` VALUES ('2454', '0', '520000', '贵州省');
INSERT INTO `hi_region` VALUES ('2455', '2454', '520100', '贵阳市');
INSERT INTO `hi_region` VALUES ('2456', '2455', '520102', '南明区');
INSERT INTO `hi_region` VALUES ('2457', '2455', '520103', '云岩区');
INSERT INTO `hi_region` VALUES ('2458', '2455', '520111', '花溪区');
INSERT INTO `hi_region` VALUES ('2459', '2455', '520112', '乌当区');
INSERT INTO `hi_region` VALUES ('2460', '2455', '520113', '白云区');
INSERT INTO `hi_region` VALUES ('2461', '2455', '520115', '观山湖区');
INSERT INTO `hi_region` VALUES ('2462', '2455', '520121', '开阳县');
INSERT INTO `hi_region` VALUES ('2463', '2455', '520122', '息烽县');
INSERT INTO `hi_region` VALUES ('2464', '2455', '520123', '修文县');
INSERT INTO `hi_region` VALUES ('2465', '2455', '520181', '清镇市');
INSERT INTO `hi_region` VALUES ('2466', '2454', '520200', '六盘水市');
INSERT INTO `hi_region` VALUES ('2467', '2466', '520201', '钟山区');
INSERT INTO `hi_region` VALUES ('2468', '2466', '520203', '六枝特区');
INSERT INTO `hi_region` VALUES ('2469', '2466', '520221', '水城县');
INSERT INTO `hi_region` VALUES ('2470', '2466', '520222', '盘县');
INSERT INTO `hi_region` VALUES ('2471', '2454', '520300', '遵义市');
INSERT INTO `hi_region` VALUES ('2472', '2471', '520302', '红花岗区');
INSERT INTO `hi_region` VALUES ('2473', '2471', '520303', '汇川区');
INSERT INTO `hi_region` VALUES ('2474', '2471', '520304', '播州区');
INSERT INTO `hi_region` VALUES ('2475', '2471', '520322', '桐梓县');
INSERT INTO `hi_region` VALUES ('2476', '2471', '520323', '绥阳县');
INSERT INTO `hi_region` VALUES ('2477', '2471', '520324', '正安县');
INSERT INTO `hi_region` VALUES ('2478', '2471', '520325', '道真仡佬族苗族自治县');
INSERT INTO `hi_region` VALUES ('2479', '2471', '520326', '务川仡佬族苗族自治县');
INSERT INTO `hi_region` VALUES ('2480', '2471', '520327', '凤冈县');
INSERT INTO `hi_region` VALUES ('2481', '2471', '520328', '湄潭县');
INSERT INTO `hi_region` VALUES ('2482', '2471', '520329', '余庆县');
INSERT INTO `hi_region` VALUES ('2483', '2471', '520330', '习水县');
INSERT INTO `hi_region` VALUES ('2484', '2471', '520381', '赤水市');
INSERT INTO `hi_region` VALUES ('2485', '2471', '520382', '仁怀市');
INSERT INTO `hi_region` VALUES ('2486', '2454', '520400', '安顺市');
INSERT INTO `hi_region` VALUES ('2487', '2486', '520402', '西秀区');
INSERT INTO `hi_region` VALUES ('2488', '2486', '520403', '平坝区');
INSERT INTO `hi_region` VALUES ('2489', '2486', '520422', '普定县');
INSERT INTO `hi_region` VALUES ('2490', '2486', '520423', '镇宁布依族苗族自治县');
INSERT INTO `hi_region` VALUES ('2491', '2486', '520424', '关岭布依族苗族自治县');
INSERT INTO `hi_region` VALUES ('2492', '2486', '520425', '紫云苗族布依族自治县');
INSERT INTO `hi_region` VALUES ('2493', '2454', '520500', '毕节市');
INSERT INTO `hi_region` VALUES ('2494', '2493', '520502', '七星关区');
INSERT INTO `hi_region` VALUES ('2495', '2493', '520521', '大方县');
INSERT INTO `hi_region` VALUES ('2496', '2493', '520522', '黔西县');
INSERT INTO `hi_region` VALUES ('2497', '2493', '520523', '金沙县');
INSERT INTO `hi_region` VALUES ('2498', '2493', '520524', '织金县');
INSERT INTO `hi_region` VALUES ('2499', '2493', '520525', '纳雍县');
INSERT INTO `hi_region` VALUES ('2500', '2493', '520526', '威宁彝族回族苗族自治县');
INSERT INTO `hi_region` VALUES ('2501', '2493', '520527', '赫章县');
INSERT INTO `hi_region` VALUES ('2502', '2454', '520600', '铜仁市');
INSERT INTO `hi_region` VALUES ('2503', '2502', '520602', '碧江区');
INSERT INTO `hi_region` VALUES ('2504', '2502', '520603', '万山区');
INSERT INTO `hi_region` VALUES ('2505', '2502', '520621', '江口县');
INSERT INTO `hi_region` VALUES ('2506', '2502', '520622', '玉屏侗族自治县');
INSERT INTO `hi_region` VALUES ('2507', '2502', '520623', '石阡县');
INSERT INTO `hi_region` VALUES ('2508', '2502', '520624', '思南县');
INSERT INTO `hi_region` VALUES ('2509', '2502', '520625', '印江土家族苗族自治县');
INSERT INTO `hi_region` VALUES ('2510', '2502', '520626', '德江县');
INSERT INTO `hi_region` VALUES ('2511', '2502', '520627', '沿河土家族自治县');
INSERT INTO `hi_region` VALUES ('2512', '2502', '520628', '松桃苗族自治县');
INSERT INTO `hi_region` VALUES ('2513', '2454', '522300', '黔西南布依族苗族自治州');
INSERT INTO `hi_region` VALUES ('2514', '2513', '522301', '兴义市');
INSERT INTO `hi_region` VALUES ('2515', '2513', '522322', '兴仁县');
INSERT INTO `hi_region` VALUES ('2516', '2513', '522323', '普安县');
INSERT INTO `hi_region` VALUES ('2517', '2513', '522324', '晴隆县');
INSERT INTO `hi_region` VALUES ('2518', '2513', '522325', '贞丰县');
INSERT INTO `hi_region` VALUES ('2519', '2513', '522326', '望谟县');
INSERT INTO `hi_region` VALUES ('2520', '2513', '522327', '册亨县');
INSERT INTO `hi_region` VALUES ('2521', '2513', '522328', '安龙县');
INSERT INTO `hi_region` VALUES ('2522', '2454', '522600', '黔东南苗族侗族自治州');
INSERT INTO `hi_region` VALUES ('2523', '2522', '522601', '凯里市');
INSERT INTO `hi_region` VALUES ('2524', '2522', '522622', '黄平县');
INSERT INTO `hi_region` VALUES ('2525', '2522', '522623', '施秉县');
INSERT INTO `hi_region` VALUES ('2526', '2522', '522624', '三穗县');
INSERT INTO `hi_region` VALUES ('2527', '2522', '522625', '镇远县');
INSERT INTO `hi_region` VALUES ('2528', '2522', '522626', '岑巩县');
INSERT INTO `hi_region` VALUES ('2529', '2522', '522627', '天柱县');
INSERT INTO `hi_region` VALUES ('2530', '2522', '522628', '锦屏县');
INSERT INTO `hi_region` VALUES ('2531', '2522', '522629', '剑河县');
INSERT INTO `hi_region` VALUES ('2532', '2522', '522630', '台江县');
INSERT INTO `hi_region` VALUES ('2533', '2522', '522631', '黎平县');
INSERT INTO `hi_region` VALUES ('2534', '2522', '522632', '榕江县');
INSERT INTO `hi_region` VALUES ('2535', '2522', '522633', '从江县');
INSERT INTO `hi_region` VALUES ('2536', '2522', '522634', '雷山县');
INSERT INTO `hi_region` VALUES ('2537', '2522', '522635', '麻江县');
INSERT INTO `hi_region` VALUES ('2538', '2522', '522636', '丹寨县');
INSERT INTO `hi_region` VALUES ('2539', '2454', '522700', '黔南布依族苗族自治州');
INSERT INTO `hi_region` VALUES ('2540', '2539', '522701', '都匀市');
INSERT INTO `hi_region` VALUES ('2541', '2539', '522702', '福泉市');
INSERT INTO `hi_region` VALUES ('2542', '2539', '522722', '荔波县');
INSERT INTO `hi_region` VALUES ('2543', '2539', '522723', '贵定县');
INSERT INTO `hi_region` VALUES ('2544', '2539', '522725', '瓮安县');
INSERT INTO `hi_region` VALUES ('2545', '2539', '522726', '独山县');
INSERT INTO `hi_region` VALUES ('2546', '2539', '522727', '平塘县');
INSERT INTO `hi_region` VALUES ('2547', '2539', '522728', '罗甸县');
INSERT INTO `hi_region` VALUES ('2548', '2539', '522729', '长顺县');
INSERT INTO `hi_region` VALUES ('2549', '2539', '522730', '龙里县');
INSERT INTO `hi_region` VALUES ('2550', '2539', '522731', '惠水县');
INSERT INTO `hi_region` VALUES ('2551', '2539', '522732', '三都水族自治县');
INSERT INTO `hi_region` VALUES ('2552', '0', '530000', '云南省');
INSERT INTO `hi_region` VALUES ('2553', '2552', '530100', '昆明市');
INSERT INTO `hi_region` VALUES ('2554', '2553', '530102', '五华区');
INSERT INTO `hi_region` VALUES ('2555', '2553', '530103', '盘龙区');
INSERT INTO `hi_region` VALUES ('2556', '2553', '530111', '官渡区');
INSERT INTO `hi_region` VALUES ('2557', '2553', '530112', '西山区');
INSERT INTO `hi_region` VALUES ('2558', '2553', '530113', '东川区');
INSERT INTO `hi_region` VALUES ('2559', '2553', '530114', '呈贡区');
INSERT INTO `hi_region` VALUES ('2560', '2553', '530115', '晋宁区');
INSERT INTO `hi_region` VALUES ('2561', '2553', '530124', '富民县');
INSERT INTO `hi_region` VALUES ('2562', '2553', '530125', '宜良县');
INSERT INTO `hi_region` VALUES ('2563', '2553', '530126', '石林彝族自治县');
INSERT INTO `hi_region` VALUES ('2564', '2553', '530127', '嵩明县');
INSERT INTO `hi_region` VALUES ('2565', '2553', '530128', '禄劝彝族苗族自治县');
INSERT INTO `hi_region` VALUES ('2566', '2553', '530129', '寻甸回族彝族自治县');
INSERT INTO `hi_region` VALUES ('2567', '2553', '530181', '安宁市');
INSERT INTO `hi_region` VALUES ('2568', '2552', '530300', '曲靖市');
INSERT INTO `hi_region` VALUES ('2569', '2568', '530302', '麒麟区');
INSERT INTO `hi_region` VALUES ('2570', '2568', '530303', '沾益区');
INSERT INTO `hi_region` VALUES ('2571', '2568', '530321', '马龙县');
INSERT INTO `hi_region` VALUES ('2572', '2568', '530322', '陆良县');
INSERT INTO `hi_region` VALUES ('2573', '2568', '530323', '师宗县');
INSERT INTO `hi_region` VALUES ('2574', '2568', '530324', '罗平县');
INSERT INTO `hi_region` VALUES ('2575', '2568', '530325', '富源县');
INSERT INTO `hi_region` VALUES ('2576', '2568', '530326', '会泽县');
INSERT INTO `hi_region` VALUES ('2577', '2568', '530381', '宣威市');
INSERT INTO `hi_region` VALUES ('2578', '2552', '530400', '玉溪市');
INSERT INTO `hi_region` VALUES ('2579', '2578', '530402', '红塔区');
INSERT INTO `hi_region` VALUES ('2580', '2578', '530403', '江川区');
INSERT INTO `hi_region` VALUES ('2581', '2578', '530422', '澄江县');
INSERT INTO `hi_region` VALUES ('2582', '2578', '530423', '通海县');
INSERT INTO `hi_region` VALUES ('2583', '2578', '530424', '华宁县');
INSERT INTO `hi_region` VALUES ('2584', '2578', '530425', '易门县');
INSERT INTO `hi_region` VALUES ('2585', '2578', '530426', '峨山彝族自治县');
INSERT INTO `hi_region` VALUES ('2586', '2578', '530427', '新平彝族傣族自治县');
INSERT INTO `hi_region` VALUES ('2587', '2578', '530428', '元江哈尼族彝族傣族自治县');
INSERT INTO `hi_region` VALUES ('2588', '2552', '530500', '保山市');
INSERT INTO `hi_region` VALUES ('2589', '2588', '530502', '隆阳区');
INSERT INTO `hi_region` VALUES ('2590', '2588', '530521', '施甸县');
INSERT INTO `hi_region` VALUES ('2591', '2588', '530581', '腾冲市');
INSERT INTO `hi_region` VALUES ('2592', '2588', '530523', '龙陵县');
INSERT INTO `hi_region` VALUES ('2593', '2588', '530524', '昌宁县');
INSERT INTO `hi_region` VALUES ('2594', '2552', '530600', '昭通市');
INSERT INTO `hi_region` VALUES ('2595', '2594', '530602', '昭阳区');
INSERT INTO `hi_region` VALUES ('2596', '2594', '530621', '鲁甸县');
INSERT INTO `hi_region` VALUES ('2597', '2594', '530622', '巧家县');
INSERT INTO `hi_region` VALUES ('2598', '2594', '530623', '盐津县');
INSERT INTO `hi_region` VALUES ('2599', '2594', '530624', '大关县');
INSERT INTO `hi_region` VALUES ('2600', '2594', '530625', '永善县');
INSERT INTO `hi_region` VALUES ('2601', '2594', '530626', '绥江县');
INSERT INTO `hi_region` VALUES ('2602', '2594', '530627', '镇雄县');
INSERT INTO `hi_region` VALUES ('2603', '2594', '530628', '彝良县');
INSERT INTO `hi_region` VALUES ('2604', '2594', '530629', '威信县');
INSERT INTO `hi_region` VALUES ('2605', '2594', '530630', '水富县');
INSERT INTO `hi_region` VALUES ('2606', '2552', '530700', '丽江市');
INSERT INTO `hi_region` VALUES ('2607', '2606', '530702', '古城区');
INSERT INTO `hi_region` VALUES ('2608', '2606', '530721', '玉龙纳西族自治县');
INSERT INTO `hi_region` VALUES ('2609', '2606', '530722', '永胜县');
INSERT INTO `hi_region` VALUES ('2610', '2606', '530723', '华坪县');
INSERT INTO `hi_region` VALUES ('2611', '2606', '530724', '宁蒗彝族自治县');
INSERT INTO `hi_region` VALUES ('2612', '2552', '530800', '普洱市');
INSERT INTO `hi_region` VALUES ('2613', '2612', '530802', '思茅区');
INSERT INTO `hi_region` VALUES ('2614', '2612', '530821', '宁洱哈尼族彝族自治县');
INSERT INTO `hi_region` VALUES ('2615', '2612', '530822', '墨江哈尼族自治县');
INSERT INTO `hi_region` VALUES ('2616', '2612', '530823', '景东彝族自治县');
INSERT INTO `hi_region` VALUES ('2617', '2612', '530824', '景谷傣族彝族自治县');
INSERT INTO `hi_region` VALUES ('2618', '2612', '530825', '镇沅彝族哈尼族拉祜族自治县');
INSERT INTO `hi_region` VALUES ('2619', '2612', '530826', '江城哈尼族彝族自治县');
INSERT INTO `hi_region` VALUES ('2620', '2612', '530827', '孟连傣族拉祜族佤族自治县');
INSERT INTO `hi_region` VALUES ('2621', '2612', '530828', '澜沧拉祜族自治县');
INSERT INTO `hi_region` VALUES ('2622', '2612', '530829', '西盟佤族自治县');
INSERT INTO `hi_region` VALUES ('2623', '2552', '530900', '临沧市');
INSERT INTO `hi_region` VALUES ('2624', '2623', '530902', '临翔区');
INSERT INTO `hi_region` VALUES ('2625', '2623', '530921', '凤庆县');
INSERT INTO `hi_region` VALUES ('2626', '2623', '530922', '云县');
INSERT INTO `hi_region` VALUES ('2627', '2623', '530923', '永德县');
INSERT INTO `hi_region` VALUES ('2628', '2623', '530924', '镇康县');
INSERT INTO `hi_region` VALUES ('2629', '2623', '530925', '双江拉祜族佤族布朗族傣族自治县');
INSERT INTO `hi_region` VALUES ('2630', '2623', '530926', '耿马傣族佤族自治县');
INSERT INTO `hi_region` VALUES ('2631', '2623', '530927', '沧源佤族自治县');
INSERT INTO `hi_region` VALUES ('2632', '2552', '532300', '楚雄彝族自治州');
INSERT INTO `hi_region` VALUES ('2633', '2632', '532301', '楚雄市');
INSERT INTO `hi_region` VALUES ('2634', '2632', '532322', '双柏县');
INSERT INTO `hi_region` VALUES ('2635', '2632', '532323', '牟定县');
INSERT INTO `hi_region` VALUES ('2636', '2632', '532324', '南华县');
INSERT INTO `hi_region` VALUES ('2637', '2632', '532325', '姚安县');
INSERT INTO `hi_region` VALUES ('2638', '2632', '532326', '大姚县');
INSERT INTO `hi_region` VALUES ('2639', '2632', '532327', '永仁县');
INSERT INTO `hi_region` VALUES ('2640', '2632', '532328', '元谋县');
INSERT INTO `hi_region` VALUES ('2641', '2632', '532329', '武定县');
INSERT INTO `hi_region` VALUES ('2642', '2632', '532331', '禄丰县');
INSERT INTO `hi_region` VALUES ('2643', '2552', '532500', '红河哈尼族彝族自治州');
INSERT INTO `hi_region` VALUES ('2644', '2643', '532501', '个旧市');
INSERT INTO `hi_region` VALUES ('2645', '2643', '532502', '开远市');
INSERT INTO `hi_region` VALUES ('2646', '2643', '532503', '蒙自市');
INSERT INTO `hi_region` VALUES ('2647', '2643', '532504', '弥勒市');
INSERT INTO `hi_region` VALUES ('2648', '2643', '532523', '屏边苗族自治县');
INSERT INTO `hi_region` VALUES ('2649', '2643', '532524', '建水县');
INSERT INTO `hi_region` VALUES ('2650', '2643', '532525', '石屏县');
INSERT INTO `hi_region` VALUES ('2651', '2643', '532527', '泸西县');
INSERT INTO `hi_region` VALUES ('2652', '2643', '532528', '元阳县');
INSERT INTO `hi_region` VALUES ('2653', '2643', '532529', '红河县');
INSERT INTO `hi_region` VALUES ('2654', '2643', '532530', '金平苗族瑶族傣族自治县');
INSERT INTO `hi_region` VALUES ('2655', '2643', '532531', '绿春县');
INSERT INTO `hi_region` VALUES ('2656', '2643', '532532', '河口瑶族自治县');
INSERT INTO `hi_region` VALUES ('2657', '2552', '532600', '文山壮族苗族自治州');
INSERT INTO `hi_region` VALUES ('2658', '2657', '532601', '文山市');
INSERT INTO `hi_region` VALUES ('2659', '2657', '532622', '砚山县');
INSERT INTO `hi_region` VALUES ('2660', '2657', '532623', '西畴县');
INSERT INTO `hi_region` VALUES ('2661', '2657', '532624', '麻栗坡县');
INSERT INTO `hi_region` VALUES ('2662', '2657', '532625', '马关县');
INSERT INTO `hi_region` VALUES ('2663', '2657', '532626', '丘北县');
INSERT INTO `hi_region` VALUES ('2664', '2657', '532627', '广南县');
INSERT INTO `hi_region` VALUES ('2665', '2657', '532628', '富宁县');
INSERT INTO `hi_region` VALUES ('2666', '2552', '532800', '西双版纳傣族自治州');
INSERT INTO `hi_region` VALUES ('2667', '2666', '532801', '景洪市');
INSERT INTO `hi_region` VALUES ('2668', '2666', '532822', '勐海县');
INSERT INTO `hi_region` VALUES ('2669', '2666', '532823', '勐腊县');
INSERT INTO `hi_region` VALUES ('2670', '2552', '532900', '大理白族自治州');
INSERT INTO `hi_region` VALUES ('2671', '2670', '532901', '大理市');
INSERT INTO `hi_region` VALUES ('2672', '2670', '532922', '漾濞彝族自治县');
INSERT INTO `hi_region` VALUES ('2673', '2670', '532923', '祥云县');
INSERT INTO `hi_region` VALUES ('2674', '2670', '532924', '宾川县');
INSERT INTO `hi_region` VALUES ('2675', '2670', '532925', '弥渡县');
INSERT INTO `hi_region` VALUES ('2676', '2670', '532926', '南涧彝族自治县');
INSERT INTO `hi_region` VALUES ('2677', '2670', '532927', '巍山彝族回族自治县');
INSERT INTO `hi_region` VALUES ('2678', '2670', '532928', '永平县');
INSERT INTO `hi_region` VALUES ('2679', '2670', '532929', '云龙县');
INSERT INTO `hi_region` VALUES ('2680', '2670', '532930', '洱源县');
INSERT INTO `hi_region` VALUES ('2681', '2670', '532931', '剑川县');
INSERT INTO `hi_region` VALUES ('2682', '2670', '532932', '鹤庆县');
INSERT INTO `hi_region` VALUES ('2683', '2552', '533100', '德宏傣族景颇族自治州');
INSERT INTO `hi_region` VALUES ('2684', '2683', '533102', '瑞丽市');
INSERT INTO `hi_region` VALUES ('2685', '2683', '533103', '芒市');
INSERT INTO `hi_region` VALUES ('2686', '2683', '533122', '梁河县');
INSERT INTO `hi_region` VALUES ('2687', '2683', '533123', '盈江县');
INSERT INTO `hi_region` VALUES ('2688', '2683', '533124', '陇川县');
INSERT INTO `hi_region` VALUES ('2689', '2552', '533300', '怒江傈僳族自治州');
INSERT INTO `hi_region` VALUES ('2690', '2689', '533301', '泸水市');
INSERT INTO `hi_region` VALUES ('2691', '2689', '533323', '福贡县');
INSERT INTO `hi_region` VALUES ('2692', '2689', '533324', '贡山独龙族怒族自治县');
INSERT INTO `hi_region` VALUES ('2693', '2689', '533325', '兰坪白族普米族自治县');
INSERT INTO `hi_region` VALUES ('2694', '2552', '533400', '迪庆藏族自治州');
INSERT INTO `hi_region` VALUES ('2695', '2694', '533401', '香格里拉市');
INSERT INTO `hi_region` VALUES ('2696', '2694', '533422', '德钦县');
INSERT INTO `hi_region` VALUES ('2697', '2694', '533423', '维西傈僳族自治县');
INSERT INTO `hi_region` VALUES ('2698', '0', '540000', '西藏自治区');
INSERT INTO `hi_region` VALUES ('2699', '2698', '540100', '拉萨市');
INSERT INTO `hi_region` VALUES ('2700', '2699', '540102', '城关区');
INSERT INTO `hi_region` VALUES ('2701', '2699', '540103', '堆龙德庆区');
INSERT INTO `hi_region` VALUES ('2702', '2699', '540121', '林周县');
INSERT INTO `hi_region` VALUES ('2703', '2699', '540122', '当雄县');
INSERT INTO `hi_region` VALUES ('2704', '2699', '540123', '尼木县');
INSERT INTO `hi_region` VALUES ('2705', '2699', '540124', '曲水县');
INSERT INTO `hi_region` VALUES ('2706', '2699', '540126', '达孜县');
INSERT INTO `hi_region` VALUES ('2707', '2699', '540127', '墨竹工卡县');
INSERT INTO `hi_region` VALUES ('2708', '2698', '540200', '日喀则市');
INSERT INTO `hi_region` VALUES ('2709', '2708', '540202', '桑珠孜区');
INSERT INTO `hi_region` VALUES ('2710', '2708', '540221', '南木林县');
INSERT INTO `hi_region` VALUES ('2711', '2708', '540222', '江孜县');
INSERT INTO `hi_region` VALUES ('2712', '2708', '540223', '定日县');
INSERT INTO `hi_region` VALUES ('2713', '2708', '540224', '萨迦县');
INSERT INTO `hi_region` VALUES ('2714', '2708', '540225', '拉孜县');
INSERT INTO `hi_region` VALUES ('2715', '2708', '540226', '昂仁县');
INSERT INTO `hi_region` VALUES ('2716', '2708', '540227', '谢通门县');
INSERT INTO `hi_region` VALUES ('2717', '2708', '540228', '白朗县');
INSERT INTO `hi_region` VALUES ('2718', '2708', '540229', '仁布县');
INSERT INTO `hi_region` VALUES ('2719', '2708', '540230', '康马县');
INSERT INTO `hi_region` VALUES ('2720', '2708', '540231', '定结县');
INSERT INTO `hi_region` VALUES ('2721', '2708', '540232', '仲巴县');
INSERT INTO `hi_region` VALUES ('2722', '2708', '540233', '亚东县');
INSERT INTO `hi_region` VALUES ('2723', '2708', '540234', '吉隆县');
INSERT INTO `hi_region` VALUES ('2724', '2708', '540235', '聂拉木县');
INSERT INTO `hi_region` VALUES ('2725', '2708', '540236', '萨嘎县');
INSERT INTO `hi_region` VALUES ('2726', '2708', '540237', '岗巴县');
INSERT INTO `hi_region` VALUES ('2727', '2698', '540300', '昌都市');
INSERT INTO `hi_region` VALUES ('2728', '2727', '540302', '卡若区');
INSERT INTO `hi_region` VALUES ('2729', '2727', '540321', '江达县');
INSERT INTO `hi_region` VALUES ('2730', '2727', '540322', '贡觉县');
INSERT INTO `hi_region` VALUES ('2731', '2727', '540323', '类乌齐县');
INSERT INTO `hi_region` VALUES ('2732', '2727', '540324', '丁青县');
INSERT INTO `hi_region` VALUES ('2733', '2727', '540325', '察雅县');
INSERT INTO `hi_region` VALUES ('2734', '2727', '540326', '八宿县');
INSERT INTO `hi_region` VALUES ('2735', '2727', '540327', '左贡县');
INSERT INTO `hi_region` VALUES ('2736', '2727', '540328', '芒康县');
INSERT INTO `hi_region` VALUES ('2737', '2727', '540329', '洛隆县');
INSERT INTO `hi_region` VALUES ('2738', '2727', '540330', '边坝县');
INSERT INTO `hi_region` VALUES ('2739', '2698', '540400', '林芝市');
INSERT INTO `hi_region` VALUES ('2740', '2739', '540402', '巴宜区');
INSERT INTO `hi_region` VALUES ('2741', '2739', '540421', '工布江达县');
INSERT INTO `hi_region` VALUES ('2742', '2739', '540422', '米林县');
INSERT INTO `hi_region` VALUES ('2743', '2739', '540423', '墨脱县');
INSERT INTO `hi_region` VALUES ('2744', '2739', '540424', '波密县');
INSERT INTO `hi_region` VALUES ('2745', '2739', '540425', '察隅县');
INSERT INTO `hi_region` VALUES ('2746', '2739', '540426', '朗县');
INSERT INTO `hi_region` VALUES ('2747', '2698', '540500', '山南市');
INSERT INTO `hi_region` VALUES ('2748', '2747', '540502', '乃东区');
INSERT INTO `hi_region` VALUES ('2749', '2747', '540521', '扎囊县');
INSERT INTO `hi_region` VALUES ('2750', '2747', '540522', '贡嘎县');
INSERT INTO `hi_region` VALUES ('2751', '2747', '540523', '桑日县');
INSERT INTO `hi_region` VALUES ('2752', '2747', '540524', '琼结县');
INSERT INTO `hi_region` VALUES ('2753', '2747', '540525', '曲松县');
INSERT INTO `hi_region` VALUES ('2754', '2747', '540526', '措美县');
INSERT INTO `hi_region` VALUES ('2755', '2747', '540527', '洛扎县');
INSERT INTO `hi_region` VALUES ('2756', '2747', '540528', '加查县');
INSERT INTO `hi_region` VALUES ('2757', '2747', '540529', '隆子县');
INSERT INTO `hi_region` VALUES ('2758', '2747', '540530', '错那县');
INSERT INTO `hi_region` VALUES ('2759', '2747', '540531', '浪卡子县');
INSERT INTO `hi_region` VALUES ('2760', '2698', '542400', '那曲地区');
INSERT INTO `hi_region` VALUES ('2761', '2760', '542421', '那曲县');
INSERT INTO `hi_region` VALUES ('2762', '2760', '542422', '嘉黎县');
INSERT INTO `hi_region` VALUES ('2763', '2760', '542423', '比如县');
INSERT INTO `hi_region` VALUES ('2764', '2760', '542424', '聂荣县');
INSERT INTO `hi_region` VALUES ('2765', '2760', '542425', '安多县');
INSERT INTO `hi_region` VALUES ('2766', '2760', '542426', '申扎县');
INSERT INTO `hi_region` VALUES ('2767', '2760', '542427', '索县');
INSERT INTO `hi_region` VALUES ('2768', '2760', '542428', '班戈县');
INSERT INTO `hi_region` VALUES ('2769', '2760', '542429', '巴青县');
INSERT INTO `hi_region` VALUES ('2770', '2760', '542430', '尼玛县');
INSERT INTO `hi_region` VALUES ('2771', '2760', '542431', '双湖县');
INSERT INTO `hi_region` VALUES ('2772', '2698', '542500', '阿里地区');
INSERT INTO `hi_region` VALUES ('2773', '2772', '542521', '普兰县');
INSERT INTO `hi_region` VALUES ('2774', '2772', '542522', '札达县');
INSERT INTO `hi_region` VALUES ('2775', '2772', '542523', '噶尔县');
INSERT INTO `hi_region` VALUES ('2776', '2772', '542524', '日土县');
INSERT INTO `hi_region` VALUES ('2777', '2772', '542525', '革吉县');
INSERT INTO `hi_region` VALUES ('2778', '2772', '542526', '改则县');
INSERT INTO `hi_region` VALUES ('2779', '2772', '542527', '措勤县');
INSERT INTO `hi_region` VALUES ('2780', '0', '610000', '陕西省');
INSERT INTO `hi_region` VALUES ('2781', '2780', '610100', '西安市');
INSERT INTO `hi_region` VALUES ('2782', '2781', '610102', '新城区');
INSERT INTO `hi_region` VALUES ('2783', '2781', '610103', '碑林区');
INSERT INTO `hi_region` VALUES ('2784', '2781', '610104', '莲湖区');
INSERT INTO `hi_region` VALUES ('2785', '2781', '610111', '灞桥区');
INSERT INTO `hi_region` VALUES ('2786', '2781', '610112', '未央区');
INSERT INTO `hi_region` VALUES ('2787', '2781', '610113', '雁塔区');
INSERT INTO `hi_region` VALUES ('2788', '2781', '610114', '阎良区');
INSERT INTO `hi_region` VALUES ('2789', '2781', '610115', '临潼区');
INSERT INTO `hi_region` VALUES ('2790', '2781', '610116', '长安区');
INSERT INTO `hi_region` VALUES ('2791', '2781', '610117', '高陵区');
INSERT INTO `hi_region` VALUES ('2792', '2781', '610118', '鄠邑区');
INSERT INTO `hi_region` VALUES ('2793', '2781', '610122', '蓝田县');
INSERT INTO `hi_region` VALUES ('2794', '2781', '610124', '周至县');
INSERT INTO `hi_region` VALUES ('2795', '2780', '610200', '铜川市');
INSERT INTO `hi_region` VALUES ('2796', '2795', '610202', '王益区');
INSERT INTO `hi_region` VALUES ('2797', '2795', '610203', '印台区');
INSERT INTO `hi_region` VALUES ('2798', '2795', '610204', '耀州区');
INSERT INTO `hi_region` VALUES ('2799', '2795', '610222', '宜君县');
INSERT INTO `hi_region` VALUES ('2800', '2780', '610300', '宝鸡市');
INSERT INTO `hi_region` VALUES ('2801', '2800', '610302', '渭滨区');
INSERT INTO `hi_region` VALUES ('2802', '2800', '610303', '金台区');
INSERT INTO `hi_region` VALUES ('2803', '2800', '610304', '陈仓区');
INSERT INTO `hi_region` VALUES ('2804', '2800', '610322', '凤翔县');
INSERT INTO `hi_region` VALUES ('2805', '2800', '610323', '岐山县');
INSERT INTO `hi_region` VALUES ('2806', '2800', '610324', '扶风县');
INSERT INTO `hi_region` VALUES ('2807', '2800', '610326', '眉县');
INSERT INTO `hi_region` VALUES ('2808', '2800', '610327', '陇县');
INSERT INTO `hi_region` VALUES ('2809', '2800', '610328', '千阳县');
INSERT INTO `hi_region` VALUES ('2810', '2800', '610329', '麟游县');
INSERT INTO `hi_region` VALUES ('2811', '2800', '610330', '凤县');
INSERT INTO `hi_region` VALUES ('2812', '2800', '610331', '太白县');
INSERT INTO `hi_region` VALUES ('2813', '2780', '610400', '咸阳市');
INSERT INTO `hi_region` VALUES ('2814', '2813', '610402', '秦都区');
INSERT INTO `hi_region` VALUES ('2815', '2813', '610403', '杨陵区');
INSERT INTO `hi_region` VALUES ('2816', '2813', '610404', '渭城区');
INSERT INTO `hi_region` VALUES ('2817', '2813', '610422', '三原县');
INSERT INTO `hi_region` VALUES ('2818', '2813', '610423', '泾阳县');
INSERT INTO `hi_region` VALUES ('2819', '2813', '610424', '乾县');
INSERT INTO `hi_region` VALUES ('2820', '2813', '610425', '礼泉县');
INSERT INTO `hi_region` VALUES ('2821', '2813', '610426', '永寿县');
INSERT INTO `hi_region` VALUES ('2822', '2813', '610427', '彬县');
INSERT INTO `hi_region` VALUES ('2823', '2813', '610428', '长武县');
INSERT INTO `hi_region` VALUES ('2824', '2813', '610429', '旬邑县');
INSERT INTO `hi_region` VALUES ('2825', '2813', '610430', '淳化县');
INSERT INTO `hi_region` VALUES ('2826', '2813', '610431', '武功县');
INSERT INTO `hi_region` VALUES ('2827', '2813', '610481', '兴平市');
INSERT INTO `hi_region` VALUES ('2828', '2780', '610500', '渭南市');
INSERT INTO `hi_region` VALUES ('2829', '2828', '610502', '临渭区');
INSERT INTO `hi_region` VALUES ('2830', '2828', '610503', '华州区');
INSERT INTO `hi_region` VALUES ('2831', '2828', '610522', '潼关县');
INSERT INTO `hi_region` VALUES ('2832', '2828', '610523', '大荔县');
INSERT INTO `hi_region` VALUES ('2833', '2828', '610524', '合阳县');
INSERT INTO `hi_region` VALUES ('2834', '2828', '610525', '澄城县');
INSERT INTO `hi_region` VALUES ('2835', '2828', '610526', '蒲城县');
INSERT INTO `hi_region` VALUES ('2836', '2828', '610527', '白水县');
INSERT INTO `hi_region` VALUES ('2837', '2828', '610528', '富平县');
INSERT INTO `hi_region` VALUES ('2838', '2828', '610581', '韩城市');
INSERT INTO `hi_region` VALUES ('2839', '2828', '610582', '华阴市');
INSERT INTO `hi_region` VALUES ('2840', '2780', '610600', '延安市');
INSERT INTO `hi_region` VALUES ('2841', '2840', '610602', '宝塔区');
INSERT INTO `hi_region` VALUES ('2842', '2840', '610603', '安塞区');
INSERT INTO `hi_region` VALUES ('2843', '2840', '610621', '延长县');
INSERT INTO `hi_region` VALUES ('2844', '2840', '610622', '延川县');
INSERT INTO `hi_region` VALUES ('2845', '2840', '610623', '子长县');
INSERT INTO `hi_region` VALUES ('2846', '2840', '610625', '志丹县');
INSERT INTO `hi_region` VALUES ('2847', '2840', '610626', '吴起县');
INSERT INTO `hi_region` VALUES ('2848', '2840', '610627', '甘泉县');
INSERT INTO `hi_region` VALUES ('2849', '2840', '610628', '富县');
INSERT INTO `hi_region` VALUES ('2850', '2840', '610629', '洛川县');
INSERT INTO `hi_region` VALUES ('2851', '2840', '610630', '宜川县');
INSERT INTO `hi_region` VALUES ('2852', '2840', '610631', '黄龙县');
INSERT INTO `hi_region` VALUES ('2853', '2840', '610632', '黄陵县');
INSERT INTO `hi_region` VALUES ('2854', '2780', '610700', '汉中市');
INSERT INTO `hi_region` VALUES ('2855', '2854', '610702', '汉台区');
INSERT INTO `hi_region` VALUES ('2856', '2854', '610721', '南郑县');
INSERT INTO `hi_region` VALUES ('2857', '2854', '610722', '城固县');
INSERT INTO `hi_region` VALUES ('2858', '2854', '610723', '洋县');
INSERT INTO `hi_region` VALUES ('2859', '2854', '610724', '西乡县');
INSERT INTO `hi_region` VALUES ('2860', '2854', '610725', '勉县');
INSERT INTO `hi_region` VALUES ('2861', '2854', '610726', '宁强县');
INSERT INTO `hi_region` VALUES ('2862', '2854', '610727', '略阳县');
INSERT INTO `hi_region` VALUES ('2863', '2854', '610728', '镇巴县');
INSERT INTO `hi_region` VALUES ('2864', '2854', '610729', '留坝县');
INSERT INTO `hi_region` VALUES ('2865', '2854', '610730', '佛坪县');
INSERT INTO `hi_region` VALUES ('2866', '2780', '610800', '榆林市');
INSERT INTO `hi_region` VALUES ('2867', '2866', '610802', '榆阳区');
INSERT INTO `hi_region` VALUES ('2868', '2866', '610803', '横山区');
INSERT INTO `hi_region` VALUES ('2869', '2866', '610821', '神木县');
INSERT INTO `hi_region` VALUES ('2870', '2866', '610822', '府谷县');
INSERT INTO `hi_region` VALUES ('2871', '2866', '610824', '靖边县');
INSERT INTO `hi_region` VALUES ('2872', '2866', '610825', '定边县');
INSERT INTO `hi_region` VALUES ('2873', '2866', '610826', '绥德县');
INSERT INTO `hi_region` VALUES ('2874', '2866', '610827', '米脂县');
INSERT INTO `hi_region` VALUES ('2875', '2866', '610828', '佳县');
INSERT INTO `hi_region` VALUES ('2876', '2866', '610829', '吴堡县');
INSERT INTO `hi_region` VALUES ('2877', '2866', '610830', '清涧县');
INSERT INTO `hi_region` VALUES ('2878', '2866', '610831', '子洲县');
INSERT INTO `hi_region` VALUES ('2879', '2780', '610900', '安康市');
INSERT INTO `hi_region` VALUES ('2880', '2879', '610902', '汉滨区');
INSERT INTO `hi_region` VALUES ('2881', '2879', '610921', '汉阴县');
INSERT INTO `hi_region` VALUES ('2882', '2879', '610922', '石泉县');
INSERT INTO `hi_region` VALUES ('2883', '2879', '610923', '宁陕县');
INSERT INTO `hi_region` VALUES ('2884', '2879', '610924', '紫阳县');
INSERT INTO `hi_region` VALUES ('2885', '2879', '610925', '岚皋县');
INSERT INTO `hi_region` VALUES ('2886', '2879', '610926', '平利县');
INSERT INTO `hi_region` VALUES ('2887', '2879', '610927', '镇坪县');
INSERT INTO `hi_region` VALUES ('2888', '2879', '610928', '旬阳县');
INSERT INTO `hi_region` VALUES ('2889', '2879', '610929', '白河县');
INSERT INTO `hi_region` VALUES ('2890', '2780', '611000', '商洛市');
INSERT INTO `hi_region` VALUES ('2891', '2890', '611002', '商州区');
INSERT INTO `hi_region` VALUES ('2892', '2890', '611021', '洛南县');
INSERT INTO `hi_region` VALUES ('2893', '2890', '611022', '丹凤县');
INSERT INTO `hi_region` VALUES ('2894', '2890', '611023', '商南县');
INSERT INTO `hi_region` VALUES ('2895', '2890', '611024', '山阳县');
INSERT INTO `hi_region` VALUES ('2896', '2890', '611025', '镇安县');
INSERT INTO `hi_region` VALUES ('2897', '2890', '611026', '柞水县');
INSERT INTO `hi_region` VALUES ('2898', '0', '620000', '甘肃省');
INSERT INTO `hi_region` VALUES ('2899', '2898', '620100', '兰州市');
INSERT INTO `hi_region` VALUES ('2900', '2899', '620102', '城关区');
INSERT INTO `hi_region` VALUES ('2901', '2899', '620103', '七里河区');
INSERT INTO `hi_region` VALUES ('2902', '2899', '620104', '西固区');
INSERT INTO `hi_region` VALUES ('2903', '2899', '620105', '安宁区');
INSERT INTO `hi_region` VALUES ('2904', '2899', '620111', '红古区');
INSERT INTO `hi_region` VALUES ('2905', '2899', '620121', '永登县');
INSERT INTO `hi_region` VALUES ('2906', '2899', '620122', '皋兰县');
INSERT INTO `hi_region` VALUES ('2907', '2899', '620123', '榆中县');
INSERT INTO `hi_region` VALUES ('2908', '2898', '620200', '嘉峪关市');
INSERT INTO `hi_region` VALUES ('2909', '2898', '620300', '金昌市');
INSERT INTO `hi_region` VALUES ('2910', '2909', '620302', '金川区');
INSERT INTO `hi_region` VALUES ('2911', '2909', '620321', '永昌县');
INSERT INTO `hi_region` VALUES ('2912', '2898', '620400', '白银市');
INSERT INTO `hi_region` VALUES ('2913', '2912', '620402', '白银区');
INSERT INTO `hi_region` VALUES ('2914', '2912', '620403', '平川区');
INSERT INTO `hi_region` VALUES ('2915', '2912', '620421', '靖远县');
INSERT INTO `hi_region` VALUES ('2916', '2912', '620422', '会宁县');
INSERT INTO `hi_region` VALUES ('2917', '2912', '620423', '景泰县');
INSERT INTO `hi_region` VALUES ('2918', '2898', '620500', '天水市');
INSERT INTO `hi_region` VALUES ('2919', '2918', '620502', '秦州区');
INSERT INTO `hi_region` VALUES ('2920', '2918', '620503', '麦积区');
INSERT INTO `hi_region` VALUES ('2921', '2918', '620521', '清水县');
INSERT INTO `hi_region` VALUES ('2922', '2918', '620522', '秦安县');
INSERT INTO `hi_region` VALUES ('2923', '2918', '620523', '甘谷县');
INSERT INTO `hi_region` VALUES ('2924', '2918', '620524', '武山县');
INSERT INTO `hi_region` VALUES ('2925', '2918', '620525', '张家川回族自治县');
INSERT INTO `hi_region` VALUES ('2926', '2898', '620600', '武威市');
INSERT INTO `hi_region` VALUES ('2927', '2926', '620602', '凉州区');
INSERT INTO `hi_region` VALUES ('2928', '2926', '620621', '民勤县');
INSERT INTO `hi_region` VALUES ('2929', '2926', '620622', '古浪县');
INSERT INTO `hi_region` VALUES ('2930', '2926', '620623', '天祝藏族自治县');
INSERT INTO `hi_region` VALUES ('2931', '2898', '620700', '张掖市');
INSERT INTO `hi_region` VALUES ('2932', '2931', '620702', '甘州区');
INSERT INTO `hi_region` VALUES ('2933', '2931', '620721', '肃南裕固族自治县');
INSERT INTO `hi_region` VALUES ('2934', '2931', '620722', '民乐县');
INSERT INTO `hi_region` VALUES ('2935', '2931', '620723', '临泽县');
INSERT INTO `hi_region` VALUES ('2936', '2931', '620724', '高台县');
INSERT INTO `hi_region` VALUES ('2937', '2931', '620725', '山丹县');
INSERT INTO `hi_region` VALUES ('2938', '2898', '620800', '平凉市');
INSERT INTO `hi_region` VALUES ('2939', '2938', '620802', '崆峒区');
INSERT INTO `hi_region` VALUES ('2940', '2938', '620821', '泾川县');
INSERT INTO `hi_region` VALUES ('2941', '2938', '620822', '灵台县');
INSERT INTO `hi_region` VALUES ('2942', '2938', '620823', '崇信县');
INSERT INTO `hi_region` VALUES ('2943', '2938', '620824', '华亭县');
INSERT INTO `hi_region` VALUES ('2944', '2938', '620825', '庄浪县');
INSERT INTO `hi_region` VALUES ('2945', '2938', '620826', '静宁县');
INSERT INTO `hi_region` VALUES ('2946', '2898', '620900', '酒泉市');
INSERT INTO `hi_region` VALUES ('2947', '2946', '620902', '肃州区');
INSERT INTO `hi_region` VALUES ('2948', '2946', '620921', '金塔县');
INSERT INTO `hi_region` VALUES ('2949', '2946', '620922', '瓜州县');
INSERT INTO `hi_region` VALUES ('2950', '2946', '620923', '肃北蒙古族自治县');
INSERT INTO `hi_region` VALUES ('2951', '2946', '620924', '阿克塞哈萨克族自治县');
INSERT INTO `hi_region` VALUES ('2952', '2946', '620981', '玉门市');
INSERT INTO `hi_region` VALUES ('2953', '2946', '620982', '敦煌市');
INSERT INTO `hi_region` VALUES ('2954', '2898', '621000', '庆阳市');
INSERT INTO `hi_region` VALUES ('2955', '2954', '621002', '西峰区');
INSERT INTO `hi_region` VALUES ('2956', '2954', '621021', '庆城县');
INSERT INTO `hi_region` VALUES ('2957', '2954', '621022', '环县');
INSERT INTO `hi_region` VALUES ('2958', '2954', '621023', '华池县');
INSERT INTO `hi_region` VALUES ('2959', '2954', '621024', '合水县');
INSERT INTO `hi_region` VALUES ('2960', '2954', '621025', '正宁县');
INSERT INTO `hi_region` VALUES ('2961', '2954', '621026', '宁县');
INSERT INTO `hi_region` VALUES ('2962', '2954', '621027', '镇原县');
INSERT INTO `hi_region` VALUES ('2963', '2898', '621100', '定西市');
INSERT INTO `hi_region` VALUES ('2964', '2963', '621102', '安定区');
INSERT INTO `hi_region` VALUES ('2965', '2963', '621121', '通渭县');
INSERT INTO `hi_region` VALUES ('2966', '2963', '621122', '陇西县');
INSERT INTO `hi_region` VALUES ('2967', '2963', '621123', '渭源县');
INSERT INTO `hi_region` VALUES ('2968', '2963', '621124', '临洮县');
INSERT INTO `hi_region` VALUES ('2969', '2963', '621125', '漳县');
INSERT INTO `hi_region` VALUES ('2970', '2963', '621126', '岷县');
INSERT INTO `hi_region` VALUES ('2971', '2898', '621200', '陇南市');
INSERT INTO `hi_region` VALUES ('2972', '2971', '621202', '武都区');
INSERT INTO `hi_region` VALUES ('2973', '2971', '621221', '成县');
INSERT INTO `hi_region` VALUES ('2974', '2971', '621222', '文县');
INSERT INTO `hi_region` VALUES ('2975', '2971', '621223', '宕昌县');
INSERT INTO `hi_region` VALUES ('2976', '2971', '621224', '康县');
INSERT INTO `hi_region` VALUES ('2977', '2971', '621225', '西和县');
INSERT INTO `hi_region` VALUES ('2978', '2971', '621226', '礼县');
INSERT INTO `hi_region` VALUES ('2979', '2971', '621227', '徽县');
INSERT INTO `hi_region` VALUES ('2980', '2971', '621228', '两当县');
INSERT INTO `hi_region` VALUES ('2981', '2898', '622900', '临夏回族自治州');
INSERT INTO `hi_region` VALUES ('2982', '2981', '622901', '临夏市');
INSERT INTO `hi_region` VALUES ('2983', '2981', '622921', '临夏县');
INSERT INTO `hi_region` VALUES ('2984', '2981', '622922', '康乐县');
INSERT INTO `hi_region` VALUES ('2985', '2981', '622923', '永靖县');
INSERT INTO `hi_region` VALUES ('2986', '2981', '622924', '广河县');
INSERT INTO `hi_region` VALUES ('2987', '2981', '622925', '和政县');
INSERT INTO `hi_region` VALUES ('2988', '2981', '622926', '东乡族自治县');
INSERT INTO `hi_region` VALUES ('2989', '2981', '622927', '积石山保安族东乡族撒拉族自治县');
INSERT INTO `hi_region` VALUES ('2990', '2898', '623000', '甘南藏族自治州');
INSERT INTO `hi_region` VALUES ('2991', '2990', '623001', '合作市');
INSERT INTO `hi_region` VALUES ('2992', '2990', '623021', '临潭县');
INSERT INTO `hi_region` VALUES ('2993', '2990', '623022', '卓尼县');
INSERT INTO `hi_region` VALUES ('2994', '2990', '623023', '舟曲县');
INSERT INTO `hi_region` VALUES ('2995', '2990', '623024', '迭部县');
INSERT INTO `hi_region` VALUES ('2996', '2990', '623025', '玛曲县');
INSERT INTO `hi_region` VALUES ('2997', '2990', '623026', '碌曲县');
INSERT INTO `hi_region` VALUES ('2998', '2990', '623027', '夏河县');
INSERT INTO `hi_region` VALUES ('2999', '0', '630000', '青海省');
INSERT INTO `hi_region` VALUES ('3000', '2999', '630100', '西宁市');
INSERT INTO `hi_region` VALUES ('3001', '3000', '630102', '城东区');
INSERT INTO `hi_region` VALUES ('3002', '3000', '630103', '城中区');
INSERT INTO `hi_region` VALUES ('3003', '3000', '630104', '城西区');
INSERT INTO `hi_region` VALUES ('3004', '3000', '630105', '城北区');
INSERT INTO `hi_region` VALUES ('3005', '3000', '630121', '大通回族土族自治县');
INSERT INTO `hi_region` VALUES ('3006', '3000', '630122', '湟中县');
INSERT INTO `hi_region` VALUES ('3007', '3000', '630123', '湟源县');
INSERT INTO `hi_region` VALUES ('3008', '2999', '630200', '海东市');
INSERT INTO `hi_region` VALUES ('3009', '3008', '630202', '乐都区');
INSERT INTO `hi_region` VALUES ('3010', '3008', '630203', '平安区');
INSERT INTO `hi_region` VALUES ('3011', '3008', '630222', '民和回族土族自治县');
INSERT INTO `hi_region` VALUES ('3012', '3008', '630223', '互助土族自治县');
INSERT INTO `hi_region` VALUES ('3013', '3008', '630224', '化隆回族自治县');
INSERT INTO `hi_region` VALUES ('3014', '3008', '630225', '循化撒拉族自治县');
INSERT INTO `hi_region` VALUES ('3015', '2999', '632200', '海北藏族自治州');
INSERT INTO `hi_region` VALUES ('3016', '3015', '632221', '门源回族自治县');
INSERT INTO `hi_region` VALUES ('3017', '3015', '632222', '祁连县');
INSERT INTO `hi_region` VALUES ('3018', '3015', '632223', '海晏县');
INSERT INTO `hi_region` VALUES ('3019', '3015', '632224', '刚察县');
INSERT INTO `hi_region` VALUES ('3020', '2999', '632300', '黄南藏族自治州');
INSERT INTO `hi_region` VALUES ('3021', '3020', '632321', '同仁县');
INSERT INTO `hi_region` VALUES ('3022', '3020', '632322', '尖扎县');
INSERT INTO `hi_region` VALUES ('3023', '3020', '632323', '泽库县');
INSERT INTO `hi_region` VALUES ('3024', '3020', '632324', '河南蒙古族自治县');
INSERT INTO `hi_region` VALUES ('3025', '2999', '632500', '海南藏族自治州');
INSERT INTO `hi_region` VALUES ('3026', '3025', '632521', '共和县');
INSERT INTO `hi_region` VALUES ('3027', '3025', '632522', '同德县');
INSERT INTO `hi_region` VALUES ('3028', '3025', '632523', '贵德县');
INSERT INTO `hi_region` VALUES ('3029', '3025', '632524', '兴海县');
INSERT INTO `hi_region` VALUES ('3030', '3025', '632525', '贵南县');
INSERT INTO `hi_region` VALUES ('3031', '2999', '632600', '果洛藏族自治州');
INSERT INTO `hi_region` VALUES ('3032', '3031', '632621', '玛沁县');
INSERT INTO `hi_region` VALUES ('3033', '3031', '632622', '班玛县');
INSERT INTO `hi_region` VALUES ('3034', '3031', '632623', '甘德县');
INSERT INTO `hi_region` VALUES ('3035', '3031', '632624', '达日县');
INSERT INTO `hi_region` VALUES ('3036', '3031', '632625', '久治县');
INSERT INTO `hi_region` VALUES ('3037', '3031', '632626', '玛多县');
INSERT INTO `hi_region` VALUES ('3038', '2999', '632700', '玉树藏族自治州');
INSERT INTO `hi_region` VALUES ('3039', '3038', '632701', '玉树市');
INSERT INTO `hi_region` VALUES ('3040', '3038', '632722', '杂多县');
INSERT INTO `hi_region` VALUES ('3041', '3038', '632723', '称多县');
INSERT INTO `hi_region` VALUES ('3042', '3038', '632724', '治多县');
INSERT INTO `hi_region` VALUES ('3043', '3038', '632725', '囊谦县');
INSERT INTO `hi_region` VALUES ('3044', '3038', '632726', '曲麻莱县');
INSERT INTO `hi_region` VALUES ('3045', '2999', '632800', '海西蒙古族藏族自治州');
INSERT INTO `hi_region` VALUES ('3046', '3045', '632801', '格尔木市');
INSERT INTO `hi_region` VALUES ('3047', '3045', '632802', '德令哈市');
INSERT INTO `hi_region` VALUES ('3048', '3045', '632821', '乌兰县');
INSERT INTO `hi_region` VALUES ('3049', '3045', '632822', '都兰县');
INSERT INTO `hi_region` VALUES ('3050', '3045', '632823', '天峻县');
INSERT INTO `hi_region` VALUES ('3051', '0', '640000', '宁夏回族自治区');
INSERT INTO `hi_region` VALUES ('3052', '3051', '640100', '银川市');
INSERT INTO `hi_region` VALUES ('3053', '3052', '640104', '兴庆区');
INSERT INTO `hi_region` VALUES ('3054', '3052', '640105', '西夏区');
INSERT INTO `hi_region` VALUES ('3055', '3052', '640106', '金凤区');
INSERT INTO `hi_region` VALUES ('3056', '3052', '640121', '永宁县');
INSERT INTO `hi_region` VALUES ('3057', '3052', '640122', '贺兰县');
INSERT INTO `hi_region` VALUES ('3058', '3052', '640181', '灵武市');
INSERT INTO `hi_region` VALUES ('3059', '3051', '640200', '石嘴山市');
INSERT INTO `hi_region` VALUES ('3060', '3059', '640202', '大武口区');
INSERT INTO `hi_region` VALUES ('3061', '3059', '640205', '惠农区');
INSERT INTO `hi_region` VALUES ('3062', '3059', '640221', '平罗县');
INSERT INTO `hi_region` VALUES ('3063', '3051', '640300', '吴忠市');
INSERT INTO `hi_region` VALUES ('3064', '3063', '640302', '利通区');
INSERT INTO `hi_region` VALUES ('3065', '3063', '640303', '红寺堡区');
INSERT INTO `hi_region` VALUES ('3066', '3063', '640323', '盐池县');
INSERT INTO `hi_region` VALUES ('3067', '3063', '640324', '同心县');
INSERT INTO `hi_region` VALUES ('3068', '3063', '640381', '青铜峡市');
INSERT INTO `hi_region` VALUES ('3069', '3051', '640400', '固原市');
INSERT INTO `hi_region` VALUES ('3070', '3069', '640402', '原州区');
INSERT INTO `hi_region` VALUES ('3071', '3069', '640422', '西吉县');
INSERT INTO `hi_region` VALUES ('3072', '3069', '640423', '隆德县');
INSERT INTO `hi_region` VALUES ('3073', '3069', '640424', '泾源县');
INSERT INTO `hi_region` VALUES ('3074', '3069', '640425', '彭阳县');
INSERT INTO `hi_region` VALUES ('3075', '3051', '640500', '中卫市');
INSERT INTO `hi_region` VALUES ('3076', '3075', '640502', '沙坡头区');
INSERT INTO `hi_region` VALUES ('3077', '3075', '640521', '中宁县');
INSERT INTO `hi_region` VALUES ('3078', '3075', '640522', '海原县');
INSERT INTO `hi_region` VALUES ('3079', '0', '650000', '新疆维吾尔自治区');
INSERT INTO `hi_region` VALUES ('3080', '3079', '650100', '乌鲁木齐市');
INSERT INTO `hi_region` VALUES ('3081', '3080', '650102', '天山区');
INSERT INTO `hi_region` VALUES ('3082', '3080', '650103', '沙依巴克区');
INSERT INTO `hi_region` VALUES ('3083', '3080', '650104', '新市区');
INSERT INTO `hi_region` VALUES ('3084', '3080', '650105', '水磨沟区');
INSERT INTO `hi_region` VALUES ('3085', '3080', '650106', '头屯河区');
INSERT INTO `hi_region` VALUES ('3086', '3080', '650107', '达坂城区');
INSERT INTO `hi_region` VALUES ('3087', '3080', '650109', '米东区');
INSERT INTO `hi_region` VALUES ('3088', '3080', '650121', '乌鲁木齐县');
INSERT INTO `hi_region` VALUES ('3089', '3079', '650200', '克拉玛依市');
INSERT INTO `hi_region` VALUES ('3090', '3089', '650202', '独山子区');
INSERT INTO `hi_region` VALUES ('3091', '3089', '650203', '克拉玛依区');
INSERT INTO `hi_region` VALUES ('3092', '3089', '650204', '白碱滩区');
INSERT INTO `hi_region` VALUES ('3093', '3089', '650205', '乌尔禾区');
INSERT INTO `hi_region` VALUES ('3094', '3079', '650400', '吐鲁番市');
INSERT INTO `hi_region` VALUES ('3095', '3094', '650402', '高昌区');
INSERT INTO `hi_region` VALUES ('3096', '3094', '650421', '鄯善县');
INSERT INTO `hi_region` VALUES ('3097', '3094', '650422', '托克逊县');
INSERT INTO `hi_region` VALUES ('3098', '3079', '650500', '哈密市');
INSERT INTO `hi_region` VALUES ('3099', '3098', '650502', '伊州区');
INSERT INTO `hi_region` VALUES ('3100', '3098', '650521', '巴里坤哈萨克自治县');
INSERT INTO `hi_region` VALUES ('3101', '3098', '650522', '伊吾县');
INSERT INTO `hi_region` VALUES ('3102', '3079', '652300', '昌吉回族自治州');
INSERT INTO `hi_region` VALUES ('3103', '3102', '652301', '昌吉市');
INSERT INTO `hi_region` VALUES ('3104', '3102', '652302', '阜康市');
INSERT INTO `hi_region` VALUES ('3105', '3102', '652323', '呼图壁县');
INSERT INTO `hi_region` VALUES ('3106', '3102', '652324', '玛纳斯县');
INSERT INTO `hi_region` VALUES ('3107', '3102', '652325', '奇台县');
INSERT INTO `hi_region` VALUES ('3108', '3102', '652327', '吉木萨尔县');
INSERT INTO `hi_region` VALUES ('3109', '3102', '652328', '木垒哈萨克自治县');
INSERT INTO `hi_region` VALUES ('3110', '3079', '652700', '博尔塔拉蒙古自治州');
INSERT INTO `hi_region` VALUES ('3111', '3110', '652701', '博乐市');
INSERT INTO `hi_region` VALUES ('3112', '3110', '652702', '阿拉山口市');
INSERT INTO `hi_region` VALUES ('3113', '3110', '652722', '精河县');
INSERT INTO `hi_region` VALUES ('3114', '3110', '652723', '温泉县');
INSERT INTO `hi_region` VALUES ('3115', '3079', '652800', '巴音郭楞蒙古自治州');
INSERT INTO `hi_region` VALUES ('3116', '3115', '652801', '库尔勒市');
INSERT INTO `hi_region` VALUES ('3117', '3115', '652822', '轮台县');
INSERT INTO `hi_region` VALUES ('3118', '3115', '652823', '尉犁县');
INSERT INTO `hi_region` VALUES ('3119', '3115', '652824', '若羌县');
INSERT INTO `hi_region` VALUES ('3120', '3115', '652825', '且末县');
INSERT INTO `hi_region` VALUES ('3121', '3115', '652826', '焉耆回族自治县');
INSERT INTO `hi_region` VALUES ('3122', '3115', '652827', '和静县');
INSERT INTO `hi_region` VALUES ('3123', '3115', '652828', '和硕县');
INSERT INTO `hi_region` VALUES ('3124', '3115', '652829', '博湖县');
INSERT INTO `hi_region` VALUES ('3125', '3079', '652900', '阿克苏地区');
INSERT INTO `hi_region` VALUES ('3126', '3125', '652901', '阿克苏市');
INSERT INTO `hi_region` VALUES ('3127', '3125', '652922', '温宿县');
INSERT INTO `hi_region` VALUES ('3128', '3125', '652923', '库车县');
INSERT INTO `hi_region` VALUES ('3129', '3125', '652924', '沙雅县');
INSERT INTO `hi_region` VALUES ('3130', '3125', '652925', '新和县');
INSERT INTO `hi_region` VALUES ('3131', '3125', '652926', '拜城县');
INSERT INTO `hi_region` VALUES ('3132', '3125', '652927', '乌什县');
INSERT INTO `hi_region` VALUES ('3133', '3125', '652928', '阿瓦提县');
INSERT INTO `hi_region` VALUES ('3134', '3125', '652929', '柯坪县');
INSERT INTO `hi_region` VALUES ('3135', '3079', '653000', '克孜勒苏柯尔克孜自治州');
INSERT INTO `hi_region` VALUES ('3136', '3135', '653001', '阿图什市');
INSERT INTO `hi_region` VALUES ('3137', '3135', '653022', '阿克陶县');
INSERT INTO `hi_region` VALUES ('3138', '3135', '653023', '阿合奇县');
INSERT INTO `hi_region` VALUES ('3139', '3135', '653024', '乌恰县');
INSERT INTO `hi_region` VALUES ('3140', '3079', '653100', '喀什地区');
INSERT INTO `hi_region` VALUES ('3141', '3140', '653101', '喀什市');
INSERT INTO `hi_region` VALUES ('3142', '3140', '653121', '疏附县');
INSERT INTO `hi_region` VALUES ('3143', '3140', '653122', '疏勒县');
INSERT INTO `hi_region` VALUES ('3144', '3140', '653123', '英吉沙县');
INSERT INTO `hi_region` VALUES ('3145', '3140', '653124', '泽普县');
INSERT INTO `hi_region` VALUES ('3146', '3140', '653125', '莎车县');
INSERT INTO `hi_region` VALUES ('3147', '3140', '653126', '叶城县');
INSERT INTO `hi_region` VALUES ('3148', '3140', '653127', '麦盖提县');
INSERT INTO `hi_region` VALUES ('3149', '3140', '653128', '岳普湖县');
INSERT INTO `hi_region` VALUES ('3150', '3140', '653129', '伽师县');
INSERT INTO `hi_region` VALUES ('3151', '3140', '653130', '巴楚县');
INSERT INTO `hi_region` VALUES ('3152', '3140', '653131', '塔什库尔干塔吉克自治县');
INSERT INTO `hi_region` VALUES ('3153', '3079', '653200', '和田地区');
INSERT INTO `hi_region` VALUES ('3154', '3153', '653201', '和田市');
INSERT INTO `hi_region` VALUES ('3155', '3153', '653221', '和田县');
INSERT INTO `hi_region` VALUES ('3156', '3153', '653222', '墨玉县');
INSERT INTO `hi_region` VALUES ('3157', '3153', '653223', '皮山县');
INSERT INTO `hi_region` VALUES ('3158', '3153', '653224', '洛浦县');
INSERT INTO `hi_region` VALUES ('3159', '3153', '653225', '策勒县');
INSERT INTO `hi_region` VALUES ('3160', '3153', '653226', '于田县');
INSERT INTO `hi_region` VALUES ('3161', '3153', '653227', '民丰县');
INSERT INTO `hi_region` VALUES ('3162', '3079', '654000', '伊犁哈萨克自治州');
INSERT INTO `hi_region` VALUES ('3163', '3162', '654002', '伊宁市');
INSERT INTO `hi_region` VALUES ('3164', '3162', '654003', '奎屯市');
INSERT INTO `hi_region` VALUES ('3165', '3162', '654004', '霍尔果斯市');
INSERT INTO `hi_region` VALUES ('3166', '3162', '654021', '伊宁县');
INSERT INTO `hi_region` VALUES ('3167', '3162', '654022', '察布查尔锡伯自治县');
INSERT INTO `hi_region` VALUES ('3168', '3162', '654023', '霍城县');
INSERT INTO `hi_region` VALUES ('3169', '3162', '654024', '巩留县');
INSERT INTO `hi_region` VALUES ('3170', '3162', '654025', '新源县');
INSERT INTO `hi_region` VALUES ('3171', '3162', '654026', '昭苏县');
INSERT INTO `hi_region` VALUES ('3172', '3162', '654027', '特克斯县');
INSERT INTO `hi_region` VALUES ('3173', '3162', '654028', '尼勒克县');
INSERT INTO `hi_region` VALUES ('3174', '3079', '654200', '塔城地区');
INSERT INTO `hi_region` VALUES ('3175', '3174', '654201', '塔城市');
INSERT INTO `hi_region` VALUES ('3176', '3174', '654202', '乌苏市');
INSERT INTO `hi_region` VALUES ('3177', '3174', '654221', '额敏县');
INSERT INTO `hi_region` VALUES ('3178', '3174', '654223', '沙湾县');
INSERT INTO `hi_region` VALUES ('3179', '3174', '654224', '托里县');
INSERT INTO `hi_region` VALUES ('3180', '3174', '654225', '裕民县');
INSERT INTO `hi_region` VALUES ('3181', '3174', '654226', '和布克赛尔蒙古自治县');
INSERT INTO `hi_region` VALUES ('3182', '3079', '654300', '阿勒泰地区');
INSERT INTO `hi_region` VALUES ('3183', '3182', '654301', '阿勒泰市');
INSERT INTO `hi_region` VALUES ('3184', '3182', '654321', '布尔津县');
INSERT INTO `hi_region` VALUES ('3185', '3182', '654322', '富蕴县');
INSERT INTO `hi_region` VALUES ('3186', '3182', '654323', '福海县');
INSERT INTO `hi_region` VALUES ('3187', '3182', '654324', '哈巴河县');
INSERT INTO `hi_region` VALUES ('3188', '3182', '654325', '青河县');
INSERT INTO `hi_region` VALUES ('3189', '3182', '654326', '吉木乃县');
INSERT INTO `hi_region` VALUES ('3190', '0', '710000', '台湾省');
INSERT INTO `hi_region` VALUES ('3191', '0', '810000', '香港特别行政区');
INSERT INTO `hi_region` VALUES ('3192', '0', '820000', '澳门特别行政区');

-- ----------------------------
-- Table structure for hi_session
-- ----------------------------
DROP TABLE IF EXISTS `hi_session`;
CREATE TABLE `hi_session` (
  `session_id` varchar(225) NOT NULL,
  `session_expire` int(11) NOT NULL,
  `session_data` text NOT NULL,
  UNIQUE KEY `session_id` (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='SESSION';

-- ----------------------------
-- Records of hi_session
-- ----------------------------
INSERT INTO `hi_session` VALUES ('0nbbvc4beofl8ru41nfbt26166', '1496192314', '');

-- ----------------------------
-- Table structure for hi_tags
-- ----------------------------
DROP TABLE IF EXISTS `hi_tags`;
CREATE TABLE `hi_tags` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'tagID',
  `tag` char(20) NOT NULL DEFAULT '' COMMENT 'tag名称',
  `usetimes` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '信息总数',
  `lastusetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后使用时间',
  `hits` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '点击数',
  `lasthittime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近访问时间',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `seo_title` varchar(100) NOT NULL DEFAULT '' COMMENT 'SEO标题',
  `seo_keyword` varchar(255) NOT NULL DEFAULT '',
  `seo_description` varchar(255) NOT NULL DEFAULT '',
  `style` char(8) NOT NULL DEFAULT '' COMMENT '前台附加样式',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag` (`tag`),
  KEY `usetimes` (`usetimes`,`sort`),
  KEY `hits` (`hits`,`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='标签表';

-- ----------------------------
-- Records of hi_tags
-- ----------------------------
INSERT INTO `hi_tags` VALUES ('12', '出处', '1', '1493369565', '0', '1493369565', '0', '', '', '', '');
INSERT INTO `hi_tags` VALUES ('2', '他们', '2', '1492399954', '0', '1492399954', '0', '', '', '', '');
INSERT INTO `hi_tags` VALUES ('3', '你们', '1', '1492401339', '20', '1492401339', '0', '你们的标题', '你们关键词', '你们描述', 'success');
INSERT INTO `hi_tags` VALUES ('4', '文章', '6', '1492413604', '0', '1492413604', '0', '', '', '', '');
INSERT INTO `hi_tags` VALUES ('5', '标题', '6', '1492413604', '0', '1492413604', '0', '', '', '', '');
INSERT INTO `hi_tags` VALUES ('6', '名称', '2', '1492432930', '0', '1492432930', '0', '', '', '', '');
INSERT INTO `hi_tags` VALUES ('7', '是的', '1', '1492782600', '0', '1492782600', '0', '', '', '', '');
INSERT INTO `hi_tags` VALUES ('8', '是打发', '1', '1492782600', '0', '1492782600', '0', '', '', '', '');
INSERT INTO `hi_tags` VALUES ('9', '标签', '1', '1492782600', '0', '1492782600', '0', '', '', '', '');
INSERT INTO `hi_tags` VALUES ('10', '空格', '0', '1492782677', '0', '1492782677', '0', '', '', '', '');
INSERT INTO `hi_tags` VALUES ('11', '12', '4', '1493298489', '0', '1493298489', '0', '', '', '', '');

-- ----------------------------
-- Table structure for hi_tags_data
-- ----------------------------
DROP TABLE IF EXISTS `hi_tags_data`;
CREATE TABLE `hi_tags_data` (
  `tag` char(20) NOT NULL COMMENT 'tag名称',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '信息地址',
  `title` varchar(80) NOT NULL DEFAULT '' COMMENT '标题',
  `modelid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模型ID',
  `contentid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '信息ID',
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '栏目ID',
  `updatetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  KEY `modelid` (`modelid`,`contentid`),
  KEY `tag` (`tag`(10))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='标签副表';

-- ----------------------------
-- Records of hi_tags_data
-- ----------------------------
INSERT INTO `hi_tags_data` VALUES ('文章', '', '文章标题111211', '2', '22', '33', '1493369537');
INSERT INTO `hi_tags_data` VALUES ('他们', '', '文章标题21111', '1', '20', '27', '1492399954');
INSERT INTO `hi_tags_data` VALUES ('他们', '', '测试文章发布', '1', '21', '27', '1492401339');
INSERT INTO `hi_tags_data` VALUES ('你们', '', '测试文章发布', '1', '21', '27', '1492401339');
INSERT INTO `hi_tags_data` VALUES ('文章', '', '文章标题', '1', '22', '33', '1492413604');
INSERT INTO `hi_tags_data` VALUES ('标题', '', '文章标题', '1', '22', '33', '1492413604');
INSERT INTO `hi_tags_data` VALUES ('文章', '', '文章标题名称，还可输入 80 个字符', '1', '23', '27', '1492432930');
INSERT INTO `hi_tags_data` VALUES ('标题', '', '文章标题名称，还可输入 80 个字符', '1', '23', '27', '1492432930');
INSERT INTO `hi_tags_data` VALUES ('名称', '', '文章标题名称，还可输入 80 个字符', '1', '23', '27', '1492432930');
INSERT INTO `hi_tags_data` VALUES ('是的', '', 'sdf阿斯顿发斯蒂芬', '2', '24', '276', '1492782600');
INSERT INTO `hi_tags_data` VALUES ('是打发', '', 'sdf阿斯顿发斯蒂芬', '2', '24', '276', '1492782600');
INSERT INTO `hi_tags_data` VALUES ('标签', '', 'sdf阿斯顿发斯蒂芬', '2', '24', '276', '1492782600');
INSERT INTO `hi_tags_data` VALUES ('文章', '', '文章标题名称', '2', '25', '31', '1492782677');
INSERT INTO `hi_tags_data` VALUES ('标题', '', '文章标题名称', '2', '25', '31', '1492782677');
INSERT INTO `hi_tags_data` VALUES ('标题', '', '顶起11', '2', '9', '27', '1493298760');
INSERT INTO `hi_tags_data` VALUES ('12', '', '文章标题2', '2', '16', '27', '1493298489');
INSERT INTO `hi_tags_data` VALUES ('文章', '', '顶起11', '2', '9', '27', '1493298760');
INSERT INTO `hi_tags_data` VALUES ('12', '', '文章标题1111111', '2', '15', '27', '1493301903');
INSERT INTO `hi_tags_data` VALUES ('标题', '', '文章标题111211', '2', '22', '33', '1493369537');
INSERT INTO `hi_tags_data` VALUES ('文章', '', '文章标题名称，还可输入 80 个字符', '2', '23', '27', '1493369565');
INSERT INTO `hi_tags_data` VALUES ('标题', '', '文章标题名称，还可输入 80 个字符', '2', '23', '27', '1493369565');
INSERT INTO `hi_tags_data` VALUES ('名称', '', '文章标题名称，还可输入 80 个字符', '2', '23', '27', '1493369565');
INSERT INTO `hi_tags_data` VALUES ('出处', '', '文章标题名称，还可输入 80 个字符', '2', '23', '27', '1493369565');
INSERT INTO `hi_tags_data` VALUES ('12', '', '文章标题23213123', '2', '15', '81', '1494985624');
INSERT INTO `hi_tags_data` VALUES ('12', '', '文章标题2', '2', '16', '81', '1494986920');

-- ----------------------------
-- Table structure for hi_template
-- ----------------------------
DROP TABLE IF EXISTS `hi_template`;
CREATE TABLE `hi_template` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `file` varchar(80) NOT NULL COMMENT '文件路径',
  `uid` int(10) NOT NULL COMMENT '会员ID',
  `template` text NOT NULL COMMENT '模板',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '备份时间',
  PRIMARY KEY (`id`),
  KEY `fileid` (`file`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='模板历史表';

-- ----------------------------
-- Records of hi_template
-- ----------------------------
INSERT INTO `hi_template` VALUES ('7', 'Home/lists/list.html', '1', '{extend name=\\\"Public/base\\\" /}122222\r\n{block name=\\\"style\\\"}<link rel=\\\"stylesheet\\\" type=\\\"text/css\\\" href=\\\"__JS__/webuploader/webuploader.css\\\">{/block}\r\n{block name=\\\"body\\\"}\r\n    <div class=\\\"ibox float-e-margins\\\">\r\n        <div class=\\\"ibox-content\\\">1\r\n            <form class=\\\"form-horizontal m-t\\\" action=\\\"__SELF__\\\" method=\\\"post\\\">\r\n                {form:input name=\\\"title\\\" title=\\\"广告名称\\\" value=\\\"info[\\\'title\\\']\\\" cols=\\\"3\\\" tips=\\\"图片标题alt显示的文字1\\\" /}\r\n                {form:input name=\\\"url\\\" title=\\\"广告链接\\\" value=\\\"info[\\\'url\\\']\\\" tips=\\\"广告链接地址 http://\\\" /}\r\n                {form:image name=\\\"image\\\" title=\\\"图片\\\" value=\\\"info[\\\'image\\\']\\\" limit=\\\"1\\\" button=\\\"选择图片\\\" /}\r\n                {form:datepicker name=\\\"enddate\\\" title=\\\"结束日期\\\" value=\\\"info[\\\'enddate\\\']|times=\\\'Y-m-d\\\'\\\" tips=\\\"广告结束日期,默认为当前3个月后\\\" /}\r\n                {form:textarea name=\\\"extend\\\" title=\\\"扩展\\\" value=\\\"info[\\\'extend\\\']\\\" cols=\\\"6\\\" rows=\\\"3\\\" tips=\\\"广告扩展参数,根据实际需要扩展。每行一个参数,如：bgcolor:#000\\\" /}\r\n                <div class=\\\"form-group\\\">\r\n                    <div class=\\\"col-sm-2 col-sm-offset-3\\\">\r\n                        <input type=\\\"hidden\\\" name=\\\"id\\\" value=\\\"{$info[\\\'id\\\']}\\\">\r\n                        <input type=\\\"hidden\\\" name=\\\"pos\\\" value=\\\"{$info[\\\'pos\\\']}\\\">\r\n                        <button class=\\\"btn btn-primary btn-block btn-lg ajax-form\\\" type=\\\"submit\\\" target-form=\\\"form-horizontal\\\"><i class=\\\"fa fa-check\\\"></i>&nbsp;提交</button>\r\n                    </div>\r\n                    <div class=\\\"col-sm-2\\\">\r\n                        <button class=\\\"btn btn-info btn-lg btn-block\\\" onclick=\\\"javascript:history.back(-1);return false;\\\"><i class=\\\"fa fa-reply\\\"> 返回</i></button>\r\n                    </div>\r\n                </div>\r\n            </form>\r\n        </div>\r\n    </div>\r\n{/block}\r\n{block name=\\\"script\\\"}\r\n<script src=\\\"__JS__/webuploader/webuploader.js\\\" type=\\\"text/javascript\\\"></script>\r\n<script src=\\\"__JS__/webuploader/upload.js\\\" type=\\\"text/javascript\\\"></script>\r\n{/block}', '1495681127');
INSERT INTO `hi_template` VALUES ('8', 'Home/lists/list.html', '1', '{extend name=\\\"Public/base\\\" /}\r\n{block name=\\\"style\\\"}<link rel=\\\"stylesheet\\\" type=\\\"text/css\\\" href=\\\"__JS__/webuploader/webuploader.css\\\">{/block}\r\n{block name=\\\"body\\\"}\r\n    <div class=\\\"ibox float-e-margins\\\">\r\n        <div class=\\\"ibox-content\\\">1\r\n            <form class=\\\"form-horizontal m-t\\\" action=\\\"__SELF__\\\" method=\\\"post\\\">\r\n                {form:input name=\\\"title\\\" title=\\\"广告名称\\\" value=\\\"info[\\\'title\\\']\\\" cols=\\\"3\\\" tips=\\\"图片标题alt显示的文字1\\\" /}\r\n                {form:input name=\\\"url\\\" title=\\\"广告链接\\\" value=\\\"info[\\\'url\\\']\\\" tips=\\\"广告链接地址 http://\\\" /}\r\n                {form:image name=\\\"image\\\" title=\\\"图片\\\" value=\\\"info[\\\'image\\\']\\\" limit=\\\"1\\\" button=\\\"选择图片\\\" /}\r\n                {form:datepicker name=\\\"enddate\\\" title=\\\"结束日期\\\" value=\\\"info[\\\'enddate\\\']|times=\\\'Y-m-d\\\'\\\" tips=\\\"广告结束日期,默认为当前3个月后\\\" /}\r\n                {form:textarea name=\\\"extend\\\" title=\\\"扩展\\\" value=\\\"info[\\\'extend\\\']\\\" cols=\\\"6\\\" rows=\\\"3\\\" tips=\\\"广告扩展参数,根据实际需要扩展。每行一个参数,如：bgcolor:#000\\\" /}\r\n                <div class=\\\"form-group\\\">\r\n                    <div class=\\\"col-sm-2 col-sm-offset-3\\\">\r\n                        <input type=\\\"hidden\\\" name=\\\"id\\\" value=\\\"{$info[\\\'id\\\']}\\\">\r\n                        <input type=\\\"hidden\\\" name=\\\"pos\\\" value=\\\"{$info[\\\'pos\\\']}\\\">\r\n                        <button class=\\\"btn btn-primary btn-block btn-lg ajax-form\\\" type=\\\"submit\\\" target-form=\\\"form-horizontal\\\"><i class=\\\"fa fa-check\\\"></i>&nbsp;提交</button>\r\n                    </div>\r\n                    <div class=\\\"col-sm-2\\\">\r\n                        <button class=\\\"btn btn-info btn-lg btn-block\\\" onclick=\\\"javascript:history.back(-1);return false;\\\"><i class=\\\"fa fa-reply\\\"> 返回</i></button>\r\n                    </div>\r\n                </div>\r\n            </form>\r\n        </div>\r\n    </div>\r\n{/block}\r\n{block name=\\\"script\\\"}\r\n<script src=\\\"__JS__/webuploader/webuploader.js\\\" type=\\\"text/javascript\\\"></script>\r\n<script src=\\\"__JS__/webuploader/upload.js\\\" type=\\\"text/javascript\\\"></script>\r\n{/block}', '1495681313');

-- ----------------------------
-- Table structure for hi_views
-- ----------------------------
DROP TABLE IF EXISTS `hi_views`;
CREATE TABLE `hi_views` (
  `contentid` int(10) NOT NULL COMMENT '内容ID',
  `modelid` tinyint(3) NOT NULL DEFAULT '0' COMMENT '模型ID',
  `modelname` varchar(20) NOT NULL COMMENT '模型名称',
  `views` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '总点击量',
  `yesterdayviews` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '昨日点击量',
  `dayviews` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '今天点击量',
  `weekviews` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '周点击量',
  `monthviews` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '月点击量',
  `updatetime` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='内容浏览表';

-- ----------------------------
-- Records of hi_views
-- ----------------------------
INSERT INTO `hi_views` VALUES ('0', '0', '', '1', '0', '1', '1', '1', '16777215');
