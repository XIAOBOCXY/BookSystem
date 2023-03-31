/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : dbhouse

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2021-12-21 22:02:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `my_book`
-- ----------------------------
DROP TABLE IF EXISTS `my_book`;
CREATE TABLE `my_book` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `BookName` varchar(40) NOT NULL,
  `BookClass` int(11) NOT NULL DEFAULT '0',
  `Author` varchar(25) DEFAULT NULL,
  `Publish` varchar(150) DEFAULT NULL,
  `BookNo` varchar(30) DEFAULT NULL,
  `Content` varchar(4000) DEFAULT NULL,
  `Prince` double DEFAULT NULL,
  `Amount` int(11) DEFAULT '0',
  `Leav_number` int(11) DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `IDX_AUTOFIELD` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of my_book
-- ----------------------------
INSERT INTO `my_book` VALUES ('1', 'java基础案例教程', '3', '黑马程序员', '人民邮电出版社', 'ISBN 111111', '本书从初学者的角度详细讲解了java开发中用到的多种技术。', '54', '50', '39');
INSERT INTO `my_book` VALUES ('2', '使用jsp开发web应用', '3', '王永茂', '清华大学出版社', 'ISBN 222222', '掌握JSP 2.0规范技术，包括开发和部署JSP，创建标签和标签文件；联合使用JSP、JavaBean、表达式语言（EL）、自定义标签以及JSTL标签库创建Web应用，最后结合Servlet技术完成Web应用的开发；独立设计基于MVC的企业应用。', '50', '100', '71');
INSERT INTO `my_book` VALUES ('3', '水浒传', '1', '施耐庵', '上海人民美术出版社', 'ISBN 333333', '《水浒传》是我国明代长篇小说的一部杰作。它不是作者凭空杜撰的，而是以北宋宣和年间宋江率众造反起义的历史事件为素材，并广泛吸收了宋、元间街谈巷议和说书人、杂剧表演依据的“梁山泊故事”。', '55', '100', '75');
INSERT INTO `my_book` VALUES ('4', '三国演义', '1', '罗贯中', '人民文学出版社', 'ISBN 444444', '本书全名《三国志通俗演义》，元末明初小说家罗贯中所著，为中国第一部长篇章回体历史演义的小说，中国古典四大名著之一，历史演义小说的经典之作。', '65', '100', '43');
INSERT INTO `my_book` VALUES ('6', '昆虫记', '2', '法布尔', '人民出版社', 'ISBN 555555', '《昆虫记》是法国杰出昆虫学家、文学家法布尔的传世佳作，亦是一部不朽的著作。它熔作者毕生研究成果和人生感悟于一炉，以为性观照虫性，将昆虫世界化作供人类获得知识、趣味、美感和思想的美文一书以忠实于法文原著整体风貌及表达特色为选择原则， 让中国读者首次领略《昆虫记》的真实面目。', '26', '100', '100');

-- ----------------------------
-- Table structure for `my_bookadminuser`
-- ----------------------------
DROP TABLE IF EXISTS `my_bookadminuser`;
CREATE TABLE `my_bookadminuser` (
  `AdminUser` varchar(20) NOT NULL,
  `AdminPass` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`AdminUser`)
) ENGINE=InnoDB DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of my_bookadminuser
-- ----------------------------
INSERT INTO `my_bookadminuser` VALUES ('admin', 'admin');

-- ----------------------------
-- Table structure for `my_bookclass`
-- ----------------------------
DROP TABLE IF EXISTS `my_bookclass`;
CREATE TABLE `my_bookclass` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` varchar(30) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IDX_AUTOFIELD` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of my_bookclass
-- ----------------------------
INSERT INTO `my_bookclass` VALUES ('1', '文学');
INSERT INTO `my_bookclass` VALUES ('2', '自然科学');
INSERT INTO `my_bookclass` VALUES ('3', '计算机图书');

-- ----------------------------
-- Table structure for `my_indent`
-- ----------------------------
DROP TABLE IF EXISTS `my_indent`;
CREATE TABLE `my_indent` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `IndentNo` varchar(20) NOT NULL,
  `UserId` int(11) NOT NULL DEFAULT '0',
  `SubmitTime` datetime NOT NULL,
  `ConsignmentTime` varchar(20) DEFAULT NULL,
  `TotalPrice` double DEFAULT NULL,
  `content` varchar(400) DEFAULT NULL,
  `IPAddress` varchar(20) DEFAULT NULL,
  `IsPayoff` int(11) DEFAULT '0',
  `IsSales` int(11) DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `IDX_AUTOFIELD` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of my_indent
-- ----------------------------
INSERT INTO `my_indent` VALUES ('19', 'HYD118', '1', '2021-12-21 08:07:25', '2021-12-28 08:07:25', '233', '附言：', '127.10.0.1', '1', '1');
INSERT INTO `my_indent` VALUES ('20', 'HYD119', '1', '2021-12-21 08:08:33', '2021-12-28 08:08:33', '26', '附言：', '127.10.0.1', '1', '1');
INSERT INTO `my_indent` VALUES ('21', 'HYD120', '1', '2021-12-21 08:08:48', '2021-12-28 08:08:48', '120', '附言：快快发货', '127.10.0.1', '1', '1');
INSERT INTO `my_indent` VALUES ('22', 'HYD121', '1', '2021-12-21 08:09:42', '2021-12-28 08:09:42', '230', '附言：看四大名著,学文学知识', '127.10.0.1', '1', '1');
INSERT INTO `my_indent` VALUES ('23', 'HYD122', '1', '2021-12-21 08:10:08', '2021-12-28 08:10:08', '26', '附言：我买的是昆虫记', '127.10.0.1', '1', '1');
INSERT INTO `my_indent` VALUES ('24', 'HYD123', '1', '2021-12-21 10:40:35', '2021-12-28 10:40:35', '81', '附言：', '0:0:0:0:0:0:0:1', '1', '1');
INSERT INTO `my_indent` VALUES ('25', 'HYD124', '1', '2021-12-21 11:57:30', '2021-12-28 11:57:30', '65', '附言：1111', '0:0:0:0:0:0:0:1', '1', '1');
INSERT INTO `my_indent` VALUES ('26', 'HYD125', '1', '2021-12-21 21:38:36', '2021-12-28 21:38:36', '65', '附言：', '0:0:0:0:0:0:0:1', '1', '1');

-- ----------------------------
-- Table structure for `my_indentlist`
-- ----------------------------
DROP TABLE IF EXISTS `my_indentlist`;
CREATE TABLE `my_indentlist` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `IndentNo` int(11) NOT NULL DEFAULT '0',
  `BookNo` int(11) NOT NULL DEFAULT '0',
  `Amount` int(11) DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `IDX_AUTOFIELD` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of my_indentlist
-- ----------------------------
INSERT INTO `my_indentlist` VALUES ('25', '19', '2', '2');
INSERT INTO `my_indentlist` VALUES ('26', '19', '3', '1');
INSERT INTO `my_indentlist` VALUES ('27', '19', '5', '3');
INSERT INTO `my_indentlist` VALUES ('28', '20', '5', '1');
INSERT INTO `my_indentlist` VALUES ('29', '21', '4', '1');
INSERT INTO `my_indentlist` VALUES ('30', '21', '3', '1');
INSERT INTO `my_indentlist` VALUES ('31', '22', '3', '3');
INSERT INTO `my_indentlist` VALUES ('32', '22', '4', '1');
INSERT INTO `my_indentlist` VALUES ('33', '23', '5', '1');
INSERT INTO `my_indentlist` VALUES ('34', '24', '6', '1');
INSERT INTO `my_indentlist` VALUES ('35', '24', '3', '1');
INSERT INTO `my_indentlist` VALUES ('36', '25', '4', '1');
INSERT INTO `my_indentlist` VALUES ('37', '26', '4', '1');

-- ----------------------------
-- Table structure for `my_users`
-- ----------------------------
DROP TABLE IF EXISTS `my_users`;
CREATE TABLE `my_users` (
  `Id` int(4) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(20) NOT NULL,
  `PassWord` varchar(50) NOT NULL,
  `Names` varchar(20) DEFAULT NULL,
  `Sex` varchar(2) DEFAULT NULL,
  `Address` varchar(150) DEFAULT NULL,
  `Phone` varchar(25) DEFAULT NULL,
  `Post` varchar(8) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `RegIpAddress` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IDX_AUTOFIELD` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of my_users
-- ----------------------------
INSERT INTO `my_users` VALUES ('1', 'y001', '000001', '张三', '男', '浙江杭州', '15254785695', '032256', 'zhangsan@qq.com', '127.10.0.1');
INSERT INTO `my_users` VALUES ('2', 'y002', '000002', '李四', '男', '浙江宁波', '15874589653', '255874', 'lisi@qq.com', '127.10.0.1');
