/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50619
 Source Host           : localhost:3306
 Source Schema         : library-management

 Target Server Type    : MySQL
 Target Server Version : 50619
 File Encoding         : 65001

 Date: 05/02/2023 09:12:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系方式',
  `createtime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updatetime` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username_key`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '16666666666', '2023-01-28 14:34:11', '2023-01-29 03:02:09', '202cb962ac59075b964b07152d234b70', 'qq@.com', 1);
INSERT INTO `admin` VALUES (2, 'admin1', '19999999999', '2023-01-28 14:35:11', '2023-01-29 03:02:06', '81dc9bdb52d04dc20036dbd8313ed055', '1', 1);
INSERT INTO `admin` VALUES (3, '123', '13432424234', '2023-01-28 14:44:43', '2023-01-29 03:02:05', '202cb962ac59075b964b07152d234b70', '1', 1);
INSERT INTO `admin` VALUES (4, 'admin3', '15988997798', '2023-01-29 07:49:22', '2023-01-29 03:02:04', '81dc9bdb52d04dc20036dbd8313ed055', 'admin3@qq.com', 1);
INSERT INTO `admin` VALUES (5, 'admin100', '18999889988', '2023-01-29 08:54:45', '2023-02-05 00:56:31', '202cb962ac59075b964b07152d234b70', '1', 1);

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT ' 名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT ' 描述',
  `publish_date` datetime(0) NULL DEFAULT NULL COMMENT '出版日期',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT ' 作者',
  `publisher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT ' 出版社',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类',
  `book_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT ' 标准码',
  `score` int(10) NULL DEFAULT NULL COMMENT '图书借出所需积分',
  `nums` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '图书数量',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT ' 封面',
  `createtime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT ' 创建时间',
  `updatetime` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `book_no`(`book_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (5, ' 西游记幼儿美绘本（全10册）', '中国四大名著之一，西游记3-8岁版，彩绘注音，有声伴读。49款夸张角色，610张精美插图， 29个西游问答，10大智力挑战，以一种超有趣的方式亲近名著经典。', '2023-02-23 16:00:00', '吕进', '少年儿童出版社', '历史文化 > 唐朝文化', 'ISBN：9787558911156', 20, '99', 'http://img3m7.ddimg.cn/10/30/25276987-1_u_44.jpg', '2023-02-02 19:14:59', '2023-02-04 00:00:00');
INSERT INTO `book` VALUES (10, 'da', 'dad', '2023-02-04 16:00:00', 'dad', 'dad', '科技 > 生物科技', 'dad', 10, '13', 'http://localhost:9090/api/book/file/download/1675498468920?&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxIiwiZXhwIjoxNjc2Nzk0NDY4fQ.FQEpY-Aomk9ezIo2-Fh7XFX6aGCfqH5VX0NITB7nynA&play=1', '2023-02-04 16:16:01', NULL);

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图书名称',
  `book_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图书标准码',
  `user_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `user_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的联系方式',
  `score` int(10) NULL DEFAULT NULL COMMENT '借书积分',
  `days` int(10) NULL DEFAULT 1 COMMENT '借书天数',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '已借出' COMMENT '借书状态',
  `return_date` datetime(0) NULL DEFAULT NULL COMMENT '归还时间',
  `createtime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updatetime` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` VALUES (14, ' 西游记幼儿美绘本（全10册）', 'ISBN：9787558911156', '202301271638568640', '李云龙', '18888888888', 60, 3, '已归还', '2023-02-07 00:00:00', '2023-02-04 13:59:32', NULL);
INSERT INTO `borrow` VALUES (15, ' 西游记幼儿美绘本（全10册）', 'ISBN：9787558911156', '202301271638568640', '李云龙', '18888888888', 20, 1, '已归还', '2023-02-05 00:00:00', '2023-02-04 13:59:40', NULL);
INSERT INTO `borrow` VALUES (16, ' 西游记幼儿美绘本（全10册）', 'ISBN：9787558911156', '20230127727071926', '小甘', '16666666666', 40, 2, '已归还', '2023-02-06 00:00:00', '2023-02-04 13:59:46', NULL);
INSERT INTO `borrow` VALUES (18, ' 西游记幼儿美绘本（全10册）', 'ISBN：9787558911156', '20230127727071926', '小甘', '16666666666', 20, 1, '已归还', '2023-02-03 00:00:00', '2023-02-02 15:31:26', NULL);
INSERT INTO `borrow` VALUES (19, ' 西游记幼儿美绘本（全10册）', 'ISBN：9787558911156', '20230127727071926', '小甘', '16666666666', 60, 3, '已归还', '2023-02-03 00:00:00', '2023-01-31 15:37:14', NULL);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `pid` int(11) NULL DEFAULT NULL COMMENT ' 父级id',
  `createtime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updatetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (3, '历史文化', '历史文化1', NULL, '2023-01-31 14:11:54', '2023-01-31 00:00:00');
INSERT INTO `category` VALUES (4, '唐朝文化', '唐朝文化', 3, '2023-01-31 14:29:26', NULL);
INSERT INTO `category` VALUES (6, '宋朝文化', NULL, 3, '2023-01-31 14:33:50', NULL);
INSERT INTO `category` VALUES (11, '现代文化', NULL, 3, '2023-01-31 14:56:51', NULL);
INSERT INTO `category` VALUES (12, '科技', '科技', NULL, '2023-01-31 15:12:31', NULL);
INSERT INTO `category` VALUES (13, '生物科技', '生物科技', 12, '2023-01-31 15:12:47', '2023-02-04 00:00:00');

-- ----------------------------
-- Table structure for retur
-- ----------------------------
DROP TABLE IF EXISTS `retur`;
CREATE TABLE `retur`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图书名称',
  `book_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图书标准码',
  `user_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `user_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的联系方式',
  `score` int(10) NULL DEFAULT NULL COMMENT '借书积分',
  `days` int(10) NULL DEFAULT 1 COMMENT '借书天数',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '已借出' COMMENT '借书状态',
  `return_date` datetime(0) NULL DEFAULT NULL COMMENT '归还时间',
  `createtime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updatetime` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `real_date` datetime(0) NULL DEFAULT NULL COMMENT '实际归还日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of retur
-- ----------------------------
INSERT INTO `retur` VALUES (18, ' 西游记幼儿美绘本（全10册）', 'ISBN：9787558911156', '202301271638568640', '李云龙', '18888888888', 20, 1, '已归还', '2023-02-05 00:00:00', '2023-02-04 14:15:19', NULL, '2023-02-04 00:00:00');
INSERT INTO `retur` VALUES (19, ' 西游记幼儿美绘本（全10册）', 'ISBN：9787558911156', '202301271638568640', '李云龙', '18888888888', 60, 3, '已归还', '2023-02-07 00:00:00', '2023-02-04 14:38:42', NULL, '2023-02-04 00:00:00');
INSERT INTO `retur` VALUES (20, ' 西游记幼儿美绘本（全10册）', 'ISBN：9787558911156', '20230127727071926', '小甘', '16666666666', 20, 1, '已归还', '2023-02-03 00:00:00', '2023-02-04 15:32:34', NULL, '2023-02-04 00:00:00');
INSERT INTO `retur` VALUES (21, ' 西游记幼儿美绘本（全10册）', 'ISBN：9787558911156', '20230127727071926', '小甘', '16666666666', 60, 3, '已归还', '2023-02-03 00:00:00', '2023-02-04 15:38:54', NULL, '2023-02-04 00:00:00');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '会员码',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系方式',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '住址',
  `createtime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updatetime` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `account` int(10) NULL DEFAULT 0 COMMENT '用户积分',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username_index`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (21, '李云龙', '202301271638568640', 20, '男', '18888888888', '福建', '2023-01-27 09:49:16', '2023-02-04 07:30:51', 110, 1);
INSERT INTO `user` VALUES (22, '小甘', '20230127727071926', 20, '男', '16666666666', '台湾', '2023-01-27 09:57:21', '2023-02-04 07:39:27', 180, 1);
INSERT INTO `user` VALUES (33, '林航', '1654327208205', 41, '男', '15793753372', '丽水', '2022-04-04 15:04:13', '2022-06-10 16:57:40', 100, 1);
INSERT INTO `user` VALUES (34, '史伟诚', '1665632271801', 98, '女', '17282381928', '临汾', '2022-01-05 20:10:13', '2022-02-28 17:12:11', 100, 1);
INSERT INTO `user` VALUES (35, '郑雪松', '1656806656568', 33, '女', '17818833180', '承德', '2022-05-21 06:48:47', '2022-09-07 23:35:23', 10, 1);
INSERT INTO `user` VALUES (36, '秦正豪', '1670267740525', 33, '女', '17365322559', '大连', '2022-10-17 17:31:37', '2022-11-26 15:41:09', 100, 1);
INSERT INTO `user` VALUES (37, '唐立果', '1654268512008', 85, '女', '15891617629', '云浮', '2022-02-27 21:24:21', '2022-04-28 11:39:24', 100, 1);
INSERT INTO `user` VALUES (38, '段健柏', '1662145215549', 51, '女', '15678966148', '齐齐哈尔', '2022-03-21 13:41:51', '2022-10-17 04:33:25', 100, 1);
INSERT INTO `user` VALUES (39, '郑伟诚', '1664997532306', 79, '男', '17572598012', '包头', '2022-01-09 05:36:51', '2022-12-20 13:53:09', 100, 1);
INSERT INTO `user` VALUES (40, '李越彬', '1669257071008', 97, '男', '14719059699', '三亚', '2022-09-06 17:06:00', '2022-11-17 02:18:04', 100, 1);
INSERT INTO `user` VALUES (41, '周彬', '1653893702398', 32, '女', '15863088096', '中山', '2022-11-08 10:46:24', '2022-04-27 23:06:59', 100, 1);
INSERT INTO `user` VALUES (42, '段鹭洋', '1649250970540', 55, '男', '15169101655', '宿迁', '2022-05-06 05:40:13', '2022-08-03 23:40:07', 100, 1);
INSERT INTO `user` VALUES (43, '廖凯瑞', '1649262505138', 15, '男', '15513845098', '合肥', '2022-12-12 23:05:05', '2022-02-25 16:29:05', 100, 1);
INSERT INTO `user` VALUES (44, '廖峻熙', '1645075426524', 75, '女', '15853383725', '威海', '2022-08-10 12:16:38', '2022-10-14 02:33:58', 100, 1);
INSERT INTO `user` VALUES (45, '韦越彬', '1663605812144', 37, '女', '17736743644', '营口', '2022-07-25 06:34:52', '2022-01-04 11:17:39', 100, 1);
INSERT INTO `user` VALUES (46, '唐煜城', '1650485938707', 26, '男', '17606918076', '义乌', '2022-12-23 05:26:49', '2022-12-08 02:01:46', 100, 1);
INSERT INTO `user` VALUES (47, '冯文', '1644022705980', 86, '女', '18511009987', '常德', '2022-10-09 14:30:29', '2022-12-02 11:09:33', 100, 1);
INSERT INTO `user` VALUES (48, '张峻熙', '1646665794785', 34, '男', '15181187604', '青岛', '2022-12-25 10:11:55', '2022-01-24 15:14:20', 100, 1);
INSERT INTO `user` VALUES (49, '许君浩', '1670021193666', 60, '男', '15862136344', '诸暨', '2022-07-20 14:47:53', '2022-12-29 23:42:17', 100, 1);
INSERT INTO `user` VALUES (50, '江瑾瑜', '1659484034564', 70, '女', '15628916527', '福州', '2022-05-01 12:23:55', '2022-10-08 02:00:53', 100, 1);
INSERT INTO `user` VALUES (51, '邱鹏煊', '1651333526261', 42, '女', '15632107370', '克拉玛依', '2022-05-06 13:38:01', '2022-07-07 13:02:53', 100, 1);
INSERT INTO `user` VALUES (52, '韦弘文', '1665336584240', 60, '女', '15076544518', '桂林', '2022-12-13 21:37:18', '2023-01-27 06:39:29', 100, 1);
INSERT INTO `user` VALUES (53, '小红2', '20230127719685163', 20, '男', '18745679876', '河南', '2023-01-27 14:42:17', '2023-01-27 07:11:10', 100, 1);
INSERT INTO `user` VALUES (54, 'ceshi', '202301281952627369', 18, '男', '15000000001', '1', '2023-01-28 16:35:38', '2023-02-04 07:34:11', 522, 1);

SET FOREIGN_KEY_CHECKS = 1;
